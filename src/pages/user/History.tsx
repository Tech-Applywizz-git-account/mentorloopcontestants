import { useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Pencil, ExternalLink, Loader2, ChevronLeft } from "lucide-react";
import { useNavigate } from "react-router-dom";

const History = () => {
  const { profile } = useAuth();
  const navigate = useNavigate();
  const [mentors, setMentors] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchMentors();
  }, [profile]);

  const fetchMentors = async () => {
    if (!profile) return;

    const { data } = await supabase
      .from("mentors")
      .select("*")
      .eq("created_by_user_id", profile.id)
      .order("created_at", { ascending: false });

    setMentors(data || []);
    setLoading(false);
  };

  const getStatusBadge = (status: string) => {
    const variants: any = {
      pending: "secondary",
      onboarded: "default",
      declined: "destructive",
    };
    return <Badge variant={variants[status]}>{status}</Badge>;
  };

  const MentorTable = ({ mentors, showEdit }: { mentors: any[]; showEdit: boolean }) => (
    <div className="rounded-lg border border-border/50 overflow-hidden">
      <div className="overflow-x-auto">
        <table className="w-full">
          <thead className="bg-muted/50">
            <tr>
              <th className="text-left p-3 text-sm font-medium">S.No</th>
              <th className="text-left p-3 text-sm font-medium">Name</th>
              <th className="text-left p-3 text-sm font-medium">Domain</th>
              <th className="text-left p-3 text-sm font-medium">Experience</th>
              <th className="text-left p-3 text-sm font-medium">Status</th>
              <th className="text-left p-3 text-sm font-medium">Options</th>
            </tr>
          </thead>
          <tbody>
            {mentors.length === 0 ? (
              <tr>
                <td colSpan={6} className="text-center p-8 text-muted-foreground">
                  No mentors found
                </td>
              </tr>
            ) : (
              mentors.map((mentor, index) => (
                <tr key={mentor.id} className="border-t border-border/50 hover:bg-muted/30 transition-colors">
                  <td className="p-3 text-sm">{index + 1}</td>
                  <td className="p-3">
                    <div>
                      <p className="font-medium">{mentor.mentor_name}</p>
                      {mentor.email && <p className="text-xs text-muted-foreground">{mentor.email}</p>}
                    </div>
                  </td>
                  <td className="p-3 text-sm">{mentor.domain}</td>
                  <td className="p-3 text-sm">{mentor.experience_years} yrs</td>
                  <td className="p-3">{getStatusBadge(mentor.status)}</td>
                  <td className="p-3">
                    <div className="flex gap-2">
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={() => window.open(mentor.linkedin_url, "_blank")}
                      >
                        <ExternalLink className="h-4 w-4" />
                      </Button>
                      {showEdit && (
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => navigate(`/dashboard/edit-mentor/${mentor.id}`)}
                        >
                          <Pencil className="h-4 w-4" />
                        </Button>
                      )}
                    </div>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
    </div>
  );

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-[400px]">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  return (
    <div className="space-y-6 animate-fade-in">
      {/* Back Button */}
      <Button 
        variant="ghost" 
        onClick={() => navigate(-1)}
        className="flex items-center gap-2 text-muted-foreground hover:text-foreground"
      >
        <ChevronLeft className="h-4 w-4" />
        <span>Back</span>
      </Button>

      <Card className="border-border/50 bg-card/50 backdrop-blur-sm">
        <CardHeader>
          <CardTitle>Mentor History</CardTitle>
        </CardHeader>
        <CardContent>
          <Tabs defaultValue="current" className="w-full">
            <TabsList className="grid w-full max-w-full sm:max-w-2xl grid-cols-3">
              <TabsTrigger value="current">Current</TabsTrigger>
              <TabsTrigger value="declined">Declined</TabsTrigger>
              <TabsTrigger value="onboarded">Onboarded</TabsTrigger>
            </TabsList>
            <TabsContent value="current" className="mt-6">
              <MentorTable
                mentors={mentors.filter((m) => m.status === "pending")}
                showEdit={true}
              />
            </TabsContent>
            <TabsContent value="declined" className="mt-6">
              <MentorTable
                mentors={mentors.filter((m) => m.status === "declined")}
                showEdit={true}
              />
            </TabsContent>
            <TabsContent value="onboarded" className="mt-6">
              <MentorTable
                mentors={mentors.filter((m) => m.status === "onboarded")}
                showEdit={false}
              />
            </TabsContent>
          </Tabs>
        </CardContent>
      </Card>
    </div>
  );
};

export default History;
