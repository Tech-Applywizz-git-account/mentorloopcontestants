import { useEffect, useState } from 'react';
import { Clock } from 'lucide-react';

export const ContestCountdown = () => {
  const [timeLeft, setTimeLeft] = useState('');

  useEffect(() => {
    const calculateTimeLeft = () => {
      // Contest end: Nov 30, 2025, 23:59 IST
      const endDate = new Date('2025-11-30T23:59:00+05:30');
      const now = new Date();
      const diff = endDate.getTime() - now.getTime();

      if (diff <= 0) {
        setTimeLeft('Contest Ended');
        return;
      }

      const days = Math.floor(diff / (1000 * 60 * 60 * 24));
      const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((diff % (1000 * 60)) / 1000);

      setTimeLeft(`${days}d ${hours}h ${minutes}m ${seconds}s`);
    };

    calculateTimeLeft();
    const interval = setInterval(calculateTimeLeft, 1000);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="flex items-center gap-2 rounded-lg border border-primary/20 bg-primary/5 px-4 py-2">
      <Clock className="h-4 w-4 text-primary" />
      <div className="flex flex-col">
        <span className="text-xs text-muted-foreground">Contest Ends</span>
        <span className="text-sm font-semibold text-primary">{timeLeft}</span>
      </div>
    </div>
  );
};
