/-
# 実対称な複素行列はエルミート（具体版）

正本: `structured-latex/content/009_eigenvalues_of_V.ts`
（`eigenvalues_of_V_claim_real_symmetric_matrix_is_hermitian`、ラベル **`real_symmetric_matrix_is_hermitian`**）。
鎖の 3 行目が引く `complex_conjugate_of_real_inclusion`（`structured-latex/content/005_exp_conjugation_proof.ts`）の
4 行の鎖もこのファイルが持つ。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `complex_conjugate_of_real_inclusion` の 4 行（`inclusion_rr_to_cc` → `def_complex_conjugate` → ℝ で `-0 = 0` → `inclusion_rr_to_cc`） | `complex_conjugate_of_real_inclusion` の `calc` の 4 段 |
| `A_{lk} = r_ℂ` を満たす `r ∈ ℝ` を取る（`def_matrix_with_real_entries`（`p → l`, `q → k`）） | `obtain ⟨r, hr⟩ := hreal l k` |
| 成分の鎖の 6 行（共役転置の定義 → `r` の取り方 → `complex_conjugate_of_real_inclusion` → `r` の取り方 → `def_matrix_transpose` → `A^⊤ = A`） | `real_symmetric_isHermitian` の `calc` の 6 段 |
| 全ての成分が一致するので `A^* = A`（エルミートの条件） | `Matrix.ext` と `Matrix.IsHermitian` の定義（`Aᴴ = A`） |

- 人手の共役転置（`def_hermitian_positive_definite`）は mathlib の `Matrix.conjTranspose`（`Aᴴ k l = star (A l k)` が定義から `rfl`）、
  複素共役（`def_complex_conjugate`）は `ℂ` の `star`（`star ⟨x, y⟩ = ⟨x, -y⟩` が定義から `rfl`）である。
- 人手の添字 `k, l ∈ {1, …, n}` は添字の型 `n` の元である（`DefinitionRealSymmetricComplexMatrix.lean` の注意）。

必要十分版は `Ising2D/NecSuf/HermitianOfStarFixedSymmetricEntries.lean`、
具体版をその特殊化として得るのは `ClaimRealSymmetricMatrixIsHermitianFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionRealSymmetricComplexMatrix
import Mathlib.LinearAlgebra.Matrix.Hermitian

namespace Ising2D

open Matrix

/-- **人手 `complex_conjugate_of_real_inclusion`**: `r ∈ ℝ` について `\overline{r_ℂ} = r_ℂ`。 -/
theorem complex_conjugate_of_real_inclusion (r : ℝ) : star (r : ℂ) = (r : ℂ) :=
  calc star (r : ℂ)
      = star (⟨r, 0⟩ : ℂ) := rfl                                            -- `inclusion_rr_to_cc`
    _ = ⟨r, -0⟩ := rfl                                                      -- `def_complex_conjugate`
    _ = ⟨r, 0⟩ := by rw [neg_zero]                                          -- ℝ で `-0 = 0`
    _ = (r : ℂ) := rfl                                                      -- `inclusion_rr_to_cc`

/-- **人手 `real_symmetric_matrix_is_hermitian`**: 実対称な複素行列はエルミートである。 -/
theorem real_symmetric_isHermitian {n : Type*} (A : Matrix n n ℂ) (hA : MatrixIsRealSymmetric A) :
    A.IsHermitian := by
  obtain ⟨hreal, hT⟩ := hA
  show Aᴴ = A
  ext k l
  obtain ⟨r, hr⟩ := hreal l k                                               -- `def_matrix_with_real_entries`（`p → l`, `q → k`）で `A_{lk} = r_ℂ` の `r` を取る
  calc Aᴴ k l
      = star (A l k) := rfl                                                 -- `def_hermitian_positive_definite` の共役転置
    _ = star (r : ℂ) := by rw [hr]                                          -- `r` の取り方 `A_{lk} = r_ℂ`
    _ = (r : ℂ) := complex_conjugate_of_real_inclusion r                    -- `complex_conjugate_of_real_inclusion`
    _ = A l k := hr.symm                                                    -- `r` の取り方 `A_{lk} = r_ℂ`
    _ = Aᵀ k l := rfl                                                       -- `def_matrix_transpose`（`p → k`, `q → l`）
    _ = A k l := by rw [hT]                                                 -- `A^⊤ = A`（`def_real_symmetric_complex_matrix`）

end Ising2D
