import Ising2DLambda.PartitionPolynomial.Basic
import Ising2DLambda.NecSuf.KacWard.RepresentativeIncrement

namespace Ising2DLambda.KacWard

/-- The standard integer representative increases by one, except at the seam. -/
theorem residueRepresentative_increment (L : ℕ) [NeZero L] (y : ZMod L) :
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
      have hy : y.val < n + 2 := ZMod.val_lt y
      change (((y + 1).val : ℕ) : ℤ) =
        if (y.val : ℤ) ≤ (n + 2 : ℕ) - 2 then (y.val : ℤ) + 1 else 0
      rw [ZMod.val_add, ZMod.val_one]
      by_cases h : y.val ≤ n
      · have hmod : (y.val + 1) % (n + 2) = y.val + 1 :=
          Nat.mod_eq_of_lt (by omega)
        rw [hmod]
        split_ifs with hh <;> omega
      · have hval : y.val = n + 1 := by omega
        rw [hval]
        have hmod : (n + 1 + 1) % (n + 2) = 0 := by
          convert Nat.mod_self (n + 2) using 1
        rw [hmod]
        split_ifs with hh <;> omega

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
