import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Users, TrendingUp, Target, Award } from "lucide-react";

const CONTEST_START = new Date("2025-10-21T00:00:00+05:30");
const CONTEST_END = new Date("2025-11-30T23:59:59+05:30");

const Overview = () => {
  const [kpis, setKpis] = useState({
    totalMentors: 0,
    totalOnboarded: 0,
    totalPoints: 0,
    activeCAs: 0,
  });

  useEffect(() => {
    fetchKPIs();
  }, []);

  const fetchKPIs = async () => {
    const { data: mentors } = await supabase
      .from("mentors")
      .select("*")
      .gte("created_at", CONTEST_START.toISOString())
      .lte("created_at", CONTEST_END.toISOString());

    const totalMentors = mentors?.length || 0;
    const totalOnboarded = mentors?.filter((m) => m.status === "onboarded").length || 0;
    const totalPoints = totalMentors * 10 + totalOnboarded * 15;
    const activeCAs = new Set(mentors?.map((m) => m.created_by_user_id)).size;

    setKpis({ totalMentors, totalOnboarded, totalPoints, activeCAs });
  };

  return (
    <div className="space-y-6 animate-fade-in">
      <h1 className="text-3xl font-bold">Contest Overview</h1>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <Card className="border-primary/50 bg-gradient-to-br from-primary/10 to-transparent">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm flex items-center gap-2">
              <TrendingUp className="h-4 w-4" />
              Total Submitted
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{kpis.totalMentors}</div>
          </CardContent>
        </Card>

        <Card className="border-secondary/50 bg-gradient-to-br from-secondary/10 to-transparent">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm flex items-center gap-2">
              <Target className="h-4 w-4" />
              Total Onboarded
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{kpis.totalOnboarded}</div>
          </CardContent>
        </Card>

        <Card className="border-accent/50 bg-gradient-to-br from-accent/10 to-transparent">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm flex items-center gap-2">
              <Award className="h-4 w-4" />
              Points Awarded
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{kpis.totalPoints}</div>
          </CardContent>
        </Card>

        <Card className="border-border/50 bg-muted/20">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm flex items-center gap-2">
              <Users className="h-4 w-4" />
              Active CAs
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{kpis.activeCAs}</div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default Overview;
