import Mathlib.Algebra.Group.Basic
import Mathlib.Algebra.Group.Int.Defs
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 周期並進を右から加えた整数添字の点列。可換性は要らない。 -/
def integerPeriodicLift {G : Type*} [AddGroup G]
    (m : ℤ) (base : ℤ → G) (shift : G) (k : ℤ) : G :=
  base (k % m) + (k / m) • shift

theorem integerPeriodicLift_translate_necSuf {G : Type*} [AddGroup G]
    (m : ℤ) (hm : m ≠ 0) (base : ℤ → G) (shift : G) (j a : ℤ) :
    integerPeriodicLift m base shift (j + a * m) =
      integerPeriodicLift m base shift j + a • shift := by
  have hquot := Int.add_mul_ediv_right j a hm
  have hrem := Int.add_mul_emod_self_right j a m
  calc
    integerPeriodicLift m base shift (j + a * m) =
        base (j % m) + (j / m + a) • shift := by
      simp only [integerPeriodicLift, hquot, hrem]
    _ = base (j % m) + ((j / m) • shift + a • shift) := by rw [add_zsmul]
    _ = (base (j % m) + (j / m) • shift) + a • shift := (add_assoc ..).symm
    _ = integerPeriodicLift m base shift j + a • shift := rfl

/-- `claim_one_sided_periodic_lift_repetition`。整数除法、二点の並進、共通項の消去。 -/
theorem integerPeriodicLift_step_remainder_necSuf {G : Type*} [AddGroup G]
    (m : ℤ) (hm : m ≠ 0) (base : ℤ → G) (shift : G) (k₀ i : ℤ) :
    integerPeriodicLift m base shift (k₀ + i + 1) -
        integerPeriodicLift m base shift (k₀ + i) =
      integerPeriodicLift m base shift (k₀ + i % m + 1) -
        integerPeriodicLift m base shift (k₀ + i % m) := by
  have hdiv : i = i / m * m + i % m := (Int.ediv_mul_add_emod i m).symm
  have hleft : k₀ + i + 1 = (k₀ + i % m + 1) + (i / m) * m := by omega
  have hright : k₀ + i = (k₀ + i % m) + (i / m) * m := by omega
  calc
    _ = integerPeriodicLift m base shift ((k₀ + i % m + 1) + (i / m) * m) -
        integerPeriodicLift m base shift ((k₀ + i % m) + (i / m) * m) := by
      rw [hleft, hright]
    _ = (integerPeriodicLift m base shift (k₀ + i % m + 1) + (i / m) • shift) -
        (integerPeriodicLift m base shift (k₀ + i % m) + (i / m) • shift) := by
      rw [integerPeriodicLift_translate_necSuf m hm, integerPeriodicLift_translate_necSuf m hm]
    _ = _ := by simp only [add_sub_add_right_eq_sub]

end Ising2DLambda.NecSuf.KacWard
