-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create enum types
CREATE TYPE user_role AS ENUM ('user', 'super_admin');
CREATE TYPE mentor_status AS ENUM ('pending', 'onboarded', 'declined');
CREATE TYPE points_reason AS ENUM ('submission', 'onboard');
CREATE TYPE redemption_status AS ENUM ('placed', 'delivered', 'cancelled');
CREATE TYPE notification_type AS ENUM ('onboarded', 'info');

-- Create profiles table (extends auth.users)
CREATE TABLE public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  avatar_url TEXT,
  role user_role NOT NULL DEFAULT 'user',
  points_total INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view all profiles" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Super admins can update any profile" ON public.profiles FOR UPDATE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'super_admin')
);

-- Create mentors table
CREATE TABLE public.mentors (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  created_by_user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  mentor_name TEXT NOT NULL,
  linkedin_url TEXT NOT NULL UNIQUE,
  phone TEXT,
  email TEXT,
  domain TEXT NOT NULL,
  experience_years INTEGER NOT NULL CHECK (experience_years >= 0),
  previous_domain TEXT,
  status mentor_status NOT NULL DEFAULT 'pending',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  edited_by_user_id UUID REFERENCES public.profiles(id)
);

-- Enable RLS
ALTER TABLE public.mentors ENABLE ROW LEVEL SECURITY;

-- Mentors policies
CREATE POLICY "Users can view own mentors" ON public.mentors FOR SELECT USING (created_by_user_id = auth.uid());
CREATE POLICY "Super admins can view all mentors" ON public.mentors FOR SELECT USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'super_admin')
);
CREATE POLICY "Users can insert own mentors" ON public.mentors FOR INSERT WITH CHECK (created_by_user_id = auth.uid());
CREATE POLICY "Users can update own pending mentors" ON public.mentors FOR UPDATE USING (
  created_by_user_id = auth.uid() AND status = 'pending'
);
CREATE POLICY "Super admins can update any mentor" ON public.mentors FOR UPDATE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'super_admin')
);

-- Create points_ledger table
CREATE TABLE public.points_ledger (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  mentor_id UUID NOT NULL REFERENCES public.mentors(id) ON DELETE CASCADE,
  delta INTEGER NOT NULL,
  reason points_reason NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.points_ledger ENABLE ROW LEVEL SECURITY;

-- Points ledger policies
CREATE POLICY "Users can view own ledger" ON public.points_ledger FOR SELECT USING (user_id = auth.uid());
CREATE POLICY "Super admins can view all ledgers" ON public.points_ledger FOR SELECT USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'super_admin')
);

-- Create marketplace_products table
CREATE TABLE public.marketplace_products (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  image_url TEXT,
  points_price INTEGER NOT NULL CHECK (points_price > 0),
  stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.marketplace_products ENABLE ROW LEVEL SECURITY;

-- Marketplace products policies
CREATE POLICY "Anyone can view active products" ON public.marketplace_products FOR SELECT USING (active = true);
CREATE POLICY "Super admins can view all products" ON public.marketplace_products FOR SELECT USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'super_admin')
);
CREATE POLICY "Super admins can insert products" ON public.marketplace_products FOR INSERT WITH CHECK (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'super_admin')
);
CREATE POLICY "Super admins can update products" ON public.marketplace_products FOR UPDATE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'super_admin')
);
CREATE POLICY "Super admins can delete products" ON public.marketplace_products FOR DELETE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'super_admin')
);

-- Create redemptions table
CREATE TABLE public.redemptions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  product_id UUID NOT NULL REFERENCES public.marketplace_products(id) ON DELETE CASCADE,
  points_cost INTEGER NOT NULL,
  status redemption_status NOT NULL DEFAULT 'placed',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.redemptions ENABLE ROW LEVEL SECURITY;

-- Redemptions policies
CREATE POLICY "Users can view own redemptions" ON public.redemptions FOR SELECT USING (user_id = auth.uid());
CREATE POLICY "Super admins can view all redemptions" ON public.redemptions FOR SELECT USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'super_admin')
);
CREATE POLICY "Users can insert own redemptions" ON public.redemptions FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "Super admins can update redemptions" ON public.redemptions FOR UPDATE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'super_admin')
);

-- Create notifications table
CREATE TABLE public.notifications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  type notification_type NOT NULL,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  is_read BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Notifications policies
CREATE POLICY "Users can view own notifications" ON public.notifications FOR SELECT USING (user_id = auth.uid());
CREATE POLICY "Users can update own notifications" ON public.notifications FOR UPDATE USING (user_id = auth.uid());

-- Create function to handle new user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, name, email, avatar_url, role)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
    NEW.email,
    NEW.raw_user_meta_data->>'avatar_url',
    COALESCE((NEW.raw_user_meta_data->>'role')::user_role, 'user')
  );
  RETURN NEW;
END;
$$;

-- Trigger for new user signup
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;

-- Trigger for mentors updated_at
CREATE TRIGGER update_mentors_updated_at
  BEFORE UPDATE ON public.mentors
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Trigger for marketplace_products updated_at
CREATE TRIGGER update_marketplace_products_updated_at
  BEFORE UPDATE ON public.marketplace_products
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Create indexes for performance
CREATE INDEX idx_mentors_created_by ON public.mentors(created_by_user_id);
CREATE INDEX idx_mentors_status ON public.mentors(status);
CREATE INDEX idx_mentors_created_at ON public.mentors(created_at);
CREATE INDEX idx_points_ledger_user_id ON public.points_ledger(user_id);
CREATE INDEX idx_points_ledger_created_at ON public.points_ledger(created_at);
CREATE INDEX idx_notifications_user_id ON public.notifications(user_id);
CREATE INDEX idx_notifications_is_read ON public.notifications(is_read);
CREATE INDEX idx_redemptions_user_id ON public.redemptions(user_id);