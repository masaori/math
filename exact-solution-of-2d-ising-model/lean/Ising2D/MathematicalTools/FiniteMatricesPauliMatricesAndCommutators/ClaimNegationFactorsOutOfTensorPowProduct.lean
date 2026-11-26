/-
# 因子の符号反転は、`Mat(2^M, ℂ)` の行列同士の積の外へ出る（**具体版**）

対応する人手証明のラベル: `negation_factors_out_of_left_factor`, `negation_factors_out_of_right_factor`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/NegMatrixProduct.lean`。具体版をその系として導くのは
`ClaimNegationFactorsOutOfMatrixProductFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。各主張は次の順に示す。

* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
* 積・符号反転の成分を、番号の上の本文の式へ移す（`tensorPow_mul_apply_eq_mat_mult`（`mat_mult`）・`tensorPow_neg_apply`（`def_matrix_negation`））。
* 番号で読んだ成分の行列（`Fin n` の添字の行列）について、人手の主張の成分の鎖（`ClaimNegationFactorsOutOfMatrixProduct.lean` の
  `neg_mul_matrix_apply`・`mul_neg_matrix_apply`）を引く。人手の主張は任意の `m, n, p` について述べてあり、ここはその `2^M` の場合である。

右辺 `-(AB)` は、符号反転を `TensorPow M` の上の演算として明示して書く。mathlib の積 `A * B` の値の型は
`Matrix (Conf M) (Conf M) ℂ` と書かれるので、そのままでは符号反転がその型の上の演算になり、本文の `Mat(2^M, ℂ)` の
符号反転（`def_matrix_negation`）として読めないためである。`TensorPow M` はその型の略記なので、項は定義として同じである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfMatrixProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`negation_factors_out_of_left_factor`**（`Mat(2^M, ℂ)`）: `(-A)B = -(AB)`（`A, B ∈ TensorPow M`）。 -/
theorem neg_mul_matrix_tensorPow {M : ℕ} (A B : TensorPow M) :
    (-A) * B = @Neg.neg (TensorPow M) _ (A * B) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc ((-A) * B) (σ i) (σ k)
      = ∑ j : Fin n, (-A) (σ i) (σ j) * B (σ j) (σ k) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ i k                     -- `mat_mult`
    _ = ∑ j : Fin n, (-Aν) i j * Bν j k := by
        simp only [tensorPow_neg_apply, matrix_neg_apply, hAν, hBν, Matrix.of_apply]  -- `def_matrix_negation`
    _ = ((-Aν) * Bν) i k := (matrix_mul_apply_sum _ _ _ _).symm                  -- `mat_mult`
    _ = (-(Aν * Bν)) i k := neg_mul_matrix_apply Aν Bν i k                        -- `negation_factors_out_of_left_factor`
    _ = -∑ j : Fin n, Aν i j * Bν j k := by
        rw [matrix_neg_apply, matrix_mul_apply_sum]                               -- `def_matrix_negation`, `mat_mult`
    _ = -∑ j : Fin n, A (σ i) (σ j) * B (σ j) (σ k) := by
        simp only [hAν, hBν, Matrix.of_apply]
    _ = -(A * B) (σ i) (σ k) := by
        rw [tensorPow_mul_apply_eq_mat_mult M n hord σ hσ A B i k]                -- `mat_mult`
    _ = (-(A * B)) (σ i) (σ k) := (tensorPow_neg_apply _ _ _).symm                -- `def_matrix_negation`

/-- **`negation_factors_out_of_right_factor`**（`Mat(2^M, ℂ)`）: `A(-B) = -(AB)`（`A, B ∈ TensorPow M`）。 -/
theorem mul_neg_matrix_tensorPow {M : ℕ} (A B : TensorPow M) :
    A * (-B) = @Neg.neg (TensorPow M) _ (A * B) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (A * (-B)) (σ i) (σ k)
      = ∑ j : Fin n, A (σ i) (σ j) * (-B) (σ j) (σ k) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ i k                     -- `mat_mult`
    _ = ∑ j : Fin n, Aν i j * (-Bν) j k := by
        simp only [tensorPow_neg_apply, matrix_neg_apply, hAν, hBν, Matrix.of_apply]  -- `def_matrix_negation`
    _ = (Aν * (-Bν)) i k := (matrix_mul_apply_sum _ _ _ _).symm                  -- `mat_mult`
    _ = (-(Aν * Bν)) i k := mul_neg_matrix_apply Aν Bν i k                        -- `negation_factors_out_of_right_factor`
    _ = -∑ j : Fin n, Aν i j * Bν j k := by
        rw [matrix_neg_apply, matrix_mul_apply_sum]                               -- `def_matrix_negation`, `mat_mult`
    _ = -∑ j : Fin n, A (σ i) (σ j) * B (σ j) (σ k) := by
        simp only [hAν, hBν, Matrix.of_apply]
    _ = -(A * B) (σ i) (σ k) := by
        rw [tensorPow_mul_apply_eq_mat_mult M n hord σ hσ A B i k]                -- `mat_mult`
    _ = (-(A * B)) (σ i) (σ k) := (tensorPow_neg_apply _ _ _).symm                -- `def_matrix_negation`

end Ising2D
