/-
# 複素数の商（具体版）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calc_formulae_definition_complex_quotient`、ラベル **`def_complex_quotient`**）

人手は `z ∈ ℂ`、`w ∈ ℂ^×` について商を `z/w := z w^{-1}` と定める。`w^{-1}` は `def_complex_inverse` の逆数である
（Lean では `DefinitionComplexInverse.lean` が `w ≠ 0` での一致を述べる）。

Lean の `/` は `0` でも値を持つ全域の写像で、人手の商はその `w ≠ 0` への制限に当たる。
`complex_div_eq_mul_inv` は、仮定に人手の商の定義域 `w ≠ 0` を置いて定義の式 `z/w = z w^{-1}` を述べる。
Lean の `/` は `z * w⁻¹` と定義として等しいので、仮定は証明に使わない。

定義であり、主張に固有の構造は定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **`def_complex_quotient`**: `w ≠ 0` のとき `z/w = z w^{-1}`（`z, w ∈ ℂ`）。仮定は人手の商の定義域で、Lean の証明は使わない。 -/
theorem complex_div_eq_mul_inv (z w : ℂ) (_hw : w ≠ 0) : z / w = z * w⁻¹ := div_eq_mul_inv z w

end Ising2D
