/-
人手証明「非正の元の有理数倍は係数の大小で比較できる（向きが逆）」
（`claim_rational_log_order_group_scalar_compare_nonpos`）の具体版。

`c := s − r`（`r ≤ s` から `0 ≤ c`）。`claim_rational_log_order_group_nonneg_scalar_monotone` を
`λ := ν`、`μ := 0` で読んで `c·ν ≤ c·0`、`c·0 = 0`、`claim_rational_log_order_group_add_monotone` で
`c·ν + r·ν ≤ 0 + r·ν`、鎖 `s·ν = (c+r)·ν = c·ν + r·ν ≤ 0 + r·ν = r·ν`。
住処は ℚ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupNonnegScalarMonotone
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupAddMonotone

namespace Ising2DLambda.ThermodynamicLimit

/-- 主張。`r ≤ s` と `ν ≤_{Λ_ℚ} 0` から `s·ν ≤_{Λ_ℚ} r·ν`。 -/
theorem rationalLogOrderLE_ratSmul_le_ratSmul_of_le_of_nonpos {r s : ℚ} (hrs : r ≤ s)
    {ν : RationalLogOrderGroup} (hν : rationalLogOrderLE ν 0) :
    rationalLogOrderLE (s • ν) (r • ν) := by
  -- 準備: c := s − r、0 ≤ c（ℚ の順序と減法）
  have hc : 0 ≤ s - r := sub_nonneg.mpr hrs
  -- claim_rational_log_order_group_nonneg_scalar_monotone（λ := ν、μ := 0）: c·ν ≤ c·0
  have h1 : rationalLogOrderLE ((s - r) • ν) ((s - r) • (0 : RationalLogOrderGroup)) :=
    rationalLogOrderLE_ratSmul_of_nonneg hc hν
  -- c·0 = 0（有理数倍は零写像を零写像へ送る）
  rw [smul_zero] at h1
  -- claim_rational_log_order_group_add_monotone（λ := c·ν、μ := 0、ν := r·ν）: c·ν + r·ν ≤ 0 + r·ν
  have h2 := rationalLogOrderLE_add_right h1 (r • ν)
  -- 鎖: s·ν = (c+r)·ν（ℚ の四則）= c·ν + r·ν（分配則）≤ 0 + r·ν = r·ν（零写像は単位元）
  rw [zero_add, ← add_smul, sub_add_cancel] at h2
  exact h2

end Ising2DLambda.ThermodynamicLimit
