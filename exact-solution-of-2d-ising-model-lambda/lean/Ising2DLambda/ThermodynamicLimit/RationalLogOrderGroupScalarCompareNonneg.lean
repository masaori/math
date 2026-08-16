/-
人手証明「非負の元の有理数倍は係数の大小で比較できる」
（`claim_rational_log_order_group_scalar_compare_nonneg`）の具体版。

`c := s − r`（`r ≤ s` から `0 ≤ c`）。`claim_rational_log_order_group_nonneg_scalar_monotone` を
`λ := 0`、`μ := ν` で読んで `c·0 ≤ c·ν`、`c·0 = 0`、`claim_rational_log_order_group_add_monotone` で
`0 + r·ν ≤ c·ν + r·ν`、鎖 `r·ν = 0 + r·ν ≤ c·ν + r·ν = (c+r)·ν = s·ν`。
住処は ℚ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupNonnegScalarMonotone
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupAddMonotone

namespace Ising2DLambda.ThermodynamicLimit

/-- 主張。`r ≤ s` と `0 ≤_{Λ_ℚ} ν` から `r·ν ≤_{Λ_ℚ} s·ν`。 -/
theorem rationalLogOrderLE_ratSmul_le_ratSmul_of_le {r s : ℚ} (hrs : r ≤ s)
    {ν : RationalLogOrderGroup} (hν : rationalLogOrderLE 0 ν) :
    rationalLogOrderLE (r • ν) (s • ν) := by
  -- 準備: c := s − r、0 ≤ c（ℚ の順序と減法）
  have hc : 0 ≤ s - r := sub_nonneg.mpr hrs
  -- claim_rational_log_order_group_nonneg_scalar_monotone（λ := 0、μ := ν）: c·0 ≤ c·ν
  have h1 : rationalLogOrderLE ((s - r) • (0 : RationalLogOrderGroup)) ((s - r) • ν) :=
    rationalLogOrderLE_ratSmul_of_nonneg hc hν
  -- c·0 = 0（有理数倍は零写像を零写像へ送る）
  rw [smul_zero] at h1
  -- claim_rational_log_order_group_add_monotone（λ := 0、μ := c·ν、ν := r·ν）: 0 + r·ν ≤ c·ν + r·ν
  have h2 := rationalLogOrderLE_add_right h1 (r • ν)
  -- 鎖: r·ν = 0 + r·ν（零写像は単位元）、c·ν + r·ν = (c+r)·ν（分配則）、c + r = s（ℚ の四則）
  rw [zero_add, ← add_smul, sub_add_cancel] at h2
  exact h2

end Ising2DLambda.ThermodynamicLimit
