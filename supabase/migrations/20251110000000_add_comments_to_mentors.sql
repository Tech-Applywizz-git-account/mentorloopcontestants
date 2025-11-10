-- Add comments column to mentors table
ALTER TABLE public.mentors ADD COLUMN comments TEXT;

-- Update the mentors table in Supabase types
-- This will be automatically reflected in the types when you run supabase gen types