/-
# 正の実数の平方根は正（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_sqrt_of_positive_real_is_positive`、ラベル **`sqrt_of_positive_real_is_positive`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `x > 0` なので `x ≥ 0`（ℝ の順序） | `hx0` |
| `y := √x` は `y ≥ 0` かつ `y^2 = x`（`definition_of_sqrt_r_positive`） | `hy0`・`hyx` |
| 背理法の鎖 1 行目: `x = y^2`（`y^2 = x` を右辺から左辺へ） | `calc` の 1 段目 |
| 2 行目: `= 0^2`（仮定 `y = 0`） | `calc` の 2 段目 |
| 3 行目: `= 0·0`（`square_of_real_number_is_product`（`r → 0`）） | `calc` の 3 段目 |
| 4 行目: `= 0`（ℝ で `0·x = 0` の `x → 0`） | `calc` の 4 段目 |
| `x > 0` に反するので `y ≠ 0`（`<` の非反射律） | `hx.ne' this` |
| `y ≥ 0` は `y > 0` または `y = 0` のことなので `y > 0` | `lt_of_le_of_ne` |

- 人手の `√·^{(ℝ_{≥0})}`（`definition_of_sqrt_r_positive`）は Lean の `Real.sqrt` である。定義が与える
  `y ≥ 0` と `y^2 = x` は `Real.sqrt_nonneg`・`Real.sq_sqrt` で読む。mathlib の `Real.sqrt_pos` は使わない。
- 人手の二乗は `def_power_of_real_number` の冪で、Lean の `^ 2`（`Monoid.npow`）である。

必要十分版は `Ising2D/NecSuf/PositiveSquareRootIsPositive.lean`、具体版をその特殊化として導くのは
`ClaimSqrtOfPositiveRealIsPositiveFromNecSuf.lean`。
-/
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealNumberIsProduct

namespace Ising2D

/-- **人手 `sqrt_of_positive_real_is_positive`**: `x ∈ ℝ_{>0}` なら `√x > 0`。 -/
theorem sqrt_of_positive_real_is_positive (x : ℝ) (hx : 0 < x) : 0 < Real.sqrt x := by
  have hx0 : 0 ≤ x := le_of_lt hx                        -- `x > 0` なので `x ≥ 0`（ℝ の順序）
  have hy0 : 0 ≤ Real.sqrt x := Real.sqrt_nonneg x       -- `definition_of_sqrt_r_positive`: `y ≥ 0`
  have hyx : Real.sqrt x ^ 2 = x := Real.sq_sqrt hx0     -- `definition_of_sqrt_r_positive`: `y^2 = x`
  have hne : Real.sqrt x ≠ 0 := by
    intro h                                              -- 背理法: `y = 0` と仮定する
    have : x = 0 :=
      calc x
          = Real.sqrt x ^ 2 := hyx.symm                  -- `definition_of_sqrt_r_positive` の `y^2 = x` を右辺から左辺へ
        _ = (0 : ℝ) ^ 2 := by rw [h]                     -- 仮定 `y = 0`
        _ = 0 * 0 := square_of_real_number_is_product 0  -- `square_of_real_number_is_product`（`r → 0`）
        _ = 0 := zero_mul 0                              -- ℝ で `0·x = 0`（`x → 0`）
    exact hx.ne' this                                    -- `x > 0` に反する
  exact lt_of_le_of_ne hy0 (Ne.symm hne)                 -- `y ≥ 0` は `y > 0` または `y = 0`（ℝ の順序）

end Ising2D
