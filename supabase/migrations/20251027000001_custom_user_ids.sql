-- Add a new column for custom user ID
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS user_id TEXT UNIQUE;

-- Create a function to generate the next user ID
CREATE OR REPLACE FUNCTION public.generate_next_user_id()
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    next_id INTEGER;
    new_user_id TEXT;
BEGIN
    -- Get the next sequential number
    SELECT COALESCE(MAX(CAST(SUBSTRING(user_id FROM 9) AS INTEGER)), 0) + 1
    INTO next_id
    FROM public.profiles
    WHERE user_id IS NOT NULL AND user_id LIKE 'MT_USER-%';
    
    -- Format the new user ID
    new_user_id := 'MT_USER-' || LPAD(next_id::TEXT, 2, '0');
    
    RETURN new_user_id;
END;
$$;

-- Update the handle_new_user function to use custom user IDs
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
    INSERT INTO public.profiles (id, user_id, name, email, avatar_url, role)
    VALUES (
        NEW.id,
        public.generate_next_user_id(),
        COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
        NEW.email,
        NEW.raw_user_meta_data->>'avatar_url',
        COALESCE((NEW.raw_user_meta_data->>'role')::user_role, 'user')
    );
    RETURN NEW;
END;
$$;