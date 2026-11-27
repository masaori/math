/-
# `Mat(2^M, ℂ)` の行列の共役転置の積・線型結合の法則（**具体版**）

対応する人手証明のラベル: `star_preserves_norm_and_limits`
（`structured-latex/content/009_eigenvalues_of_V.ts` の `eigenvalues_of_V_012_claim_star_is_norm_preserving`）の (1) の、
行列が `Mat(2^M, ℂ)` の場合（`n → 2^M`）。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/StarPreservesNormAndLimits.lean`。具体版をその系として導くのは
`ClaimStarPreservesNormAndLimitsFromNecSuf.lean`（`conjTranspose_mul_tensorPow_of_necSuf`・`conjTranspose_add_smul_tensorPow_of_necSuf`）。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。

| 人手 | Lean（具体版） |
| --- | --- |
| (1) の第 1 式の `(k, l)` 成分の鎖の 7 行と「すべての成分が等しい」 | `conjTranspose_mul_tensorPow` の `calc` の 7 段と、その前の `refine` |
| (1) の第 2 式の `(k, l)` 成分の鎖の 8 行と「すべての成分が等しい」 | `conjTranspose_add_smul_tensorPow` の `calc` の 8 段と、その前の `refine` |

* 成分の式との接点は、共役転置 `matrix_conf_conjTranspose_apply`（`def_hermitian_positive_definite`）、積 `tensorPow_mul_apply_eq_mat_mult`・
  `matrix_conf_mul_apply_eq_mat_mult`（`mat_mult`）、和 `tensorPow_add_apply`・`matrix_conf_add_apply`（`def_matrix_sum`）、
  スカラー倍 `tensorPow_smul_apply`・`matrix_conf_smul_apply`（`def_matrix_scalar_multiple`）である。
  共役転置の値は型 `Matrix (Conf M) (Conf M) ℂ` と書かれるので、その積・和・スカラー倍は `matrix_conf_*` の形を引く。
* 複素共役の性質は `Fin n` の場合と同じ具体版 `complex_conjugate_star_finite_sum`（`complex_conjugate_of_sum` の `m = n`）・
  `complex_conjugate_of_sum_two`（`m = 2`）・`complex_conjugate_of_product_eq` を引く。`ℂ` の積の可換性（`complex_numbers_form_a_field`）は `mul_comm`。
* 行列の等号は、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionConjugateTransposeAndHermitian
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimComplexConjugateOfSumProductDifferenceStarForm
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices
import Ising2D.Representation

namespace Ising2D

open Matrix

/-- **`star_preserves_norm_and_limits` (1) の第 1 式**（`Mat(2^M, ℂ)`）: `(AB)^* = B^*A^*`（`A, B ∈ TensorPow M`）。 -/
theorem conjTranspose_mul_tensorPow {M : ℕ} (A B : TensorPow M) : (A * B)ᴴ = Bᴴ * Aᴴ := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  have hent := tensorPow_entries_by_kronecker_numbering M n hord σ hσ
  refine (hent.1 _ _).2 (fun k l => ?_)                                         -- すべての成分が等しい（`def_complex_matrices`）
  calc (A * B)ᴴ (σ k) (σ l)
      = star ((A * B) (σ l) (σ k)) := matrix_conf_conjTranspose_apply _ _ _     -- `def_hermitian_positive_definite`
    _ = star (∑ j : Fin n, A (σ l) (σ j) * B (σ j) (σ k)) := by
        rw [tensorPow_mul_apply_eq_mat_mult M n hord σ hσ]                       -- `mat_mult`
    _ = ∑ j : Fin n, star (A (σ l) (σ j) * B (σ j) (σ k)) :=
        complex_conjugate_star_finite_sum _ _                                    -- `complex_conjugate_of_sum` の `m = n`
    _ = ∑ j : Fin n, star (A (σ l) (σ j)) * star (B (σ j) (σ k)) := by
        simp only [complex_conjugate_of_product_eq]                              -- `complex_conjugate_of_product` を各項へ
    _ = ∑ j : Fin n, star (B (σ j) (σ k)) * star (A (σ l) (σ j)) :=
        Finset.sum_congr rfl fun _ _ => mul_comm _ _                             -- 積の可換性を各項へ（`complex_numbers_form_a_field`）
    _ = ∑ j : Fin n, Bᴴ (σ k) (σ j) * Aᴴ (σ j) (σ l) := by
        simp only [matrix_conf_conjTranspose_apply]                              -- `def_hermitian_positive_definite` を各項へ
    _ = (Bᴴ * Aᴴ) (σ k) (σ l) :=
        (matrix_conf_mul_apply_eq_mat_mult M n hord σ hσ _ _ k l).symm           -- `mat_mult`

/-- **`star_preserves_norm_and_limits` (1) の第 2 式**（`Mat(2^M, ℂ)`）:
`(αA + βB)^* = \overline{α}A^* + \overline{β}B^*`（`A, B ∈ TensorPow M`）。 -/
theorem conjTranspose_add_smul_tensorPow {M : ℕ} (α β : ℂ) (A B : TensorPow M) :
    (α • A + β • B)ᴴ = star α • Aᴴ + star β • Bᴴ := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  have hent := tensorPow_entries_by_kronecker_numbering M n hord σ hσ
  refine (hent.1 _ _).2 (fun k l => ?_)                                         -- すべての成分が等しい（`def_complex_matrices`）
  calc (α • A + β • B)ᴴ (σ k) (σ l)
      = star ((α • A + β • B) (σ l) (σ k)) := matrix_conf_conjTranspose_apply _ _ _  -- `def_hermitian_positive_definite`
    _ = star ((α • A) (σ l) (σ k) + (β • B) (σ l) (σ k)) := by
        rw [tensorPow_add_apply]                                                 -- `def_matrix_sum`
    _ = star (α * A (σ l) (σ k) + β * B (σ l) (σ k)) := by
        rw [tensorPow_smul_apply, tensorPow_smul_apply]                          -- `def_matrix_scalar_multiple`（2 項へ同時に）
    _ = star (α * A (σ l) (σ k)) + star (β * B (σ l) (σ k)) :=
        complex_conjugate_of_sum_two _ _                                         -- `complex_conjugate_of_sum` の `m = 2`
    _ = star α * star (A (σ l) (σ k)) + star β * star (B (σ l) (σ k)) := by
        rw [complex_conjugate_of_product_eq, complex_conjugate_of_product_eq]    -- `complex_conjugate_of_product` を各項へ
    _ = star α * Aᴴ (σ k) (σ l) + star β * Bᴴ (σ k) (σ l) := by
        rw [matrix_conf_conjTranspose_apply, matrix_conf_conjTranspose_apply]    -- `def_hermitian_positive_definite` を各項へ
    _ = (star α • Aᴴ) (σ k) (σ l) + (star β • Bᴴ) (σ k) (σ l) := by
        rw [matrix_conf_smul_apply, matrix_conf_smul_apply]                      -- `def_matrix_scalar_multiple`（2 項へ同時に）
    _ = (star α • Aᴴ + star β • Bᴴ) (σ k) (σ l) :=
        (matrix_conf_add_apply _ _ _ _).symm                                     -- `def_matrix_sum`

end Ising2D
