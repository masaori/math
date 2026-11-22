/-
# 複素数の `-1` 倍と差（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
- `calc_formulae_008_multiply_by_minus_one`（ラベル **`multiply_by_minus_one`**）
- `calc_formulae_008b_definition_complex_difference`（ラベル **`def_complex_difference`**）

## 人手の定義との対応

| 人手 | Lean |
| --- | --- |
| `multiply_by_minus_one` の `-z := (-1_ℂ)·z`（`-1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = -1`） | `complex_neg_eq_ofReal_neg_one_mul` |
| `def_complex_difference` の `z − w := z + (−w)` | `complex_sub_eq_add_neg`（`rfl`） |

mathlib の `ℂ` の符号反転は成分ごとの `-⟨x, y⟩ = ⟨-x, -y⟩` で定義されていて、人手の `(-1_ℂ)·z` とは定義として等しくない。
そこで一致を `complex_neg_eq_ofReal_neg_one_mul` 一本で述べ、Lean の `-`（`ℂ` の符号反転）を人手の `-z` として使う。
証明は `z = (x, y)` について、成分ごとに本文の `ℝ` の主張（`real_minus_one_times_is_negation`・`real_minus_zero_is_self`・
`real_zero_times_is_zero`）と加法の単位元を当てて `definition_of_cc` の積の式にする。

mathlib の `ℂ` の差は成分ごとの `⟨x - u, y - v⟩` で定義され、`ℝ` の差は `def_real_difference` の `y + (−z)` と定義として等しいので、
Lean の符号反転を使った `z + -w` と定義として等しい（`complex_sub_eq_add_neg` は `rfl`）。その `-w` が人手の `(-1_ℂ)·w` に等しいことは
`complex_neg_eq_ofReal_neg_one_mul` による。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionComplexNumbers
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroTimesIsZero
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusOneTimesIsNegation
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusZeroIsSelf

namespace Ising2D

/-- **`multiply_by_minus_one`**: `-z = (-1_ℂ)·z`（`z ∈ ℂ`。`-1_ℂ` は `(-1)_ℂ`）。 -/
theorem complex_neg_eq_ofReal_neg_one_mul (z : ℂ) : -z = ((-1 : ℝ) : ℂ) * z :=
  calc -z
      = (⟨-z.re, -z.im⟩ : ℂ) := rfl                               -- mathlib の `ℂ` の符号反転は成分ごと
    _ = (⟨(-1) * z.re, -z.im⟩ : ℂ) := by
          rw [real_minus_one_times_is_negation z.re]                 -- `real_minus_one_times_is_negation`（`a → x`）を右辺から左辺へ
    _ = (⟨(-1) * z.re, (-1) * z.im⟩ : ℂ) := by
          rw [real_minus_one_times_is_negation z.im]                 -- `real_minus_one_times_is_negation`（`a → y`）を右辺から左辺へ
    _ = (⟨(-1) * z.re - 0, (-1) * z.im⟩ : ℂ) := by
          rw [real_minus_zero_is_self]                               -- `real_minus_zero_is_self`（`a → (-1)x`）を右辺から左辺へ
    _ = (⟨(-1) * z.re - 0, (-1) * z.im + 0⟩ : ℂ) := by
          rw [add_zero ((-1) * z.im)]                                -- `ℝ` の加法の単位元 `x + 0 = x`（`set_and_algebra_notation`）
    _ = (⟨(-1) * z.re - 0 * z.im, (-1) * z.im + 0 * z.re⟩ : ℂ) := by
          rw [real_zero_times_is_zero z.im, real_zero_times_is_zero z.re] -- `real_zero_times_is_zero` を 2 か所へ
    _ = (⟨-1, 0⟩ : ℂ) * ⟨z.re, z.im⟩ := (complex_mk_mul_mk (-1) 0 z.re z.im).symm
                                                                     -- `definition_of_cc` の積
    _ = ((-1 : ℝ) : ℂ) * z := by rw [← complex_ofReal_eq_mk (-1)]    -- `inclusion_rr_to_cc`（`x → -1`）と `z = (z.re, z.im)`

/-- **`def_complex_difference`**: `z − w = z + (−w)`（`z, w ∈ ℂ`）。 -/
theorem complex_sub_eq_add_neg (z w : ℂ) : z - w = z + -w := rfl

end Ising2D
