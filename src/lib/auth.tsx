import { createContext, useContext, useState, ReactNode } from 'react';
import { useNavigate } from 'react-router-dom';
import { toast } from 'sonner';

interface AuthContextType {
  isAdmin: boolean;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<{ error: any }>;
  signOut: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider');
  }
  return context;
};

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [isAdmin, setIsAdmin] = useState(() => {
    return localStorage.getItem('isAdmin') === 'true';
  });
  const [loading] = useState(false);
  const navigate = useNavigate();

  const signIn = async (email: string, password: string) => {
    // Simple hardcoded check
    if (email === 'admin@gmail.com' && password === 'Created@123') {
      localStorage.setItem('isAdmin', 'true');
      setIsAdmin(true);
      navigate('/admin/overview');
      toast.success('Welcome back, Admin!');
      return { error: null };
    } else {
      return { error: { message: 'Invalid credentials. Use admin@gmail.com / Created@123' } };
    }
  };

  const signOut = () => {
    localStorage.removeItem('isAdmin');
    setIsAdmin(false);
    navigate('/');
    toast.success('Signed out successfully');
  };

  return (
    <AuthContext.Provider value={{ isAdmin, loading, signIn, signOut }}>
      {children}
    </AuthContext.Provider>
  );
};
