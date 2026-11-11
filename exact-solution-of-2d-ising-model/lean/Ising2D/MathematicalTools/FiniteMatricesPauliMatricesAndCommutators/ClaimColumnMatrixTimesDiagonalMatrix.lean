/-
# 列に並べた行列に対角行列を右から掛けると、各列が対角成分倍になる（**具体版**）

対応する人手証明のラベル: `column_matrix_times_diagonal_matrix_scales_columns`
（`structured-latex/content/004_transfer_matrix.ts` の
`transfer_matrix_claim_column_matrix_times_diagonal_matrix_scales_columns`）。

**必要十分版**: `Ising2D/NecSuf/ColumnMatrixTimesDiagonalMatrix.lean` の `NecSuf.cols_mul_diagonal_eq_cols_smul`。
具体版をその系として導くのは `ClaimColumnMatrixTimesDiagonalMatrixFromNecSuf.lean`。

## 人手証明との対応

* 人手の「列に並べた行列 `[b_1 ⋯ b_p]`」（`mat_columnwise` の記法）は `Matrix.of fun j k => b k j`、
  数ベクトル `b_k ∈ ℂ^n` は `b k : Fin n → ℂ` である（`ClaimMatColumnwise.lean` と同じ置き方）。
* 人手の「`D` は対角行列（`def_diagonal_matrix`）」は仮定 `hD : ∀ k l, k ≠ l → D k l = 0` である
  （`def_diagonal_matrix` の「`k ≠ l ⟹ D_{kl} = 0_ℂ`」そのもの）。
* 人手の前置きの 2 行（`j ≠ k` の `(b_j)_i D_{jk} = (b_j)_i 0_ℂ = 0_ℂ`）は `column_entry_mul_offdiag_eq_zero` の `calc` の 2 段、
  成分の鎖 6 行は `cols_mul_diagonal_matrix` の `calc` の 6 段と 1 対 1 である。
  1 行目の `mat_mult` は `matrix_mul_apply_sum`、2 行目と 6 行目の「列に並べた行列の成分の定め方」は `Matrix.of` の成分で `rfl`、
  3 行目の `finite_sum_with_single_nonzero_term` は具体版が無く `Finset.sum_eq_single`（既存の慣行どおり）、
  4 行目の積の可換律は `mul_comm`、5 行目の `def_matrix_scalar_multiple` は `vec_smul_apply`。
  人手の「各成分が一致することを示せばよい」は `ext i k` である。
* 人手の `n, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors

namespace Ising2D

open Matrix

/-- **`column_matrix_times_diagonal_matrix_scales_columns` の前置き**: `j ≠ k` なら `(b_j)_i D_{jk} = 0_ℂ`（2 行）。 -/
theorem column_entry_mul_offdiag_eq_zero {n p : ℕ} (b : Fin p → Fin n → ℂ) (D : Matrix (Fin p) (Fin p) ℂ)
    (hD : ∀ k l, k ≠ l → D k l = 0) (i : Fin n) {j k : Fin p} (hjk : j ≠ k) :
    b j i * D j k = 0 :=
  calc b j i * D j k
      = b j i * 0 := by rw [hD j k hjk]   -- `def_diagonal_matrix`（`k → j`, `l → k`）
    _ = 0 := mul_zero _                    -- `complex_times_zero_is_zero`（`z → (b_j)_i`）

/-- **`column_matrix_times_diagonal_matrix_scales_columns`**: `D` が対角行列なら
`[b_1 ⋯ b_p] D = [D_{11} b_1 ⋯ D_{pp} b_p]`。 -/
theorem cols_mul_diagonal_matrix {n p : ℕ} (b : Fin p → Fin n → ℂ) (D : Matrix (Fin p) (Fin p) ℂ)
    (hD : ∀ k l, k ≠ l → D k l = 0) :
    Matrix.of (fun j k => b k j) * D = Matrix.of (fun i k => (D k k • b k) i) := by
  ext i k
  calc (Matrix.of (fun j k => b k j) * D) i k
      = ∑ j, Matrix.of (fun j k => b k j) i j * D j k := matrix_mul_apply_sum _ _ _ _
                                                        -- 1 行目: `mat_mult` の積の成分
    _ = ∑ j, b j i * D j k := rfl                       -- 2 行目: 列に並べた行列の成分の定め方を各項へ
    _ = b k i * D k k :=
        Finset.sum_eq_single k (fun j _ hjk => column_entry_mul_offdiag_eq_zero b D hD i hjk)
          (fun h => absurd (Finset.mem_univ k) h)       -- 3 行目: `finite_sum_with_single_nonzero_term` と前置き
    _ = D k k * b k i := mul_comm _ _                   -- 4 行目: `complex_numbers_form_a_field` の積の可換律
    _ = (D k k • b k) i := (vec_smul_apply _ _ _).symm  -- 5 行目: `def_matrix_scalar_multiple` を右辺から左辺へ
    _ = Matrix.of (fun i k => (D k k • b k) i) i k := rfl
                                                        -- 6 行目: 列に並べた行列の成分の定め方を右辺から左辺へ

end Ising2D
