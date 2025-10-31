import { useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Progress } from "@/components/ui/progress";
import { Plus, TrendingUp, Target, Award, Zap } from "lucide-react";
import { useNavigate } from "react-router-dom";
import { Badge } from "@/components/ui/badge";


const CONTEST_START = new Date("2025-10-21T00:00:00+05:30");
const CONTEST_END = new Date("2025-11-30T23:59:59+05:30");

const Dashboard = () => {
  const { profile } = useAuth();
  const navigate = useNavigate();
  const [stats, setStats] = useState({
    submissions: 0,
    onboarded: 0,
    totalPoints: 0,
  });
  const [recentActivity, setRecentActivity] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchDashboardData();
  }, [profile]);

  const fetchDashboardData = async () => {
    if (!profile) return;

    // Fetch contest window stats
    const { data: mentors } = await supabase
      .from("mentors")
      .select("*")
      .eq("created_by_user_id", profile.id)
      .gte("created_at", CONTEST_START.toISOString())
      .lte("created_at", CONTEST_END.toISOString());

    const submissions = mentors?.length || 0;
    const onboarded = mentors?.filter((m) => m.status === "onboarded").length || 0;

    // Fetch ALL points from points_ledger (accurate calculation)
    const { data: allPoints } = await supabase
      .from("points_ledger")
      .select("delta")
      .eq("user_id", profile.id);

    // Calculate accurate total points by summing all delta values
    const totalPoints = allPoints?.reduce((sum, entry) => sum + entry.delta, 0) || 0;

    // Fetch recent activity
    const { data: ledger } = await supabase
      .from("points_ledger")
      .select("*, mentors(mentor_name)")
      .eq("user_id", profile.id)
      .order("created_at", { ascending: false })
      .limit(5);

    setStats({
      submissions,
      onboarded,
      totalPoints,
    });
    setRecentActivity(ledger || []);
    setLoading(false);
  };

  const getBadgeProgress = () => {
    const points = stats.totalPoints;
    if (points >= 500) return { level: "Gold", progress: 100, next: null };
    if (points >= 250) return { level: "Silver", progress: ((points - 250) / 250) * 100, next: 500 };
    if (points >= 100) return { level: "Bronze", progress: ((points - 100) / 150) * 100, next: 250 };
    return { level: "None", progress: (points / 100) * 100, next: 100 };
  };

  const badgeProgress = getBadgeProgress();

  if (loading) {
    return <div className="animate-pulse">Loading...</div>;
  }

  return (
    <div className="space-y-6 animate-fade-in">
      {/* Hero Section */}
      <div className="relative overflow-hidden rounded-2xl md:rounded-3xl bg-gradient-to-br from-primary/20 via-secondary/20 to-accent/20 p-4 sm:p-6 md:p-8 border border-primary/20">
        <div className="absolute inset-0 bg-grid-white/10" />
        <div className="relative flex flex-col md:flex-row md:items-center justify-between gap-4 md:gap-6">
          <div className="flex items-center gap-3 md:gap-4">
            <Avatar className="h-12 w-12 sm:h-14 sm:w-14 md:h-16 md:w-16 border-2 md:border-4 border-primary/50 animate-glow-pulse">
              <AvatarImage src={profile?.avatar_url} />
              <AvatarFallback className="bg-primary/20 text-primary text-xl md:text-2xl">
                {profile?.name?.charAt(0) || "U"}
              </AvatarFallback>
            </Avatar>
            <div>
              <h1 className="text-xl sm:text-2xl md:text-3xl font-bold break-words">Welcome back, {profile?.name}!</h1>
              <p className="text-xs sm:text-sm text-muted-foreground">Ready to climb the leaderboard?</p>
            </div>
          </div>
          <div className="flex flex-col items-start md:items-end gap-1 md:gap-2">
            <div className="text-left md:text-right">
              <div className="text-3xl sm:text-4xl md:text-5xl font-bold text-primary animate-shimmer bg-gradient-to-r from-primary via-secondary to-accent bg-clip-text text-transparent bg-[length:200%_100%]">
                {stats.totalPoints}
              </div>
              <p className="text-xs sm:text-sm text-muted-foreground">Total Points</p>
            </div>

          </div>
        </div>
      </div>

      {/* Stats Grid */}
      <div className="grid gap-3 sm:gap-4 grid-cols-1 sm:grid-cols-2 md:grid-cols-3">
        <Card className="border-border/50 bg-card/50 backdrop-blur-sm hover:border-primary/50 transition-all">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium">Submissions</CardTitle>
            <TrendingUp className="h-4 w-4 text-primary" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{stats.submissions}</div>
            <p className="text-xs text-muted-foreground mt-1">This contest</p>
          </CardContent>
        </Card>

        <Card className="border-border/50 bg-card/50 backdrop-blur-sm hover:border-secondary/50 transition-all">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium">Onboarded</CardTitle>
            <Target className="h-4 w-4 text-secondary" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-secondary">{stats.onboarded}</div>
            <p className="text-xs text-muted-foreground mt-1">Approved mentors</p>
          </CardContent>
        </Card>

        <Card className="border-border/50 bg-card/50 backdrop-blur-sm hover:border-accent/50 transition-all">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium">Badge Progress</CardTitle>
            <Award className="h-4 w-4 text-accent" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-accent">{badgeProgress.level}</div>
            <Progress value={badgeProgress.progress} className="mt-2" />
            {badgeProgress.next && (
              <p className="text-xs text-muted-foreground mt-1">
                {badgeProgress.next - stats.totalPoints} pts to next level
              </p>
            )}
          </CardContent>
        </Card>
      </div>

      {/* CTA Button */}
      <Button
        size="lg"
        className="w-full h-14 sm:h-16 text-base sm:text-lg font-semibold animate-glow-pulse"
        onClick={() => navigate("/mentor-form")}
      >
        <Plus className="h-5 w-5 sm:h-6 sm:w-6 mr-2" />
        <span className="hidden xs:inline">Add Mentor Now</span>
        <span className="inline xs:hidden">Add Mentor</span>
        <Zap className="h-4 w-4 sm:h-5 sm:w-5 ml-2 text-accent" />
      </Button>

      {/* Recent Activity */}
      <Card className="border-border/50 bg-card/50 backdrop-blur-sm">
        <CardHeader>
          <CardTitle>Recent Activity</CardTitle>
        </CardHeader>
        <CardContent>
          {recentActivity.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-8">
              No activity yet. Submit your first mentor to get started!
            </p>
          ) : (
            <div className="space-y-3">
              {recentActivity.map((item) => (
                <div
                  key={item.id}
                  className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 sm:gap-0 p-3 rounded-lg bg-muted/50 hover:bg-muted transition-colors"
                >
                  <div className="flex items-center gap-2 sm:gap-3">
                    {item.reason === "submission" ? (
                      <TrendingUp className="h-4 w-4 sm:h-5 sm:w-5 text-primary flex-shrink-0" />
                    ) : (
                      <Award className="h-4 w-4 sm:h-5 sm:w-5 text-secondary flex-shrink-0" />
                    )}
                    <div className="min-w-0">
                      <p className="text-xs sm:text-sm font-medium truncate">
                        {item.reason === "submission" ? "Submitted" : "Onboarded"}: {item.mentors?.mentor_name}
                      </p>
                      <p className="text-xs text-muted-foreground">
                        {new Date(item.created_at).toLocaleDateString()}
                      </p>
                    </div>
                  </div>
                  <Badge variant={item.delta > 10 ? "default" : "secondary"} className="self-start sm:self-auto">
                    +{item.delta} pts
                  </Badge>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
};

export default Dashboard;
