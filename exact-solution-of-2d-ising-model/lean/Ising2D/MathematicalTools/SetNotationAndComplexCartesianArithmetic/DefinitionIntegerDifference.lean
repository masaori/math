/-
# 整数の差（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_integer_difference`、ラベル **`def_int_difference`**）

人手は `y, z ∈ ℤ` について `y −_ℤ z := y +_ℤ (−z)` と定める。`−z` は `set_and_algebra_notation` が外から持ち込んだ
`ℤ` の符号反転の値である。Lean の `ℤ` の差 `Int.sub m n` も `m + -n` と定義されており、人手の定義の式と定義として等しい（`rfl`）。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`def_int_difference`**: `y − z = y + (−z)`（`y, z ∈ ℤ`）。 -/
theorem int_sub_eq_add_neg (y z : ℤ) : y - z = y + -z := rfl

end Ising2D
