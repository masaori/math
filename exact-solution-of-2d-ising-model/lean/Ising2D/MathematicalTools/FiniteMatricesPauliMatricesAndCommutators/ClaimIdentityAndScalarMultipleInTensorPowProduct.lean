/-
# 単位行列とスカラー倍の、`Mat(2^M, ℂ)` の行列同士の積での性質（**具体版**）

対応する人手証明のラベル:
`identity_matrix_is_left_unit_of_mat_mult`, `identity_matrix_is_right_unit_of_mat_mult`,
`scalar_multiple_factors_out_of_left_factor`, `scalar_multiple_factors_out_of_right_factor`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/MatrixProductIdentityAndScalar.lean`。具体版をその系として導くのは
`ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。各主張は次の順に示す。

* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
* 積・単位行列・スカラー倍の成分を、番号の上の本文の式へ移す（`tensorPow_mul_apply_eq_mat_mult`（`mat_mult`）・
  `tensorPow_one_apply_eq_identity_matrix`（`def_identity_matrix`）・`tensorPow_smul_apply`（`def_matrix_scalar_multiple`））。
* 番号で読んだ成分の行列（`Fin n` の添字の行列）について、人手の主張の成分の鎖（`ClaimIdentityAndScalarMultipleInMatrixProduct.lean` の
  `identity_matrix_mul_apply` ほか）を引く。人手の主張は任意の `m, n, p` について述べてあり、ここはその `2^M` の場合である。

スカラー倍の二つの主張の右辺 `a(AB)` は、スカラー倍を `TensorPow M` の上の演算として明示して書く。mathlib の積 `A * B` の値の型は
`Matrix (Conf M) (Conf M) ℂ` と書かれるので、そのままではスカラー倍がその型の上の演算になり、本文の `Mat(2^M, ℂ)` の
スカラー倍（`def_matrix_scalar_multiple`）として読めないためである。`TensorPow M` はその型の略記なので、項は定義として同じである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`identity_matrix_is_left_unit_of_mat_mult`**（`Mat(2^M, ℂ)`）: `I A = A`（`A ∈ TensorPow M`）。 -/
theorem identity_matrix_mul_tensorPow {M : ℕ} (A : TensorPow M) : (1 : TensorPow M) * A = A := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc ((1 : TensorPow M) * A) (σ i) (σ k)
      = ∑ j : Fin n, (1 : TensorPow M) (σ i) (σ j) * A (σ j) (σ k) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ i k                     -- `mat_mult`
    _ = ∑ j : Fin n, kroneckerDelta i j * Aν j k := by
        simp only [tensorPow_one_apply_eq_identity_matrix M n σ hσ, hAν, Matrix.of_apply]  -- `def_identity_matrix`
    _ = ∑ j : Fin n, (1 : Matrix (Fin n) (Fin n) ℂ) i j * Aν j k := by
        simp only [identity_matrix_apply]                                         -- `def_identity_matrix`
    _ = ((1 : Matrix (Fin n) (Fin n) ℂ) * Aν) i k := (matrix_mul_apply_sum _ _ _ _).symm  -- `mat_mult`
    _ = Aν i k := identity_matrix_mul_apply Aν i k                                -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = A (σ i) (σ k) := Matrix.of_apply _ _ _

/-- **`identity_matrix_is_right_unit_of_mat_mult`**（`Mat(2^M, ℂ)`）: `A I = A`（`A ∈ TensorPow M`）。 -/
theorem mul_identity_matrix_tensorPow {M : ℕ} (A : TensorPow M) : A * (1 : TensorPow M) = A := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (A * (1 : TensorPow M)) (σ i) (σ k)
      = ∑ j : Fin n, A (σ i) (σ j) * (1 : TensorPow M) (σ j) (σ k) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ i k                     -- `mat_mult`
    _ = ∑ j : Fin n, Aν i j * kroneckerDelta j k := by
        simp only [tensorPow_one_apply_eq_identity_matrix M n σ hσ, hAν, Matrix.of_apply]  -- `def_identity_matrix`
    _ = ∑ j : Fin n, Aν i j * (1 : Matrix (Fin n) (Fin n) ℂ) j k := by
        simp only [identity_matrix_apply]                                         -- `def_identity_matrix`
    _ = (Aν * (1 : Matrix (Fin n) (Fin n) ℂ)) i k := (matrix_mul_apply_sum _ _ _ _).symm  -- `mat_mult`
    _ = Aν i k := mul_identity_matrix_apply Aν i k                                -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = A (σ i) (σ k) := Matrix.of_apply _ _ _

/-- **`scalar_multiple_factors_out_of_left_factor`**（`Mat(2^M, ℂ)`）: `(aA)B = a(AB)`（`A, B ∈ TensorPow M`）。 -/
theorem smul_mul_matrix_tensorPow {M : ℕ} (a : ℂ) (A B : TensorPow M) :
    (a • A) * B = @HSMul.hSMul ℂ (TensorPow M) (TensorPow M) _ a (A * B) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc ((a • A) * B) (σ i) (σ k)
      = ∑ j : Fin n, (a • A) (σ i) (σ j) * B (σ j) (σ k) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ i k                     -- `mat_mult`
    _ = ∑ j : Fin n, (a • Aν) i j * Bν j k := by
        simp only [tensorPow_smul_apply, matrix_smul_apply, hAν, hBν, Matrix.of_apply]  -- `def_matrix_scalar_multiple`
    _ = ((a • Aν) * Bν) i k := (matrix_mul_apply_sum _ _ _ _).symm               -- `mat_mult`
    _ = (a • (Aν * Bν)) i k := smul_mul_matrix_apply a Aν Bν i k                  -- `scalar_multiple_factors_out_of_left_factor`
    _ = a * ∑ j : Fin n, Aν i j * Bν j k := by
        rw [matrix_smul_apply, matrix_mul_apply_sum]                              -- `def_matrix_scalar_multiple`, `mat_mult`
    _ = a * ∑ j : Fin n, A (σ i) (σ j) * B (σ j) (σ k) := by
        simp only [hAν, hBν, Matrix.of_apply]
    _ = a * (A * B) (σ i) (σ k) := by
        rw [tensorPow_mul_apply_eq_mat_mult M n hord σ hσ A B i k]                -- `mat_mult`
    _ = (a • (A * B)) (σ i) (σ k) := (tensorPow_smul_apply _ _ _ _).symm         -- `def_matrix_scalar_multiple`

/-- **`scalar_multiple_factors_out_of_right_factor`**（`Mat(2^M, ℂ)`）: `A(aB) = a(AB)`（`A, B ∈ TensorPow M`）。 -/
theorem mul_smul_matrix_tensorPow {M : ℕ} (a : ℂ) (A B : TensorPow M) :
    A * (a • B) = @HSMul.hSMul ℂ (TensorPow M) (TensorPow M) _ a (A * B) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (A * (a • B)) (σ i) (σ k)
      = ∑ j : Fin n, A (σ i) (σ j) * (a • B) (σ j) (σ k) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ i k                     -- `mat_mult`
    _ = ∑ j : Fin n, Aν i j * (a • Bν) j k := by
        simp only [tensorPow_smul_apply, matrix_smul_apply, hAν, hBν, Matrix.of_apply]  -- `def_matrix_scalar_multiple`
    _ = (Aν * (a • Bν)) i k := (matrix_mul_apply_sum _ _ _ _).symm               -- `mat_mult`
    _ = (a • (Aν * Bν)) i k := mul_smul_matrix_apply a Aν Bν i k                  -- `scalar_multiple_factors_out_of_right_factor`
    _ = a * ∑ j : Fin n, Aν i j * Bν j k := by
        rw [matrix_smul_apply, matrix_mul_apply_sum]                              -- `def_matrix_scalar_multiple`, `mat_mult`
    _ = a * ∑ j : Fin n, A (σ i) (σ j) * B (σ j) (σ k) := by
        simp only [hAν, hBν, Matrix.of_apply]
    _ = a * (A * B) (σ i) (σ k) := by
        rw [tensorPow_mul_apply_eq_mat_mult M n hord σ hσ A B i k]                -- `mat_mult`
    _ = (a • (A * B)) (σ i) (σ k) := (tensorPow_smul_apply _ _ _ _).symm         -- `def_matrix_scalar_multiple`

end Ising2D
