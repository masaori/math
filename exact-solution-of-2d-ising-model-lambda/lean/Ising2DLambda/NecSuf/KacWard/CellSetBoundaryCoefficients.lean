import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A finite boundary sum needs only two distinguished cells and decidable equality. -/
theorem finiteBoundaryIndicatorDifference {C : Type*} [DecidableEq C]
    (S : Finset C) (positive negative : C) :
    S.sum (fun p => (if p = positive then (1 : ℤ) else 0) -
      (if p = negative then (1 : ℤ) else 0)) =
      (if positive ∈ S then (1 : ℤ) else 0) -
      (if negative ∈ S then (1 : ℤ) else 0) := by
  simp [Finset.sum_sub_distrib]

end Ising2DLambda.NecSuf.KacWard
