/-
# 複素数の二乗は、その複素数を二つ掛けた積に等しい（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_square_of_complex_number_is_product`、ラベル **`square_of_complex_number_is_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 4 行の鎖（`z^{m+1} := z^m z`（`m → 1`）→ 同（`m → 0`）→ `z^0 := 1_ℂ` → `complex_numbers_form_a_field` の積の単位元） | `square_of_complex_number_is_product` の `calc` の 4 段 |

- 人手の冪（`def_power_of_complex_number`）は mathlib の `z ^ 2`（`Monoid.npow`）で、定義の 2 つの式は `pow_zero`・`pow_succ` で読む
  （`ClaimSquareOfRealNumberIsProduct.lean` と同じ）。mathlib の `sq`・`pow_two` は使わない。

必要十分版は `Ising2D/NecSuf/SquareIsProduct.lean`、具体版をその系として導くのは
`ClaimSquareOfComplexNumberIsProductFromNecSuf.lean`。
-/
import Mathlib.Algebra.Group.Basic
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **人手 `square_of_complex_number_is_product`**: `z ∈ ℂ` について `z^2 = z z`（人手の 4 行の鎖と 1 対 1 の `calc`）。 -/
theorem square_of_complex_number_is_product (z : ℂ) : z ^ 2 = z * z :=
  calc z ^ 2
      = z ^ 1 * z := pow_succ z 1                                             -- `z^{m+1} := z^m z`（`m → 1`）
    _ = (z ^ 0 * z) * z := by rw [pow_succ z 0]                               -- `z^{m+1} := z^m z`（`m → 0`）
    _ = (1 * z) * z := by rw [pow_zero z]                                     -- `z^0 := 1_ℂ`
    _ = z * z := by rw [one_mul z]                                            -- `complex_numbers_form_a_field` の積の単位元

end Ising2D
