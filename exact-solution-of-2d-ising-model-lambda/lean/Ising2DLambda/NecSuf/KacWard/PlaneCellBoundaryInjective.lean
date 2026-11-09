import Mathlib.Data.Finset.Sym

namespace Ising2DLambda.NecSuf.KacWard

open scoped symmDiff

/-- Symmetric-difference preservation transfers equality of images to the difference;
the trivial-kernel condition is needed to conclude that this difference is empty. -/
theorem boundary_injective_of_symmetric_difference
    {α β : Type*} [DecidableEq α] [DecidableEq β]
    (boundary : Finset α → Finset β)
    (hsymm : ∀ A B, boundary (A ∆ B) = boundary A ∆ boundary B)
    (hkernel : ∀ A, boundary A = ∅ → A = ∅) :
    Function.Injective boundary := by
  intro A B hAB
  have hzero : boundary (A ∆ B) = ∅ := by
    rw [hsymm, hAB]
    simp
  exact Finset.symmDiff_eq_empty.mp (hkernel _ hzero)

end Ising2DLambda.NecSuf.KacWard
