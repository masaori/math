/-
# 行列の組と 2×2 行列と数の列の積の結合律（**具体版**）

対応する人手証明のラベル: `pair_of_matrices_times_matrix_times_column_associative`
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensectorT_claim_pair_of_matrices_times_matrix_times_column_associative`）。
主張が使う定義のうち、`def_pair_of_matrices_times_column_of_numbers` の Lean の定義 `rowMulCol` をこのファイルに置く。
`def_pair_of_matrices_times_two_by_two_matrix` の Lean の定義は既存の `Ising2D.rowMul`
（`MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean`）で、
`rowMul (A, B) P` の第 1・第 2 成分は `rowMulCol (A, B) ![P 0 0, P 1 0]`・`rowMulCol (A, B) ![P 0 1, P 1 1]` と定義の展開で一致する。

**必要十分版**: `Ising2D/NecSuf/PairTimesMatrixTimesColumnAssociative.lean` の
`NecSuf.rowMul2Col_rowMul2_assoc`。具体版をその系として導くのは
同じフォルダの `ClaimPairTimesMatrixTimesColumnAssociativeFromNecSuf.lean`。

## 人手証明との対応

* 人手の数の列 `v ∈ Mat(2,1,ℂ)` は `v : Fin 2 → ℂ`（成分 `v_{11}, v_{21}` は `v 0, v 1`）、
  `Pv` は `P *ᵥ v`（`Matrix.mulVec`。`i` 成分は `∑ j, P i j * v j` で、`mat_mult` の積の成分そのもの）である。
* 人手の `A, B ∈ Mat(d,ℂ)`（`d ∈ ℤ_{≥1}`）は、添字の型 `ι` の正方行列 `Matrix ι ι ℂ` で書く
  （使う側の `TensorPow M` の添字は `Conf M`）。和とスカラー倍は成分ごとなので、添字の型に条件は要らない。
* 人手の `p, q, r, s, a, b` は `P 0 0, P 0 1, P 1 0, P 1 1, v 0, v 1` である。人手の 13 行目（`p, q, r, s, a, b` の置き方）は
  Lean では同じ式なので、`calc` は 12 行目から 14 行目へ続く（13 行目はコメントだけに残す）。
* 人手の行列の組 `(A, B)` は `(A, B) : Matrix ι ι ℂ × Matrix ι ι ℂ` である。
* 人手の「各成分が一致することを示せばよい」は `ext k l`、成分の鎖の 18 行のうち 13 行目を除く 17 行は `rowMulCol_rowMul_assoc` の
  `calc` の 17 段と 1 対 1 である。定義の展開（1〜7・15〜18 行目）は `rfl`、
  `complex_numbers_form_a_field` の分配律・積の結合律・加法の結合律と交換律・積の交換律（8〜12 行目）は
  `mul_add`・`mul_assoc`・`add_add_add_comm`・`add_mul`・`mul_comm`、
  `def_finite_sum_of_complex_numbers`（14 行目）は `Fin.sum_univ_two` である。
-/
import Ising2D.MathematicalTools.InvertibleMatricesLinearMapCorrespondenceAndConjugation.DefinitionTgAndTV
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

open Matrix

section RowMulCol

variable {A : Type*} [AddCommMonoid A] [Module ℂ A]

/-- **`def_pair_of_matrices_times_column_of_numbers`**: 組 `(A, B)` と数の列 `w = (w_{11}; w_{21})` の積
`(A, B) w := w_{11} A + w_{21} B`（数の列は `w : Fin 2 → ℂ`）。 -/
def rowMulCol (p : A × A) (w : Fin 2 → ℂ) : A :=
  w 0 • p.1 + w 1 • p.2

end RowMulCol

/-- **`pair_of_matrices_times_matrix_times_column_associative`**: `((A, B) P) v = (A, B)(P v)`。 -/
theorem rowMulCol_rowMul_assoc {ι : Type*} (A B : Matrix ι ι ℂ)
    (P : Matrix (Fin 2) (Fin 2) ℂ) (v : Fin 2 → ℂ) :
    rowMulCol (rowMul (A, B) P) v = rowMulCol (A, B) (P *ᵥ v) := by
  ext k l
  calc rowMulCol (rowMul (A, B) P) v k l
      = rowMulCol (rowMulCol (A, B) ![P 0 0, P 1 0], rowMulCol (A, B) ![P 0 1, P 1 1]) v k l := rfl
                    -- 1 行目: `def_pair_of_matrices_times_two_by_two_matrix`
    _ = rowMulCol (P 0 0 • A + P 1 0 • B, P 0 1 • A + P 1 1 • B) v k l := rfl
                    -- 2 行目: `def_pair_of_matrices_times_column_of_numbers` を 2 成分へ同時適用
    _ = (v 0 • (P 0 0 • A + P 1 0 • B) + v 1 • (P 0 1 • A + P 1 1 • B)) k l := rfl
                    -- 3 行目: `def_pair_of_matrices_times_column_of_numbers`
    _ = (v 0 • (P 0 0 • A + P 1 0 • B)) k l + (v 1 • (P 0 1 • A + P 1 1 • B)) k l := rfl
                    -- 4 行目: `def_matrix_sum`
    _ = v 0 * (P 0 0 • A + P 1 0 • B) k l + v 1 * (P 0 1 • A + P 1 1 • B) k l := rfl
                    -- 5 行目: `def_matrix_scalar_multiple` を 2 箇所
    _ = v 0 * ((P 0 0 • A) k l + (P 1 0 • B) k l) + v 1 * ((P 0 1 • A) k l + (P 1 1 • B) k l) := rfl
                    -- 6 行目: `def_matrix_sum` を 2 箇所
    _ = v 0 * (P 0 0 * A k l + P 1 0 * B k l) + v 1 * (P 0 1 * A k l + P 1 1 * B k l) := rfl
                    -- 7 行目: `def_matrix_scalar_multiple` を 4 箇所
    _ = (v 0 * (P 0 0 * A k l) + v 0 * (P 1 0 * B k l))
          + (v 1 * (P 0 1 * A k l) + v 1 * (P 1 1 * B k l)) := by rw [mul_add, mul_add]
                    -- 8 行目: `complex_numbers_form_a_field` の分配律を 2 箇所
    _ = ((v 0 * P 0 0) * A k l + (v 0 * P 1 0) * B k l)
          + ((v 1 * P 0 1) * A k l + (v 1 * P 1 1) * B k l) := by
        rw [← mul_assoc (v 0), ← mul_assoc (v 0), ← mul_assoc (v 1), ← mul_assoc (v 1)]
                    -- 9 行目: `complex_numbers_form_a_field` の積の結合律を 4 箇所
    _ = ((v 0 * P 0 0) * A k l + (v 1 * P 0 1) * A k l)
          + ((v 0 * P 1 0) * B k l + (v 1 * P 1 1) * B k l) := add_add_add_comm _ _ _ _
                    -- 10 行目: `complex_numbers_form_a_field` の加法の結合律・交換律
    _ = (v 0 * P 0 0 + v 1 * P 0 1) * A k l + (v 0 * P 1 0 + v 1 * P 1 1) * B k l := by
        rw [← add_mul, ← add_mul]
                    -- 11 行目: `complex_numbers_form_a_field` の分配律を 2 箇所
    _ = (P 0 0 * v 0 + P 0 1 * v 1) * A k l + (P 1 0 * v 0 + P 1 1 * v 1) * B k l := by
        rw [mul_comm (v 0) (P 0 0), mul_comm (v 1) (P 0 1), mul_comm (v 0) (P 1 0),
          mul_comm (v 1) (P 1 1)]
                    -- 12 行目: `complex_numbers_form_a_field` の積の交換律を 4 箇所
                    -- 13 行目（`p, q, r, s, a, b` の置き方）は Lean では同じ式
    _ = (∑ j, P 0 j * v j) * A k l + (∑ j, P 1 j * v j) * B k l := by
        rw [Fin.sum_univ_two, Fin.sum_univ_two]
                    -- 14 行目: `def_finite_sum_of_complex_numbers` の 2 つの式（`m = 1`）を 2 箇所
    _ = (P *ᵥ v) 0 * A k l + (P *ᵥ v) 1 * B k l := rfl
                    -- 15 行目: `mat_mult` を 2 箇所
    _ = ((P *ᵥ v) 0 • A) k l + ((P *ᵥ v) 1 • B) k l := rfl
                    -- 16 行目: `def_matrix_scalar_multiple` を 2 箇所
    _ = ((P *ᵥ v) 0 • A + (P *ᵥ v) 1 • B) k l := rfl
                    -- 17 行目: `def_matrix_sum`
    _ = rowMulCol (A, B) (P *ᵥ v) k l := rfl
                    -- 18 行目: `def_pair_of_matrices_times_column_of_numbers`

end Ising2D
