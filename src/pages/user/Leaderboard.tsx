import { useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Trophy, Medal, Award, Loader2, ChevronLeft } from "lucide-react";
import { useNavigate } from "react-router-dom";

const CONTEST_START = new Date("2025-10-21T00:00:00+05:30");
const CONTEST_END = new Date("2025-11-30T23:59:59+05:30");

const Leaderboard = () => {
  const { profile } = useAuth();
  const navigate = useNavigate();
  const [leaderboard, setLeaderboard] = useState<any[]>([]);
  const [userRank, setUserRank] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchLeaderboard();
  }, [profile]);

  const fetchLeaderboard = async () => {
    // Fetch all users with their contest stats
    const { data: profiles } = await supabase.from("profiles").select("*");

    if (!profiles) {
      setLoading(false);
      return;
    }

    const leaderboardData = await Promise.all(
      profiles.map(async (p) => {
        const { data: mentors } = await supabase
          .from("mentors")
          .select("*")
          .eq("created_by_user_id", p.id)
          .gte("created_at", CONTEST_START.toISOString())
          .lte("created_at", CONTEST_END.toISOString());

        const submissions = mentors?.length || 0;
        const onboarded = mentors?.filter((m) => m.status === "onboarded") || [];
        const onboardedCount = onboarded.length;
        
        // Fetch ALL points from points_ledger for accurate calculation (same as user dashboard)
        const { data: allPoints } = await supabase
          .from("points_ledger")
          .select("delta")
          .eq("user_id", p.id);

        // Calculate accurate total points by summing all delta values (same as user dashboard)
        const points = allPoints?.reduce((sum, entry) => sum + entry.delta, 0) || 0;

        // Get latest onboarded timestamp for tie-breaker
        const lastOnboarded = onboarded.length > 0
          ? Math.max(...onboarded.map((m) => new Date(m.updated_at).getTime()))
          : 0;

        return {
          ...p,
          submissions,
          onboarded: onboardedCount,
          points,
          lastOnboarded,
        };
      })
    );

    // Sort by points (desc), then by lastOnboarded (desc for newer)
    const sorted = leaderboardData
      .filter((u) => u.points > 0)
      .sort((a, b) => {
        if (b.points !== a.points) return b.points - a.points;
        return b.lastOnboarded - a.lastOnboarded;
      });

    // Top 20
    const top20 = sorted.slice(0, 20);
    setLeaderboard(top20);

    // Find current user's rank
    const userIndex = sorted.findIndex((u) => u.id === profile?.id);
    if (userIndex !== -1) {
      setUserRank({
        ...sorted[userIndex],
        rank: userIndex + 1,
      });
    }

    setLoading(false);
  };

  const getRankIcon = (rank: number) => {
    if (rank === 1) return <Trophy className="h-6 w-6 text-amber" />;
    if (rank === 2) return <Medal className="h-6 w-6 text-muted-foreground" />;
    if (rank === 3) return <Award className="h-6 w-6 text-[#cd7f32]" />;
    return <span className="text-lg font-bold text-muted-foreground">#{rank}</span>;
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

      <Card className="border-border/50 bg-card/50 backdrop-blur-sm">
        <CardHeader>
          <CardTitle className="flex items-center gap-2 text-xl sm:text-2xl">
            <Trophy className="h-5 w-5 sm:h-6 sm:w-6 text-primary" />
            <span className="hidden sm:inline">Top 20 Leaderboard</span>
            <span className="inline sm:hidden">Leaderboard</span>
          </CardTitle>
          <p className="text-xs sm:text-sm text-muted-foreground">
            Contest: Oct 21 - Nov 30, 2025
          </p>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {leaderboard.map((user, index) => {
              const rank = index + 1;
              const isCurrentUser = user.id === profile?.id;

              return (
                <div
                  key={user.id}
                  className={`flex items-center gap-2 sm:gap-4 p-3 sm:p-4 rounded-lg transition-all ${
                    isCurrentUser
                      ? "bg-primary/10 border-2 border-primary/50"
                      : "bg-muted/30 hover:bg-muted/50"
                  }`}
                >
                  <div className="flex items-center justify-center w-8 sm:w-12 flex-shrink-0">
                    {getRankIcon(rank)}
                  </div>

                  <Avatar className="h-8 w-8 sm:h-10 sm:w-10 border-2 border-primary/30 flex-shrink-0">
                    <AvatarImage src={user.avatar_url} />
                    <AvatarFallback className="bg-primary/20 text-primary text-xs sm:text-base">
                      {user.name?.charAt(0) || "U"}
                    </AvatarFallback>
                  </Avatar>

                  <div className="flex-1 min-w-0">
                    <p className="font-semibold truncate flex items-center gap-1 sm:gap-2 text-sm sm:text-base">
                      <span className="truncate">{user.name}</span>
                      {isCurrentUser && <Badge variant="secondary" className="text-xs flex-shrink-0">You</Badge>}
                    </p>
                    <div className="flex gap-2 sm:gap-4 text-xs text-muted-foreground">
                      <span className="truncate">{user.submissions} sub</span>
                      <span className="truncate">{user.onboarded} onb</span>
                    </div>
                  </div>

                  <div className="text-right flex-shrink-0">
                    <div className="text-lg sm:text-2xl font-bold text-primary">{user.points}</div>
                    <p className="text-xs text-muted-foreground hidden sm:block">points</p>
                  </div>
                </div>
              );
            })}
          </div>

          {userRank && userRank.rank > 20 && (
            <div className="mt-6 pt-6 border-t border-border/50">
              <p className="text-sm text-muted-foreground mb-3">Your Rank</p>
              <div className="flex items-center gap-4 p-4 rounded-lg bg-primary/10 border-2 border-primary/50">
                <div className="flex items-center justify-center w-12">
                  <span className="text-lg font-bold text-primary">#{userRank.rank}</span>
                </div>

                <Avatar className="h-10 w-10 border-2 border-primary/50">
                  <AvatarImage src={userRank.avatar_url} />
                  <AvatarFallback className="bg-primary/20 text-primary">
                    {userRank.name?.charAt(0) || "U"}
                  </AvatarFallback>
                </Avatar>

                <div className="flex-1 min-w-0">
                  <p className="font-semibold truncate">{userRank.name}</p>
                  <div className="flex gap-4 text-xs text-muted-foreground">
                    <span>{userRank.submissions} submissions</span>
                    <span>{userRank.onboarded} onboarded</span>
                  </div>
                </div>

                <div className="text-right">
                  <div className="text-2xl font-bold text-primary">{userRank.points}</div>
                  <p className="text-xs text-muted-foreground">points</p>
                </div>
              </div>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
};

export default Leaderboard;
