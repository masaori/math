/-
# 実数の 2（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_real_two`、ラベル **`def_real_two`**）

人手は `ℝ` の元 `2` を `2 := 1 + 1` と定める。右辺の `1` と `+` は `set_and_algebra_notation` が外から持ち込んだ
`1_ℝ` と `+_ℝ` である。mathlib の `ℝ` の数字 `2` は `Nat.cast 2` を通して定められており、`1 + 1` と定義として等しくは
ないので、Lean の `(2 : ℝ)` を人手の `2` として使い、一致を `real_two_eq_one_add_one` の一本で述べる。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **`def_real_two`**: `2 = 1 + 1`（`ℝ`）。 -/
theorem real_two_eq_one_add_one : (2 : ℝ) = 1 + 1 := one_add_one_eq_two.symm

end Ising2D
