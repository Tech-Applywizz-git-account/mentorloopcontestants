import { useState, useEffect } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { toast } from "sonner";
import { useNavigate, useParams } from "react-router-dom";
import { Loader2, ChevronLeft } from "lucide-react";

const EditMentor = () => {
  const { profile } = useAuth();
  const navigate = useNavigate();
  const { id } = useParams();
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [mentorData, setMentorData] = useState<any>(null);

  useEffect(() => {
    fetchMentorData();
  }, [id, profile]);

  const fetchMentorData = async () => {
    if (!profile || !id) return;

    const { data, error } = await supabase
      .from("mentors")
      .select("*")
      .eq("id", id)
      .eq("created_by_user_id", profile.id)
      .single();

    if (error || !data) {
      toast.error("Mentor not found or access denied");
      navigate("/history");
      return;
    }

    setMentorData(data);
    setLoading(false);
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setSaving(true);

    const formData = new FormData(e.currentTarget);
    const linkedinUrl = (formData.get("linkedin_url") as string).trim().toLowerCase();

    // Validate LinkedIn URL format
    const linkedinRegex = /^https:\/\/(www\.)?linkedin\.com\/in\/[a-zA-Z0-9\-_%]+\/?(\?.*)?$/;
    if (!linkedinRegex.test(linkedinUrl)) {
      toast.error("Please enter a valid LinkedIn profile URL (e.g., https://www.linkedin.com/in/username)");
      setSaving(false);
      return;
    }

    // Check for duplicate LinkedIn URL (excluding current mentor)
    const { data: existing } = await supabase
      .from("mentors")
      .select("id")
      .eq("linkedin_url", linkedinUrl)
      .eq("created_by_user_id", profile!.id)
      .neq("id", id)
      .maybeSingle();

    if (existing) {
      toast.error("You have already submitted a mentor with this LinkedIn URL");
      setSaving(false);
      return;
    }

    const { error } = await supabase
      .from("mentors")
      .update({
        mentor_name: formData.get("mentor_name") as string,
        linkedin_url: linkedinUrl,
        phone: formData.get("phone") as string || null,
        email: formData.get("email") as string || null,
        domain: formData.get("domain") as string,
        experience_years: parseInt(formData.get("experience_years") as string),
        previous_domain: formData.get("previous_domain") as string || null,
        edited_by_user_id: profile!.id,
      })
      .eq("id", id)
      .eq("created_by_user_id", profile!.id);

    if (error) {
      toast.error(error.message);
      setSaving(false);
      return;
    }

    toast.success("Mentor updated successfully");
    navigate("/history");
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-[400px]">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!mentorData) {
    return null;
  }

  return (
    <div className="max-w-2xl mx-auto animate-fade-in">
      {/* Back Button */}
      <Button 
        variant="ghost" 
        onClick={() => navigate(-1)}
        className="flex items-center gap-2 text-muted-foreground hover:text-foreground mb-4"
      >
        <ChevronLeft className="h-4 w-4" />
        <span>Back</span>
      </Button>

      <Card className="border-border/50 bg-card/50 backdrop-blur-sm">
        <CardHeader>
          <CardTitle className="text-2xl">Edit Mentor</CardTitle>
          <CardDescription>Update mentor information</CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="grid gap-4 md:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="mentor_name">Mentor Name *</Label>
                <Input 
                  id="mentor_name" 
                  name="mentor_name" 
                  required 
                  placeholder="John Doe"
                  defaultValue={mentorData.mentor_name}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="linkedin_url">LinkedIn URL *</Label>
                <Input
                  id="linkedin_url"
                  name="linkedin_url"
                  required
                  placeholder="https://www.linkedin.com/in/..."
                  type="url"
                  defaultValue={mentorData.linkedin_url}
                />
              </div>
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="phone">Phone</Label>
                <Input 
                  id="phone" 
                  name="phone" 
                  placeholder="+91 98765 43210"
                  defaultValue={mentorData.phone || ""}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="email">Email</Label>
                <Input 
                  id="email" 
                  name="email" 
                  type="email" 
                  placeholder="mentor@example.com"
                  defaultValue={mentorData.email || ""}
                />
              </div>
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="domain">Domain *</Label>
                <Input 
                  id="domain" 
                  name="domain" 
                  required 
                  placeholder="Software Engineering"
                  defaultValue={mentorData.domain}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="experience_years">Experience (years) *</Label>
                <Input
                  id="experience_years"
                  name="experience_years"
                  type="number"
                  required
                  min="0"
                  placeholder="5"
                  defaultValue={mentorData.experience_years}
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="previous_domain">Previous Domain</Label>
              <Input 
                id="previous_domain" 
                name="previous_domain" 
                placeholder="Data Science"
                defaultValue={mentorData.previous_domain || ""}
              />
            </div>

            <div className="flex gap-3">
              <Button 
                type="button" 
                variant="outline" 
                className="flex-1" 
                onClick={() => navigate("/history")}
                disabled={saving}
              >
                Cancel
              </Button>
              <Button type="submit" className="flex-1" disabled={saving}>
                {saving ? (
                  <>
                    <Loader2 className="h-5 w-5 mr-2 animate-spin" />
                    Saving...
                  </>
                ) : (
                  <>Save</>
                )}
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  );
};

export default EditMentor;
