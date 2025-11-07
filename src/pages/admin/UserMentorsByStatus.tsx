import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Badge } from '@/components/ui/badge';
import { ChevronLeft, ChevronDown, ChevronRight, Check, Ban } from 'lucide-react';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { useNavigate, useParams } from 'react-router-dom';
import { supabase } from '@/integrations/supabase/client';

export default function UserMentorsByStatus() {
  const navigate = useNavigate();
  const { id, status } = useParams<{ id: string; status: 'declined' | 'onboarded' }>();
  const [mentors, setMentors] = useState<any[]>([]);
  const [contestantInfo, setContestantInfo] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      if (!id || !status) return;
      
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
      
      // Fetch mentors submitted by this contestant with specific status
      const { data: mentorsData, error: mentorsError } = await supabase
        .from('mentors')
        .select('*')
        .eq('created_by_user_id', id)
        .eq('status', status)
        .order('created_at', { ascending: false });
      
      if (mentorsError) {
        console.error('Error fetching mentors:', mentorsError);
      } else {
        setMentors(mentorsData || []);
      }
      
      setLoading(false);
    };
    
    fetchData();
  }, [id, status]);

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
        // Refresh the mentors list with the same status filter
        const { data: mentorsData } = await supabase
          .from('mentors')
          .select('*')
          .eq('created_by_user_id', id)
          .eq('status', status)
          .order('created_at', { ascending: false });
        
        setMentors(mentorsData || []);
      }
    } catch (error) {
      console.error('Error updating status:', error);
    }
  };

  const getStatusBadge = (mentorStatus: string) => {
    switch (mentorStatus) {
      case 'pending':
        return <Badge variant="secondary">Pending</Badge>;
      case 'onboarded':
        return <Badge variant="default" className="bg-green-600">Onboarded</Badge>;
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
          <p className="text-muted-foreground">
            {contestantInfo.role} • {contestantInfo.email}
          </p>
        </div>
      </div>

      {/* Status Badge */}
      <div className="flex items-center gap-2">
        <span className={`px-4 py-2 rounded-lg text-sm font-medium ${
          status === 'declined' 
            ? 'bg-red-100 text-red-800' 
            : 'bg-green-100 text-green-800'
        }`}>
          Showing {status?.charAt(0).toUpperCase() + status?.slice(1)} Mentors Only
        </span>
        <span className="text-2xl font-bold">{mentors.length}</span>
      </div>

      {/* Mentors Table */}
      <Card>
        <CardHeader>
          <CardTitle>{status?.charAt(0).toUpperCase() + status?.slice(1)} Mentor Submissions</CardTitle>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Mentor Name</TableHead>
                <TableHead>LinkedIn</TableHead>
                <TableHead>Domain</TableHead>
                <TableHead>Submitted At</TableHead>
                <TableHead>Status</TableHead>
                
              </TableRow>
            </TableHeader>
            <TableBody>
              {mentors.length > 0 ? (
                mentors.map((mentor) => (
                  <TableRow key={mentor.id}>
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

                  </TableRow>
                ))
              ) : (
                <TableRow>
                  <TableCell colSpan={5} className="text-center text-muted-foreground">
                    No {status} mentors found
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
