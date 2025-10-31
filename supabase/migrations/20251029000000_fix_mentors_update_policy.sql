-- Drop the existing restrictive update policy
DROP POLICY IF EXISTS "Users can update own pending mentors" ON public.mentors;

-- Create a new policy that allows users to update their own mentors regardless of status
-- USING clause checks if user owns the mentor (before update)
-- WITH CHECK clause ensures the mentor still belongs to the user (after update)
CREATE POLICY "Users can update own mentors" ON public.mentors 
FOR UPDATE 
USING (created_by_user_id = auth.uid())
WITH CHECK (created_by_user_id = auth.uid());
