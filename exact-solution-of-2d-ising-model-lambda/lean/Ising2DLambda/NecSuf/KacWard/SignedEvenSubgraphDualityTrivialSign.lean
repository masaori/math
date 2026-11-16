import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- The four-term sum fixes the remaining sign after the three nontrivial signs are positive. -/
theorem duality_trivial_negative_sign {F : Type*} [CommRing F] [NoZeroDivisors F]
    [CharZero F] (n : ℕ) (Q : (Fin 2 × Fin 2) → F) (Z : F)
    (hthree : ∀ s, s ≠ (0, 0) → Q s = (2 : F) ^ n)
    (hsum : (∑ s : Fin 2 × Fin 2, Q s) = 2 * Z)
    (hZ : Z = (2 : F) ^ n)
    (hsign : Q (0, 0) = (2 : F) ^ n ∨ Q (0, 0) = -((2 : F) ^ n)) :
    Q (0, 0) = -((2 : F) ^ n) := by
  have h01 := hthree (0, 1) (by decide)
  have h10 := hthree (1, 0) (by decide)
  have h11 := hthree (1, 1) (by decide)
  have hfour : Q (0, 0) + 3 * (2 : F) ^ n = 2 * (2 : F) ^ n := by
    simp only [Fintype.sum_prod_type, Fin.sum_univ_two] at hsum
    rw [h01, h10, h11, hZ] at hsum
    convert hsum using 1 <;> ring
  rcases hsign with hpos | hneg
  · have htwo : (2 : F) * (2 : F) ^ n = 0 := by
      calc
        (2 : F) * (2 : F) ^ n =
            Q (0, 0) + 3 * (2 : F) ^ n - 2 * (2 : F) ^ n := by rw [hpos]; ring
        _ = 0 := sub_eq_zero.mpr hfour
    exact False.elim ((mul_ne_zero (by norm_num) (pow_ne_zero _ (by norm_num))) htwo)
  · exact hneg

end Ising2DLambda.NecSuf.KacWard
