/-
人手証明「Archimedes 性の倍率以上の自然数で割れば上界を超えない」
（`claim_rational_log_order_group_div_ge_multiplier_le`）の具体版。

`0 ≤_{Λ_ℚ} ε`、`μ ≤_{Λ_ℚ} n·ε`、`1 ≤ a`、`n ≤ a` から `(1/a)·μ ≤_{Λ_ℚ} ε`。
準備: `0 ≤ 1/a`、`n/a ≤ 1`（ℚ の順序）。本体は一続き
`(1/a)·μ ≤ (1/a)·(n·ε)`（`claim_rational_log_order_group_nonneg_scalar_monotone`）
`= ((1/a)·n)·ε`（有理数倍の結合則）`= (n/a)·ε`（ℚ の四則）
`≤ 1·ε`（`claim_rational_log_order_group_scalar_compare_nonneg`）`= ε`（`1·λ = λ`）。
推移律は `claim_rational_log_order_group_linear_order`。
住処は ℕ・ℚ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupNonnegScalarMonotone
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupScalarCompareNonneg
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupLinearOrder

namespace Ising2DLambda.ThermodynamicLimit

/-- 主張。`0 ≤ ε`、`μ ≤ n·ε`、`1 ≤ a`、`n ≤ a` から `(1/a)·μ ≤ ε`。 -/
theorem rationalLogOrderLE_inv_natSmul_le_of_le_natSmul {μ ε : RationalLogOrderGroup}
    (hε : rationalLogOrderLE 0 ε) {n a : ℕ} (ha : 1 ≤ a) (hna : n ≤ a)
    (hμ : rationalLogOrderLE μ ((n : ℚ) • ε)) :
    rationalLogOrderLE (((1 : ℚ) / a) • μ) ε := by
  -- 準備: 0 ≤ 1/a、n/a ≤ 1（ℚ の順序）
  have hapos : (0 : ℚ) < a := by exact_mod_cast ha
  have h0 : (0 : ℚ) ≤ 1 / a := le_of_lt (one_div_pos.mpr hapos)
  have h1 : (n : ℚ) / a ≤ 1 := by
    rw [div_le_one hapos]
    exact_mod_cast hna
  -- 第一段: claim_rational_log_order_group_nonneg_scalar_monotone（c := 1/a）
  have s1 : rationalLogOrderLE (((1 : ℚ) / a) • μ) (((1 : ℚ) / a) • ((n : ℚ) • ε)) :=
    rationalLogOrderLE_ratSmul_of_nonneg h0 hμ
  -- 第二段・第三段: 有理数倍の結合則（右から左）、ℚ の四則 (1/a)·n = n/a
  have hcoef : (1 : ℚ) / a * n = n / a := by ring
  rw [← mul_smul, hcoef] at s1
  -- 第四段: claim_rational_log_order_group_scalar_compare_nonneg（r := n/a、s := 1、ν := ε）
  have s2 : rationalLogOrderLE (((n : ℚ) / a) • ε) ((1 : ℚ) • ε) :=
    rationalLogOrderLE_ratSmul_le_ratSmul_of_le h1 hε
  -- 第五段: 1·ε = ε
  rw [one_smul] at s2
  -- 推移律（claim_rational_log_order_group_linear_order）
  exact rationalLogOrderLE_trans s1 s2

end Ising2DLambda.ThermodynamicLimit
