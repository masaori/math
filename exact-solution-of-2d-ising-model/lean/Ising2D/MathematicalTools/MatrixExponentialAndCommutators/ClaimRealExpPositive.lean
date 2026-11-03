/-
# 実数の exp は正（具体版）

対応する人手証明（正本は `structured-latex/content/003_exp_linear_map.ts`）:

* `exp_linear_map_010_claim_real_exp_positive`（ラベル **`real_exp_positive`**）

原文の主張: `x ∈ ℝ` について `exp(x) > 0`。

| 人手の段 | Lean |
| --- | --- |
| Step 1 の鎖 `exp(x)exp(-x) = exp(x + (-x)) = exp(0) = 1` | `real_exp_mul_exp_neg` |
| Step 1 の背理法 `1 = exp(x)exp(-x) = 0·exp(-x) = 0` | `real_exp_ne_zero` |
| Step 2 の鎖 `exp(x) = exp(x/2 + x/2) = exp(x/2)exp(x/2) = (exp(x/2))^2 ≥ 0` | `real_exp_nonneg` |
| 結び（`≥ 0` と `≠ 0` から `> 0`） | `real_exp_positive` |

人手の `exp : ℝ → ℝ` は `def_scalar_exp`（行列の exp の 1 行 1 列の成分）で、Lean はこれを mathlib の `Real.exp` で表す
（`def_scalar_exp` の Lean の具体版は無い）。同じ理由で、人手が引く `scalar_exp_product`・`scalar_exp_zero` は
mathlib の `Real.exp_add`・`Real.exp_zero` で表す。この 2 つ以外の段は人手の行と 1 対 1 である。

必要十分版は `Ising2D/NecSuf/PositivityOfAdditiveToMultiplicativeMap.lean`、具体版をその系として導くのは
`ClaimRealExpPositiveFromNecSuf.lean`。
-/
import Mathlib.Analysis.SpecialFunctions.Exp

namespace Ising2D

/-- **人手 `real_exp_positive` Step 1 の鎖**: `exp(x)exp(-x) = 1`。 -/
theorem real_exp_mul_exp_neg (x : ℝ) : Real.exp x * Real.exp (-x) = 1 :=
  calc Real.exp x * Real.exp (-x)
      = Real.exp (x + -x) := (Real.exp_add x (-x)).symm
                                        -- `scalar_exp_product`（Lean は mathlib の `Real.exp_add`）
    _ = Real.exp 0 := by rw [add_neg_cancel]
                                        -- 加法の逆元
    _ = 1 := Real.exp_zero
                                        -- `scalar_exp_zero`（Lean は mathlib の `Real.exp_zero`）

/-- **人手 `real_exp_positive` Step 1**: `exp(x) ≠ 0`。`exp(x) = 0` と仮定して `1 = 0` を導く。 -/
theorem real_exp_ne_zero (x : ℝ) : Real.exp x ≠ 0 := by
  intro h
  have h10 : (1 : ℝ) = 0 :=
    calc (1 : ℝ)
        = Real.exp x * Real.exp (-x) := (real_exp_mul_exp_neg x).symm
                                        -- 上の鎖
      _ = 0 * Real.exp (-x) := by rw [h]
                                        -- 仮定 `exp(x) = 0`
      _ = 0 := zero_mul _
                                        -- ℝ の元に `0` を掛けると `0`
  exact one_ne_zero h10
                                        -- `1 ≠ 0` に反する

/-- **人手 `real_exp_positive` Step 2**: `exp(x) ≥ 0`。 -/
theorem real_exp_nonneg (x : ℝ) : Real.exp x ≥ 0 :=
  calc Real.exp x
      = Real.exp (x / 2 + x / 2) := by rw [add_halves]
                                        -- `x/2 + x/2 = x`
    _ = Real.exp (x / 2) * Real.exp (x / 2) := Real.exp_add _ _
                                        -- `scalar_exp_product`（Lean は mathlib の `Real.exp_add`）
    _ = (Real.exp (x / 2)) ^ 2 := (sq _).symm
                                        -- 冪の定義
    _ ≥ 0 := sq_nonneg _
                                        -- 実数の平方は非負

/-- **人手 `real_exp_positive`**: `x ∈ ℝ` について `exp(x) > 0`。Step 2 の `exp(x) ≥ 0` と Step 1 の `exp(x) ≠ 0` から。 -/
theorem real_exp_positive (x : ℝ) : Real.exp x > 0 :=
  lt_of_le_of_ne (real_exp_nonneg x) (real_exp_ne_zero x).symm

end Ising2D
