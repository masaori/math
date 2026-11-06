/-
# 実対称な複素行列の exp は実対称（**具体版**）

正本: `structured-latex/content/009_eigenvalues_of_V.ts`
（`eigenvalues_of_V_claim_exp_of_real_symmetric_is_real_symmetric`、ラベル **`exp_of_real_symmetric_is_real_symmetric`**）。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 1 行目 `A^* = A`（`real_symmetric_matrix_is_hermitian`（`n → n`, `A → A`）） | `hH`（`real_symmetric_isHermitian`） |
| 2 行目 `A^⊤ = A`（`def_real_symmetric_complex_matrix`） | `hT`（`MatrixIsRealSymmetric` の第 2 成分） |
| 3 行目 `exp(A)^* = exp(A)`（`A^* = A`、`exp_of_hermitian_is_hermitian`（`n → n`, `S → A`）） | `hEH`（`matExp_conjTranspose_of_conjTranspose_eq`） |
| 4 行目 `exp(A)^⊤ = exp(A)`（`A^⊤ = A`、`exp_of_symmetric_is_symmetric`（`n → n`, `S → A`）） | `hET`（`matExp_transpose_of_transpose_eq`） |
| 結論: 後の二つの等式から `hermitian_and_transpose_invariant_matrix_is_real_symmetric`（`n → n`, `A → exp(A)`） | `hermitian_and_transpose_invariant_matrix_is_real_symmetric (matExp A) hEH hET` |

- 行列は `TensorPow M`（添字 `Conf M`）で述べ、人手の `n` は `2^M` に限る。引く `exp_of_hermitian_is_hermitian`・
  `exp_of_symmetric_is_symmetric` の具体版が、`matExp` が `TensorPow M` にしか無いために `TensorPow M` で述べてあるからである。
  使う側（`W_is_real_symmetric_positive_definite` の Step 2 の `A → ½K_1D`・`A → S_2`）も `TensorPow M` である。
- 人手のエルミート（`A^* = A`）は mathlib の `Matrix.IsHermitian`（定義が `Aᴴ = A`）で、`real_symmetric_isHermitian` の値をそのまま
  `Aᴴ = A` として渡す。
- 極限の段（`ℝ` への脱出）は、引く 2 つの具体版の中にある。このファイルの段は脱出を含まない。

人手の主張は既存の 4 つの主張（`real_symmetric_matrix_is_hermitian`・`exp_of_hermitian_is_hermitian`・
`exp_of_symmetric_is_symmetric`・`hermitian_and_transpose_invariant_matrix_is_real_symmetric`）と定義を並べるだけなので、
必要十分版は置かない。引く 4 つにはそれぞれ必要十分版がある（`lean/docs/ch009-formalization.md`）。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealSymmetricMatrixIsHermitian
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimExpOfHermitianIsHermitian
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimExpOfSymmetricIsSymmetric
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimHermitianAndTransposeInvariantMatrixIsRealSymmetric

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手 `exp_of_real_symmetric_is_real_symmetric`**: 実対称な `A` について `exp(A)` も実対称。 -/
theorem exp_of_real_symmetric_is_real_symmetric (A : TensorPow M) (hA : MatrixIsRealSymmetric A) :
    MatrixIsRealSymmetric (matExp A) := by
  have hH : Aᴴ = A := real_symmetric_isHermitian A hA                       -- 1 行目 `real_symmetric_matrix_is_hermitian`（`n → n`, `A → A`）
  have hT : Aᵀ = A := hA.2                                                  -- 2 行目 `def_real_symmetric_complex_matrix`
  have hEH : (matExp A)ᴴ = matExp A :=
    matExp_conjTranspose_of_conjTranspose_eq A hH                           -- 3 行目 `A^* = A`、`exp_of_hermitian_is_hermitian`（`S → A`）
  have hET : (matExp A)ᵀ = matExp A :=
    matExp_transpose_of_transpose_eq A hT                                   -- 4 行目 `A^⊤ = A`、`exp_of_symmetric_is_symmetric`（`S → A`）
  exact hermitian_and_transpose_invariant_matrix_is_real_symmetric
    (matExp A) hEH hET                                                      -- 結論 `hermitian_and_transpose_invariant_matrix_is_real_symmetric`（`A → exp(A)`）

end Ising2D
