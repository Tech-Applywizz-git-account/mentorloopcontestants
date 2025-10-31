import { useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ShoppingBag, Loader2, ChevronLeft } from "lucide-react";
import { toast } from "sonner";
import confetti from "canvas-confetti";
import { useNavigate } from "react-router-dom";

const Marketplace = () => {
  const { profile } = useAuth();
  const navigate = useNavigate();
  const [products, setProducts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [userPoints, setUserPoints] = useState(0);

  useEffect(() => {
    fetchProducts();
    fetchUserPoints();
  }, [profile]);

  const fetchUserPoints = async () => {
    if (!profile) return;
    
    // Calculate accurate points from points_ledger
    const { data: allPoints } = await supabase
      .from("points_ledger")
      .select("delta")
      .eq("user_id", profile.id);
    
    const totalPoints = allPoints?.reduce((sum, entry) => sum + entry.delta, 0) || 0;
    setUserPoints(totalPoints);
  };

  const fetchProducts = async () => {
    const { data } = await supabase
      .from("marketplace_products")
      .select("*")
      .eq("active", true)
      .order("points_price", { ascending: true });
    setProducts(data || []);
    setLoading(false);
  };

  const handleRedeem = async (product: any) => {
    if (!profile || userPoints < product.points_price) {
      toast.error("Not enough points!");
      return;
    }

    if (product.stock <= 0) {
      toast.error("Out of stock!");
      return;
    }

    const { error } = await supabase.from("redemptions").insert({
      user_id: profile.id,
      product_id: product.id,
      points_cost: product.points_price,
    });

    if (!error) {
      await supabase
        .from("marketplace_products")
        .update({ stock: product.stock - 1 })
        .eq("id", product.id);

      confetti({ particleCount: 50, spread: 60 });
      toast.success("Redeemed successfully!");
      fetchProducts();
      fetchUserPoints(); // Refresh points
    } else {
      toast.error("Redemption failed");
    }
  };

  if (loading) {
    return <div className="flex justify-center"><Loader2 className="h-8 w-8 animate-spin" /></div>;
  }

  return (
    <div className="space-y-6 animate-fade-in">
      {/* Back Button */}
      <Button 
        variant="ghost" 
        onClick={() => navigate(-1)}
        className="flex items-center gap-2 text-muted-foreground hover:text-foreground"
      >
        <ChevronLeft className="h-4 w-4" />
        <span>Back</span>
      </Button>

      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 sm:gap-0">
        <h1 className="text-2xl sm:text-3xl font-bold">Marketplace</h1>
        <Badge variant="secondary" className="text-base sm:text-lg px-3 sm:px-4 py-1.5 sm:py-2 self-start sm:self-auto">
          {userPoints} points
        </Badge>
      </div>

      <div className="grid gap-4 sm:gap-6 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3">
        {products.map((product) => (
          <Card key={product.id} className="border-border/50 bg-card/50 backdrop-blur-sm hover:border-primary/50 transition-all">
            <CardHeader>
              <div className="aspect-video rounded-lg bg-muted/30 mb-4 flex items-center justify-center">
                <ShoppingBag className="h-12 w-12 text-muted-foreground" />
              </div>
              <CardTitle>{product.name}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="flex items-center justify-between">
                <span className="text-2xl font-bold text-primary">{product.points_price} pts</span>
                <Badge variant={product.stock > 0 ? "secondary" : "destructive"}>
                  {product.stock} left
                </Badge>
              </div>
            </CardContent>
            <CardFooter>
              <Button
                className="w-full"
                onClick={() => handleRedeem(product)}
                disabled={product.stock <= 0 || userPoints < product.points_price}
              >
                Redeem
              </Button>
            </CardFooter>
          </Card>
        ))}
      </div>
    </div>
  );
};

export default Marketplace;
