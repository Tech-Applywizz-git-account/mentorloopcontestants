import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";

const Index = () => {
  const navigate = useNavigate();
  const { profile, loading } = useAuth();

  useEffect(() => {
    // Don't redirect while loading
    if (loading) return;
    
    // Redirect based on user role
    if (profile) {
      if (profile.role === "super_admin") {
        navigate("/admin/ca-dashboard");
      } else {
        navigate("/dashboard");
      }
    } else {
      navigate("/auth");
    }
  }, [profile, loading, navigate]);

  return (
    <div className="flex min-h-screen items-center justify-center bg-background">
      <div className="text-center">
        <h1 className="mb-4 text-4xl font-bold">Redirecting...</h1>
        <p className="text-xl text-muted-foreground">Please wait while we redirect you to the appropriate page.</p>
      </div>
    </div>
  );
};

export default Index;