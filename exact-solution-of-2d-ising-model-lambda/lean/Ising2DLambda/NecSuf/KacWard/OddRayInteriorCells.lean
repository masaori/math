import Ising2DLambda.NecSuf.KacWard.RightRayVerticalCrossingCount

namespace Ising2DLambda.NecSuf.KacWard

/-- Cells with odd right-ray crossing count for a finite integer lattice path. -/
def oddRayInteriorCells (m : ℕ) (P : Fin (m + 2) → ℤ × ℤ) : Set (ℤ × ℤ) :=
  {p | Odd (rightRayVerticalCrossingCount m P p.1 p.2)}

end Ising2DLambda.NecSuf.KacWard
