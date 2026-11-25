/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.RepresentativeIncrement
import Ising2DLambda.NecSuf.KacWard.RepresentativeIncrement

namespace Ising2DLambda.KacWard

/-- The cyclic arithmetic lemma specializes to the actual residue representative. -/
theorem residueRepresentative_increment_from_necSuf (L : ℕ) [NeZero L] (y : ZMod L) :
    Ising2DLambda.PartitionPolynomial.residueRepresentative L (y + 1) =
      if Ising2DLambda.PartitionPolynomial.residueRepresentative L y ≤ (L : ℤ) - 2 then
        Ising2DLambda.PartitionPolynomial.residueRepresentative L y + 1
      else 0 := by
  cases L with
  | zero => exact (NeZero.ne 0 rfl).elim
  | succ n =>
    cases n with
    | zero =>
      have hy : y.val = 0 := by have := ZMod.val_lt y; omega
      change (((y + 1).val : ℕ) : ℤ) =
        if (y.val : ℤ) ≤ (1 : ℕ) - 2 then (y.val : ℤ) + 1 else 0
      rw [ZMod.val_add, ZMod.val_one_eq_one_mod]
      simp [hy]
    | succ n =>
      haveI : Fact (1 < n + 2) := ⟨by omega⟩
      change (((y + 1).val : ℕ) : ℤ) =
        if (y.val : ℤ) ≤ (n + 2 : ℕ) - 2 then (y.val : ℤ) + 1 else 0
      rw [ZMod.val_add, ZMod.val_one]
      exact Ising2DLambda.NecSuf.KacWard.cyclicRepresentative_increment
        (n + 2) y.val (ZMod.val_lt y)

end Ising2DLambda.KacWard
