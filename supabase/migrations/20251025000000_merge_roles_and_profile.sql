-- Create enum for user roles
CREATE TYPE public.app_role AS ENUM ('admin', 'ca');

-- Create users profiles table (extends auth.users)
CREATE TABLE public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  role public.app_role NOT NULL DEFAULT 'ca',
  avatar_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Enable RLS on profiles
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view their own profile"
  ON public.profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Admins can view all profiles"
  ON public.profiles FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  ));

-- Create mentors table
CREATE TABLE public.mentors (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mentor_name TEXT NOT NULL,
  linkedin_url TEXT UNIQUE NOT NULL,
  phone TEXT,
  email TEXT,
  domain TEXT NOT NULL,
  experience_years INTEGER NOT NULL,
  previous_domain TEXT,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'onboarded', 'declined')),
  submitted_by_user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  submitted_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  onboarded_at TIMESTAMPTZ,
  declined_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Enable RLS on mentors
ALTER TABLE public.mentors ENABLE ROW LEVEL SECURITY;

-- Mentors policies
CREATE POLICY "CAs can view their own mentors"
  ON public.mentors FOR SELECT
  USING (auth.uid() = submitted_by_user_id);

CREATE POLICY "CAs can insert their own mentors"
  ON public.mentors FOR INSERT
  WITH CHECK (auth.uid() = submitted_by_user_id);

CREATE POLICY "Admins can view all mentors"
  ON public.mentors FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  ));

CREATE POLICY "Admins can update all mentors"
  ON public.mentors FOR UPDATE
  USING (EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  ));

-- Create points_ledger table
CREATE TABLE public.points_ledger (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  mentor_id UUID NOT NULL REFERENCES public.mentors(id) ON DELETE CASCADE,
  source TEXT NOT NULL CHECK (source IN ('submission', 'onboarded')),
  points INTEGER NOT NULL CHECK (points IN (10, 15)),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(mentor_id, source)
);

-- Enable RLS on points_ledger
ALTER TABLE public.points_ledger ENABLE ROW LEVEL SECURITY;

-- Points ledger policies
CREATE POLICY "Users can view their own points"
  ON public.points_ledger FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Admins can view all points"
  ON public.points_ledger FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  ));

CREATE POLICY "Admins can insert points"
  ON public.points_ledger FOR INSERT
  WITH CHECK (EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  ));

-- Create products table
CREATE TABLE public.products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  image_url TEXT,
  description TEXT,
  point_price INTEGER NOT NULL CHECK (point_price > 0),
  stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
  daily_limit_per_user INTEGER NOT NULL DEFAULT 1 CHECK (daily_limit_per_user >= 1),
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Enable RLS on products
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

-- Products policies
CREATE POLICY "Anyone can view active products"
  ON public.products FOR SELECT
  USING (is_active = true OR EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  ));

CREATE POLICY "Admins can manage products"
  ON public.products FOR ALL
  USING (EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  ));

-- Create redemptions table
CREATE TABLE public.redemptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  points_spent INTEGER NOT NULL,
  status TEXT NOT NULL DEFAULT 'placed' CHECK (status IN ('placed', 'cancelled')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Enable RLS on redemptions
ALTER TABLE public.redemptions ENABLE ROW LEVEL SECURITY;

-- Redemptions policies
CREATE POLICY "Users can view their own redemptions"
  ON public.redemptions FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Admins can view all redemptions"
  ON public.redemptions FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  ));

CREATE POLICY "Users can insert their own redemptions"
  ON public.redemptions FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Admins can update redemptions"
  ON public.redemptions FOR UPDATE
  USING (EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  ));

-- Create notifications table
CREATE TABLE public.notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  is_read BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Enable RLS on notifications
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Notifications policies
CREATE POLICY "Users can view their own notifications"
  ON public.notifications FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own notifications"
  ON public.notifications FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "System can insert notifications"
  ON public.notifications FOR INSERT
  WITH CHECK (true);

-- Create admin_view_state table for red dot logic
CREATE TABLE public.admin_view_state (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  admin_user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  ca_user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  last_seen_pending_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(admin_user_id, ca_user_id)
);

-- Enable RLS on admin_view_state
ALTER TABLE public.admin_view_state ENABLE ROW LEVEL SECURITY;

-- Admin view state policies
CREATE POLICY "Admins can manage view state"
  ON public.admin_view_state FOR ALL
  USING (EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  ));

-- Create function to handle new user profile creation
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, name, email, role)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'name', 'User'),
    NEW.email,
    COALESCE((NEW.raw_user_meta_data->>'role')::public.app_role, 'ca')
  );
  RETURN NEW;
END;
$$;

-- Create trigger for new user profile
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();