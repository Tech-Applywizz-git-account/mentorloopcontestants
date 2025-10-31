import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import { Download, Trophy, Medal, Award, ChevronLeft } from 'lucide-react';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { supabase } from '@/integrations/supabase/client';
import { useNavigate } from 'react-router-dom';

export default function Leaderboard() {
  const navigate = useNavigate();
  const [scope, setScope] = useState<'contest' | 'alltime'>('contest');
  const [leaderboardData, setLeaderboardData] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchLeaderboardData();
  }, [scope]);

  const fetchLeaderboardData = async () => {
    setLoading(true);
    
    // Fetch all mentors with onboarded status
    const { data: mentors, error: mentorsError } = await supabase
      .from('mentors')
      .select('created_by_user_id')
      .eq('status', 'onboarded');
    
    if (mentorsError) {
      console.error('Error fetching mentors:', mentorsError);
      setLoading(false);
      return;
    }
    
    // Count onboarded mentors per user
    const userCounts: { [key: string]: number } = {};
    mentors?.forEach((mentor) => {
      const userId = mentor.created_by_user_id;
      userCounts[userId] = (userCounts[userId] || 0) + 1;
    });
    
    // Get user details
    const userIds = Object.keys(userCounts);
    if (userIds.length === 0) {
      setLeaderboardData([]);
      setLoading(false);
      return;
    }
    
    const { data: profiles, error: profilesError } = await supabase
      .from('profiles')
      .select('id, name, email, role')
      .in('id', userIds);
    
    if (profilesError) {
      console.error('Error fetching profiles:', profilesError);
      setLoading(false);
      return;
    }
    
    // Fetch accurate points from points_ledger for each user
    const { data: allPoints, error: pointsError } = await supabase
      .from('points_ledger')
      .select('user_id, delta')
      .in('user_id', userIds);
    
    if (pointsError) {
      console.error('Error fetching points:', pointsError);
    }
    
    // Calculate total points per user from ledger
    const userPoints: { [key: string]: number } = {};
    allPoints?.forEach((entry) => {
      userPoints[entry.user_id] = (userPoints[entry.user_id] || 0) + entry.delta;
    });
    
    // Combine data and sort by onboarded count
    const leaderboard = profiles?.map((profile) => ({
      ...profile,
      onboardedCount: userCounts[profile.id] || 0,
      points_total: userPoints[profile.id] || 0, // Accurate points from ledger
    })).sort((a, b) => b.onboardedCount - a.onboardedCount) || [];
    
    // Limit to top 20
    setLeaderboardData(leaderboard.slice(0, 20));
    setLoading(false);
  };

  const getRankIcon = (rank: number) => {
    if (rank === 1) return <Trophy className="h-5 w-5 text-yellow-500" />;
    if (rank === 2) return <Medal className="h-5 w-5 text-gray-400" />;
    if (rank === 3) return <Award className="h-5 w-5 text-amber-600" />;
    return null;
  };

  return (
    <div className="space-y-6">
      {/* Back Button */}
      <Button 
        variant="ghost" 
        onClick={() => navigate(-1)}
        className="flex items-center gap-2 text-muted-foreground hover:text-foreground"
      >
        <ChevronLeft className="h-4 w-4" />
        <span>Back</span>
      </Button>

      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">
            Leaderboard
          </h1>
          <p className="text-muted-foreground">
            Track CA performance and rankings
          </p>
        </div>

        <Button variant="outline" className="gap-2">
          <Download className="h-4 w-4" />
          Export CSV
        </Button>
      </div>

      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <CardTitle>Top 20 Campus Ambassadors</CardTitle>
            <Tabs value={scope} onValueChange={(v) => setScope(v as any)}>
              <TabsList>
                <TabsTrigger value="contest">Contest</TabsTrigger>
                <TabsTrigger value="alltime">All-Time</TabsTrigger>
              </TabsList>
            </Tabs>
          </div>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-16">Rank</TableHead>
                <TableHead>Campus Ambassador</TableHead>
                <TableHead className="text-center">Onboarded</TableHead>
                <TableHead className="text-right">Points</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? (
                <TableRow>
                  <TableCell colSpan={4} className="text-center text-muted-foreground py-12">
                    Loading...
                  </TableCell>
                </TableRow>
              ) : leaderboardData.length > 0 ? (
                leaderboardData.map((user, index) => (
                  <TableRow key={user.id}>
                    <TableCell className="font-bold">
                      <div className="flex items-center gap-2">
                        {getRankIcon(index + 1)}
                        <span>{index + 1}</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-3">
                        <Avatar className="h-8 w-8">
                          <AvatarFallback className="text-xs">
                            {user.name?.charAt(0) || 'U'}
                          </AvatarFallback>
                        </Avatar>
                        <div>
                          <p className="font-medium">{user.name}</p>
                          <p className="text-xs text-muted-foreground">{user.role}</p>
                        </div>
                      </div>
                    </TableCell>
                    <TableCell className="text-center">
                      <span className="inline-flex items-center justify-center w-12 h-8 rounded-full bg-green-100 text-green-800 font-semibold text-sm">
                        {user.onboardedCount}
                      </span>
                    </TableCell>
                    <TableCell className="text-right font-semibold">
                      {user.points_total}
                    </TableCell>
                  </TableRow>
                ))
              ) : (
                <TableRow>
                  <TableCell colSpan={4} className="text-center text-muted-foreground py-12">
                    No data available yet
                  </TableCell>
                </TableRow>
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
}
