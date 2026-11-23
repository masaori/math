/-
# 整数の狭義の順序（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_integer_strict_order`、ラベル **`def_int_strict_order`**）

人手は `x, y ∈ ℤ` について `x <_ℤ y :⇔ x +_ℤ 1_ℤ ≤_ℤ y` と定める。`+_ℤ`・`1_ℤ`・`≤_ℤ` は `set_and_algebra_notation` が
外から持ち込んだ `ℤ` の和・乗法の単位元・順序である。Lean の `ℤ` の `<`（`Int.lt m n`）も `m + 1 ≤ n` と定義されており、
人手の定義の式と定義として等しい（`Iff.rfl`）。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`def_int_strict_order`**: `x < y ⇔ x + 1 ≤ y`（`x, y ∈ ℤ`）。 -/
theorem int_lt_iff_add_one_le (x y : ℤ) : x < y ↔ x + 1 ≤ y := Iff.rfl

end Ising2D
