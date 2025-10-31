import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Badge } from '@/components/ui/badge';
import { ChevronLeft, ChevronDown, Check } from 'lucide-react';
 import { X, Ban } from "lucide-react"; // ✅ Lucide icons
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { useNavigate, useParams } from 'react-router-dom';
import { supabase } from '@/integrations/supabase/client';

export default function ContestantDashboard() {
  const navigate = useNavigate();
  const { id } = useParams();
  const [mentors, setMentors] = useState<any[]>([]);
  const [contestantInfo, setContestantInfo] = useState<any>(null);
  const [totalPoints, setTotalPoints] = useState(0);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      if (!id) return;
      
      setLoading(true);
      
      // Fetch contestant info
      const { data: profileData, error: profileError } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', id)
        .single();
      
      if (profileError) {
        console.error('Error fetching contestant info:', profileError);
        setLoading(false);
        return;
      }
      
      setContestantInfo(profileData);
      
      // Fetch accurate total points from points_ledger
      const { data: pointsData } = await supabase
        .from('points_ledger')
        .select('delta')
        .eq('user_id', id);
      
      const calculatedPoints = pointsData?.reduce((sum, entry) => sum + entry.delta, 0) || 0;
      setTotalPoints(calculatedPoints);
      
      // Fetch mentors submitted by this contestant
      const { data: mentorsData, error: mentorsError } = await supabase
        .from('mentors')
        .select('*')
        .eq('created_by_user_id', id)
        .order('created_at', { ascending: false });
      
      if (mentorsError) {
        console.error('Error fetching mentors:', mentorsError);
      } else {
        setMentors(mentorsData || []);
      }
      
      setLoading(false);
    };
    
    fetchData();
  }, [id]);

  const handleBack = () => {
    navigate('/admin/ca-dashboard');
  };

  const handleStatusChange = async (mentorId: string, newStatus: 'pending' | 'onboarded' | 'declined') => {
    try {
      const { error } = await supabase
        .from('mentors')
        .update({ status: newStatus })
        .eq('id', mentorId);

      if (error) {
        console.error('Error updating mentor status:', error);
      } else {
        // Refresh the mentors list
        const { data: mentorsData } = await supabase
          .from('mentors')
          .select('*')
          .eq('created_by_user_id', id)
          .order('created_at', { ascending: false });
        
        setMentors(mentorsData || []);
        
        // Check if all mentors are now declined or onboarded (no pending mentors left)
        const hasPendingMentors = mentorsData?.some(m => m.status === 'pending');
        
        // If no pending mentors left, navigate back to dashboard after a short delay
        if (!hasPendingMentors) {
          setTimeout(() => {
            navigate('/admin/ca-dashboard');
          }, 500);
        }
      }
    } catch (error) {
      console.error('Error updating status:', error);
    }
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

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
      </div>
    );
  }

  if (!contestantInfo) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-center">
          <h2 className="text-2xl font-bold text-muted-foreground">Contestant not found</h2>
          <Button onClick={handleBack} className="mt-4">Back to Dashboard</Button>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center gap-4">
        <Button variant="ghost" size="icon" onClick={handleBack}>
          <ChevronLeft className="h-5 w-5" />
        </Button>
        <div>
          <h1 className="text-3xl font-bold">{contestantInfo.name}</h1>
          <p className="text-muted-foreground">{contestantInfo.role}</p>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid gap-4 md:grid-cols-3">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium">Total Submissions</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{mentors.length}</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium">Onboarded</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{mentors.filter(m => m.status === 'onboarded').length}</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium">Total Points</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{totalPoints}</div>
          </CardContent>
        </Card>
      </div>

      {/* Mentors Table */}
      <Card>
        <CardHeader>
          <CardTitle>Mentor Submissions</CardTitle>
        </CardHeader>
        <CardContent>
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
                mentors.map((mentor, index) => (
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
                          <Button variant="ghost" size="sm" className='bg-orange-500'>
                            <ChevronDown className="h-4 w-4 text-black" />
                          </Button>
                        </DropdownMenuTrigger>
                        {/* <DropdownMenuContent align="end">
                          <DropdownMenuItem onClick={() => console.log('Close mentor', mentor.id)}>
                            Close
                          </DropdownMenuItem>
                          <DropdownMenuItem onClick={() => console.log('Decline mentor', mentor.id)}>
                            Decline
                          </DropdownMenuItem>
                        </DropdownMenuContent> */}
                       

<DropdownMenuContent align="end">
  <DropdownMenuItem
    onClick={() => handleStatusChange(mentor.id, 'onboarded')}
    className="flex items-center space-x-2"
  >
    <Check className="w-4 h-4 text-green-600" />
    <span>Onboarded</span>
  </DropdownMenuItem>

  <DropdownMenuItem
    onClick={() => handleStatusChange(mentor.id, 'declined')}
    className="flex items-center space-x-2"
  >
    <Ban className="w-4 h-4 text-red-500" />
    <span>Decline</span>
  </DropdownMenuItem>
</DropdownMenuContent>

                      </DropdownMenu>
                    </TableCell>
                  </TableRow>
                ))
              ) : (
                <TableRow>
                  <TableCell colSpan={7} className="text-center text-muted-foreground">
                    No mentors found
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