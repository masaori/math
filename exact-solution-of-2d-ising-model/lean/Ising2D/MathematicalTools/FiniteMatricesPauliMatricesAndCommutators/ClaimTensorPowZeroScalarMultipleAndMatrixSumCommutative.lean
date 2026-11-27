/-
# `Mat(2^M, ℂ)` の行列の 0 倍は零行列・和の可換律（**具体版**）

対応する人手証明のラベル: `zero_scalar_multiple_is_zero_matrix`, `matrix_sum_is_commutative`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/ZeroSmulAndAddCommMatrix.lean`。具体版をその系として導くのは
`ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。主張は次の順に示す。

* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
* スカラー倍・和・零行列の成分を、番号の上の本文の式へ移す（`tensorPow_smul_apply`（`def_matrix_scalar_multiple`）・
  `tensorPow_add_apply`（`def_matrix_sum`）・`tensorPow_zero_apply`（`def_zero_matrix`））。
* 番号で読んだ成分の行列（`Fin n` の添字の行列）について、人手の主張の成分の鎖（`ClaimZeroScalarMultipleAndMatrixSumCommutative.lean` の
  `matrix_zero_smul_apply`・`matrix_add_comm_apply`）を引く。人手の主張は任意の `m, n` について述べてあり、ここはその `2^M` の場合である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutative
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`zero_scalar_multiple_is_zero_matrix`**（`Mat(2^M, ℂ)`）: `0_ℂ A = O`（`A ∈ TensorPow M`）。 -/
theorem zero_smul_tensorPow {M : ℕ} (A : TensorPow M) : (0 : ℂ) • A = 0 := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc ((0 : ℂ) • A) (σ i) (σ k)
      = 0 * A (σ i) (σ k) := tensorPow_smul_apply _ _ _ _                   -- `def_matrix_scalar_multiple`
    _ = 0 * Aν i k := by simp only [hAν, Matrix.of_apply]                  -- 番号で読んだ成分の行列 `Aν` の定義
    _ = ((0 : ℂ) • Aν) i k := (matrix_smul_apply _ _ _ _).symm             -- `def_matrix_scalar_multiple`
    _ = (0 : Matrix (Fin n) (Fin n) ℂ) i k := matrix_zero_smul_apply Aν i k -- `zero_scalar_multiple_is_zero_matrix`
    _ = 0 := matrix_zero_apply i k                                          -- `def_zero_matrix`
    _ = (0 : TensorPow M) (σ i) (σ k) := (tensorPow_zero_apply _ _).symm    -- `def_zero_matrix`

/-- **`matrix_sum_is_commutative`**（`Mat(2^M, ℂ)`）: `A + B = B + A`（`A, B ∈ TensorPow M`）。 -/
theorem add_comm_tensorPow {M : ℕ} (A B : TensorPow M) : A + B = B + A := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (A + B) (σ i) (σ k)
      = A (σ i) (σ k) + B (σ i) (σ k) := tensorPow_add_apply _ _ _ _       -- `def_matrix_sum`
    _ = Aν i k + Bν i k := by simp only [hAν, hBν, Matrix.of_apply]        -- 番号で読んだ成分の行列 `Aν`・`Bν` の定義
    _ = (Aν + Bν) i k := (matrix_sum_apply _ _ _ _).symm                   -- `def_matrix_sum` を右辺から左辺へ
    _ = (Bν + Aν) i k := matrix_add_comm_apply Aν Bν i k                   -- `matrix_sum_is_commutative`
    _ = Bν i k + Aν i k := matrix_sum_apply _ _ _ _                         -- `def_matrix_sum`
    _ = B (σ i) (σ k) + A (σ i) (σ k) := by simp only [hAν, hBν, Matrix.of_apply] -- 番号で読んだ成分の行列 `Aν`・`Bν` の定義
    _ = (B + A) (σ i) (σ k) := (tensorPow_add_apply _ _ _ _).symm          -- `def_matrix_sum`

end Ising2D
