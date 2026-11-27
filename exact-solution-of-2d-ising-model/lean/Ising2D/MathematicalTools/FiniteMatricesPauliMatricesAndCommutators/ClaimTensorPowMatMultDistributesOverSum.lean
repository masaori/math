/-
# `Mat(2^M, ℂ)` の行列の積の、因子の和への分配（**具体版**）

対応する人手証明のラベル: `mat_mult_distributes_over_sum_in_right_factor`, `mat_mult_distributes_over_sum_in_left_factor`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/MatMulDistribSum.lean`。具体版をその系として導くのは
`ClaimMatMultDistributesOverSumFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。各主張は次の順に示す。

* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
* 積・和の成分を、番号の上の本文の式へ移す（`tensorPow_mul_apply_eq_mat_mult`（`mat_mult`）・`tensorPow_add_apply`・
  `matrix_conf_add_apply`（`def_matrix_sum`））。
* 番号で読んだ成分の行列（`Fin n` の添字の行列）について、人手の主張の成分の鎖（`ClaimMatMultDistributesOverSum.lean` の
  `mul_add_matrix_apply`・`add_mul_matrix_apply`）を引く。人手の主張は任意の `m, n, p` について述べてあり、ここはその `2^M` の場合である。

右辺の和 `AB + AC` は、mathlib の積の値の型が `Matrix (Conf M) (Conf M) ℂ` と書かれるので、その型の上の和である
（成分は `matrix_conf_add_apply`）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSum
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`mat_mult_distributes_over_sum_in_right_factor`**（`Mat(2^M, ℂ)`）: `A(B + C) = AB + AC`（`A, B, C ∈ TensorPow M`）。 -/
theorem mul_add_matrix_tensorPow {M : ℕ} (A B C : TensorPow M) : A * (B + C) = A * B + A * C := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`・`C_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  set Cν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => C (σ j) (σ l) with hCν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (A * (B + C)) (σ i) (σ k)
      = ∑ j : Fin n, A (σ i) (σ j) * (B + C) (σ j) (σ k) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ i k                     -- `mat_mult`
    _ = ∑ j : Fin n, Aν i j * (Bν + Cν) j k := by
        simp only [tensorPow_add_apply, matrix_sum_apply, hAν, hBν, hCν, Matrix.of_apply]  -- `def_matrix_sum`、番号で読んだ成分の行列の定義
    _ = (Aν * (Bν + Cν)) i k := (matrix_mul_apply_sum _ _ _ _).symm              -- `mat_mult`
    _ = (Aν * Bν + Aν * Cν) i k := mul_add_matrix_apply Aν Bν Cν i k              -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = (∑ j : Fin n, Aν i j * Bν j k) + ∑ j : Fin n, Aν i j * Cν j k := by
        rw [matrix_sum_apply, matrix_mul_apply_sum, matrix_mul_apply_sum]         -- `def_matrix_sum`, `mat_mult` を 2 か所
    _ = (∑ j : Fin n, A (σ i) (σ j) * B (σ j) (σ k)) + ∑ j : Fin n, A (σ i) (σ j) * C (σ j) (σ k) := by
        simp only [hAν, hBν, hCν, Matrix.of_apply]                                -- 番号で読んだ成分の行列の定義
    _ = (A * B) (σ i) (σ k) + (A * C) (σ i) (σ k) := by
        rw [tensorPow_mul_apply_eq_mat_mult M n hord σ hσ A B i k,
          tensorPow_mul_apply_eq_mat_mult M n hord σ hσ A C i k]                  -- `mat_mult` を 2 か所
    _ = (A * B + A * C) (σ i) (σ k) := (matrix_conf_add_apply _ _ _ _).symm       -- `def_matrix_sum`

/-- **`mat_mult_distributes_over_sum_in_left_factor`**（`Mat(2^M, ℂ)`）: `(A + B)C = AC + BC`（`A, B, C ∈ TensorPow M`）。 -/
theorem add_mul_matrix_tensorPow {M : ℕ} (A B C : TensorPow M) : (A + B) * C = A * C + B * C := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`・`C_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  set Cν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => C (σ j) (σ l) with hCν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc ((A + B) * C) (σ i) (σ k)
      = ∑ j : Fin n, (A + B) (σ i) (σ j) * C (σ j) (σ k) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ i k                     -- `mat_mult`
    _ = ∑ j : Fin n, (Aν + Bν) i j * Cν j k := by
        simp only [tensorPow_add_apply, matrix_sum_apply, hAν, hBν, hCν, Matrix.of_apply]  -- `def_matrix_sum`、番号で読んだ成分の行列の定義
    _ = ((Aν + Bν) * Cν) i k := (matrix_mul_apply_sum _ _ _ _).symm              -- `mat_mult`
    _ = (Aν * Cν + Bν * Cν) i k := add_mul_matrix_apply Aν Bν Cν i k              -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = (∑ j : Fin n, Aν i j * Cν j k) + ∑ j : Fin n, Bν i j * Cν j k := by
        rw [matrix_sum_apply, matrix_mul_apply_sum, matrix_mul_apply_sum]         -- `def_matrix_sum`, `mat_mult` を 2 か所
    _ = (∑ j : Fin n, A (σ i) (σ j) * C (σ j) (σ k)) + ∑ j : Fin n, B (σ i) (σ j) * C (σ j) (σ k) := by
        simp only [hAν, hBν, hCν, Matrix.of_apply]                                -- 番号で読んだ成分の行列の定義
    _ = (A * C) (σ i) (σ k) + (B * C) (σ i) (σ k) := by
        rw [tensorPow_mul_apply_eq_mat_mult M n hord σ hσ A C i k,
          tensorPow_mul_apply_eq_mat_mult M n hord σ hσ B C i k]                  -- `mat_mult` を 2 か所
    _ = (A * C + B * C) (σ i) (σ k) := (matrix_conf_add_apply _ _ _ _).symm       -- `def_matrix_sum`

end Ising2D
