import { useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { toast } from "sonner";
import { useNavigate } from "react-router-dom";
import confetti from "canvas-confetti";
import { CheckCircle2, Loader2, ChevronLeft } from "lucide-react";

const MentorForm = () => {
  const { profile } = useAuth();
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [submitted, setSubmitted] = useState(false);
  const [mentorData, setMentorData] = useState<any>(null);

  const triggerConfetti = () => {
    confetti({
      particleCount: 100,
      spread: 70,
      origin: { y: 0.6 },
      colors: ["#00d9ff", "#00ffc8", "#d4ff00"],
    });
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);
    
    console.log("Profile data:", profile);

    const formData = new FormData(e.currentTarget);
    const linkedinUrl = (formData.get("linkedin_url") as string).trim().toLowerCase();

    // Validate LinkedIn URL format
    const linkedinRegex = /^https:\/\/(www\.)?linkedin\.com\/in\/[a-zA-Z0-9\-_%]+\/?(\?.*)?$/;
    if (!linkedinRegex.test(linkedinUrl)) {
      toast.error("Please enter a valid LinkedIn profile URL (e.g., https://www.linkedin.com/in/username)");
      setLoading(false);
      return;
    }

    // Check for duplicate LinkedIn URL (only for the current user)
    console.log("Checking for duplicate mentor with URL:", linkedinUrl);
    const { data: existing, error: checkError } = await supabase
      .from("mentors")
      .select("id")
      .eq("linkedin_url", linkedinUrl)
      .eq("created_by_user_id", profile!.id)
      .maybeSingle();

    if (checkError) {
      console.error("Error checking for duplicate mentor:", checkError);
    }

    console.log("Duplicate check result:", existing);
    if (existing) {
      toast.error("You have already submitted a mentor with this LinkedIn URL");
      setLoading(false);
      return;
    }

    const mentorPayload = {
      created_by_user_id: profile!.id,
      mentor_name: formData.get("mentor_name") as string,
      linkedin_url: linkedinUrl,
      phone: formData.get("phone") as string || null,
      email: formData.get("email") as string || null,
      domain: formData.get("domain") as string,
      experience_years: parseInt(formData.get("experience_years") as string),
      previous_domain: formData.get("previous_domain") as string || null,
    };

    // Insert mentor
    const { data: mentor, error: mentorError } = await supabase
      .from("mentors")
      .insert(mentorPayload)
      .select()
      .single();

    if (mentorError) {
      toast.error(mentorError.message);
      setLoading(false);
      return;
    }

    // Add points
    const { error: ledgerError } = await supabase.from("points_ledger").insert({
      user_id: profile!.id,
      mentor_id: mentor.id,
      delta: 10,
      reason: "submission",
    });

    if (ledgerError) {
      console.error("Failed to add points to ledger:", ledgerError);
      toast.error("Failed to award points: " + ledgerError.message);
      setLoading(false);
      return;
    }

    // Calculate accurate total points from ledger
    const { data: allPoints } = await supabase
      .from("points_ledger")
      .select("delta")
      .eq("user_id", profile!.id);
    
    const totalPoints = allPoints?.reduce((sum, entry) => sum + entry.delta, 0) || 0;

    triggerConfetti();
    toast.success("Mentor submitted! +10 points 🎯");
    setMentorData({ ...mentorPayload, points: totalPoints });
    setSubmitted(true);
    setLoading(false);
  };

  if (submitted) {
    return (
      <div className="max-w-2xl mx-auto animate-scale-in">
        <Card className="border-primary/50 bg-gradient-to-br from-primary/10 to-secondary/10">
          <CardHeader className="text-center">
            <CheckCircle2 className="h-16 w-16 text-primary mx-auto mb-4 animate-bounce-subtle" />
            <CardTitle className="text-3xl">Mentor Submitted!</CardTitle>
            <CardDescription>You earned +10 points</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="p-4 rounded-lg bg-card/50 space-y-2">
              <p><span className="font-semibold">Name:</span> {mentorData.mentor_name}</p>
              <p><span className="font-semibold">Domain:</span> {mentorData.domain}</p>
              <p><span className="font-semibold">Experience:</span> {mentorData.experience_years} years</p>
              <p><span className="font-semibold">Your Total Points:</span> <span className="text-2xl text-primary font-bold">{mentorData.points}</span></p>
            </div>
            <div className="flex gap-3">
              <Button onClick={() => navigate("/history")} variant="outline" className="flex-1">
                View History
              </Button>
              <Button onClick={() => { setSubmitted(false); setMentorData(null); }} className="flex-1">
                Add Another
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    );
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
          <CardTitle className="text-2xl">Add New Mentor</CardTitle>
          <CardDescription>Submit a mentor and earn 10 points instantly</CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="grid gap-4 md:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="mentor_name">Mentor Name *</Label>
                <Input id="mentor_name" name="mentor_name" required placeholder="John Doe" />
              </div>
              <div className="space-y-2">
                <Label htmlFor="linkedin_url">LinkedIn URL *</Label>
                <Input
                  id="linkedin_url"
                  name="linkedin_url"
                  required
                  placeholder="https://www.linkedin.com/in/..."
                  type="url"
                />
              </div>
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="phone">Phone</Label>
                <Input id="phone" name="phone" placeholder="+91 98765 43210" />
              </div>
              <div className="space-y-2">
                <Label htmlFor="email">Email</Label>
                <Input id="email" name="email" type="email" placeholder="mentor@example.com" />
              </div>
            </div>

            <div className="grid gap-4 md:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="domain">Domain *</Label>
                <Input id="domain" name="domain" required placeholder="Software Engineering" />
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
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="previous_domain">Previous Domain</Label>
              <Input id="previous_domain" name="previous_domain" placeholder="Data Science" />
            </div>

            <Button type="submit" className="w-full h-12 text-lg" disabled={loading}>
              {loading ? (
                <>
                  <Loader2 className="h-5 w-5 mr-2 animate-spin" />
                  Submitting...
                </>
              ) : (
                <>Submit Mentor (+10 pts)</>
              )}
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
};

export default MentorForm;
