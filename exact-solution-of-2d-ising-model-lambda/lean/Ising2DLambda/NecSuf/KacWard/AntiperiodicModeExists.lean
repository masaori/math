import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 平方が 1 の元は、1 でなければ -1 である。必要なのは整域だけである。 -/
theorem square_one_ne_one_eq_neg_one_necSuf {R : Type*} [CommRing R] [IsDomain R]
    (z : R) (hsquare : z ^ 2 = 1) (hne : z ≠ 1) : z = -1 := by
  have hfactor : (z - 1) * (z + 1) = 0 := by
    calc
      (z - 1) * (z + 1) = z ^ 2 - 1 := by ring
      _ = 0 := by rw [hsquare]; ring
  have hright : z + 1 = 0 := by
    rcases mul_eq_zero.mp hfactor with hleft | hright
    · exact False.elim (hne (sub_eq_zero.mp hleft))
    · exact hright
  exact eq_neg_of_add_eq_zero_left hright

/-- 位数条件から得た証人に、上の整域の論法を適用する。 -/
theorem antiperiodicMode_exists_necSuf {R : Type*} [CommRing R] [IsDomain R]
    (L : ℕ) (hξ : ∃ ξ : R, ξ ^ (2 * L) = 1 ∧ ξ ^ L ≠ 1) :
    ∃ ξ : R, ξ ^ (2 * L) = 1 ∧ ξ ^ L = -1 := by
  obtain ⟨ξ, hroot, hne⟩ := hξ
  have hsquare : (ξ ^ L) ^ 2 = 1 := by
    calc
      (ξ ^ L) ^ 2 = ξ ^ (2 * L) := by rw [mul_comm 2 L, pow_mul]
      _ = 1 := hroot
  exact ⟨ξ, hroot, square_one_ne_one_eq_neg_one_necSuf (ξ ^ L) hsquare hne⟩

end Ising2DLambda.NecSuf.KacWard
