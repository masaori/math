/-
# `Mat(2^M, ℂ)` の行列に右から零行列を足す・引く（**具体版**）

対応する人手証明のラベル: `matrix_plus_zero_matrix`, `matrix_minus_zero_matrix`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/MatrixAddSubZero.lean`。具体版をその系として導くのは
`ClaimAddAndSubtractZeroMatrixFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `X (σ i) (σ k)` が人手の `X_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。`matrix_plus_zero_matrix` は次の順に示す。

* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
* 和・零行列の成分を、番号の上の本文の式へ移す（`tensorPow_add_apply`（`def_matrix_sum`）・`tensorPow_zero_apply`（`def_zero_matrix`））。
* 番号で読んだ成分の行列（`Fin n` の添字の行列）について、人手の主張の成分の鎖（`ClaimAddAndSubtractZeroMatrix.lean` の
  `matrix_add_zero_matrix_apply`）を引く。人手の主張は任意の `m, n` について述べてあり、ここはその `2^M` の場合である。

`matrix_minus_zero_matrix` は、人手の 2 行 `X - O = X + O = X` と 1 対 1 である。1 行目（成分ごとの等式）は上と同じ順に、差の成分を
`tensorPow_sub_apply`（`def_matrix_difference`）で番号の上の式へ移して `matrix_sub_zero_matrix_apply` を引き、2 行目は
`matrix_plus_zero_matrix` の `Mat(2^M, ℂ)` の場合 `matrix_add_zero_matrix_tensorPow` を引く。

`zero_matrix_plus_matrix` の `Mat(2^M, ℂ)` の場合は、具体版が使わないのでここに置かない（導出の `zero_matrix_add_matrix_tensorPow` だけがある）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`matrix_plus_zero_matrix`**（`Mat(2^M, ℂ)`）: `X + O = X`（`X ∈ TensorPow M`）。 -/
theorem matrix_add_zero_matrix_tensorPow {M : ℕ} (X : TensorPow M) : X + 0 = X := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `X_{jl}`（`Mat(2^M, ℂ)` の元）
  set Xν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => X (σ j) (σ l) with hXν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (X + 0) (σ i) (σ k)
      = X (σ i) (σ k) + (0 : TensorPow M) (σ i) (σ k) := tensorPow_add_apply _ _ _ _ -- `def_matrix_sum`
    _ = X (σ i) (σ k) + 0 := by rw [tensorPow_zero_apply]                            -- `def_zero_matrix`
    _ = Xν i k + 0 := by simp only [hXν, Matrix.of_apply]                            -- 番号で読んだ成分の行列 `Xν` の定義
    _ = Xν i k + (0 : Matrix (Fin n) (Fin n) ℂ) i k := by rw [matrix_zero_apply]      -- `def_zero_matrix`
    _ = (Xν + 0) i k := (matrix_sum_apply _ _ _ _).symm                              -- `def_matrix_sum`
    _ = Xν i k := matrix_add_zero_matrix_apply Xν i k                                -- `matrix_plus_zero_matrix`
    _ = X (σ i) (σ k) := by simp only [hXν, Matrix.of_apply]                         -- 番号で読んだ成分の行列 `Xν` の定義

/-- **`matrix_minus_zero_matrix`**（`Mat(2^M, ℂ)`）: `X - O = X`（`X ∈ TensorPow M`）。 -/
theorem matrix_sub_zero_matrix_tensorPow {M : ℕ} (X : TensorPow M) : X - 0 = X := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `X_{jl}`（`Mat(2^M, ℂ)` の元）
  set Xν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => X (σ j) (σ l) with hXν
  calc X - 0
      = X + 0 := by
        -- 全ての成分が一致する（`def_complex_matrices`）
        refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
        calc (X - 0) (σ i) (σ k)
            = X (σ i) (σ k) - (0 : TensorPow M) (σ i) (σ k) := tensorPow_sub_apply _ _ _ _ -- `def_matrix_difference`
          _ = X (σ i) (σ k) - 0 := by rw [tensorPow_zero_apply]                            -- `def_zero_matrix`
          _ = Xν i k - 0 := by simp only [hXν, Matrix.of_apply]                            -- 番号で読んだ成分の行列 `Xν` の定義
          _ = Xν i k - (0 : Matrix (Fin n) (Fin n) ℂ) i k := by rw [matrix_zero_apply]      -- `def_zero_matrix`
          _ = (Xν - 0) i k := (matrix_sub_apply _ _ _ _).symm                              -- `def_matrix_difference`
          _ = (Xν + 0) i k := matrix_sub_zero_matrix_apply Xν i k                          -- `matrix_minus_zero_matrix` の成分の鎖
          _ = Xν i k + (0 : Matrix (Fin n) (Fin n) ℂ) i k := matrix_sum_apply _ _ _ _       -- `def_matrix_sum`
          _ = Xν i k + 0 := by rw [matrix_zero_apply]                                      -- `def_zero_matrix`
          _ = X (σ i) (σ k) + 0 := by simp only [hXν, Matrix.of_apply]                     -- 番号で読んだ成分の行列 `Xν` の定義
          _ = X (σ i) (σ k) + (0 : TensorPow M) (σ i) (σ k) := by rw [tensorPow_zero_apply] -- `def_zero_matrix`
          _ = (X + 0) (σ i) (σ k) := (tensorPow_add_apply _ _ _ _).symm                    -- `def_matrix_sum`
    _ = X := matrix_add_zero_matrix_tensorPow X                                            -- `matrix_plus_zero_matrix`

end Ising2D
