/-
# 実数の狭義の順序（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_real_strict_order`、ラベル **`def_real_strict_order`**）

人手は `x, y ∈ ℝ` について `x < y :⟺ (x ≤ y ∧ x ≠ y)` と定め、`x > y` を `y < x` の略記とする。
`≤` は `set_and_algebra_notation` が外から持ち込み、使う性質を列挙した ℝ の順序である。
mathlib の `ℝ` の `<` は `≤` から定めたものではないので、Lean の `<` を人手の `<` として使い、
一致を `real_lt_iff_le_and_ne` の一本で述べる。`>` は Lean でも `y < x` と定義として等しい。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`def_real_strict_order`**: `x < y ⟺ (x ≤ y ∧ x ≠ y)`（`x, y ∈ ℝ`）。 -/
theorem real_lt_iff_le_and_ne (x y : ℝ) : x < y ↔ (x ≤ y ∧ x ≠ y) := lt_iff_le_and_ne

end Ising2D
