/-
# 実数の絶対値の二乗と、二つの実数の和の二乗の評価（**具体版**）

対応する人手証明のラベル: `square_of_real_absolute_value`, `square_of_real_sum_is_at_most_twice_sum_of_squares`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の `calc_formulae_claim_square_of_real_absolute_value`,
`calc_formulae_claim_square_of_real_sum_is_at_most_twice_sum_of_squares`）。

**必要十分版**: `Ising2D/NecSuf/SquareOfAbsoluteValueAndOfSum.lean`。具体版をその系として導くのは
`ClaimSquareOfRealAbsoluteValueAndOfRealSumFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `square_of_real_absolute_value` の `q ≥ 0` の 1 行（`def_real_absolute_value`） | `abs_of_nonneg` で `|q| = q` に開く 1 段 |
| `square_of_real_absolute_value` の `q < 0` の 4 行（`def_real_absolute_value`、`square_of_real_number_is_product`、ℝ で `(-a)(-b) = ab`、`square_of_real_number_is_product` を右辺から左辺へ） | `abs_of_neg` の段、`square_of_real_number_is_product` の段、`neg_mul_neg` の段、`square_of_real_number_is_product` の逆向きの段 |
| `square_of_real_sum_is_at_most_twice_sum_of_squares` の 6 行の鎖 | 準備の `0 ≤ (a - b)^2` は `sq_nonneg`、`calc` の 6 段（加法の単位元 `add_zero`、準備と順序と加法の両立 `add_le_add`、`square_of_real_number_is_product` を 2 か所、展開、`square_of_real_number_is_product` を右辺から左辺へ 4 か所、加法と減法の計算） |

* 人手 `def_real_absolute_value`（`q ≥ 0` なら `|q| = q`、`q < 0` なら `|q| = -q`）は、`ClaimRealAbsoluteValueBoundsTriangleAndProduct.lean` と同じく
  mathlib の `abs_of_nonneg`・`abs_of_neg` で場合分けの形へ開いて読む。
* 人手の二乗（`def_power_of_real_number` の冪）は Lean の `r ^ 2`（`Monoid.npow`）である。積の形へ開く段は
  `square_of_real_number_is_product`（`ClaimSquareOfRealNumberIsProduct.lean`）で引き、mathlib の `sq`・`neg_sq` は使わない。
* 鎖の 4 行目「分配則による展開」と 6 行目「加法と減法の計算」は `ring` の 1 段ずつである（両辺は `a`、`b` の多項式として等しい）。
  人手の展開は `ab` と `ba` を分けて書き、乗法の可換性を使わない（必要十分版が `Ring` で通ることがその検査である）。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealNumberIsProduct
import Mathlib.Algebra.Order.Ring.Abs
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

namespace Ising2D

/-- **`square_of_real_absolute_value`**: `q ∈ ℝ` について `|q|^2 = q^2`（`q` の符号で 2 つに場合を分ける）。 -/
theorem square_of_real_absolute_value (q : ℝ) : |q| ^ 2 = q ^ 2 := by
  rcases le_or_gt 0 q with hq | hq
  · -- `q ≥ 0` のとき
    rw [abs_of_nonneg hq]                                        -- `def_real_absolute_value`（`q ≥ 0`）（1 行の鎖）
  · -- `q < 0` のとき
    calc |q| ^ 2
        = (-q) ^ 2 := by rw [abs_of_neg hq]                                   -- `def_real_absolute_value`（`q < 0`）
      _ = (-q) * (-q) := square_of_real_number_is_product (-q)                -- `square_of_real_number_is_product`（`r → -q`）
      _ = q * q := neg_mul_neg q q                                            -- ℝ で `(-a)(-b) = ab`（`a, b → q`）
      _ = q ^ 2 := (square_of_real_number_is_product q).symm                  -- `square_of_real_number_is_product`（`r → q`）を右辺から左辺へ

/-- **`square_of_real_sum_is_at_most_twice_sum_of_squares`**: `a, b ∈ ℝ` について `(a + b)^2 ≤ 2a^2 + 2b^2`
（人手の 6 行の鎖と 1 対 1 の `calc`）。 -/
theorem square_of_real_sum_is_at_most_twice_sum_of_squares (a b : ℝ) :
    (a + b) ^ 2 ≤ 2 * a ^ 2 + 2 * b ^ 2 :=
  calc (a + b) ^ 2
      = (a + b) ^ 2 + 0 := (add_zero _).symm                                  -- `0` は ℝ の加法の単位元
    _ ≤ (a + b) ^ 2 + (a - b) ^ 2 :=
        add_le_add le_rfl (sq_nonneg (a - b))                                 -- 準備の `0 ≤ (a - b)^2`（実数の平方は非負）と順序と加法の両立（`c → (a + b)^2`）
    _ = (a + b) * (a + b) + (a - b) * (a - b) := by
        rw [square_of_real_number_is_product (a + b),
          square_of_real_number_is_product (a - b)]                           -- `square_of_real_number_is_product`（`r → a + b`, `r → a - b`）を 2 か所へ同時適用
    _ = (a * a + a * b + b * a + b * b) + (a * a - a * b - b * a + b * b) := by
        ring                                                                  -- 分配則による展開を 2 か所へ同時適用
    _ = (a ^ 2 + a * b + b * a + b ^ 2) + (a ^ 2 - a * b - b * a + b ^ 2) := by
        rw [← square_of_real_number_is_product a,
          ← square_of_real_number_is_product b]                               -- `square_of_real_number_is_product`（`r → a`, `r → b`）を右辺から左辺へ 4 か所へ同時適用
    _ = 2 * a ^ 2 + 2 * b ^ 2 := by ring                                      -- ℝ の加法と減法の計算

end Ising2D
