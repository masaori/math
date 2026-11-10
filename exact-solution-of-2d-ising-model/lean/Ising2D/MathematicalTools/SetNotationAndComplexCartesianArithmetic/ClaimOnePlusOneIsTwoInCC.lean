/-
# `1_ℂ + 1_ℂ = 2_ℂ`（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_one_plus_one_is_two_in_cc`、ラベル **`one_plus_one_is_two_in_cc`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 1 行目: `1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = 1` を 2 か所へ | `calc` の 1 段目（`Complex.ofReal_one` を右辺から左辺へ） |
| 2 行目: `real_inclusion_preserves_sum`（`a → 1`, `b → 1`） | 2 段目（`real_inclusion_add`） |
| 3 行目: ℝ で `1 + 1 = 2` | 3 段目（ℝ の等式を包含の引数へ渡す） |
| 4 行目: `2_ℂ` は同じ略記の `r = 2` | 4 段目（`Complex.ofReal_ofNat`） |

- 人手の `1_ℂ`・`2_ℂ` は Lean で `1 : ℂ`・`2 : ℂ` と書き、略記の像 `((1 : ℝ) : ℂ)`・`((2 : ℝ) : ℂ)` との行き来は
  1 段目と 4 段目の読み替えだけで行う。`2_ℂ` を `((2 : ℝ) : ℂ)`（`def_V1_plus_square_root` の `(2_ℝ)_ℂ`）や
  `complexTwo := ⟨2, 0⟩` と書くファイルは、`complex_one_add_one_eq_ofReal_two`・`one_add_one_eq_complexTwo`
  （`ClaimZeroMatrixProductAndSumEquations.lean`）でこの主張を読む。
- 3 段目の ℝ の等式 `1 + 1 = 2` は mathlib の `one_add_one_eq_two`（ℝ は土台の集合である）。

必要十分版は置かない。2 つの具体的な数の和の計算で、使う構造は `real_inclusion_preserves_sum`（ℂ の和の定義の式）と
ℝ の 1 つの等式だけであり、取り払える構造をこの説明以上に示す計算が無い（`complex_minus_one_mul_minus_one` と同じ扱い）。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum

namespace Ising2D

/-- **人手 `one_plus_one_is_two_in_cc`**: `1_ℂ + 1_ℂ = 2_ℂ`（人手の 4 行）。 -/
theorem complex_one_add_one : (1 : ℂ) + 1 = 2 :=
  calc (1 : ℂ) + 1
      = ((1 : ℝ) : ℂ) + ((1 : ℝ) : ℂ) := by rw [Complex.ofReal_one]   -- 1 行目: `1_ℂ` は略記 `r_ℂ` の `r = 1` を 2 か所へ
    _ = ((1 + 1 : ℝ) : ℂ) := real_inclusion_add 1 1                   -- 2 行目: `real_inclusion_preserves_sum`（`a → 1`, `b → 1`）
    _ = ((2 : ℝ) : ℂ) := by rw [one_add_one_eq_two]                    -- 3 行目: ℝ で `1 + 1 = 2`
    _ = 2 := Complex.ofReal_ofNat 2                                    -- 4 行目: `2_ℂ` は略記 `r_ℂ` の `r = 2`

/-- `one_plus_one_is_two_in_cc` の右辺 `2_ℂ` を、略記の像 `((2 : ℝ) : ℂ)`（`def_V1_plus_square_root` の `(2_ℝ)_ℂ`）で書いたもの。
人手では同じ記号 `2_ℂ` なので、読み替えの段 `Complex.ofReal_ofNat` だけを足す。 -/
theorem complex_one_add_one_eq_ofReal_two : (1 : ℂ) + 1 = ((2 : ℝ) : ℂ) :=
  calc (1 : ℂ) + 1
      = 2 := complex_one_add_one                                       -- `one_plus_one_is_two_in_cc`
    _ = ((2 : ℝ) : ℂ) := (Complex.ofReal_ofNat 2).symm                 -- `2_ℂ` は略記 `r_ℂ` の `r = 2`

end Ising2D
