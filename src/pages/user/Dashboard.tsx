import { useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Progress } from "@/components/ui/progress";
import { Plus, TrendingUp, Target, Award, Zap, ChevronDown, Search, Check } from "lucide-react";
import { useNavigate } from "react-router-dom";
import { Badge } from "@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Input } from "@/components/ui/input";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

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
  const [mentors, setMentors] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  // State to track engagement status for each mentor
  const [mentorEngagement, setMentorEngagement] = useState<Record<string, string>>({});
  // State to track which mentors have been awarded points
  const [pointsAwarded, setPointsAwarded] = useState<Record<string, Record<string, boolean>>>({});
  // State for search functionality
  const [searchTerm, setSearchTerm] = useState("");

  useEffect(() => {
    fetchDashboardData();
  }, [profile]);

  const fetchDashboardData = async () => {
    if (!profile) return;

    // Fetch contest window stats
    const { data: mentorsData } = await supabase
      .from("mentors")
      .select("*")
      .eq("created_by_user_id", profile.id)
      .gte("created_at", CONTEST_START.toISOString())
      .lte("created_at", CONTEST_END.toISOString());

    const submissions = mentorsData?.length || 0;
    const onboarded = mentorsData?.filter((m) => m.status === "onboarded").length || 0;

    // Set mentors data for the table
    setMentors(mentorsData || []);

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

  const getStatusBadge = (status: string) => {
    switch (status) {
      case 'pending':
        return <Badge variant="secondary">Pending</Badge>;
      case 'onboarded':
        return <Badge variant="default">Onboarded</Badge>;
      case 'declined':
        return <Badge variant="destructive">Declined</Badge>;
      default:
        return <Badge variant="outline">Unknown</Badge>;
    }
  };

  // Function to handle mentor engagement status updates
  const handleEngagementUpdate = (mentorId: string, status: string) => {
    setMentorEngagement(prev => ({
      ...prev,
      [mentorId]: status
    }));
    
    // In a real implementation, you would save this to the database
    // For now, we'll just show an alert
    alert(`Marked mentor as: ${status}`);
  };

  // Function to handle awarding points for engagement
  const handleAwardPoints = async (mentorId: string, status: string, mentor: any) => {
    // Check if points have already been awarded for this mentor and status
    if (pointsAwarded[mentorId]?.[status]) {
      if (confirm('Points already awarded for this action. Do you want to continue?')) {
        return;
      }
    }

    // Determine points based on status
    const points = status === "Positive Engagement" ? 15 : 10;

    try {
      // Award points to the mentor's owner
      const { error } = await supabase.from('points_ledger').insert({
        user_id: mentor.created_by_user_id,
        mentor_id: mentorId,
        delta: points,
        reason: 'onboard'
      });

      if (error) throw error;

      // Update local state to mark points as awarded
      setPointsAwarded(prev => ({
        ...prev,
        [mentorId]: {
          ...prev[mentorId],
          [status]: true
        }
      }));

      // Update the stats to reflect new points
      setStats(prev => ({
        ...prev,
        totalPoints: prev.totalPoints + points
      }));

      if (!confirm(`${points} points awarded to mentor owner for: ${status}. Do you want to continue?`)) {
        return;
      }
    } catch (error) {
      console.error('Error awarding points:', error);
      if (!confirm('Error awarding points. Do you want to continue?')) {
        return;
      }
    }
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
        onClick={() => navigate("/dashboard/mentor-form")}
      >
        <Plus className="h-5 w-5 sm:h-6 sm:w-6 mr-2" />
        <span className="hidden xs:inline">Add Mentor Now</span>
        <span className="inline xs:hidden">Add Mentor</span>
        <Zap className="h-4 w-4 sm:h-5 sm:w-5 ml-2 text-accent" />
      </Button>

      {/* Mentors Table */}
      <Card className="border-border/50 bg-card/50 backdrop-blur-sm">
        <CardHeader>
          <CardTitle>My Mentors</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="mb-4">
            <div className="relative">
              <Search className="absolute left-2 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
              <Input
                placeholder="Search mentors by name..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="pl-8"
              />
            </div>
          </div>
          
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>S.No</TableHead>
                <TableHead>Mentor Name</TableHead>
                <TableHead>LinkedIn</TableHead>
                <TableHead>Domain</TableHead>
                <TableHead>Submitted At</TableHead>
                <TableHead>Status</TableHead>
                <TableHead className="text-right">Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {mentors.length > 0 ? (
                mentors
                  .filter(mentor => 
                    mentor.mentor_name.toLowerCase().includes(searchTerm.toLowerCase())
                  )
                  .map((mentor, index) => (
                    <TableRow key={mentor.id}>
                      <TableCell>{index + 1}</TableCell>
                      <TableCell className="font-medium">
                        <div className="flex items-center gap-2">
                          <span>{mentor.mentor_name}</span>
                          {mentor.edited_by_user_id && (
                            <div className="relative">
                              <div className="h-2 w-2 rounded-full bg-red-500 animate-pulse" />
                              <div className="absolute -top-1 -right-1 h-3 w-3 rounded-full bg-red-500 opacity-75 animate-ping" />
                            </div>
                          )}
                        </div>
                      </TableCell>
                      <TableCell>
                        <a 
                          href={mentor.linkedin_url} 
                          target="_blank" 
                          rel="noopener noreferrer" 
                          className="text-blue-500 hover:underline"
                        >
                          LinkedIn Profile
                        </a>
                      </TableCell>
                      <TableCell>{mentor.domain}</TableCell>
                      <TableCell>{new Date(mentor.created_at).toLocaleDateString()}</TableCell>
                      <TableCell>{getStatusBadge(mentor.status)}</TableCell>
                      <TableCell className="text-right">
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" size="sm">
                              <ChevronDown className="h-4 w-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem 
                              onClick={() => {
                                handleEngagementUpdate(mentor.id, "Connection Accepted");
                                handleAwardPoints(mentor.id, "Connection Accepted", mentor);
                              }}
                            >
                              Connection Accepted
                              {mentorEngagement[mentor.id] === "Connection Accepted" && (
                                <Check className="ml-2 h-4 w-4 text-green-500" />
                              )}
                            </DropdownMenuItem>
                            <DropdownMenuItem 
                              onClick={() => {
                                handleEngagementUpdate(mentor.id, "Positive Engagement");
                                handleAwardPoints(mentor.id, "Positive Engagement", mentor);
                              }}
                            >
                              Positive Engagement
                              {mentorEngagement[mentor.id] === "Positive Engagement" && (
                                <Check className="ml-2 h-4 w-4 text-green-500" />
                              )}
                            </DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>
                  ))
              ) : (
                <TableRow>
                  <TableCell colSpan={7} className="text-center text-muted-foreground">
                    No mentors found. Submit your first mentor to get started!
                  </TableCell>
                </TableRow>
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
};

export default Dashboard;
