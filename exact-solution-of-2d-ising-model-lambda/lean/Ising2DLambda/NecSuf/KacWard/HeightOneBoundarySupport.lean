import Ising2DLambda.NecSuf.KacWard.CellSetBoundaryCoefficients

namespace Ising2DLambda.NecSuf.KacWard

/-- A boundary indicator difference is nonzero exactly when the two cell values differ. -/
theorem heightOneBoundary_support (a b : Bool) :
    ((if a then (1 : ℤ) else 0) - (if b then (1 : ℤ) else 0) ≠ 0) ↔ a ≠ b := by
  cases a <;> cases b <;> decide

end Ising2DLambda.NecSuf.KacWard
