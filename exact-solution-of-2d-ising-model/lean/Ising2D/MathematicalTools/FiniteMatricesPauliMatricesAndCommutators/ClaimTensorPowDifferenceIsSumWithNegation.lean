/-
# `Mat(2^M, ℂ)` の行列の差は符号反転した行列との和に等しい・符号反転した行列の差は差の符号反転に等しい（**具体版**）

対応する人手証明のラベル: `matrix_difference_is_sum_with_negation`, `difference_of_negated_matrices`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/MatrixSubNeg.lean`。具体版をその系として導くのは
`ClaimMatrixDifferenceIsSumWithNegationFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。主張は次の順に示す。

* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
* 差・符号反転・和の成分を、番号の上の本文の式へ移す（`tensorPow_sub_apply`（`def_matrix_difference`）・`tensorPow_neg_apply`（`def_matrix_negation`）・
  `tensorPow_add_apply`（`def_matrix_sum`））。
* 番号で読んだ成分の行列（`Fin n` の添字の行列）について、人手の主張の成分の鎖（`ClaimMatrixDifferenceIsSumWithNegation.lean` の
  `matrix_sub_eq_add_neg_apply`）を引く。人手の主張は任意の `m, n` について述べてあり、ここはその `2^M` の場合である。

`difference_of_negated_matrices` の `Mat(2^M, ℂ)` の場合 `neg_sub_neg_tensorPow` は、人手の 3 行の行列の等号の鎖と 1 対 1 で、
`matrix_difference_is_sum_with_negation` の `Mat(2^M, ℂ)` の場合 `sub_eq_add_neg_tensorPow` と
`negation_distributes_over_matrix_sum` の `Mat(2^M, ℂ)` の場合 `neg_add_tensorPow`（`ClaimNegationDistributesOverTensorPowSum.lean`）を引く。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDifferenceIsSumWithNegation
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationDistributesOverTensorPowSum

namespace Ising2D

/-- **`matrix_difference_is_sum_with_negation`**（`Mat(2^M, ℂ)`）: `A - B = A + (-B)`（`A, B ∈ TensorPow M`）。 -/
theorem sub_eq_add_neg_tensorPow {M : ℕ} (A B : TensorPow M) : A - B = A + (-B) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (A - B) (σ i) (σ k)
      = A (σ i) (σ k) - B (σ i) (σ k) := tensorPow_sub_apply _ _ _ _          -- `def_matrix_difference`
    _ = Aν i k - Bν i k := by simp only [hAν, hBν, Matrix.of_apply]           -- 番号で読んだ成分の行列 `Aν`・`Bν` の定義
    _ = (Aν - Bν) i k := (matrix_sub_apply _ _ _ _).symm                      -- `def_matrix_difference`
    _ = (Aν + (-Bν)) i k := matrix_sub_eq_add_neg_apply Aν Bν i k             -- `matrix_difference_is_sum_with_negation`
    _ = Aν i k + -Bν i k := by rw [matrix_sum_apply, matrix_neg_apply]        -- `def_matrix_sum`, `def_matrix_negation`
    _ = A (σ i) (σ k) + -B (σ i) (σ k) := by
        simp only [hAν, hBν, Matrix.of_apply]                                 -- 番号で読んだ成分の行列 `Aν`・`Bν` の定義
    _ = (A + (-B)) (σ i) (σ k) := by
        rw [tensorPow_add_apply, tensorPow_neg_apply]                         -- `def_matrix_sum`, `def_matrix_negation`

/-- **`difference_of_negated_matrices`**（`Mat(2^M, ℂ)`）: `(-A) - (-B) = -(A - B)`（`A, B ∈ TensorPow M`）。 -/
theorem neg_sub_neg_tensorPow {M : ℕ} (A B : TensorPow M) : (-A) - (-B) = -(A - B) :=
  calc (-A) - (-B)
      = (-A) + (-(-B)) := sub_eq_add_neg_tensorPow _ _                        -- `matrix_difference_is_sum_with_negation`（`A → -A`, `B → -B`）
    _ = -(A + (-B)) := (neg_add_tensorPow A (-B)).symm                        -- `negation_distributes_over_matrix_sum`（`A → A`, `B → -B`）
    _ = -(A - B) := by rw [sub_eq_add_neg_tensorPow A B]                      -- `matrix_difference_is_sum_with_negation`

end Ising2D
