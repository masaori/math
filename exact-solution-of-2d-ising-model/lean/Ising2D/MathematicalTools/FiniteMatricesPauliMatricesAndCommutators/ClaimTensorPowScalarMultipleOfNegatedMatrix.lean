/-
# `Mat(2^M, ℂ)` の行列について、符号反転した行列のスカラー倍はスカラー倍の符号反転に等しい（**具体版**）

対応する人手証明のラベル: `scalar_multiple_of_negated_matrix`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/SmulNegMatrix.lean`。具体版をその系として導くのは
`ClaimScalarMultipleOfNegatedMatrixFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。主張は次の順に示す。

* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
* スカラー倍・符号反転の成分を、番号の上の本文の式へ移す（`tensorPow_smul_apply`（`def_matrix_scalar_multiple`）・`tensorPow_neg_apply`（`def_matrix_negation`））。
* 番号で読んだ成分の行列（`Fin n` の添字の行列）について、人手の主張の成分の鎖（`ClaimScalarMultipleOfNegatedMatrix.lean` の
  `smul_neg_matrix_apply`）を引く。人手の主張は任意の `m, n` について述べてあり、ここはその `2^M` の場合である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleOfNegatedMatrix
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`scalar_multiple_of_negated_matrix`**（`Mat(2^M, ℂ)`）: `a(-A) = -(aA)`（`a ∈ ℂ`、`A ∈ TensorPow M`）。 -/
theorem smul_neg_matrix_tensorPow {M : ℕ} (a : ℂ) (A : TensorPow M) : a • (-A) = -(a • A) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (a • (-A)) (σ i) (σ k)
      = a * (-A) (σ i) (σ k) := tensorPow_smul_apply _ _ _ _          -- `def_matrix_scalar_multiple`
    _ = a * (-A (σ i) (σ k)) := by rw [tensorPow_neg_apply]           -- `def_matrix_negation`
    _ = a * (-Aν i k) := by simp only [hAν, Matrix.of_apply]           -- 番号で読んだ成分の行列 `Aν` の定義
    _ = a * (-Aν) i k := by rw [matrix_neg_apply]                      -- `def_matrix_negation`
    _ = (a • (-Aν)) i k := (matrix_smul_apply _ _ _ _).symm            -- `def_matrix_scalar_multiple`
    _ = (-(a • Aν)) i k := smul_neg_matrix_apply a Aν i k              -- `scalar_multiple_of_negated_matrix`
    _ = -((a • Aν) i k) := matrix_neg_apply _ _ _                      -- `def_matrix_negation`
    _ = -(a * Aν i k) := by rw [matrix_smul_apply]                     -- `def_matrix_scalar_multiple`
    _ = -(a * A (σ i) (σ k)) := by simp only [hAν, Matrix.of_apply]    -- 番号で読んだ成分の行列 `Aν` の定義
    _ = -((a • A) (σ i) (σ k)) := by rw [tensorPow_smul_apply]         -- `def_matrix_scalar_multiple`
    _ = (-(a • A)) (σ i) (σ k) := (tensorPow_neg_apply _ _ _).symm     -- `def_matrix_negation`

end Ising2D
