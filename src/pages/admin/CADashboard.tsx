import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Switch } from '@/components/ui/switch';
import { Label } from '@/components/ui/label';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { ChevronLeft, ChevronRight, Search } from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useAuth } from '@/contexts/AuthContext';
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from '@/components/ui/alert-dialog';
import { Enums } from '@/integrations/supabase/types';

export default function CADashboard() {
  const { profile } = useAuth();
  const navigate = useNavigate();
  const [tlRecords, setTlRecords] = useState<any[]>([]);
  const [mentors, setMentors] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [showCareerAssociate, setShowCareerAssociate] = useState(true);
  const [currentPage, setCurrentPage] = useState(1);
  const [searchQuery, setSearchQuery] = useState('');
  const [declinedSearchQuery, setDeclinedSearchQuery] = useState('');
  const [onboardedSearchQuery, setOnboardedSearchQuery] = useState('');
  const [pendingSearchQuery, setPendingSearchQuery] = useState('');
  const [editedMentorsByUser, setEditedMentorsByUser] = useState<Record<string, number>>({});
  const [declinedMentorsByUser, setDeclinedMentorsByUser] = useState<Record<string, any[]>>({});
  const [onboardedMentorsByUser, setOnboardedMentorsByUser] = useState<Record<string, any[]>>({});
  const [pendingMentorsByUser, setPendingMentorsByUser] = useState<Record<string, any[]>>({});
  const recordsPerPage = 5;
  
  // Role change state
  const [roleChangeDialog, setRoleChangeDialog] = useState({
    open: false,
    userId: '',
    userName: '',
    currentRole: '' as Enums<'user_role'>,
    newRole: '' as Enums<'user_role'>,
  });

  // Available roles
  const availableRoles: Enums<'user_role'>[] = ['user', 'CA', 'CA TL', 'TECH', 'TECH TL', 'super_admin'];

  // Fetch real data from database
  useEffect(() => {
    const fetchTLRecords = async () => {
      if (!profile) return;
      
      setLoading(true);
      // Fetch all users except super_admin
      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .neq('role', 'super_admin')
        .order('name', { ascending: true });

      if (error) {
        console.error('Error fetching TL records:', error);
      } else {
        // Transform the data to match the existing structure
        const transformedData = data?.map((record, index) => ({
          id: record.id,
          name: record.name,
          role: record.role,
          email: record.email,
          phone: 'N/A' // Phone field not available in profiles table
        })) || [];
        
        setTlRecords(transformedData);
      }
      
      // Fetch all mentors
      const { data: mentorsData, error: mentorsError } = await supabase
        .from('mentors')
        .select('*')
        .order('created_at', { ascending: false });
      
      if (mentorsError) {
        console.error('Error fetching mentors:', mentorsError);
      } else {
        setMentors(mentorsData || []);
        
        // Calculate edited mentors count per user
        const editedCounts: Record<string, number> = {};
        const declinedByUser: Record<string, any[]> = {};
        const onboardedByUser: Record<string, any[]> = {};
        const pendingByUser: Record<string, any[]> = {};
        
        mentorsData?.forEach((mentor) => {
          if (mentor.edited_by_user_id) {
            const userId = mentor.created_by_user_id;
            editedCounts[userId] = (editedCounts[userId] || 0) + 1;
          }
          
          // Group pending mentors by user
          if (mentor.status === 'pending') {
            const userId = mentor.created_by_user_id;
            if (!pendingByUser[userId]) {
              pendingByUser[userId] = [];
            }
            pendingByUser[userId].push(mentor);
          }
          
          // Group declined mentors by user
          if (mentor.status === 'declined') {
            const userId = mentor.created_by_user_id;
            if (!declinedByUser[userId]) {
              declinedByUser[userId] = [];
            }
            declinedByUser[userId].push(mentor);
          }
          
          // Group onboarded mentors by user
          if (mentor.status === 'onboarded') {
            const userId = mentor.created_by_user_id;
            if (!onboardedByUser[userId]) {
              onboardedByUser[userId] = [];
            }
            onboardedByUser[userId].push(mentor);
          }
        });
        
        setEditedMentorsByUser(editedCounts);
        setPendingMentorsByUser(pendingByUser);
        setDeclinedMentorsByUser(declinedByUser);
        setOnboardedMentorsByUser(onboardedByUser);
      }
      
      setLoading(false);
    };

    fetchTLRecords();
  }, [profile]);

  // Refresh data when navigating back to this page
  useEffect(() => {
    const handleVisibilityChange = () => {
      if (document.visibilityState === 'visible' && profile) {
        // Refetch data when page becomes visible
        const refetch = async () => {
          const { data: mentorsData } = await supabase
            .from('mentors')
            .select('*')
            .order('created_at', { ascending: false });
          
          if (mentorsData) {
            setMentors(mentorsData);
            
            const editedCounts: Record<string, number> = {};
            const declinedByUser: Record<string, any[]> = {};
            const onboardedByUser: Record<string, any[]> = {};
            const pendingByUser: Record<string, any[]> = {};
            
            mentorsData.forEach((mentor) => {
              if (mentor.edited_by_user_id) {
                const userId = mentor.created_by_user_id;
                editedCounts[userId] = (editedCounts[userId] || 0) + 1;
              }
              
              if (mentor.status === 'pending') {
                const userId = mentor.created_by_user_id;
                if (!pendingByUser[userId]) pendingByUser[userId] = [];
                pendingByUser[userId].push(mentor);
              }
              
              if (mentor.status === 'declined') {
                const userId = mentor.created_by_user_id;
                if (!declinedByUser[userId]) declinedByUser[userId] = [];
                declinedByUser[userId].push(mentor);
              }
              
              if (mentor.status === 'onboarded') {
                const userId = mentor.created_by_user_id;
                if (!onboardedByUser[userId]) onboardedByUser[userId] = [];
                onboardedByUser[userId].push(mentor);
              }
            });
            
            setEditedMentorsByUser(editedCounts);
            setPendingMentorsByUser(pendingByUser);
            setDeclinedMentorsByUser(declinedByUser);
            setOnboardedMentorsByUser(onboardedByUser);
          }
        };
        refetch();
      }
    };

    document.addEventListener('visibilitychange', handleVisibilityChange);
    return () => document.removeEventListener('visibilitychange', handleVisibilityChange);
  }, [profile]);

  // Handle role change request
  const handleRoleChangeRequest = (userId: string, userName: string, currentRole: Enums<'user_role'>, newRole: Enums<'user_role'>) => {
    setRoleChangeDialog({
      open: true,
      userId,
      userName,
      currentRole,
      newRole,
    });
  };

  // Confirm role change
  const confirmRoleChange = async () => {
    try {
      const { error } = await supabase
        .from('profiles')
        .update({ role: roleChangeDialog.newRole })
        .eq('id', roleChangeDialog.userId);

      if (error) {
        console.error('Error updating role:', error);
      } else {
        // Refresh the data
        const { data, error: fetchError } = await supabase
          .from('profiles')
          .select('*')
          .neq('role', 'super_admin')
          .order('name', { ascending: true });

        if (!fetchError) {
          const transformedData = data?.map((record) => ({
            id: record.id,
            name: record.name,
            role: record.role,
            email: record.email,
            phone: 'N/A'
          })) || [];
          
          setTlRecords(transformedData);
        }
      }
    } catch (error) {
      console.error('Error updating role:', error);
    } finally {
      setRoleChangeDialog({
        open: false,
        userId: '',
        userName: '',
        currentRole: 'user',
        newRole: 'user',
      });
    }
  };

  // Calculate pagination with search filter - Show all contestants regardless of mentor status
  const filteredRecords = tlRecords.filter((record) =>
    record.name.toLowerCase().includes(searchQuery.toLowerCase())
  );
  const totalPages = Math.ceil(filteredRecords.length / recordsPerPage);
  const startIndex = (currentPage - 1) * recordsPerPage;
  const currentRecords = filteredRecords.slice(startIndex, startIndex + recordsPerPage);

  const handleNextPage = () => {
    if (currentPage < totalPages) {
      setCurrentPage(currentPage + 1);
    }
  };

  const handlePreviousPage = () => {
    if (currentPage > 1) {
      setCurrentPage(currentPage - 1);
    }
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

      {/* Page intro */}
      <p className="text-sm text-muted-foreground">Review and manage mentor submissions</p>

      {/* Toggle Switch */}
      <div className="flex items-center space-x-2">
        <Switch
          id="card-toggle"
          checked={showCareerAssociate}
          onCheckedChange={setShowCareerAssociate}
        />
        <Label htmlFor="card-toggle">
          {showCareerAssociate ? 'Contestants' : 'Mentor Submissions'}
        </Label>
      </div>

      <div className="grid gap-6 lg:grid-cols-1">
        {/* Career Associate List - Show when toggle is ON */}
        {showCareerAssociate && (
          <Card>
            <CardHeader>
              <CardTitle className='text-center'>Contestants</CardTitle>
            </CardHeader>
            <CardContent>
              {/* Search Bar */}
              <div className="mb-4">
                <div className="relative">
                  <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                  <Input
                    type="search"
                    placeholder="Search contestant by name..."
                    className="pl-10"
                    value={searchQuery}
                    onChange={(e) => {
                      setSearchQuery(e.target.value);
                      setCurrentPage(1); // Reset to first page on search
                    }}
                  />
                </div>
              </div>

              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>S.No</TableHead>
                    <TableHead>Name</TableHead>
                    <TableHead>Role</TableHead>
                    <TableHead>Email</TableHead>
                    <TableHead>Phone</TableHead>
                    <TableHead className="text-right">Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {loading ? (
                    <TableRow>
                      <TableCell colSpan={6} className="text-center text-muted-foreground">
                        Loading...
                      </TableCell>
                    </TableRow>
                  ) : currentRecords.length > 0 ? (
                    currentRecords.map((record, index) => (
                      <TableRow key={record.id}>
                        <TableCell>{index + 1}</TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <span>{record.name}</span>
                            {editedMentorsByUser[record.id] > 0 && (
                              <div className="relative">
                                <div className="h-2 w-2 rounded-full bg-red-500 animate-pulse" />
                                <div className="absolute -top-1 -right-1 h-3 w-3 rounded-full bg-red-500 opacity-75 animate-ping" />
                              </div>
                            )}
                          </div>
                        </TableCell>
                        <TableCell>
                          <Select
                            value={record.role}
                            onValueChange={(value) => handleRoleChangeRequest(record.id, record.name, record.role as Enums<'user_role'>, value as Enums<'user_role'>)}
                          >
                            <SelectTrigger className="w-[180px]">
                              <SelectValue placeholder="Select role" />
                            </SelectTrigger>
                            <SelectContent>
                              {availableRoles.map((role) => (
                                <SelectItem key={role} value={role}>
                                  {role}
                                </SelectItem>
                              ))}
                            </SelectContent>
                          </Select>
                        </TableCell>
                        <TableCell>{record.email}</TableCell>
                        <TableCell>{record.phone}</TableCell>
                        <TableCell className="text-right">
                          <Button variant="ghost" size="sm" onClick={() => navigate(`/admin/contestant/${record.id}`)} className='bg-white'>
                            <ChevronRight className="h-4 w-4 text-black" />
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))
                  ) : (
                    <TableRow>
                      <TableCell colSpan={6} className="text-center text-muted-foreground">
                        No records found
                      </TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>

              {/* Pagination Controls */}
              <div className="flex items-center justify-center mt-4 space-x-2">
                <Button
                  variant="outline"
                  size="sm"
                  onClick={handlePreviousPage}
                  disabled={currentPage === 1}
                >
                  <ChevronLeft className="h-4 w-4" />
                  Previous
                </Button>
                <span className="text-sm text-muted-foreground">
                  Page {currentPage} of {totalPages}
                </span>
                <Button
                  variant="outline"
                  size="sm"
                  onClick={handleNextPage}
                  disabled={currentPage === totalPages}
                >
                  Next
                  <ChevronRight className="h-4 w-4 ml-2" />
                </Button>
              </div>
            </CardContent>
          </Card>
        )}

        {/* Mentor Submissions - Show when toggle is OFF */}
        {!showCareerAssociate && (
          <Card>
            <CardHeader>
              <div className="flex items-center gap-4">
                <Button variant="ghost" size="icon" onClick={() => setShowCareerAssociate(true)}>
                  <ChevronLeft className="h-5 w-5" />
                </Button>
                <CardTitle>Mentor Submissions</CardTitle>
              </div>
            </CardHeader>
            <CardContent>
              <Tabs defaultValue="current">
                <TabsList className="grid w-full grid-cols-3">
                  <TabsTrigger value="current">Current</TabsTrigger>
                  <TabsTrigger value="declined">Declined</TabsTrigger>
                  <TabsTrigger value="onboarded">Onboarded</TabsTrigger>
                </TabsList>

                <TabsContent value="current" className="mt-6">
                  {/* Search Bar for Current/Pending */}
                  <div className="mb-4">
                    <div className="relative">
                      <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                      <Input
                        type="search"
                        placeholder="Search by name or email..."
                        className="pl-10"
                        value={pendingSearchQuery}
                        onChange={(e) => setPendingSearchQuery(e.target.value)}
                      />
                    </div>
                  </div>

                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>S.No</TableHead>
                        <TableHead>Name</TableHead>
                        <TableHead>Role</TableHead>
                        <TableHead>Email</TableHead>
                        <TableHead>Pending Mentors</TableHead>
                        <TableHead className="text-right">Actions</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {Object.keys(pendingMentorsByUser).length > 0 ? (
                        Object.keys(pendingMentorsByUser)
                          .filter((userId) => {
                            const user = tlRecords.find(u => u.id === userId);
                            if (!user) return false;
                            const searchLower = pendingSearchQuery.toLowerCase();
                            return user.name.toLowerCase().includes(searchLower) || 
                                   user.email.toLowerCase().includes(searchLower);
                          })
                          .map((userId, index) => {
                          const user = tlRecords.find(u => u.id === userId);
                          if (!user) return null;
                          return (
                            <TableRow key={userId}>
                              <TableCell>{index + 1}</TableCell>
                              <TableCell>{user.name}</TableCell>
                              <TableCell>
                                <Select
                                  value={user.role}
                                  onValueChange={(value) => handleRoleChangeRequest(userId, user.name, user.role as Enums<'user_role'>, value as Enums<'user_role'>)}
                                >
                                  <SelectTrigger className="w-[180px]">
                                    <SelectValue placeholder="Select role" />
                                  </SelectTrigger>
                                  <SelectContent>
                                    {availableRoles.map((role) => (
                                      <SelectItem key={role} value={role}>
                                        {role}
                                      </SelectItem>
                                    ))}
                                  </SelectContent>
                                </Select>
                              </TableCell>
                              <TableCell>{user.email}</TableCell>
                              <TableCell>
                                <span className="px-2 py-1 rounded-full text-xs bg-yellow-100 text-yellow-800">
                                  {pendingMentorsByUser[userId].length}
                                </span>
                              </TableCell>
                              <TableCell className="text-right">
                                <Button 
                                  variant="ghost" 
                                  size="sm" 
                                  onClick={() => navigate(`/admin/user/${userId}/mentors/pending`)}
                                  className='bg-white'
                                >
                                  <ChevronRight className="h-4 w-4 text-black" />
                                </Button>
                              </TableCell>
                            </TableRow>
                          );
                        })
                      ) : (
                        <TableRow>
                          <TableCell colSpan={6} className="text-center text-muted-foreground">
                            No users with pending submissions
                          </TableCell>
                        </TableRow>
                      )}
                    </TableBody>
                  </Table>
                </TabsContent>

                <TabsContent value="declined" className="mt-6">
                  {/* Search Bar for Declined */}
                  <div className="mb-4">
                    <div className="relative">
                      <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                      <Input
                        type="search"
                        placeholder="Search by name or email..."
                        className="pl-10"
                        value={declinedSearchQuery}
                        onChange={(e) => setDeclinedSearchQuery(e.target.value)}
                      />
                    </div>
                  </div>

                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>S.No</TableHead>
                        <TableHead>Name</TableHead>
                        <TableHead>Role</TableHead>
                        <TableHead>Email</TableHead>
                        <TableHead>Declined Mentors</TableHead>
                        <TableHead className="text-right">Actions</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {Object.keys(declinedMentorsByUser).length > 0 ? (
                        Object.keys(declinedMentorsByUser)
                          .filter((userId) => {
                            const user = tlRecords.find(u => u.id === userId);
                            if (!user) return false;
                            const searchLower = declinedSearchQuery.toLowerCase();
                            return user.name.toLowerCase().includes(searchLower) || 
                                   user.email.toLowerCase().includes(searchLower);
                          })
                          .map((userId, index) => {
                          const user = tlRecords.find(u => u.id === userId);
                          if (!user) return null;
                          return (
                            <TableRow key={userId}>
                              <TableCell>{index + 1}</TableCell>
                              <TableCell>{user.name}</TableCell>
                              <TableCell>
                                <Select
                                  value={user.role}
                                  onValueChange={(value) => handleRoleChangeRequest(userId, user.name, user.role as Enums<'user_role'>, value as Enums<'user_role'>)}
                                >
                                  <SelectTrigger className="w-[180px]">
                                    <SelectValue placeholder="Select role" />
                                  </SelectTrigger>
                                  <SelectContent>
                                    {availableRoles.map((role) => (
                                      <SelectItem key={role} value={role}>
                                        {role}
                                      </SelectItem>
                                    ))}
                                  </SelectContent>
                                </Select>
                              </TableCell>
                              <TableCell>{user.email}</TableCell>
                              <TableCell>
                                <span className="px-2 py-1 rounded-full text-xs bg-red-100 text-red-800">
                                  {declinedMentorsByUser[userId].length}
                                </span>
                              </TableCell>
                              <TableCell className="text-right">
                                <Button 
                                  variant="ghost" 
                                  size="sm" 
                                  onClick={() => navigate(`/admin/user/${userId}/mentors/declined`)}
                                  className='bg-white'
                                >
                                  <ChevronRight className="h-4 w-4 text-black" />
                                </Button>
                              </TableCell>
                            </TableRow>
                          );
                        })
                      ) : (
                        <TableRow>
                          <TableCell colSpan={6} className="text-center text-muted-foreground">
                            No users with declined submissions
                          </TableCell>
                        </TableRow>
                      )}
                    </TableBody>
                  </Table>
                </TabsContent>

                <TabsContent value="onboarded" className="mt-6">
                  {/* Search Bar for Onboarded */}
                  <div className="mb-4">
                    <div className="relative">
                      <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                      <Input
                        type="search"
                        placeholder="Search by name or email..."
                        className="pl-10"
                        value={onboardedSearchQuery}
                        onChange={(e) => setOnboardedSearchQuery(e.target.value)}
                      />
                    </div>
                  </div>

                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>S.No</TableHead>
                        <TableHead>Name</TableHead>
                        <TableHead>Role</TableHead>
                        <TableHead>Email</TableHead>
                        <TableHead>Onboarded Mentors</TableHead>
                        <TableHead className="text-right">Actions</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {Object.keys(onboardedMentorsByUser).length > 0 ? (
                        Object.keys(onboardedMentorsByUser)
                          .filter((userId) => {
                            const user = tlRecords.find(u => u.id === userId);
                            if (!user) return false;
                            const searchLower = onboardedSearchQuery.toLowerCase();
                            return user.name.toLowerCase().includes(searchLower) || 
                                   user.email.toLowerCase().includes(searchLower);
                          })
                          .map((userId, index) => {
                          const user = tlRecords.find(u => u.id === userId);
                          if (!user) return null;
                          return (
                            <TableRow key={userId}>
                              <TableCell>{index + 1}</TableCell>
                              <TableCell>{user.name}</TableCell>
                              <TableCell>
                                <Select
                                  value={user.role}
                                  onValueChange={(value) => handleRoleChangeRequest(userId, user.name, user.role as Enums<'user_role'>, value as Enums<'user_role'>)}
                                >
                                  <SelectTrigger className="w-[180px]">
                                    <SelectValue placeholder="Select role" />
                                  </SelectTrigger>
                                  <SelectContent>
                                    {availableRoles.map((role) => (
                                      <SelectItem key={role} value={role}>
                                        {role}
                                      </SelectItem>
                                    ))}
                                  </SelectContent>
                                </Select>
                              </TableCell>
                              <TableCell>{user.email}</TableCell>
                              <TableCell>
                                <span className="px-2 py-1 rounded-full text-xs bg-green-100 text-green-800">
                                  {onboardedMentorsByUser[userId].length}
                                </span>
                              </TableCell>
                              <TableCell className="text-right">
                                <Button 
                                  variant="ghost" 
                                  size="sm" 
                                  onClick={() => navigate(`/admin/user/${userId}/mentors/onboarded`)}
                                  className='bg-white'
                                >
                                  <ChevronRight className="h-4 w-4 text-black" />
                                </Button>
                              </TableCell>
                            </TableRow>
                          );
                        })
                      ) : (
                        <TableRow>
                          <TableCell colSpan={6} className="text-center text-muted-foreground">
                            No users with onboarded mentors
                          </TableCell>
                        </TableRow>
                      )}
                    </TableBody>
                  </Table>
                </TabsContent>
              </Tabs>
            </CardContent>
          </Card>
        )}
      </div>

      {/* Role Change Confirmation Dialog */}
      <AlertDialog open={roleChangeDialog.open} onOpenChange={(open) => setRoleChangeDialog({...roleChangeDialog, open})}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Confirm Role Change</AlertDialogTitle>
            <AlertDialogDescription>
              Are you sure you want to change the role for <strong>{roleChangeDialog.userName}</strong> from <strong>{roleChangeDialog.currentRole}</strong> to <strong>{roleChangeDialog.newRole}</strong>?
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction onClick={confirmRoleChange}>Confirm</AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
};