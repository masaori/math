import Ising2DLambda.NecSuf.KacWard.CellSetBoundaryCoefficients

namespace Ising2DLambda.NecSuf.KacWard

/-- A boundary indicator difference is nonzero exactly when the two cell values differ. -/
theorem heightOneBoundary_support (a b : Bool) :
    ((if a then (1 : ℤ) else 0) - (if b then (1 : ℤ) else 0) ≠ 0) ↔ a ≠ b := by
  cases a <;> cases b <;> decide

/-- A binary height jump transfers its parity to the support of the boundary coefficient. -/
theorem heightOneBoundary_internal_parity (a b : Bool) (p : ℕ)
    (hjump : (a ≠ b ↔ p = 1)) :
    ((if a then (1 : ℤ) else 0) - (if b then (1 : ℤ) else 0) ≠ 0) ↔
      p = 1 := by
  exact (heightOneBoundary_support a b).trans hjump

end Ising2DLambda.NecSuf.KacWard
