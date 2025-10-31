import { useState, useEffect } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/integrations/supabase/client";
import { toast } from "sonner";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Label } from "@/components/ui/label";

const RoleSelector = () => {
  const { user, profile } = useAuth();
  const [selectedRole, setSelectedRole] = useState<'CA' | 'CA TL' | 'TECH' | 'TECH TL' | 'super_admin' | 'user'>("user");
  const [loading, setLoading] = useState(false);

  const roles = ['CA', 'CA TL', 'TECH', 'TECH TL', 'super_admin'] as const;

  useEffect(() => {
    if (profile?.role) {
      setSelectedRole(profile.role as 'CA' | 'CA TL' | 'TECH' | 'TECH TL' | 'super_admin' | 'user');
    }
  }, [profile]);

  const updateRole = async (role: 'CA' | 'CA TL' | 'TECH' | 'TECH TL' | 'super_admin' | 'user') => {
    if (!user) {
      toast.error("You must be logged in to update your role");
      return;
    }

    setLoading(true);
    try {
      const { error } = await supabase
        .from("profiles")
        .update({ role })
        .eq("id", user.id);

      if (error) throw error;

      toast.success("Role updated successfully");
    } catch (error) {
      console.error("Error updating role:", error);
      toast.error("Failed to update role");
    } finally {
      setLoading(false);
    }
  };

  const handleRoleChange = (value: 'CA' | 'CA TL' | 'TECH' | 'TECH TL' | 'super_admin' | 'user') => {
    setSelectedRole(value);
    updateRole(value);
  };

  if (!user) {
    return null;
  }

  return (
    <div className="space-y-2">
      <Label htmlFor="role-select">Select Role</Label>
      <Select value={selectedRole} onValueChange={handleRoleChange} disabled={loading}>
        <SelectTrigger id="role-select" className="w-full">
          <SelectValue placeholder="Select your role" />
        </SelectTrigger>
        <SelectContent>
          {roles.map((role) => (
            <SelectItem key={role} value={role}>
              {role}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
    </div>
  );
};

export default RoleSelector;