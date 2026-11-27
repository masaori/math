/-
# `Mat(2^M, ℂ)` の行列について、零行列を左から掛けると零行列・自分自身との和が零行列なら零行列・和の等式から右の項を差で表す（**具体版**）

対応する人手証明のラベル: `zero_matrix_is_left_zero_of_mat_mult`, `matrix_sum_with_itself_zero_implies_zero`,
`matrix_summand_from_sum_equation`（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/MatrixZeroMulAndSumEquations.lean`。具体版をその系として導くのは
`ClaimZeroMatrixProductAndSumEquationsFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。三つの主張は、どれも次の順に示す。

* 仮定があれば、それを番号で読んだ成分の行列（`Fin n` の添字の行列）の等式へ移す
  （成分ごとに `tensorPow_add_apply`・`matrix_sum_apply`（`def_matrix_sum`）と `tensorPow_zero_apply`・`matrix_zero_apply`（`def_zero_matrix`）を通す）。
* 番号で読んだ成分の行列について人手の主張（`ClaimZeroMatrixProductAndSumEquations.lean` の `zero_matrix_mul`・
  `matrix_eq_zero_of_add_self_eq_zero`・`matrix_eq_sub_of_add_eq`）を引く。人手の主張は任意の `m, n, p` について述べてあり、
  ここはその `2^M` の場合である。
* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
  成分の等号は、積を `tensorPow_mul_apply_eq_mat_mult`・`matrix_mul_apply_sum`（`mat_mult`）で、差を `tensorPow_sub_apply`・
  `matrix_sub_apply`（`def_matrix_difference`）で、零行列を `tensorPow_zero_apply`・`matrix_zero_apply`（`def_zero_matrix`）で読む。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroMatrixProductAndSumEquations
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`zero_matrix_is_left_zero_of_mat_mult`**（`Mat(2^M, ℂ)`）: `O B = O`（`B ∈ TensorPow M`）。 -/
theorem zero_matrix_mul_tensorPow {M : ℕ} (B : TensorPow M) : (0 : TensorPow M) * B = 0 := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `B_{jl}`（`Mat(2^M, ℂ)` の元）
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc ((0 : TensorPow M) * B) (σ i) (σ k)
      = ∑ j : Fin n, (0 : TensorPow M) (σ i) (σ j) * B (σ j) (σ k) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ 0 B i k                       -- `mat_mult`
    _ = ∑ j : Fin n, (0 : ℂ) * B (σ j) (σ k) := by simp only [tensorPow_zero_apply]  -- `def_zero_matrix` を各項へ
    _ = ∑ j : Fin n, (0 : Matrix (Fin n) (Fin n) ℂ) i j * Bν j k := by
        simp only [matrix_zero_apply, hBν, Matrix.of_apply]                        -- `def_zero_matrix` を各項へ、番号で読んだ成分の行列 `Bν` の定義
    _ = ((0 : Matrix (Fin n) (Fin n) ℂ) * Bν) i k := (matrix_mul_apply_sum _ _ _ _).symm  -- `mat_mult`
    _ = (0 : Matrix (Fin n) (Fin n) ℂ) i k := by rw [zero_matrix_mul Bν]            -- `zero_matrix_is_left_zero_of_mat_mult`
    _ = 0 := matrix_zero_apply _ _                                                 -- `def_zero_matrix`
    _ = (0 : TensorPow M) (σ i) (σ k) := (tensorPow_zero_apply _ _).symm           -- `def_zero_matrix`

/-- **`matrix_sum_with_itself_zero_implies_zero`**（`Mat(2^M, ℂ)`）: `X + X = O` なら `X = O`（`X ∈ TensorPow M`）。 -/
theorem eq_zero_of_add_self_eq_zero_tensorPow {M : ℕ} (X : TensorPow M) (h : X + X = 0) : X = 0 := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `X_{jl}`（`Mat(2^M, ℂ)` の元）
  set Xν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => X (σ j) (σ l) with hXν
  -- 仮定 `X + X = O` を番号で読んだ成分の行列へ移す
  have hν : Xν + Xν = 0 := Matrix.ext fun i k =>   -- 全ての成分が一致する（`def_complex_matrices`）
    calc (Xν + Xν) i k
        = Xν i k + Xν i k := matrix_sum_apply _ _ _ _                         -- `def_matrix_sum`
      _ = X (σ i) (σ k) + X (σ i) (σ k) := by simp only [hXν, Matrix.of_apply]
                                                                             -- 番号で読んだ成分の行列 `Xν` の定義
      _ = (X + X) (σ i) (σ k) := (tensorPow_add_apply _ _ _ _).symm          -- `def_matrix_sum`
      _ = (0 : TensorPow M) (σ i) (σ k) := by rw [h]                         -- 仮定 `X + X = O`
      _ = 0 := tensorPow_zero_apply _ _                                      -- `def_zero_matrix`
      _ = (0 : Matrix (Fin n) (Fin n) ℂ) i k := (matrix_zero_apply _ _).symm  -- `def_zero_matrix`
  -- 人手の主張を `Xν` について引く
  have hzero : Xν = 0 := matrix_eq_zero_of_add_self_eq_zero Xν hν             -- `matrix_sum_with_itself_zero_implies_zero`
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc X (σ i) (σ k)
      = Xν i k := by simp only [hXν, Matrix.of_apply]                        -- 番号で読んだ成分の行列 `Xν` の定義
    _ = (0 : Matrix (Fin n) (Fin n) ℂ) i k := by rw [hzero]                  -- 上の `Xν = O`
    _ = 0 := matrix_zero_apply _ _                                           -- `def_zero_matrix`
    _ = (0 : TensorPow M) (σ i) (σ k) := (tensorPow_zero_apply _ _).symm     -- `def_zero_matrix`

/-- **`matrix_summand_from_sum_equation`**（`Mat(2^M, ℂ)`）: `A + B = C` なら `B = C - A`（`A, B, C ∈ TensorPow M`）。 -/
theorem eq_sub_of_add_eq_tensorPow {M : ℕ} (A B C : TensorPow M) (h : A + B = C) : B = C - A := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}`・`C_{jl}`（`Mat(2^M, ℂ)` の元）
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  set Cν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => C (σ j) (σ l) with hCν
  -- 仮定 `A + B = C` を番号で読んだ成分の行列へ移す
  have hν : Aν + Bν = Cν := Matrix.ext fun i k =>   -- 全ての成分が一致する（`def_complex_matrices`）
    calc (Aν + Bν) i k
        = Aν i k + Bν i k := matrix_sum_apply _ _ _ _                         -- `def_matrix_sum`
      _ = A (σ i) (σ k) + B (σ i) (σ k) := by simp only [hAν, hBν, Matrix.of_apply]
                                                                             -- 番号で読んだ成分の行列 `Aν`・`Bν` の定義
      _ = (A + B) (σ i) (σ k) := (tensorPow_add_apply _ _ _ _).symm          -- `def_matrix_sum`
      _ = C (σ i) (σ k) := by rw [h]                                         -- 仮定 `A + B = C`
      _ = Cν i k := by simp only [hCν, Matrix.of_apply]                      -- 番号で読んだ成分の行列 `Cν` の定義
  -- 人手の主張を `Aν`・`Bν`・`Cν` について引く
  have hsub : Bν = Cν - Aν := matrix_eq_sub_of_add_eq Aν Bν Cν hν            -- `matrix_summand_from_sum_equation`
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc B (σ i) (σ k)
      = Bν i k := by simp only [hBν, Matrix.of_apply]                        -- 番号で読んだ成分の行列 `Bν` の定義
    _ = (Cν - Aν) i k := by rw [hsub]                                        -- 上の `Bν = Cν - Aν`
    _ = Cν i k - Aν i k := matrix_sub_apply _ _ _ _                          -- `def_matrix_difference`
    _ = C (σ i) (σ k) - A (σ i) (σ k) := by simp only [hAν, hCν, Matrix.of_apply]
                                                                             -- 番号で読んだ成分の行列 `Aν`・`Cν` の定義
    _ = (C - A) (σ i) (σ k) := (tensorPow_sub_apply _ _ _ _).symm            -- `def_matrix_difference`

end Ising2D
