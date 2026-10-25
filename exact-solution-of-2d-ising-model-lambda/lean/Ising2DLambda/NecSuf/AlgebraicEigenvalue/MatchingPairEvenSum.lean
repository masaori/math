import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Classical

/-- 必要なのは有限な添字集合の全単射、各項の等号、和を持つ可換モノイドだけである。 -/
theorem weightedSum_reindex_of_term_eq
    {P S R : Type*} [Fintype P] [Fintype S] [AddCommMonoid R]
    (e : P ≃ S) (f : S → R) (g : P → R)
    (hterm : ∀ p, f (e p) = g p) :
    (∑ s : S, f s) = ∑ p : P, g p := by
  calc
    (∑ s : S, f s) = ∑ p : P, f (e p) := (Equiv.sum_comp e f).symm
    _ = ∑ p : P, g p := by
      apply Finset.sum_congr rfl
      intro p _
      exact hterm p

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
