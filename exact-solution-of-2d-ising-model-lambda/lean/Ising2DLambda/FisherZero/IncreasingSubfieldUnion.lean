import Ising2DLambda.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_increasing_subfield_union_is_subfield` の具体版。
二元を扱う段では、両方が入る大きい方の添字を取る。 -/
def increasingSubfieldUnion (F : ℕ → Subfield Qbar) (hmono : Monotone F) : Subfield Qbar where
  carrier := {z | ∃ n, z ∈ F n}
  zero_mem' := ⟨0, (F 0).zero_mem⟩
  one_mem' := ⟨0, (F 0).one_mem⟩
  add_mem' := by
    rintro x y ⟨i, hi⟩ ⟨j, hj⟩
    refine ⟨max i j, ?_⟩
    exact (F (max i j)).add_mem (hmono (Nat.le_max_left i j) hi)
      (hmono (Nat.le_max_right i j) hj)
  neg_mem' := by
    rintro x ⟨i, hi⟩
    exact ⟨i, (F i).neg_mem hi⟩
  mul_mem' := by
    rintro x y ⟨i, hi⟩ ⟨j, hj⟩
    refine ⟨max i j, ?_⟩
    exact (F (max i j)).mul_mem (hmono (Nat.le_max_left i j) hi)
      (hmono (Nat.le_max_right i j) hj)
  inv_mem' := by
    rintro x ⟨i, hi⟩
    exact ⟨i, (F i).inv_mem hi⟩

end Ising2DLambda.FisherZero
