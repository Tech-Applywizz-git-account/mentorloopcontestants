import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider, useAuth } from "@/contexts/AuthContext";
import { ProtectedRoute } from "@/components/ProtectedRoute";
import { UserLayout } from "@/components/UserLayout";
import { AdminLayout } from "@/components/admin/AdminLayout";

import Auth from "./pages/Auth";
import ResetPassword from "./pages/ResetPassword";
import Dashboard from "./pages/user/Dashboard";
import MentorForm from "./pages/user/MentorForm";
import EditMentor from "./pages/user/EditMentor";
import History from "./pages/user/History";
import Leaderboard from "./pages/user/Leaderboard";
import Score from "./pages/user/Score";
import Marketplace from "./pages/user/Marketplace";
import Overview from "./pages/admin/Overview";
import CADashboard from "./pages/admin/CADashboard";
import ContestantDashboard from "./pages/admin/ContestantDashboard";
import UserMentorsByStatus from "./pages/admin/UserMentorsByStatus";
import AdminLeaderboard from "./pages/admin/Leaderboard";
import AdminMarketplace from "./pages/admin/Marketplace";
import NotFound from "./pages/NotFound";

// Add Email Confirmation Handler
import EmailConfirmationHandler from "./pages/EmailConfirmationHandler";

const queryClient = new QueryClient();

const AppRoutes = () => {
  const { profile, loading } = useAuth();

  if (loading) return <div className="flex min-h-screen items-center justify-center"><div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" /></div>;

  // Always allow access to reset password and email verification pages
  return (
    <Routes>
      <Route path="/reset-password" element={<ResetPassword />} />
      <Route path="/verify-email" element={<EmailConfirmationHandler />} />
      
      {!profile ? (
        <>
          <Route path="/auth" element={<Auth />} />
          <Route path="*" element={<Navigate to="/auth" />} />
        </>
      ) : profile.role === "super_admin" ? (
        <>
          <Route
            path="/admin"
            element={
              <ProtectedRoute requireRole="super_admin">
                <AdminLayout />
              </ProtectedRoute>
            }
          >
            <Route path="overview" element={<Overview />} />
            <Route path="ca-dashboard" element={<CADashboard />} />
            <Route path="contestant/:id" element={<ContestantDashboard />} />
            <Route path="user/:id/mentors/:status" element={<UserMentorsByStatus />} />
            <Route path="leaderboard" element={<AdminLeaderboard />} />
            <Route path="marketplace" element={<AdminMarketplace />} />
            <Route index element={<Navigate to="/admin/ca-dashboard" replace />} />
          </Route>
          <Route path="*" element={<Navigate to="/admin/ca-dashboard" />} />
        </>
      ) : (
        <>
          <Route path="/" element={<ProtectedRoute><UserLayout /></ProtectedRoute>}>
            <Route index element={<Dashboard />} />
            <Route path="mentor-form" element={<MentorForm />} />
            <Route path="edit-mentor/:id" element={<EditMentor />} />
            <Route path="history" element={<History />} />
            <Route path="leaderboard" element={<Leaderboard />} />
            <Route path="score" element={<Score />} />
            <Route path="marketplace" element={<Marketplace />} />
          </Route>
          <Route path="*" element={<Navigate to="/" />} />
        </>
      )}
    </Routes>
  );
};

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      <Toaster />
      <Sonner />
      <BrowserRouter>
        <AuthProvider>
          <AppRoutes />
        </AuthProvider>
      </BrowserRouter>
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;