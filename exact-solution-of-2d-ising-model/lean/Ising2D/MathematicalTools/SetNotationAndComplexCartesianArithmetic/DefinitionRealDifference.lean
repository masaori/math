/-
# 実数の差（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_real_difference`、ラベル **`def_real_difference`**）

人手は `y, z ∈ ℝ` の差を `y − z := y + (−z)` と定める。mathlib の `ℝ` の差もこの式で定義されているので、
Lean の `-`（`ℝ` の差）をそのまま人手の差として使い、一致は `real_sub_eq_add_neg`（`rfl`）で述べる。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`def_real_difference`**: `y − z = y + (−z)`（`y, z ∈ ℝ`）。 -/
theorem real_sub_eq_add_neg (y z : ℝ) : y - z = y + -z := rfl

end Ising2D
