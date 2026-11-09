/-
# エルミート行列の実数倍はエルミート（具体版）

正本: `structured-latex/content/009_eigenvalues_of_V.ts`
の `eigenvalues_of_V_claim_real_multiple_of_hermitian_is_hermitian`（ラベル **`real_multiple_of_hermitian_is_hermitian`**）。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 成分の鎖の 7 行（共役転置の定義 → `def_matrix_scalar_multiple` → `complex_conjugate_of_product` → `complex_conjugate_of_real_inclusion` → 共役転置の定義 → `A^* = A` → `def_matrix_scalar_multiple`） | `real_multiple_isHermitian` の `calc` の 7 段 |
| すべての成分が等しいので `(α_ℂA)^* = α_ℂA` | `Matrix.ext` と `Matrix.IsHermitian` の定義（`Aᴴ = A`） |

- 人手の共役転置（`def_hermitian_positive_definite`）は mathlib の `Matrix.conjTranspose`（`Aᴴ k l = star (A l k)` が定義から `rfl`）、
  行列のスカラー倍（`def_matrix_scalar_multiple`）は `Matrix` の `•`（`(c • A) k l = c * A k l` が定義から `rfl`）である。
- `complex_conjugate_of_product` の具体版 `complex_conjugate_of_product_eq`（`MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimComplexConjugateOfSumProductDifference.lean`）は `starRingEnd ℂ` の形なので、
  `star` の形のこのファイルはまだ mathlib の `star_mul'`（可換な `ℂ` での `\overline{zw} = \overline{z}\,\overline{w}`）を引く（差し替えは状態台帳の残り）。
- 人手の添字 `k, l ∈ {1, …, n}` は添字の型 `n` の元である（`DefinitionRealSymmetricComplexMatrix.lean` の注意）。

必要十分版は `Ising2D/NecSuf/StarFixedScalarMultipleOfHermitian.lean`、
具体版をその特殊化として得るのは `ClaimRealMultipleOfHermitianIsHermitianFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealSymmetricMatrixIsHermitian

namespace Ising2D

open Matrix

/-- **人手 `real_multiple_of_hermitian_is_hermitian`**: `α ∈ ℝ` と `A^* = A` について `(α_ℂA)^* = α_ℂA`。 -/
theorem real_multiple_isHermitian {n : Type*} (α : ℝ) {A : Matrix n n ℂ} (hA : A.IsHermitian) :
    ((α : ℂ) • A).IsHermitian := by
  show ((α : ℂ) • A)ᴴ = (α : ℂ) • A
  ext k l
  calc ((α : ℂ) • A)ᴴ k l
      = star (((α : ℂ) • A) l k) := rfl                                     -- `def_hermitian_positive_definite` の共役転置
    _ = star ((α : ℂ) * A l k) := rfl                                       -- `def_matrix_scalar_multiple`
    _ = star (α : ℂ) * star (A l k) := star_mul' _ _                        -- `complex_conjugate_of_product`
    _ = (α : ℂ) * star (A l k) := by rw [complex_conjugate_of_real_inclusion] -- `complex_conjugate_of_real_inclusion`
    _ = (α : ℂ) * Aᴴ k l := rfl                                             -- `def_hermitian_positive_definite` の共役転置
    _ = (α : ℂ) * A k l := by rw [hA.eq]                                    -- `A^* = A`
    _ = ((α : ℂ) • A) k l := rfl                                            -- `def_matrix_scalar_multiple`

end Ising2D
