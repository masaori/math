import Mathlib.Algebra.Field.Subfield.Basic

namespace Ising2DLambda.NecSuf.FisherZero

/-- 増大する部分体の和集合が部分体になるためには、添字が上に有向であることだけを使う。 -/
def increasingSubfieldUnion {K : Type*} [Field K]
    (F : ℕ → Subfield K) (hmono : Monotone F) : Subfield K where
  carrier := {z | ∃ n, z ∈ F n}
  zero_mem' := ⟨0, (F 0).zero_mem⟩
  one_mem' := ⟨0, (F 0).one_mem⟩
  add_mem' := by
    rintro x y ⟨i, hi⟩ ⟨j, hj⟩
    exact ⟨max i j, (F (max i j)).add_mem
      (hmono (Nat.le_max_left i j) hi) (hmono (Nat.le_max_right i j) hj)⟩
  neg_mem' := by
    rintro x ⟨i, hi⟩
    exact ⟨i, (F i).neg_mem hi⟩
  mul_mem' := by
    rintro x y ⟨i, hi⟩ ⟨j, hj⟩
    exact ⟨max i j, (F (max i j)).mul_mem
      (hmono (Nat.le_max_left i j) hi) (hmono (Nat.le_max_right i j) hj)⟩
  inv_mem' := by
    rintro x ⟨i, hi⟩
    exact ⟨i, (F i).inv_mem hi⟩

end Ising2DLambda.NecSuf.FisherZero
