// import { useState } from "react";
// import { useNavigate } from "react-router-dom";
// import { supabase } from "@/integrations/supabase/client";
// import { Button } from "@/components/ui/button";
// import { Input } from "@/components/ui/input";
// import { Label } from "@/components/ui/label";
// import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
// import { toast } from "sonner";
// import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
// import { Rocket, Eye, EyeOff } from "lucide-react";
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from "@/components/ui/select";

// const Auth = () => {
//   const [loading, setLoading] = useState(false);
//   const [showSignInPassword, setShowSignInPassword] = useState(false);
//   const [showSignUpPassword, setShowSignUpPassword] = useState(false);
//   const [selectedRole, setSelectedRole] = useState("user");
//   const navigate = useNavigate();

//   const handleSignIn = async (e: React.FormEvent<HTMLFormElement>) => {
//     e.preventDefault();
//     setLoading(true);

//     const formData = new FormData(e.currentTarget);
//     const email = formData.get("email") as string;
//     const password = formData.get("password") as string;

//     const { data, error } = await supabase.auth.signInWithPassword({ email, password });

//     if (error) {
//       toast.error(error.message);
//       setLoading(false);
//     } else if (data.user) {
//       // Fetch user profile to check role
//       const { data: profile, error: profileError } = await supabase
//         .from('profiles')
//         .select('role')
//         .eq('id', data.user.id)
//         .single();

//       if (profileError) {
//         toast.error("Error loading profile. Please try again.");
//         setLoading(false);
//         return;
//       }

//       // Redirect based on role
//       console.log("User role:", profile?.role);
//       if (profile?.role && profile.role.trim().toLowerCase() === 'super_admin') {
//         toast.success("Welcome back, Admin!");
//         navigate("/admin");
//       } else {
//         // All other roles (CA, CA TL, TECH, TECH TL, user) go to user pages
//         toast.success("Welcome back!");
//         navigate("/");
//       }
//       setLoading(false);
//     } else {
//       toast.error("Invalid credentials. Please try again.");
//       setLoading(false);
//     }
//   };

//   const handleSignUp = async (e: React.FormEvent<HTMLFormElement>) => {
//     e.preventDefault();
//     setLoading(true);

//     const formData = new FormData(e.currentTarget);
//     const name = formData.get("name") as string;
//     const email = formData.get("email") as string;
//     const password = formData.get("password") as string;

//     const { data, error } = await supabase.auth.signUp({
//       email,
//       password,
//       options: {
//         emailRedirectTo: `${window.location.origin}/verify-email`,
//         data: {
//           name,
//           role: selectedRole,
//         },
//       },
//     });

//     if (error) {
//       toast.error(error.message);
//       setLoading(false);
//     } else if (data.user) {
//       // Check if email confirmation is required
//       if (data.user.identities && data.user.identities.length === 0) {
//         toast.success("Please check your email to confirm your account before signing in.");
//       } else if (data.session) {
//         // Auto sign in is enabled
//         toast.success("Account created successfully! Welcome!");
//         navigate("/");
//       } else {
//         // Email confirmation required
//         toast.success("Confirmation email sent! Please check your inbox to verify your account. You'll be redirected to sign in after confirmation.");
//       }
//       setLoading(false);
//     } else {
//       toast.error("Something went wrong. Please try again.");
//       setLoading(false);
//     }
//   };

//   return (
//     <div className="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-background via-background to-primary/5">
//       <div className="w-full max-w-md">
//         <div className="text-center mb-8">
//           <div className="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-primary/20 mb-4 animate-glow-pulse">
//             <Rocket className="h-8 w-8 text-primary" />
//           </div>
//           <h1 className="text-4xl font-bold mb-2">
//             MentorLoop <span className="text-primary">Contest</span>
//           </h1>
//           <p className="text-muted-foreground">Join the competition. Earn rewards.</p>
//         </div>

//         <Card className="border-border/50 backdrop-blur-sm bg-card/50">
//           <CardHeader>
//             <CardTitle>Get Started</CardTitle>
//             <CardDescription>Sign in or create your account</CardDescription>
//           </CardHeader>
//           <CardContent>
//             <Tabs defaultValue="signin" className="w-full">
//               <TabsList className="grid w-full grid-cols-2">
//                 <TabsTrigger value="signin">Sign In</TabsTrigger>
//                 <TabsTrigger value="signup">Sign Up</TabsTrigger>
//               </TabsList>

//               <TabsContent value="signin">
//                 <form onSubmit={handleSignIn} className="space-y-4">
//                   <div className="space-y-2">
//                     <Label htmlFor="signin-email">Email</Label>
//                     <Input
//                       id="signin-email"
//                       name="email"
//                       type="email"
//                       placeholder="you@example.com"
//                       required
//                     />
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signin-password">Password</Label>
//                     <div className="relative">
//                       <Input
//                         id="signin-password"
//                         name="password"
//                         type={showSignInPassword ? "text" : "password"}
//                         placeholder="••••••••"
//                         required
//                         className="pr-10"
//                       />
//                       <button
//                         type="button"
//                         onClick={() => setShowSignInPassword(!showSignInPassword)}
//                         className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
//                       >
//                         {showSignInPassword ? (
//                           <EyeOff className="h-4 w-4" />
//                         ) : (
//                           <Eye className="h-4 w-4" />
//                         )}
//                       </button>
//                     </div>
//                   </div>
//                   <Button type="submit" className="w-full" disabled={loading}>
//                     {loading ? "Signing in..." : "Sign In"}
//                   </Button>
//                 </form>
//               </TabsContent>

//               <TabsContent value="signup">
//                 <form onSubmit={handleSignUp} className="space-y-4">
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-name">Name</Label>
//                     <Input
//                       id="signup-name"
//                       name="name"
//                       type="text"
//                       placeholder="Your name"
//                       required
//                     />
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-email">Email</Label>
//                     <Input
//                       id="signup-email"
//                       name="email"
//                       type="email"
//                       placeholder="you@example.com"
//                       required
//                     />
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-password">Password</Label>
//                     <div className="relative">
//                       <Input
//                         id="signup-password"
//                         name="password"
//                         type={showSignUpPassword ? "text" : "password"}
//                         placeholder="••••••••"
//                         required
//                         minLength={6}
//                         className="pr-10"
//                       />
//                       <button
//                         type="button"
//                         onClick={() => setShowSignUpPassword(!showSignUpPassword)}
//                         className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
//                       >
//                         {showSignUpPassword ? (
//                           <EyeOff className="h-4 w-4" />
//                         ) : (
//                           <Eye className="h-4 w-4" />
//                         )}
//                       </button>
//                     </div>
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-role">Role</Label>
//                     <Select value={selectedRole} onValueChange={setSelectedRole}>
//                       <SelectTrigger id="signup-role">
//                         <SelectValue placeholder="Select your role" />
//                       </SelectTrigger>
//                       <SelectContent>
//                         <SelectItem value="user">User</SelectItem>
//                         <SelectItem value="CA">CA</SelectItem>
//                         <SelectItem value="CA TL">CA TL</SelectItem>
//                         <SelectItem value="TECH">TECH</SelectItem>
//                         <SelectItem value="TECH TL">TECH TL</SelectItem>
//                       </SelectContent>
//                     </Select>
//                   </div>
//                   <Button type="submit" className="w-full" disabled={loading}>
//                     {loading ? "Creating account..." : "Sign Up"}
//                   </Button>
//                 </form>
//               </TabsContent>
//             </Tabs>
//           </CardContent>
//         </Card>
//       </div>
//     </div>
//   );
// };

// export default Auth;





































// import { useState, useEffect } from "react";
// import { useNavigate, useLocation } from "react-router-dom";
// import { supabase } from "@/integrations/supabase/client";
// import { Button } from "@/components/ui/button";
// import { Input } from "@/components/ui/input";
// import { Label } from "@/components/ui/label";
// import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
// import { toast } from "sonner";
// import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
// import { Rocket, Eye, EyeOff } from "lucide-react";
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from "@/components/ui/select";

// const Auth = () => {
//   const [loading, setLoading] = useState(false);
//   const [showSignInPassword, setShowSignInPassword] = useState(false);
//   const [showSignUpPassword, setShowSignUpPassword] = useState(false);
//   const [selectedRole, setSelectedRole] = useState("user");
//   const navigate = useNavigate();
//   const location = useLocation();

//   // Handle email confirmation redirect parameters
//   useEffect(() => {
//     const searchParams = new URLSearchParams(location.search);
//     const emailConfirmed = searchParams.get("emailConfirmed");
//     const emailConfirmationError = searchParams.get("emailConfirmationError");
    
//     if (emailConfirmed === "true") {
//       toast.success("Email confirmed successfully! You can now sign in.");
//     } else if (emailConfirmationError === "true") {
//       toast.error("There was an issue with email confirmation. Please try signing in or contact support.");
//     }
//   }, [location]);

//   const handleSignIn = async (e: React.FormEvent<HTMLFormElement>) => {
//     e.preventDefault();
//     setLoading(true);

//     const formData = new FormData(e.currentTarget);
//     const email = formData.get("email") as string;
//     const password = formData.get("password") as string;

//     const { data, error } = await supabase.auth.signInWithPassword({ email, password });

//     if (error) {
//       toast.error(error.message);
//       setLoading(false);
//     } else if (data.user) {
//       // Fetch user profile to check role
//       const { data: profile, error: profileError } = await supabase
//         .from('profiles')
//         .select('role')
//         .eq('id', data.user.id)
//         .single();

//       if (profileError) {
//         toast.error("Error loading profile. Please try again.");
//         setLoading(false);
//         return;
//       }

//       // Redirect based on role
//       console.log("User role:", profile?.role);
//       if (profile?.role && profile.role.trim().toLowerCase() === 'super_admin') {
//         toast.success("Welcome back, Admin!");
//         navigate("/admin");
//       } else {
//         // All other roles (CA, CA TL, TECH, TECH TL, user) go to user pages
//         toast.success("Welcome back!");
//         navigate("/");
//       }
//       setLoading(false);
//     } else {
//       toast.error("Invalid credentials. Please try again.");
//       setLoading(false);
//     }
//   };

//   const handleSignUp = async (e: React.FormEvent<HTMLFormElement>) => {
//     e.preventDefault();
//     setLoading(true);

//     const formData = new FormData(e.currentTarget);
//     const name = formData.get("name") as string;
//     const email = formData.get("email") as string;
//     const password = formData.get("password") as string;

//     // Ensure we use the full URL for email redirects to work properly with Gmail
//     const baseUrl = window.location.origin;
    
//     const { data, error } = await supabase.auth.signUp({
//       email,
//       password,
//       options: {
//         emailRedirectTo: `${baseUrl}/verify-email`,
//         data: {
//           name,
//           role: selectedRole,
//         },
//       },
//     });

//     if (error) {
//       toast.error(error.message);
//       setLoading(false);
//     } else if (data.user) {
//       // Check if email confirmation is required
//       if (data.user.identities && data.user.identities.length === 0) {
//         toast.success("Please check your email to confirm your account before signing in.");
//       } else if (data.session) {
//         // Auto sign in is enabled
//         toast.success("Account created successfully! Welcome!");
//         navigate("/");
//       } else {
//         // Email confirmation required
//         toast.success("Confirmation email sent! Please check your inbox to verify your account. You'll be redirected to sign in after confirmation.");
//       }
//       setLoading(false);
//     } else {
//       toast.error("Something went wrong. Please try again.");
//       setLoading(false);
//     }
//   };

//   return (
//     <div className="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-background via-background to-primary/5">
//       <div className="w-full max-w-md">
//         <div className="text-center mb-8">
//           <div className="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-primary/20 mb-4 animate-glow-pulse">
//             <Rocket className="h-8 w-8 text-primary" />
//           </div>
//           <h1 className="text-4xl font-bold mb-2">
//             MentorLoop <span className="text-primary">Contest</span>
//           </h1>
//           <p className="text-muted-foreground">Join the competition. Earn rewards.</p>
//         </div>

//         <Card className="border-border/50 backdrop-blur-sm bg-card/50">
//           <CardHeader>
//             <CardTitle>Get Started</CardTitle>
//             <CardDescription>Sign in or create your account</CardDescription>
//           </CardHeader>
//           <CardContent>
//             <Tabs defaultValue="signin" className="w-full">
//               <TabsList className="grid w-full grid-cols-2">
//                 <TabsTrigger value="signin">Sign In</TabsTrigger>
//                 <TabsTrigger value="signup">Sign Up</TabsTrigger>
//               </TabsList>

//               <TabsContent value="signin">
//                 <form onSubmit={handleSignIn} className="space-y-4">
//                   <div className="space-y-2">
//                     <Label htmlFor="signin-email">Email</Label>
//                     <Input
//                       id="signin-email"
//                       name="email"
//                       type="email"
//                       placeholder="you@example.com"
//                       required
//                     />
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signin-password">Password</Label>
//                     <div className="relative">
//                       <Input
//                         id="signin-password"
//                         name="password"
//                         type={showSignInPassword ? "text" : "password"}
//                         placeholder="••••••••"
//                         required
//                         className="pr-10"
//                       />
//                       <button
//                         type="button"
//                         onClick={() => setShowSignInPassword(!showSignInPassword)}
//                         className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
//                       >
//                         {showSignInPassword ? (
//                           <EyeOff className="h-4 w-4" />
//                         ) : (
//                           <Eye className="h-4 w-4" />
//                         )}
//                       </button>
//                     </div>
//                   </div>
//                   <Button type="submit" className="w-full" disabled={loading}>
//                     {loading ? "Signing in..." : "Sign In"}
//                   </Button>
//                 </form>
//               </TabsContent>

//               <TabsContent value="signup">
//                 <form onSubmit={handleSignUp} className="space-y-4">
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-name">Name</Label>
//                     <Input
//                       id="signup-name"
//                       name="name"
//                       type="text"
//                       placeholder="Your name"
//                       required
//                     />
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-email">Email</Label>
//                     <Input
//                       id="signup-email"
//                       name="email"
//                       type="email"
//                       placeholder="you@example.com"
//                       required
//                     />
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-password">Password</Label>
//                     <div className="relative">
//                       <Input
//                         id="signup-password"
//                         name="password"
//                         type={showSignUpPassword ? "text" : "password"}
//                         placeholder="••••••••"
//                         required
//                         minLength={6}
//                         className="pr-10"
//                       />
//                       <button
//                         type="button"
//                         onClick={() => setShowSignUpPassword(!showSignUpPassword)}
//                         className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
//                       >
//                         {showSignUpPassword ? (
//                           <EyeOff className="h-4 w-4" />
//                         ) : (
//                           <Eye className="h-4 w-4" />
//                         )}
//                       </button>
//                     </div>
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-role">Role</Label>
//                     <Select value={selectedRole} onValueChange={setSelectedRole}>
//                       <SelectTrigger id="signup-role">
//                         <SelectValue placeholder="Select your role" />
//                       </SelectTrigger>
//                       <SelectContent>
//                         <SelectItem value="user">User</SelectItem>
//                         <SelectItem value="CA">CA</SelectItem>
//                         <SelectItem value="CA TL">CA TL</SelectItem>
//                         <SelectItem value="TECH">TECH</SelectItem>
//                         <SelectItem value="TECH TL">TECH TL</SelectItem>
//                       </SelectContent>
//                     </Select>
//                   </div>
//                   <Button type="submit" className="w-full" disabled={loading}>
//                     {loading ? "Creating account..." : "Sign Up"}
//                   </Button>
//                 </form>
//               </TabsContent>
//             </Tabs>
//           </CardContent>
//         </Card>
//       </div>
//     </div>
//   );
// };

// export default Auth;






















































// import { useState, useEffect } from "react";
// import { useNavigate, useLocation } from "react-router-dom";
// import { supabase } from "@/integrations/supabase/client";
// import { Button } from "@/components/ui/button";
// import { Input } from "@/components/ui/input";
// import { Label } from "@/components/ui/label";
// import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
// import { toast } from "sonner";
// import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
// import { Rocket, Eye, EyeOff } from "lucide-react";
// import {
//   Select,
//   SelectContent,
//   SelectItem,
//   SelectTrigger,
//   SelectValue,
// } from "@/components/ui/select";

// const Auth = () => {
//   const [loading, setLoading] = useState(false);
//   const [showSignInPassword, setShowSignInPassword] = useState(false);
//   const [showSignUpPassword, setShowSignUpPassword] = useState(false);
//   const [selectedRole, setSelectedRole] = useState("user");
//   const navigate = useNavigate();
//   const location = useLocation();

//   // Handle email confirmation redirect parameters
//   useEffect(() => {
//     const searchParams = new URLSearchParams(location.search);
//     const emailConfirmed = searchParams.get("emailConfirmed");
//     const emailConfirmationError = searchParams.get("emailConfirmationError");
    
//     if (emailConfirmed === "true") {
//       toast.success("Email confirmed successfully! You can now sign in.");
//     } else if (emailConfirmationError === "true") {
//       toast.error("There was an issue with email confirmation. Please try signing in or contact support.");
//     }
//   }, [location]);

//   const handleSignIn = async (e: React.FormEvent<HTMLFormElement>) => {
//     e.preventDefault();
//     setLoading(true);

//     const formData = new FormData(e.currentTarget);
//     const email = formData.get("email") as string;
//     const password = formData.get("password") as string;

//     const { data, error } = await supabase.auth.signInWithPassword({ email, password });

//     if (error) {
//       toast.error(error.message);
//       setLoading(false);
//     } else if (data.user) {
//       // Fetch user profile to check role
//       const { data: profile, error: profileError } = await supabase
//         .from('profiles')
//         .select('role')
//         .eq('id', data.user.id)
//         .single();

//       if (profileError) {
//         toast.error("Error loading profile. Please try again.");
//         setLoading(false);
//         return;
//       }

//       // Redirect based on role
//       console.log("User role:", profile?.role);
//       if (profile?.role && profile.role.trim().toLowerCase() === 'super_admin') {
//         toast.success("Welcome back, Admin!");
//         navigate("/admin");
//       } else {
//         // All other roles (CA, CA TL, TECH, TECH TL, user) go to user pages
//         toast.success("Welcome back!");
//         navigate("/");
//       }
//       setLoading(false);
//     } else {
//       toast.error("Invalid credentials. Please try again.");
//       setLoading(false);
//     }
//   };

//   const handleSignUp = async (e: React.FormEvent<HTMLFormElement>) => {
//     e.preventDefault();
//     setLoading(true);

//     const formData = new FormData(e.currentTarget);
//     const name = formData.get("name") as string;
//     const email = formData.get("email") as string;
//     const password = formData.get("password") as string;

//     // Ensure we use the full URL for email redirects to work properly with Gmail
//     const baseUrl = window.location.origin;
    
//     const { data, error } = await supabase.auth.signUp({
//       email,
//       password,
//       options: {
//         emailRedirectTo: `${baseUrl}/`,
//         data: {
//           name,
//           role: selectedRole,
//         },
//       },
//     });

//     if (error) {
//       toast.error(error.message);
//       setLoading(false);
//     } else if (data.user) {
//       // Check if email confirmation is required
//       if (data.user.identities && data.user.identities.length === 0) {
//         toast.success("Please check your email to confirm your account before signing in.");
//       } else if (data.session) {
//         // Auto sign in is enabled
//         toast.success("Account created successfully! Welcome!");
//         navigate("/");
//       } else {
//         // Email confirmation required
//         toast.success("Confirmation email sent! Please check your inbox to verify your account. You'll be redirected to sign in after confirmation.");
//       }
//       setLoading(false);
//     } else {
//       toast.error("Something went wrong. Please try again.");
//       setLoading(false);
//     }
//   };

//   return (
//     <div className="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-background via-background to-primary/5">
//       <div className="w-full max-w-md">
//         <div className="text-center mb-8">
//           <div className="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-primary/20 mb-4 animate-glow-pulse">
//             <Rocket className="h-8 w-8 text-primary" />
//           </div>
//           <h1 className="text-4xl font-bold mb-2">
//             MentorLoop <span className="text-primary">Contest</span>
//           </h1>
//           <p className="text-muted-foreground">Join the competition. Earn rewards.</p>
//         </div>

//         <Card className="border-border/50 backdrop-blur-sm bg-card/50">
//           <CardHeader>
//             <CardTitle>Get Started</CardTitle>
//             <CardDescription>Sign in or create your account</CardDescription>
//           </CardHeader>
//           <CardContent>
//             <Tabs defaultValue="signin" className="w-full">
//               <TabsList className="grid w-full grid-cols-2">
//                 <TabsTrigger value="signin">Sign In</TabsTrigger>
//                 <TabsTrigger value="signup">Sign Up</TabsTrigger>
//               </TabsList>

//               <TabsContent value="signin">
//                 <form onSubmit={handleSignIn} className="space-y-4">
//                   <div className="space-y-2">
//                     <Label htmlFor="signin-email">Email</Label>
//                     <Input
//                       id="signin-email"
//                       name="email"
//                       type="email"
//                       placeholder="you@example.com"
//                       required
//                     />
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signin-password">Password</Label>
//                     <div className="relative">
//                       <Input
//                         id="signin-password"
//                         name="password"
//                         type={showSignInPassword ? "text" : "password"}
//                         placeholder="••••••••"
//                         required
//                         className="pr-10"
//                       />
//                       <button
//                         type="button"
//                         onClick={() => setShowSignInPassword(!showSignInPassword)}
//                         className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
//                       >
//                         {showSignInPassword ? (
//                           <EyeOff className="h-4 w-4" />
//                         ) : (
//                           <Eye className="h-4 w-4" />
//                         )}
//                       </button>
//                     </div>
//                   </div>
//                   <Button type="submit" className="w-full" disabled={loading}>
//                     {loading ? "Signing in..." : "Sign In"}
//                   </Button>
//                 </form>
//               </TabsContent>

//               <TabsContent value="signup">
//                 <form onSubmit={handleSignUp} className="space-y-4">
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-name">Name</Label>
//                     <Input
//                       id="signup-name"
//                       name="name"
//                       type="text"
//                       placeholder="Your name"
//                       required
//                     />
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-email">Email</Label>
//                     <Input
//                       id="signup-email"
//                       name="email"
//                       type="email"
//                       placeholder="you@example.com"
//                       required
//                     />
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-password">Password</Label>
//                     <div className="relative">
//                       <Input
//                         id="signup-password"
//                         name="password"
//                         type={showSignUpPassword ? "text" : "password"}
//                         placeholder="••••••••"
//                         required
//                         minLength={6}
//                         className="pr-10"
//                       />
//                       <button
//                         type="button"
//                         onClick={() => setShowSignUpPassword(!showSignUpPassword)}
//                         className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
//                       >
//                         {showSignUpPassword ? (
//                           <EyeOff className="h-4 w-4" />
//                         ) : (
//                           <Eye className="h-4 w-4" />
//                         )}
//                       </button>
//                     </div>
//                   </div>
//                   <div className="space-y-2">
//                     <Label htmlFor="signup-role">Role</Label>
//                     <Select value={selectedRole} onValueChange={setSelectedRole}>
//                       <SelectTrigger id="signup-role">
//                         <SelectValue placeholder="Select your role" />
//                       </SelectTrigger>
//                       <SelectContent>
//                         <SelectItem value="user">User</SelectItem>
//                         <SelectItem value="CA">CA</SelectItem>
//                         <SelectItem value="CA TL">CA TL</SelectItem>
//                         <SelectItem value="TECH">TECH</SelectItem>
//                         <SelectItem value="TECH TL">TECH TL</SelectItem>
//                       </SelectContent>
//                     </Select>
//                   </div>
//                   <Button type="submit" className="w-full" disabled={loading}>
//                     {loading ? "Creating account..." : "Sign Up"}
//                   </Button>
//                 </form>
//               </TabsContent>
//             </Tabs>
//           </CardContent>
//         </Card>
//       </div>
//     </div>
//   );
// };

// export default Auth;


































import { useState, useEffect } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { toast } from "sonner";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Rocket, Eye, EyeOff } from "lucide-react";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

const Auth = () => {
  const [loading, setLoading] = useState(false);
  const [showSignInPassword, setShowSignInPassword] = useState(false);
  const [showSignUpPassword, setShowSignUpPassword] = useState(false);
  const [selectedRole, setSelectedRole] = useState("user");
  const navigate = useNavigate();
  const location = useLocation();

  // Handle email confirmation redirect parameters
  useEffect(() => {
    const searchParams = new URLSearchParams(location.search);
    const emailConfirmed = searchParams.get("emailConfirmed");
    const emailConfirmationError = searchParams.get("emailConfirmationError");
    
    if (emailConfirmed === "true") {
      toast.success("Email confirmed successfully! You can now sign in.");
    } else if (emailConfirmationError === "true") {
      toast.error("There was an issue with email confirmation. Please try signing in or contact support.");
    }
  }, [location]);

  const handleSignIn = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);

    const formData = new FormData(e.currentTarget);
    const email = formData.get("email") as string;
    const password = formData.get("password") as string;

    const { data, error } = await supabase.auth.signInWithPassword({ email, password });

    if (error) {
      toast.error(error.message);
      setLoading(false);
    } else if (data.user) {
      // Fetch user profile to check role
      const { data: profile, error: profileError } = await supabase
        .from('profiles')
        .select('role')
        .eq('id', data.user.id)
        .single();

      if (profileError) {
        toast.error("Error loading profile. Please try again.");
        setLoading(false);
        return;
      }

      // Redirect based on role
      console.log("User role:", profile?.role);
      if (profile?.role && profile.role.trim().toLowerCase() === 'super_admin') {
        toast.success("Welcome back, Admin!");
        navigate("/admin");
      } else {
        // All other roles (CA, CA TL, TECH, TECH TL, user) go to user pages
        toast.success("Welcome back!");
        navigate("/");
      }
      setLoading(false);
    } else {
      toast.error("Invalid credentials. Please try again.");
      setLoading(false);
    }
  };

  const handleSignUp = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);

    const formData = new FormData(e.currentTarget);
    const name = formData.get("name") as string;
    const email = formData.get("email") as string;
    const password = formData.get("password") as string;

    // Validate email domain
    if (!email.endsWith('@applywizz.com')) {
      toast.error("Invalid email domain. Please use an email ending with @applywizz.com");
      setLoading(false);
      return;
    }

    // Ensure we use the full URL for email redirects to work properly with Gmail
    const baseUrl = window.location.origin;
    
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: `${baseUrl}/`,
        data: {
          name,
          role: selectedRole,
        },
      },
    });

    if (error) {
      toast.error(error.message);
      setLoading(false);
    } else if (data.user) {
      // Check if email confirmation is required
      if (data.user.identities && data.user.identities.length === 0) {
        toast.success("Please check your email to confirm your account before signing in.");
      } else if (data.session) {
        // Auto sign in is enabled
        toast.success("Account created successfully! Welcome!");
        navigate("/");
      } else {
        // Email confirmation required
        toast.success("Confirmation email sent! Please check your inbox to verify your account. You'll be redirected to sign in after confirmation.");
      }
      setLoading(false);
    } else {
      toast.error("Something went wrong. Please try again.");
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-background via-background to-primary/5">
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <div className="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-primary/20 mb-4 animate-glow-pulse">
            <Rocket className="h-8 w-8 text-primary" />
          </div>
          <h1 className="text-4xl font-bold mb-2">
            MentorLoop <span className="text-primary">Contest</span>
          </h1>
          <p className="text-muted-foreground">Join the competition. Earn rewards.</p>
        </div>

        <Card className="border-border/50 backdrop-blur-sm bg-card/50">
          <CardHeader>
            <CardTitle>Get Started</CardTitle>
            <CardDescription>Sign in or create your account</CardDescription>
          </CardHeader>
          <CardContent>
            <Tabs defaultValue="signin" className="w-full">
              <TabsList className="grid w-full grid-cols-2">
                <TabsTrigger value="signin">Sign In</TabsTrigger>
                <TabsTrigger value="signup">Sign Up</TabsTrigger>
              </TabsList>

              <TabsContent value="signin">
                <form onSubmit={handleSignIn} className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="signin-email">Email</Label>
                    <Input
                      id="signin-email"
                      name="email"
                      type="email"
                      placeholder="you@example.com"
                      required
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="signin-password">Password</Label>
                    <div className="relative">
                      <Input
                        id="signin-password"
                        name="password"
                        type={showSignInPassword ? "text" : "password"}
                        placeholder="••••••••"
                        required
                        className="pr-10"
                      />
                      <button
                        type="button"
                        onClick={() => setShowSignInPassword(!showSignInPassword)}
                        className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
                      >
                        {showSignInPassword ? (
                          <EyeOff className="h-4 w-4" />
                        ) : (
                          <Eye className="h-4 w-4" />
                        )}
                      </button>
                    </div>
                  </div>
                  <Button type="submit" className="w-full" disabled={loading}>
                    {loading ? "Signing in..." : "Sign In"}
                  </Button>
                </form>
              </TabsContent>

              <TabsContent value="signup">
                <form onSubmit={handleSignUp} className="space-y-4">
                  <div className="space-y-2">
                    <Label htmlFor="signup-name">Name</Label>
                    <Input
                      id="signup-name"
                      name="name"
                      type="text"
                      placeholder="Your name"
                      required
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="signup-email">Email</Label>
                    <Input
                      id="signup-email"
                      name="email"
                      type="email"
                      placeholder="you@example.com"
                      required
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="signup-password">Password</Label>
                    <div className="relative">
                      <Input
                        id="signup-password"
                        name="password"
                        type={showSignUpPassword ? "text" : "password"}
                        placeholder="••••••••"
                        required
                        minLength={6}
                        className="pr-10"
                      />
                      <button
                        type="button"
                        onClick={() => setShowSignUpPassword(!showSignUpPassword)}
                        className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
                      >
                        {showSignUpPassword ? (
                          <EyeOff className="h-4 w-4" />
                        ) : (
                          <Eye className="h-4 w-4" />
                        )}
                      </button>
                    </div>
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="signup-role">Role</Label>
                    <Select value={selectedRole} onValueChange={setSelectedRole}>
                      <SelectTrigger id="signup-role">
                        <SelectValue placeholder="Select your role" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="user">User</SelectItem>
                        <SelectItem value="CA">CA</SelectItem>
                        <SelectItem value="CA TL">CA TL</SelectItem>
                        <SelectItem value="TECH">TECH</SelectItem>
                        <SelectItem value="TECH TL">TECH TL</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  <Button type="submit" className="w-full" disabled={loading}>
                    {loading ? "Creating account..." : "Sign Up"}
                  </Button>
                </form>
              </TabsContent>
            </Tabs>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default Auth;
