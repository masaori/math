/-
# 整数の絶対値（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_integer_absolute_value`、ラベル **`def_int_absolute_value`**）

人手は `x ∈ ℤ` について、`0_ℤ ≤ x` なら `|x| := x`、`¬(0_ℤ ≤ x)` なら `|x| := −x` と場合分けで定める。
`0_ℤ`・`≤`・`−` は `set_and_algebra_notation` が外から持ち込んだ `ℤ` の零元・順序・符号反転である。
mathlib の `ℤ` の `|x|` は束の上限 `x ⊔ (−x)` として定められており、場合分けの式と定義として等しくはないので、
Lean の `|x|` を人手の `|x|` として使い、場合分けの二つの式が成り立つことを補題一本
`int_abs_of_nonneg_and_of_not_nonneg` で述べる。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`def_int_absolute_value`**: `0 ≤ x` なら `|x| = x`、`¬(0 ≤ x)` なら `|x| = −x`（`x ∈ ℤ`）。 -/
theorem int_abs_of_nonneg_and_of_not_nonneg (x : ℤ) :
    (0 ≤ x → |x| = x) ∧ (¬ (0 ≤ x) → |x| = -x) :=
  ⟨fun h => abs_of_nonneg h, fun h => abs_of_neg (lt_of_not_ge h)⟩

end Ising2D
