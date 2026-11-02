import Ising2DLambda.KacWard.ClosedNonbacktrackingWalk

namespace Ising2DLambda.KacWard

/-- 実際の向き付き辺列の横切断線に対する符号付き横断数。 -/
def horizontalDirectedWindingNumber {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) : ℤ :=
  ∑ k : Fin (m + 1),
    (horizontalSeamParity (γ k) : ℤ) * (1 - 2 * ((γ k).2.toNat : ℤ))

/-- 実際の向き付き辺列の縦切断線に対する符号付き横断数。 -/
def verticalDirectedWindingNumber {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) : ℤ :=
  ∑ k : Fin (m + 1),
    (verticalSeamParity (γ k) : ℤ) * (1 - 2 * ((γ k).2.toNat : ℤ))

end Ising2DLambda.KacWard
