// import { useEffect } from "react";
// import { useNavigate, useLocation } from "react-router-dom";
// import { supabase } from "@/integrations/supabase/client";
// import { toast } from "sonner";

// const EmailConfirmationHandler = () => {
//   const navigate = useNavigate();
//   const location = useLocation();

//   useEffect(() => {
//     const handleEmailConfirmation = async () => {
//       try {
//         // Check for error parameters
//         const searchParams = new URLSearchParams(location.search);
//         const error = searchParams.get("error");
//         const errorDescription = searchParams.get("error_description");
        
//         if (error) {
//           console.error("Email confirmation error:", errorDescription);
//           toast.error(`Email confirmation failed: ${errorDescription || error}`);
//         } else {
//           // Success case - Supabase will automatically handle the token exchange
//           // We just need to inform the user and redirect them
//           toast.success("Email confirmed successfully! Redirecting to sign in page...");
//         }
        
//         // Redirect to sign in page after a short delay
//         setTimeout(() => {
//           navigate("/auth");
//         }, 3000);
//       } catch (err) {
//         console.error("Error handling email confirmation:", err);
//         toast.error("An unexpected error occurred. Redirecting to sign in page.");
//         setTimeout(() => {
//           navigate("/auth");
//         }, 3000);
//       }
//     };

//     handleEmailConfirmation();
//   }, [navigate, location]);

//   return (
//     <div className="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-background via-background to-primary/5">
//       <div className="w-full max-w-md text-center">
//         <div className="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-primary/20 mb-4 animate-glow-pulse">
//           <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
//         </div>
//         <h1 className="text-2xl font-bold mb-2">Confirming Email</h1>
//         <p className="text-muted-foreground">
//           Please wait while we confirm your email address...
//         </p>
//         <p className="text-sm text-muted-foreground mt-4">
//           You will be redirected to the sign in page shortly.
//         </p>
//       </div>
//     </div>
//   );
// };

// export default EmailConfirmationHandler;






























import { useEffect } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { toast } from "sonner";

const EmailConfirmationHandler = () => {
  const navigate = useNavigate();
  const location = useLocation();

  useEffect(() => {
    const handleEmailConfirmation = async () => {
      try {
        // Check for error parameters
        const searchParams = new URLSearchParams(location.search);
        const error = searchParams.get("error");
        const errorDescription = searchParams.get("error_description");
        
        if (error) {
          console.error("Email confirmation error:", errorDescription);
          toast.error(`Email confirmation failed: ${errorDescription || error}`);
        } else {
          // Success case - Supabase will automatically handle the token exchange
          // We just need to inform the user and redirect them
          toast.success("Email confirmed successfully! Redirecting to sign in page...");
        }
        
        // Redirect to sign in page after a short delay
        setTimeout(() => {
          // Using replace to prevent back navigation to this page
          // Using absolute URL to ensure proper redirect from Gmail
          const baseUrl = window.location.origin;
          window.location.replace(`${baseUrl}/auth?emailConfirmed=true`);
        }, 3000);
      } catch (err) {
        console.error("Error handling email confirmation:", err);
        toast.error("An unexpected error occurred. Redirecting to sign in page.");
        setTimeout(() => {
          // Using replace to prevent back navigation to this page
          // Using absolute URL to ensure proper redirect from Gmail
          const baseUrl = window.location.origin;
          window.location.replace(`${baseUrl}/auth?emailConfirmationError=true`);
        }, 3000);
      }
    };

    handleEmailConfirmation();
  }, [navigate, location]);

  return (
    <div className="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-background via-background to-primary/5">
      <div className="w-full max-w-md text-center">
        <div className="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-primary/20 mb-4 animate-glow-pulse">
          <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent" />
        </div>
        <h1 className="text-2xl font-bold mb-2">Confirming Email</h1>
        <p className="text-muted-foreground">
          Please wait while we confirm your email address...
        </p>
        <p className="text-sm text-muted-foreground mt-4">
          You will be redirected to the sign in page shortly.
        </p>
      </div>
    </div>
  );
};

export default EmailConfirmationHandler;
