import Ising2DLambda.KacWard.PeriodicPlaneLiftDistinct

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem periodicPlaneLift_translate
    (m L : ℕ) (hm : 0 < m) (base : ℤ → ℤ × ℤ) (wv wh j a : ℤ) :
    periodicPlaneLift m base L wv wh (j + a * m) =
      periodicPlaneLift m base L wv wh j + a • windingShift L wv wh := by
  have hm0 : (m : ℤ) ≠ 0 := by omega
  have hquot := Int.add_mul_ediv_right j a hm0
  have hrem := Int.add_mul_emod_self_right j a (m : ℤ)
  calc
    periodicPlaneLift m base L wv wh (j + a * m) =
        base (j % m) + (j / m + a) • windingShift L wv wh := by
      simp only [periodicPlaneLift, periodicLiftCore, hquot, hrem]
    _ = base (j % m) + ((j / m) • windingShift L wv wh + a • windingShift L wv wh) :=
      by rw [add_zsmul]
    _ = (base (j % m) + (j / m) • windingShift L wv wh) + a • windingShift L wv wh :=
      (add_assoc ..).symm
    _ = periodicPlaneLift m base L wv wh j + a • windingShift L wv wh := rfl

/-- `claim_one_sided_periodic_lift_repetition` の整数格子上の具体版。 -/
theorem periodicPlaneLift_step_remainder
    (m L : ℕ) (hm : 0 < m) (base : ℤ → ℤ × ℤ) (wv wh k₀ i : ℤ) :
    periodicPlaneLift m base L wv wh (k₀ + i + 1) -
        periodicPlaneLift m base L wv wh (k₀ + i) =
      periodicPlaneLift m base L wv wh (k₀ + i % m + 1) -
        periodicPlaneLift m base L wv wh (k₀ + i % m) := by
  have hdiv : i = i / (m : ℤ) * m + i % m := (Int.ediv_mul_add_emod i m).symm
  have hleft : k₀ + i + 1 = (k₀ + i % m + 1) + (i / m) * m := by omega
  have hright : k₀ + i = (k₀ + i % m) + (i / m) * m := by omega
  calc
    _ = periodicPlaneLift m base L wv wh ((k₀ + i % m + 1) + (i / m) * m) -
        periodicPlaneLift m base L wv wh ((k₀ + i % m) + (i / m) * m) := by
      rw [hleft, hright]
    _ = (periodicPlaneLift m base L wv wh (k₀ + i % m + 1) + (i / m) • windingShift L wv wh) -
        (periodicPlaneLift m base L wv wh (k₀ + i % m) + (i / m) • windingShift L wv wh) := by
      rw [periodicPlaneLift_translate m L hm, periodicPlaneLift_translate m L hm]
    _ = _ := by simp only [add_sub_add_right_eq_sub]

end Ising2DLambda.KacWard
