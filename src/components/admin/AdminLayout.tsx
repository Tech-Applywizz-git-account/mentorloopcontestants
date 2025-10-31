import { Outlet, NavLink } from 'react-router-dom';
import { LayoutDashboard, Users, Trophy, ShoppingBag } from 'lucide-react';
import { AdminHeader } from './AdminHeader';
import { cn } from '@/lib/utils';
import { useState, useEffect } from 'react';
import { supabase } from '@/integrations/supabase/client';

const navItems = [
  { title: 'Overview', url: '/admin/overview', icon: LayoutDashboard },
  { title: 'Dashboard', url: '/admin/ca-dashboard', icon: Users },
  { title: 'Leaderboard', url: '/admin/leaderboard', icon: Trophy },
  { title: 'Marketplace', url: '/admin/marketplace', icon: ShoppingBag },
];

export const AdminLayout = () => {
  const [hasEditedMentors, setHasEditedMentors] = useState(false);

  useEffect(() => {
    const checkEditedMentors = async () => {
      const { data, error } = await supabase
        .from('mentors')
        .select('id, edited_by_user_id')
        .not('edited_by_user_id', 'is', null)
        .limit(1);

      if (!error && data && data.length > 0) {
        setHasEditedMentors(true);
      }
    };

    checkEditedMentors();

    // Set up real-time subscription for mentor edits
    const channel = supabase
      .channel('mentor-edits')
      .on(
        'postgres_changes',
        {
          event: 'UPDATE',
          schema: 'public',
          table: 'mentors',
          filter: 'edited_by_user_id=not.null'
        },
        () => {
          setHasEditedMentors(true);
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, []);
  return (
    <div className="min-h-screen bg-background">
      <AdminHeader />
      
      <div className="flex">
        {/* Sidebar */}
        <aside className="sticky top-16 h-[calc(100vh-4rem)] w-64 border-r border-border bg-card/50">
          <nav className="flex flex-col gap-2 p-4">
            {navItems.map((item) => (
              <NavLink
                key={item.url}
                to={item.url}
                className={({ isActive }) =>
                  cn(
                    'flex items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium transition-all',
                    isActive
                      ? 'bg-primary/10 text-primary shadow-sm'
                      : 'text-muted-foreground hover:bg-muted hover:text-foreground'
                  )
                }
              >
                <item.icon className="h-4 w-4" />
                <span className="relative">
                  {item.title}
                  {item.title === 'Dashboard' && hasEditedMentors && (
                    <span className="absolute -top-1 -right-3 flex h-2 w-2">
                      <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-500 opacity-75"></span>
                      <span className="relative inline-flex rounded-full h-2 w-2 bg-red-500"></span>
                    </span>
                  )}
                </span>
              </NavLink>
            ))}
          </nav>
        </aside>

        {/* Main Content */}
        <main className="flex-1 p-6">
          <Outlet />
        </main>
      </div>
    </div>
  );
};
