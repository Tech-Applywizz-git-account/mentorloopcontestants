import { useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { Badge } from "@/components/ui/badge";
import { Award, TrendingUp, Target, Loader2, ChevronLeft } from "lucide-react";
import { useNavigate } from "react-router-dom";

const BADGES = [
  { name: "Bronze Closer", threshold: 100, color: "text-[#cd7f32]" },
  { name: "Silver Closer", threshold: 250, color: "text-muted-foreground" },
  { name: "Gold Closer", threshold: 500, color: "text-amber" },
];

const Score = () => {
  const { profile } = useAuth();
  const navigate = useNavigate();
  const [ledger, setLedger] = useState<any[]>([]);
  const [stats, setStats] = useState({ submission: 0, onboard: 0, totalPoints: 0 });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchScoreData();
  }, [profile]);

  const fetchScoreData = async () => {
    if (!profile) return;

    const { data } = await supabase
      .from("points_ledger")
      .select("*, mentors(mentor_name)")
      .eq("user_id", profile.id)
      .order("created_at", { ascending: false });

    if (data) {
      setLedger(data);
      const submission = data
        .filter((l) => l.reason === "submission")
        .reduce((sum, l) => sum + l.delta, 0);
      const onboard = data
        .filter((l) => l.reason === "onboard")
        .reduce((sum, l) => sum + l.delta, 0);
      // Calculate accurate total points from all ledger entries
      const totalPoints = data.reduce((sum, l) => sum + l.delta, 0);
      setStats({ submission, onboard, totalPoints });
    }

    setLoading(false);
  };

  const getBadgeProgress = (threshold: number) => {
    const points = stats.totalPoints;
    if (points >= threshold) return 100;
    const previousThreshold = threshold === 100 ? 0 : threshold === 250 ? 100 : 250;
    const range = threshold - previousThreshold;
    const progress = points - previousThreshold;
    return Math.max(0, Math.min(100, (progress / range) * 100));
  };

  const isBadgeUnlocked = (threshold: number) => {
    return stats.totalPoints >= threshold;
  };

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

      {/* Points Summary */}
      <div className="grid gap-3 sm:gap-4 grid-cols-1 sm:grid-cols-2 md:grid-cols-3">
        <Card className="border-border/50 bg-gradient-to-br from-primary/10 to-transparent">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium flex items-center gap-2">
              <Award className="h-4 w-4 text-primary" />
              Total Points
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl sm:text-4xl font-bold text-primary">{stats.totalPoints}</div>
          </CardContent>
        </Card>

        <Card className="border-border/50 bg-gradient-to-br from-secondary/10 to-transparent">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium flex items-center gap-2">
              <TrendingUp className="h-4 w-4 text-secondary" />
              Submission Points
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl sm:text-4xl font-bold text-secondary">{stats.submission}</div>
          </CardContent>
        </Card>

        <Card className="border-border/50 bg-gradient-to-br from-accent/10 to-transparent">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium flex items-center gap-2">
              <Target className="h-4 w-4 text-accent" />
              Onboard Points
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl sm:text-4xl font-bold text-accent">{stats.onboard}</div>
          </CardContent>
        </Card>
      </div>

      {/* Badges */}
      <Card className="border-border/50 bg-card/50 backdrop-blur-sm">
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Award className="h-5 w-5 text-primary" />
            Badge Progression
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-6">
          {BADGES.map((badge) => {
            const isUnlocked = isBadgeUnlocked(badge.threshold);
            const progress = getBadgeProgress(badge.threshold);

            return (
              <div
                key={badge.name}
                className={`p-4 rounded-lg border-2 transition-all ${
                  isUnlocked
                    ? "border-primary/50 bg-primary/5"
                    : "border-border/50 bg-muted/20"
                }`}
              >
                <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 sm:gap-0 mb-3">
                  <div className="flex items-center gap-2 sm:gap-3">
                    <Award className={`h-6 w-6 sm:h-8 sm:w-8 flex-shrink-0 ${isUnlocked ? badge.color : "text-muted-foreground"}`} />
                    <div>
                      <h3 className="font-semibold text-sm sm:text-base">{badge.name}</h3>
                      <p className="text-xs sm:text-sm text-muted-foreground">{badge.threshold} points</p>
                    </div>
                  </div>
                  {isUnlocked && (
                    <Badge className="animate-pulse self-start sm:self-auto">Unlocked!</Badge>
                  )}
                </div>
                <Progress value={progress} className="h-2" />
                {!isUnlocked && (
                  <p className="text-xs text-muted-foreground mt-2">
                    {badge.threshold - stats.totalPoints} points to unlock
                  </p>
                )}
              </div>
            );
          })}
        </CardContent>
      </Card>

      {/* Timeline */}
      <Card className="border-border/50 bg-card/50 backdrop-blur-sm">
        <CardHeader>
          <CardTitle>Points Timeline</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {ledger.length === 0 ? (
              <p className="text-sm text-muted-foreground text-center py-8">
                No points history yet
              </p>
            ) : (
              ledger.map((entry) => (
                <div
                  key={entry.id}
                  className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 sm:gap-0 p-3 rounded-lg bg-muted/30 hover:bg-muted/50 transition-colors"
                >
                  <div className="min-w-0">
                    <p className="font-medium text-sm sm:text-base truncate">
                      {entry.reason === "submission" ? "Submitted" : "Onboarded"}: {entry.mentors?.mentor_name}
                    </p>
                    <p className="text-xs text-muted-foreground">
                      {new Date(entry.created_at).toLocaleString()}
                    </p>
                  </div>
                  <Badge
                    variant={entry.reason === "onboard" ? "default" : "secondary"}
                    className="text-base sm:text-lg self-start sm:self-auto"
                  >
                    +{entry.delta}
                  </Badge>
                </div>
              ))
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default Score;
