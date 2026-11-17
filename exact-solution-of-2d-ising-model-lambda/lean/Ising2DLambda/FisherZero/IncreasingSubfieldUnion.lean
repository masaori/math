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

/-- 各段で正錐を延長した増大列の和集合は、部分体の和集合の正錐である。 -/
theorem increasingPositiveConeUnion_isPositiveCone
    (F : ℕ → Subfield Qbar) (C : ℕ → Set Qbar)
    (hstep : ∀ n, ExtendsPositiveCone (F n) (F (n + 1)) (C n) (C (n + 1))) :
    IsSubfieldPositiveCone
      (increasingSubfieldUnion F (monotone_nat_of_le_succ (fun n => (hstep n).subfield_le)))
      {z | ∃ n, z ∈ C n} := by
  have hF : Monotone F :=
    monotone_nat_of_le_succ (fun n => (hstep n).subfield_le)
  have hC : Monotone C := monotone_nat_of_le_succ (by
    intro n z hz
    exact ((hstep n).inter_eq z).2 hz |>.1)
  change IsSubfieldPositiveCone (increasingSubfieldUnion F hF) {z | ∃ n, z ∈ C n}
  refine ⟨?_, ?_, ?_, ?_⟩
  · rintro z ⟨n, hz⟩
    exact ⟨n, ((hstep n).cone_F.subset z hz)⟩
  · rintro x y ⟨i, hx⟩ ⟨j, hy⟩
    let k := max i j
    exact ⟨k, (hstep k).cone_F.add_mem x y
      (hC (Nat.le_max_left i j) hx) (hC (Nat.le_max_right i j) hy)⟩
  · rintro x y ⟨i, hx⟩ ⟨j, hy⟩
    let k := max i j
    exact ⟨k, (hstep k).cone_F.mul_mem x y
      (hC (Nat.le_max_left i j) hx) (hC (Nat.le_max_right i j) hy)⟩
  · rintro z ⟨i, hz⟩
    have htri := (hstep i).cone_F.trichotomy z hz
    refine ⟨?_, ?_, ?_, ?_⟩
    · rcases htri.1 with hzero | hpos | hneg
      · exact Or.inl hzero
      · exact Or.inr (Or.inl ⟨i, hpos⟩)
      · exact Or.inr (Or.inr ⟨i, hneg⟩)
    · rintro ⟨hzero, j, hpos⟩
      have htri' := (hstep j).cone_F.trichotomy z (hzero ▸ (F j).zero_mem)
      exact htri'.2.1 ⟨hzero, hpos⟩
    · rintro ⟨hzero, j, hneg⟩
      have htri' := (hstep j).cone_F.trichotomy z (hzero ▸ (F j).zero_mem)
      exact htri'.2.2.1 ⟨hzero, hneg⟩
    · rintro ⟨⟨j, hpos⟩, ⟨k, hneg⟩⟩
      let m := max j k
      have hzm : z ∈ F m := (hstep m).cone_F.subset z (hC (Nat.le_max_left j k) hpos)
      have htri' := (hstep m).cone_F.trichotomy z hzm
      exact htri'.2.2.2 ⟨hC (Nat.le_max_left j k) hpos,
        hC (Nat.le_max_right j k) hneg⟩

end Ising2DLambda.FisherZero
