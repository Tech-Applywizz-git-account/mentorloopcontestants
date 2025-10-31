-- Drop the existing INSERT policy
DROP POLICY IF EXISTS "Admins can insert points" ON public.points_ledger;

-- Create a new INSERT policy that allows users to insert their own points
CREATE POLICY "Users can insert their own points"
  ON public.points_ledger FOR INSERT
  WITH CHECK (auth.uid() = user_id);