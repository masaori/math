/- 隣接二項の和の不変性に必要なのは、有限添字、次の添字と可換な全単射、可換な加法だけである。 -/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.KacWard

theorem permutedAdjacentSum_necSuf {ι M : Type*} [Fintype ι] [AddCommMonoid M]
    (next : ι → ι) (shift : Equiv.Perm ι)
    (hnext : ∀ j, shift (next j) = next (shift j)) (a : ι → ι → M) :
    (∑ j, a (shift j) (shift (next j))) = ∑ j, a j (next j) := by
  calc
    (∑ j, a (shift j) (shift (next j)))
        = ∑ j, a (shift j) (next (shift j)) := by
          apply Finset.sum_congr rfl
          intro j _
          rw [hnext j]
    _ = ∑ j, a j (next j) := Equiv.sum_comp shift (fun j => a j (next j))

end Ising2DLambda.NecSuf.KacWard
