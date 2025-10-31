-- Create Admin User Script
-- Run this in Supabase SQL Editor to create admin account

-- Step 1: Check if user already exists
DO $$
DECLARE
  admin_user_id UUID;
BEGIN
  -- Look for existing user with this email
  SELECT id INTO admin_user_id
  FROM auth.users
  WHERE email = 'nithinerroju21120@gmail.com';

  -- If user exists, update their role to super_admin
  IF admin_user_id IS NOT NULL THEN
    UPDATE public.profiles
    SET role = 'super_admin'
    WHERE id = admin_user_id;
    
    RAISE NOTICE 'Admin role assigned to existing user: %', admin_user_id;
  ELSE
    RAISE NOTICE 'User does not exist yet. Please sign up first with email: nithinerroju21120@gmail.com and password: Nithin@1092';
    RAISE NOTICE 'After signing up, run this script again to convert to admin.';
  END IF;
END $$;

-- Alternative: If you want to check the current users
SELECT id, email, 
       CASE 
         WHEN id IN (SELECT id FROM public.profiles WHERE role = 'super_admin') 
         THEN 'super_admin' 
         ELSE 'user' 
       END as role
FROM auth.users
ORDER BY created_at DESC;
