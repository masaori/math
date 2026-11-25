/-
# `κ(K)` の増分の評価（具体版を必要十分版から導く）

具体版 `ClaimKappaOfKBasic.lean` の `abs_kappaK_bounds`・`abs_kappaDerivSq_sub_le` の主張を、必要十分版
`Ising2D/NecSuf/MeanValueTwoSided.lean` の `abs_sub_bounds_of_deriv_bounds`（`D = [K_c − 1/10, K_c + 1/10]`,
`f = κ`, `c_lo = 3.52`, `c_hi = 4.74`）と `abs_sub_le_of_abs_deriv_le`（`f = κ'²`, `C = 88.2`）への特殊化から得る
（人手のラベルは `kappa_of_K_basic` (5)）。
-/
import Ising2D.CriticalPoint.CriticalPointAndLogDivergence.ClaimKappaOfKBasic
import Ising2D.NecSuf.MeanValueTwoSided

namespace Ising2D

open Real

/-- `abs_kappaK_bounds` を、`NecSuf.abs_sub_bounds_of_deriv_bounds` の `D = Dnbhd`, `f = κ`,
`c_lo = 3.52`, `c_hi = 4.74` への特殊化から得る。 -/
theorem abs_kappaK_bounds_of_necSuf {K : ℝ} (hK : K ∈ Dnbhd) :
    (3.52 : ℝ) * |K - Kc| ≤ |kappaK K| ∧ |kappaK K| ≤ 4.74 * |K - Kc| ∧ |kappaK K| ≤ 0.474 := by
  have hb := NecSuf.abs_sub_bounds_of_deriv_bounds (D := Dnbhd) Dnbhd_convex
    (f := kappaK) (clo := 3.52) (chi := 4.74) continuousOn_kappaK differentiableOn_kappaK
    (fun x hx => by
      rw [deriv_kappaK_on (mem_Dnbhd_of_mem_interior hx)]
      exact (kappaDeriv_bounds (mem_Dnbhd_of_mem_interior hx)).1)
    (fun x hx => by
      rw [deriv_kappaK_on (mem_Dnbhd_of_mem_interior hx)]
      exact (kappaDeriv_bounds (mem_Dnbhd_of_mem_interior hx)).2)
    (by norm_num) Kc_mem_Dnbhd hK
  rw [kappaK_Kc, sub_zero] at hb
  have habs : |K - Kc| ≤ 0.1 := by
    have h1 : Kc - 1/10 ≤ K := hK.1
    have h2 : K ≤ Kc + 1/10 := hK.2
    rw [abs_le]
    constructor <;> [linarith; linarith]
  exact ⟨hb.1, hb.2, by nlinarith [hb.2, habs, abs_nonneg (K - Kc)]⟩

/-- `abs_kappaDerivSq_sub_le` を、`NecSuf.abs_sub_le_of_abs_deriv_le` の `D = Dnbhd`, `f = κ'²`,
`C = 88.2` への特殊化と `abs_kappaK_bounds_of_necSuf` の下界から得る。 -/
theorem abs_kappaDerivSq_sub_le_of_necSuf {K : ℝ} (hK : K ∈ Dnbhd) :
    |kappaDeriv K ^ 2 - 16| ≤ 25.1 * |kappaK K| := by
  have hb := NecSuf.abs_sub_le_of_abs_deriv_le (D := Dnbhd) Dnbhd_convex
    (f := kappaDerivSq) (C := 88.2) continuousOn_kappaDerivSq differentiableOn_kappaDerivSq
    (fun x hx => by
      rw [(hasDerivAt_kappaDerivSq (pos_of_mem_Dnbhd (mem_Dnbhd_of_mem_interior hx))).deriv]
      exact abs_deriv_kappaDerivSq_le (mem_Dnbhd_of_mem_interior hx))
    Kc_mem_Dnbhd hK
  rw [kappaDerivSq_Kc] at hb
  have hlow := (abs_kappaK_bounds_of_necSuf hK).1
  have : |K - Kc| ≤ |kappaK K| / 3.52 := by
    rw [le_div_iff₀ (by norm_num)]; linarith
  have hfin : (88.2 : ℝ) * |K - Kc| ≤ 25.1 * |kappaK K| := by
    have h2 : (88.2 : ℝ) * |K - Kc| ≤ 88.2 * (|kappaK K| / 3.52) := by
      exact mul_le_mul_of_nonneg_left this (by norm_num)
    have h3 : (88.2 : ℝ) * (|kappaK K| / 3.52) ≤ 25.1 * |kappaK K| := by
      have heq : (88.2 : ℝ) * (|kappaK K| / 3.52) = (88.2 / 3.52) * |kappaK K| := by ring
      rw [heq]
      exact mul_le_mul_of_nonneg_right (by norm_num) (abs_nonneg _)
    linarith
  simp only [kappaDerivSq] at hb
  linarith

end Ising2D
