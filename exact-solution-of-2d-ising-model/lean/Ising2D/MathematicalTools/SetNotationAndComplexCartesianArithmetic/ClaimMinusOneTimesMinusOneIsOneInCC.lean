/-
# `(-1_ℂ)(-1_ℂ) = 1_ℂ`（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_minus_one_times_minus_one_is_one_in_cc`、ラベル **`minus_one_times_minus_one_is_one_in_cc`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 1 行目: `-1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = -1` | `calc` の 1 段目（`Complex.ofReal_neg`・`Complex.ofReal_one` を右辺から左辺へ） |
| 2 行目: `real_inclusion_preserves_product`（`a → -1`, `b → -1`） | 2 段目（`real_inclusion_mul`） |
| 3 行目: ℝ で `(-1)(-1) = 1`（ℝ は体 `set_and_algebra_notation`） | 3 段目（ℝ の等式を包含の引数へ渡す） |
| 4 行目: `1_ℂ` は同じ略記の `r = 1` | 4 段目（`Complex.ofReal_one`） |

- 人手の `-1_ℂ`・`1_ℂ` は Lean で `-1 : ℂ`・`1 : ℂ` と書き、略記の像 `((-1 : ℝ) : ℂ)`・`((1 : ℝ) : ℂ)` との行き来は
  1 段目と 4 段目の読み替えだけで行う。
- 3 段目の ℝ の等式 `(-1)(-1) = 1` は、人手と同じく ℝ の体の計算として `norm_num` で出す（ℝ は土台の集合である）。

必要十分版は置かない。2 つの具体的な数の積の計算で、使う構造は `real_inclusion_preserves_product`（ℂ の積の定義の式）と
ℝ の 1 つの等式だけであり、取り払える構造をこの説明以上に示す計算が無い（`real_inclusion_mul` と同じ扱い）。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Mathlib.Tactic.NormNum

namespace Ising2D

/-- **人手 `minus_one_times_minus_one_is_one_in_cc`**: `(-1_ℂ)(-1_ℂ) = 1_ℂ`（人手の 4 行）。 -/
theorem complex_minus_one_mul_minus_one : (-1 : ℂ) * (-1 : ℂ) = 1 :=
  calc (-1 : ℂ) * (-1 : ℂ)
      = ((-1 : ℝ) : ℂ) * ((-1 : ℝ) : ℂ) := by
        rw [Complex.ofReal_neg, Complex.ofReal_one]                     -- 1 行目: `-1_ℂ` は略記 `r_ℂ` の `r = -1`
    _ = (((-1) * (-1) : ℝ) : ℂ) := real_inclusion_mul (-1) (-1)         -- 2 行目: `real_inclusion_preserves_product`（`a → -1`, `b → -1`）
    _ = ((1 : ℝ) : ℂ) :=
        congrArg (fun r : ℝ => (r : ℂ)) (by norm_num)                   -- 3 行目: ℝ で `(-1)(-1) = 1`
    _ = 1 := Complex.ofReal_one                                         -- 4 行目: `1_ℂ` は略記 `r_ℂ` の `r = 1`

end Ising2D
