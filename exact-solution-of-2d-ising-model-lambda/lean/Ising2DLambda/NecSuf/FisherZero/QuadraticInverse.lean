import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 逆元の共役表示に必要なのは、係数の埋め込みと `1,s` の一次独立性である。 -/
theorem inverse_mem_necSuf
    {K : Type*} [Field K] [CharZero K]
    (j : ℚ →+* K) (s : K) (hs : s * s = j 2)
    (hlin : ∀ a b : ℚ, j a + j b * s = 0 → a = 0 ∧ b = 0)
    (xi : K) (hxi : ∃ a b : ℚ, xi = j a + j b * s) (hnonzero : xi ≠ 0) :
    ∃ a b : ℚ, xi⁻¹ = j a + j b * s := by
  obtain ⟨a, b, hab⟩ := hxi
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
    have hcoeff : a = 0 ∧ -b = 0 := hlin a (-b) (by
      simpa [map_neg, sub_eq_add_neg, neg_mul] using hconj)
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
  have hmapd : j d ≠ 0 := by
    intro hz
    exact hd ((RingHom.injective j) (by simpa using hz))
  have hunit : xi * ((j d)⁻¹ * (j a - j b * s)) = 1 := by
    calc
      xi * ((j d)⁻¹ * (j a - j b * s)) = (j d)⁻¹ * (xi * (j a - j b * s)) := by ring
      _ = (j d)⁻¹ * j d := by rw [hproduct]
      _ = 1 := inv_mul_cancel₀ hmapd
  exact (eq_inv_of_mul_eq_one_right hunit).symm

end Ising2DLambda.NecSuf.FisherZero
