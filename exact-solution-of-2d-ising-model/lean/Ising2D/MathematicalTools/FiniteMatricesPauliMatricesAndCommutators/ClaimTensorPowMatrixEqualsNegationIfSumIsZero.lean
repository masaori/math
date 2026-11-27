/-
# `Mat(2^M, ℂ)` の行列について、和が零行列なら一方は他方の符号反転（**具体版**）

対応する人手証明のラベル: `matrix_equals_negation_if_sum_is_zero`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/MatrixEqNegOfAddEqZero.lean`。具体版をその系として導くのは
`ClaimMatrixEqualsNegationIfSumIsZeroFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。主張は次の順に示す。

* 仮定 `X + Y = O` を、番号で読んだ成分の行列（`Fin n` の添字の行列）`Xν`・`Yν` の `Xν + Yν = O` へ移す
  （成分ごとに `tensorPow_add_apply`・`matrix_sum_apply`（`def_matrix_sum`）と `tensorPow_zero_apply`・`matrix_zero_apply`（`def_zero_matrix`）を通す）。
* `Xν`・`Yν` について人手の主張（`ClaimMatrixEqualsNegationIfSumIsZero.lean` の `matrix_eq_neg_of_add_eq_zero`）を引き、`Xν = -Yν` を得る。
  人手の主張は任意の `m, p` について述べてあり、ここはその `2^M` の場合である。
* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
  成分の等号は `Xν = -Yν` の成分と `matrix_neg_apply`・`tensorPow_neg_apply`（`def_matrix_negation`）で読む。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixEqualsNegationIfSumIsZero
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`matrix_equals_negation_if_sum_is_zero`**（`Mat(2^M, ℂ)`）: `X + Y = O` なら `X = -Y`（`X, Y ∈ TensorPow M`）。 -/
theorem eq_neg_of_add_eq_zero_tensorPow {M : ℕ} (X Y : TensorPow M) (h : X + Y = 0) : X = -Y := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `X_{jl}`・`Y_{jl}`（`Mat(2^M, ℂ)` の元）
  set Xν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => X (σ j) (σ l) with hXν
  set Yν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => Y (σ j) (σ l) with hYν
  -- 仮定 `X + Y = O` を番号で読んだ成分の行列へ移す
  have hν : Xν + Yν = 0 := Matrix.ext fun i k =>   -- 全ての成分が一致する（`def_complex_matrices`）
    calc (Xν + Yν) i k
        = Xν i k + Yν i k := matrix_sum_apply _ _ _ _                         -- `def_matrix_sum`
      _ = X (σ i) (σ k) + Y (σ i) (σ k) := by simp only [hXν, hYν, Matrix.of_apply]
                                                                             -- 番号で読んだ成分の行列 `Xν`・`Yν` の定義
      _ = (X + Y) (σ i) (σ k) := (tensorPow_add_apply _ _ _ _).symm          -- `def_matrix_sum`
      _ = (0 : TensorPow M) (σ i) (σ k) := by rw [h]                         -- 仮定 `X + Y = O`
      _ = 0 := tensorPow_zero_apply _ _                                      -- `def_zero_matrix`
      _ = (0 : Matrix (Fin n) (Fin n) ℂ) i k := (matrix_zero_apply _ _).symm  -- `def_zero_matrix`
  -- 人手の主張を `Xν`・`Yν` について引く
  have hneg : Xν = -Yν := matrix_eq_neg_of_add_eq_zero Xν Yν hν               -- `matrix_equals_negation_if_sum_is_zero`
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc X (σ i) (σ k)
      = Xν i k := by simp only [hXν, Matrix.of_apply]                        -- 番号で読んだ成分の行列 `Xν` の定義
    _ = (-Yν) i k := by rw [hneg]                                            -- 上の `Xν = -Yν`
    _ = -(Yν i k) := matrix_neg_apply _ _ _                                  -- `def_matrix_negation`
    _ = -(Y (σ i) (σ k)) := by simp only [hYν, Matrix.of_apply]              -- 番号で読んだ成分の行列 `Yν` の定義
    _ = (-Y) (σ i) (σ k) := (tensorPow_neg_apply _ _ _).symm                 -- `def_matrix_negation`

end Ising2D
