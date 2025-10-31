import { LogOut } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { useAuth } from '@/contexts/AuthContext';
import { ContestCountdown } from './ContestCountdown';

export const AdminHeader = () => {
  const { signOut } = useAuth();

  return (
    <header className="sticky top-0 z-50 border-b border-border bg-card/80 backdrop-blur-lg">
      <div className="flex h-16 items-center justify-between px-6">
        {/* Logo */}
        <div className="flex items-center gap-2">
          <span className="text-xl font-bold animate-shimmer bg-gradient-to-r from-yellow-400 via-yellow-200 to-yellow-600 bg-clip-text text-transparent bg-[length:200%_100%]">
            MentorLoop
          </span>
        </div>

        {/* Right side actions */}
        <div className="flex items-center gap-4">
          {/* Contest Countdown */}
          <ContestCountdown />

          {/* Admin Button */}
          <Button variant="outline">
            Admin
          </Button>

          {/* Sign Out Button */}
          <Button variant="ghost" onClick={signOut} className="flex items-center gap-2">
            <LogOut className="h-5 w-5" />
            <span>Sign Out</span>
          </Button>
        </div>
      </div>
    </header>
  );
};
