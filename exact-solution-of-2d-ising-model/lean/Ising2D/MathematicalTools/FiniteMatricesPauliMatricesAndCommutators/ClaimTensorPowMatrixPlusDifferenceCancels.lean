/-
# `Mat(2^M, ℂ)` の行列 A と差 B − A の和は B（**具体版**）

対応する人手証明のラベル: `matrix_plus_difference_cancels`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/MatrixAddSubCancel.lean`。具体版をその系として導くのは
`ClaimMatrixPlusDifferenceCancelsFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。主張は次の順に示す。

* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
* 和と差の成分を、番号の上の本文の式へ移す（`tensorPow_add_apply`（`def_matrix_sum`）・`tensorPow_sub_apply`（`def_matrix_difference`））。
* 番号で読んだ成分の行列（`Fin n` の添字の行列）について、人手の主張の成分の鎖（`ClaimMatrixPlusDifferenceCancels.lean` の
  `matrix_add_sub_cancel_apply`）を引く。人手の主張は任意の `m, p` について述べてあり、ここはその `2^M` の場合である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixPlusDifferenceCancels
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`matrix_plus_difference_cancels`**（`Mat(2^M, ℂ)`）: `A + (B - A) = B`（`A, B ∈ TensorPow M`）。 -/
theorem add_sub_cancel_tensorPow {M : ℕ} (A B : TensorPow M) : A + (B - A) = B := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (A + (B - A)) (σ i) (σ k)
      = A (σ i) (σ k) + (B - A) (σ i) (σ k) := tensorPow_add_apply _ _ _ _   -- `def_matrix_sum`
    _ = A (σ i) (σ k) + (B (σ i) (σ k) - A (σ i) (σ k)) := by
        rw [tensorPow_sub_apply]                                             -- `def_matrix_difference`
    _ = Aν i k + (Bν i k - Aν i k) := by simp only [hAν, hBν, Matrix.of_apply]
                                                                             -- 番号で読んだ成分の行列 `Aν`・`Bν` の定義
    _ = Aν i k + (Bν - Aν) i k := by rw [matrix_sub_apply]                   -- `def_matrix_difference`
    _ = (Aν + (Bν - Aν)) i k := (matrix_sum_apply _ _ _ _).symm              -- `def_matrix_sum`
    _ = Bν i k := matrix_add_sub_cancel_apply Aν Bν i k                      -- `matrix_plus_difference_cancels`
    _ = B (σ i) (σ k) := by simp only [hBν, Matrix.of_apply]                 -- 番号で読んだ成分の行列 `Bν` の定義

end Ising2D
