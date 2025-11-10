//src/pages/user/Dashboard.tsx
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { 
  Table, 
  TableBody, 
  TableCell, 
  TableHead, 
  TableHeader, 
  TableRow 
} from "@/components/ui/table";
import { 
  DropdownMenu, 
  DropdownMenuContent, 
  DropdownMenuItem, 
  DropdownMenuTrigger 
} from "@/components/ui/dropdown-menu";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Progress } from "@/components/ui/progress";
import { 
  ChevronDown, 
  Check, 
  Calendar, 
  Users, 
  Trophy,
  MessageSquare,
  Save,
  X,
  TrendingUp,
  Target,
  Award,
  Plus,
  Zap,
  Search,
  ChevronLeft,
  ChevronRight
} from "lucide-react";
import { useToast } from "@/hooks/use-toast";

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
  // State for pagination
  const [currentPage, setCurrentPage] = useState(1);
  const recordsPerPage = 7;
  // State for engagement popup
  const [engagementPopup, setEngagementPopup] = useState<{
    isOpen: boolean;
    mentorId: string;
    status: string;
    mentor: any;
    message: string;
  } | null>(null);
  const [engagementComment, setEngagementComment] = useState('');
  const [existingComments, setExistingComments] = useState<Record<string, string>>({});

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
      .lte("created_at", CONTEST_END.toISOString())
      .order("created_at", { ascending: false }); // Order by created_at in descending order

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

    // Fetch current engagement status for each mentor
    if (mentorsData && mentorsData.length > 0) {
      const updatedEngagementStatus: Record<string, string> = {};
      
      for (const mentor of mentorsData) {
        const { data: pointsData } = await supabase
          .from("points_ledger")
          .select("reason, delta")
          .eq("mentor_id", mentor.id)
          .eq("user_id", profile.id)
          .limit(1);
        
        if (pointsData && pointsData.length > 0) {
          const reason = pointsData[0].reason;
          // Map reason to display text
          switch (reason) {
            case 'submission':
              updatedEngagementStatus[mentor.id] = "Submitted";
              break;
            case 'connection_accepted':
              updatedEngagementStatus[mentor.id] = "Connection Accepted";
              break;
            case 'positive_engagement':
              updatedEngagementStatus[mentor.id] = "Positive Engagement";
              break;
            case 'onboard':
              updatedEngagementStatus[mentor.id] = "Onboarded";
              break;
            default:
              updatedEngagementStatus[mentor.id] = reason;
          }
        }
      }
      
      setMentorEngagement(updatedEngagementStatus);
    }

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
  const handleEngagementUpdate = async (mentorId: string, status: string, comment: string = '') => {
    setMentorEngagement(prev => ({
      ...prev,
      [mentorId]: status
    }));
    
    // Always update comments in database
    try {
      const { error: updateError } = await supabase
        .from('mentors')
        .update({ comments: comment })
        .eq('id', mentorId);

      if (updateError) {
        console.error('Error saving comment:', updateError);
        alert('Error saving comment. Please try again.');
        return false;
      }
      
      // Update local state
      setExistingComments(prev => ({
        ...prev,
        [mentorId]: comment
      }));
      
      return true;
    } catch (error) {
      console.error('Error saving comment:', error);
      alert('Error saving comment. Please try again.');
      return false;
    }
  };

  // Function to handle awarding points for engagement
  const handleAwardPoints = async (mentorId: string, status: string, mentor: any) => {
    try {
      // Check if a record already exists for this mentor and user
      const { data: existingRecords, error: fetchError } = await supabase
        .from('points_ledger')
        .select('id, delta, reason')
        .eq('mentor_id', mentorId)
        .eq('user_id', mentor.created_by_user_id);

      if (fetchError) throw fetchError;

      if (existingRecords && existingRecords.length > 0) {
        // Record exists, determine next stage based on current reason and status
        const existingRecord = existingRecords[0];
        let newDelta = existingRecord.delta;
        let newReason = existingRecord.reason;

        // Implement the flow: submission -> connection_accepted -> positive_engagement -> onboard
        if (existingRecord.reason === 'submission' && status === "Connection Accepted") {
          newDelta = existingRecord.delta + 10; // 10 + 10 = 20
          newReason = 'connection_accepted';
        } else if (existingRecord.reason === 'connection_accepted' && status === "Positive Engagement") {
          newDelta = existingRecord.delta + 15; // 20 + 15 = 35
          newReason = 'positive_engagement';
        } else if (existingRecord.reason === 'positive_engagement' && (status === "Onboarded" || status === "onboarded")) {
          newDelta = existingRecord.delta + 10; // 35 + 10 = 45
          newReason = 'onboard';
        } else {
          window.alert(`Invalid transition from ${existingRecord.reason} (${existingRecord.delta} points) to ${status}`);
          return;
        }

        // Update the record with new delta and reason
        const { error: updateError } = await supabase
          .from('points_ledger')
          .update({ delta: newDelta, reason: newReason })
          .eq('id', existingRecord.id);

        if (updateError) throw updateError;

        window.alert(`Points updated successfully. New total: ${newDelta} points with reason: ${newReason}`);
        
        // Update local state to mark engagement
        handleEngagementUpdate(mentorId, status);
      } else {
        // No existing record, insert initial record for submission
        const { error: insertError } = await supabase.from('points_ledger').insert({
          user_id: mentor.created_by_user_id,
          mentor_id: mentorId,
          delta: 10, // Initial 10 points for submission
          reason: 'submission'
        });

        if (insertError) throw insertError;

        window.alert("Initial 10 points awarded for submission.");
        
        // Update local state to mark engagement
        handleEngagementUpdate(mentorId, status);
      }

      // Refresh the data to ensure consistency
      fetchDashboardData();
    } catch (error) {
      console.error('Error awarding points:', error);
      window.alert('Error awarding points. Please try again.');
    }
  };

  // Function to handle comment updates
  // const handleUpdateComment = (mentorId: string, comment: string) => {
  //   setComments(prev => ({
  //     ...prev,
  //     [mentorId]: comment
  //   }));
  // };

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
                <TableHead className="text-center">Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {mentors.length > 0 ? (
                (() => {
                  // Calculate pagination
                  const filteredMentors = mentors.filter(mentor => 
                    mentor.mentor_name.toLowerCase().includes(searchTerm.toLowerCase())
                  );
                  const indexOfLastRecord = currentPage * recordsPerPage;
                  const indexOfFirstRecord = indexOfLastRecord - recordsPerPage;
                  const currentRecords = filteredMentors.slice(indexOfFirstRecord, indexOfLastRecord);
                  
                  return currentRecords.map((mentor, index) => (
                    <TableRow key={mentor.id}>
                      <TableCell>{indexOfFirstRecord + index + 1}</TableCell>
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
                      <TableCell className="text-center">
                        <div className="flex items-center justify-center gap-2">
                          {/* Display current reason/status */}
                          {mentorEngagement[mentor.id] && (
                            <span className="text-sm text-muted-foreground">
                              {mentorEngagement[mentor.id]}
                            </span>
                          )}
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" size="sm">
                                <ChevronDown className="h-4 w-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent align="center" side="bottom">
                              <DropdownMenuItem 
                                onClick={async () => {
                                  // Fetch existing comments for this mentor
                                  const { data: mentorData } = await supabase
                                    .from('mentors')
                                    .select('comments')
                                    .eq('id', mentor.id)
                                    .single();
                                  
                                  setEngagementComment(mentorData?.comments || '');
                                  setExistingComments(prev => ({
                                    ...prev,
                                    [mentor.id]: mentorData?.comments || ''
                                  }));
                                  
                                  setEngagementPopup({
                                    isOpen: true,
                                    mentorId: mentor.id,
                                    status: "Connection Accepted",
                                    mentor: mentor,
                                    message: `Marking mentor as: Connection Accepted`
                                  });
                                }}
                              >
                                Connection Accepted
                                {mentorEngagement[mentor.id] === "Connection Accepted" && (
                                  <Check className="ml-2 h-4 w-4 text-green-500" />
                                )}
                              </DropdownMenuItem>
                              <DropdownMenuItem 
                                onClick={async () => {
                                  // Fetch existing comments for this mentor
                                  const { data: mentorData } = await supabase
                                    .from('mentors')
                                    .select('comments')
                                    .eq('id', mentor.id)
                                    .single();
                                  
                                  setEngagementComment(mentorData?.comments || '');
                                  setExistingComments(prev => ({
                                    ...prev,
                                    [mentor.id]: mentorData?.comments || ''
                                  }));
                                  
                                  setEngagementPopup({
                                    isOpen: true,
                                    mentorId: mentor.id,
                                    status: "Positive Engagement",
                                    mentor: mentor,
                                    message: `Marking mentor as: Positive Engagement`
                                  });
                                }}
                              >
                                Positive Engagement
                                {mentorEngagement[mentor.id] === "Positive Engagement" && (
                                  <Check className="ml-2 h-4 w-4 text-green-500" />
                                )}
                              </DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </div>
                      </TableCell>
                    </TableRow>
                  ));
                })()
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
      
      {/* Pagination Controls with Chevron Buttons */}
      {mentors.length > recordsPerPage && (
        (() => {
          const filteredMentors = mentors.filter(mentor => 
            mentor.mentor_name.toLowerCase().includes(searchTerm.toLowerCase())
          );
          const totalPages = Math.ceil(filteredMentors.length / recordsPerPage);
          
          return (
            <div className="flex items-center justify-center gap-4 mt-4">
              <Button
                variant="outline"
                size="sm"
                onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))}
                disabled={currentPage === 1}
              >
                <ChevronLeft className="h-4 w-4" />
              </Button>
              
              <div className="flex items-center gap-2">
                {Array.from({ length: totalPages }, (_, i) => i + 1)
                  .slice(Math.max(0, currentPage - 3), Math.min(totalPages, currentPage + 2))
                  .map(pageNumber => (
                    <Button
                      key={pageNumber}
                      variant={currentPage === pageNumber ? "default" : "outline"}
                      size="sm"
                      onClick={() => setCurrentPage(pageNumber)}
                      className="w-8 h-8 p-0"
                    >
                      {pageNumber}
                    </Button>
                  ))}
              </div>
              
              <Button
                variant="outline"
                size="sm"
                onClick={() => setCurrentPage(prev => Math.min(prev + 1, totalPages))}
                disabled={currentPage === totalPages}
              >
                <ChevronRight className="h-4 w-4" />
              </Button>
            </div>
          );
        })()
      )}

      {/* Engagement Popup Dialog */}
      {engagementPopup && engagementPopup.isOpen && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-background border rounded-lg p-6 w-full max-w-md relative">
            {/* Close button */}
            <button
              className="absolute top-4 right-4 text-muted-foreground hover:text-foreground"
              onClick={() => {
                setEngagementPopup(null);
                setEngagementComment('');
              }}
            >
              <X className="h-5 w-5" />
            </button>
            
            <h3 className="text-lg font-semibold mb-4">Update Engagement Status</h3>
            <p className="mb-2 text-muted-foreground">{engagementPopup.message}</p>
            <p className="mb-4 text-sm">
              Adding {engagementPopup.status === "Connection Accepted" ? "10" : "15"} points for this engagement.
            </p>
            
            <div className="mb-4">
              <label className="block text-sm font-medium mb-2">Note</label>
              <Textarea
                placeholder="Add any additional notes here..."
                value={engagementComment}
                onChange={(e) => setEngagementComment(e.target.value)}
                className="mb-4"
                rows={4}
              />
              {existingComments[engagementPopup.mentorId] && (
                <div className="text-xs text-muted-foreground mt-1">
                  <strong>Existing note:</strong> {existingComments[engagementPopup.mentorId]}
                </div>
              )}
            </div>
            
            <div className="flex justify-end gap-2">
              <Button 
                variant="outline" 
                onClick={() => {
                  // Cancel - no updates
                  setEngagementPopup(null);
                  setEngagementComment('');
                }}
              >
                Cancel
              </Button>
              <Button 
                onClick={async () => {
                  // OK - save comment, update status, and add points
                  await handleEngagementUpdate(engagementPopup.mentorId, engagementPopup.status, engagementComment);
                  
                  // Handle point awarding
                  await handleAwardPoints(
                    engagementPopup.mentorId, 
                    engagementPopup.status, 
                    engagementPopup.mentor
                  );
                  
                  // Close the popup and reset comment
                  setEngagementPopup(null);
                  setEngagementComment('');
                }}
              >
                OK
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Dashboard;






















