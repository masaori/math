/-
# `Mat(2^M, ℂ)` の行列について、スカラー倍は行列の和に分配する（**具体版**）

対応する人手証明のラベル: `scalar_multiple_distributes_over_matrix_sum`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/SmulMatrixSum.lean`。具体版をその系として導くのは
`ClaimScalarMultipleDistributesOverMatrixSumFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。主張は次の順に示す。

* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
* スカラー倍・和の成分を、番号の上の本文の式へ移す（`tensorPow_smul_apply`（`def_matrix_scalar_multiple`）・`tensorPow_add_apply`（`def_matrix_sum`））。
* 番号で読んだ成分の行列（`Fin n` の添字の行列）について、人手の主張の成分の鎖（`ClaimScalarMultipleDistributesOverMatrixSum.lean` の
  `matrix_smul_add_apply`）を引く。人手の主張は任意の行数・列数について述べてあり、ここはその行数・列数を共に `2^M` とした場合である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleDistributesOverMatrixSum
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`scalar_multiple_distributes_over_matrix_sum`**（`Mat(2^M, ℂ)`）: `c(A + B) = cA + cB`（`c ∈ ℂ`、`A, B ∈ TensorPow M`）。 -/
theorem smul_add_tensorPow {M : ℕ} (c : ℂ) (A B : TensorPow M) : c • (A + B) = c • A + c • B := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (c • (A + B)) (σ i) (σ k)
      = c * (A + B) (σ i) (σ k) := tensorPow_smul_apply _ _ _ _                 -- `def_matrix_scalar_multiple`
    _ = c * (A (σ i) (σ k) + B (σ i) (σ k)) := by rw [tensorPow_add_apply]       -- `def_matrix_sum`
    _ = c * (Aν i k + Bν i k) := by simp only [hAν, hBν, Matrix.of_apply]       -- 番号で読んだ成分の行列 `Aν`・`Bν` の定義
    _ = c * (Aν + Bν) i k := by rw [matrix_sum_apply]                           -- `def_matrix_sum`
    _ = (c • (Aν + Bν)) i k := (matrix_smul_apply _ _ _ _).symm                 -- `def_matrix_scalar_multiple`
    _ = (c • Aν + c • Bν) i k := matrix_smul_add_apply c Aν Bν i k              -- `scalar_multiple_distributes_over_matrix_sum`
    _ = (c • Aν) i k + (c • Bν) i k := matrix_sum_apply _ _ _ _                 -- `def_matrix_sum`
    _ = c * Aν i k + c * Bν i k := by rw [matrix_smul_apply, matrix_smul_apply] -- `def_matrix_scalar_multiple` を 2 箇所
    _ = c * A (σ i) (σ k) + c * B (σ i) (σ k) := by
        simp only [hAν, hBν, Matrix.of_apply]                                   -- 番号で読んだ成分の行列 `Aν`・`Bν` の定義
    _ = (c • A) (σ i) (σ k) + (c • B) (σ i) (σ k) := by
        rw [tensorPow_smul_apply, tensorPow_smul_apply]                         -- `def_matrix_scalar_multiple` を 2 箇所
    _ = (c • A + c • B) (σ i) (σ k) := (tensorPow_add_apply _ _ _ _).symm       -- `def_matrix_sum`

end Ising2D
