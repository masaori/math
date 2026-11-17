import Ising2DLambda.FisherZero.QuadraticPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 二次体の非零元の逆元は、共役を有理ノルムで割った表示を持つ。 -/
theorem quadraticInverse_mem
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : Qbar) (hxi : xi ∈ quadraticFieldSet s) (hnonzero : xi ≠ 0) :
    xi⁻¹ ∈ quadraticFieldSet s := by
  obtain ⟨a, b, hab⟩ := hxi
  let j : ℚ →+* Qbar := algebraMap ℚ Qbar
  let d : ℚ := a * a - 2 * (b * b)
  have hproduct : xi * (j a - j b * s) = j d := by
    rw [hab]
    change (j a + j b * s) * (j a - j b * s) = j (a * a - 2 * (b * b))
    calc
      (j a + j b * s) * (j a - j b * s) =
          j a * j a - (j b * j b) * (s * s) := by ring
      _ = j (a * a - 2 * (b * b)) := by
        rw [hs]
        simp only [map_sub, map_mul]
        ring
  have hd : d ≠ 0 := by
    intro hd0
    have hconj : j a - j b * s = 0 := by
      have hz : xi * (j a - j b * s) = 0 := by simpa [hd0] using hproduct
      exact (mul_eq_zero.mp hz).resolve_left hnonzero
    have hcoeff := quadraticRepresentationUnique s hs a (-b) 0 0 (by
      simpa [j, map_neg, sub_eq_add_neg, neg_mul] using hconj)
    have ha : a = 0 := hcoeff.1
    have hb : b = 0 := neg_eq_zero.mp hcoeff.2
    apply hnonzero
    simpa [ha, hb] using hab
  refine ⟨a / d, -b / d, ?_⟩
  have htarget : j (a / d) + j (-b / d) * s =
      (j d)⁻¹ * (j a - j b * s) := by
    simp only [map_div₀, map_neg]
    ring
  rw [htarget]
  have hmapd : j d ≠ 0 := (map_ne_zero (algebraMap ℚ Qbar)).mpr hd
  have hunit : xi * ((j d)⁻¹ * (j a - j b * s)) = 1 := by
    calc
      xi * ((j d)⁻¹ * (j a - j b * s)) = (j d)⁻¹ * (xi * (j a - j b * s)) := by ring
      _ = (j d)⁻¹ * j d := by rw [hproduct]
      _ = 1 := inv_mul_cancel₀ hmapd
  exact (eq_inv_of_mul_eq_one_right hunit).symm

end Ising2DLambda.FisherZero
