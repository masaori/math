/-
# 一つの行列のスカラー倍の差と有限和（**具体版**）

対応する人手証明のラベル: `difference_of_scalar_multiples_of_one_matrix`, `finite_sum_of_scalar_multiples_of_one_matrix`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_difference_of_scalar_multiples_of_one_matrix`,
`linear_space_general_claim_finite_sum_of_scalar_multiples_of_one_matrix`）。

**必要十分版**: `Ising2D/NecSuf/SmulOneMatrix.lean`。具体版をその系として導くのは
`ClaimScalarMultiplesOfOneMatrixFromNecSuf.lean`。

## 人手証明との対応

* `difference_of_scalar_multiples_of_one_matrix` の `(i, k)` 成分の鎖の 9 行は、`smul_sub_smul_matrix_apply` の `calc` の 9 段と 1 対 1 である。
  成分の式との接点は `matrix_sub_apply`（`def_matrix_difference`）・`matrix_smul_apply`（`def_matrix_scalar_multiple`）である。
  人手の `z - w := z + (-w)`（`def_complex_difference`）は `sub_eq_add_neg`、`-z := (-1_ℂ)·z`（`multiply_by_minus_one`）は `neg_one_mul`、
  `ℂ` の積の結合律・分配律（`complex_numbers_form_a_field`）は `mul_assoc`・`add_mul`。
* `finite_sum_of_scalar_multiples_of_one_matrix` の `(i, k)` 成分の鎖の 4 行は、`finite_sum_smul_one_matrix_apply` の `calc` の 4 段と 1 対 1 である。
  人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる（`Fin (r + 1)` の上の和）。`finite_sum_of_matrices_entrywise` には Lean の具体版が無いので
  mathlib の `Matrix.sum_apply`、人手の名前だけの根拠「`ℂ` の有限和の分配則」は mathlib の `Finset.sum_mul` で出す。
* 最後の「全ての成分が一致する」は `Matrix.ext`。人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Matrix.Basic

namespace Ising2D

open Matrix

/-- **`difference_of_scalar_multiples_of_one_matrix`** の成分の鎖: `(aA - bA)_{ik} = ((a - b)A)_{ik}`。 -/
theorem smul_sub_smul_matrix_apply {m n : ℕ} (a b : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (k : Fin n) :
    (a • A - b • A) i k = ((a - b) • A) i k :=
  calc (a • A - b • A) i k
      = (a • A) i k - (b • A) i k := matrix_sub_apply _ _ _ _                  -- `def_matrix_difference`
    _ = a * A i k - b * A i k := by rw [matrix_smul_apply, matrix_smul_apply]  -- `def_matrix_scalar_multiple` を 2 箇所
    _ = a * A i k + -(b * A i k) := sub_eq_add_neg _ _                        -- `def_complex_difference`
    _ = a * A i k + (-1) * (b * A i k) := by rw [neg_one_mul]                 -- `multiply_by_minus_one`
    _ = a * A i k + ((-1) * b) * A i k := by rw [mul_assoc]                   -- 積の結合律
    _ = a * A i k + (-b) * A i k := by rw [neg_one_mul]                       -- `multiply_by_minus_one` を右辺から左辺へ
    _ = (a + -b) * A i k := (add_mul _ _ _).symm                              -- 分配律を右辺から左辺へ
    _ = (a - b) * A i k := by rw [sub_eq_add_neg]                             -- `def_complex_difference` を右辺から左辺へ
    _ = ((a - b) • A) i k := (matrix_smul_apply _ _ _ _).symm                 -- `def_matrix_scalar_multiple`

/-- **`difference_of_scalar_multiples_of_one_matrix`**: `aA - bA = (a - b)A`。 -/
theorem smul_sub_smul_matrix {m n : ℕ} (a b : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) :
    a • A - b • A = (a - b) • A :=
  Matrix.ext (smul_sub_smul_matrix_apply a b A)   -- 全ての成分が一致する

/-- **`finite_sum_of_scalar_multiples_of_one_matrix`** の成分の鎖: `(Σ_{j=1}^{r+1} c_jA)_{ik} = ((Σ_{j=1}^{r+1} c_j)A)_{ik}`。 -/
theorem finite_sum_smul_one_matrix_apply {m n : ℕ} (r : ℕ) (c : Fin (r + 1) → ℂ) (A : Matrix (Fin m) (Fin n) ℂ)
    (i : Fin m) (k : Fin n) :
    (∑ j, c j • A) i k = ((∑ j, c j) • A) i k :=
  calc (∑ j, c j • A) i k
      = ∑ j, (c j • A) i k := Matrix.sum_apply _ _ _ _                        -- `finite_sum_of_matrices_entrywise`（mathlib の `Matrix.sum_apply`）
    _ = ∑ j, c j * A i k := by simp only [matrix_smul_apply]                  -- `def_matrix_scalar_multiple` を `r` 個の項へ同時適用
    _ = (∑ j, c j) * A i k := (Finset.sum_mul _ _ _).symm                     -- `ℂ` の有限和の分配則（mathlib の `Finset.sum_mul`）
    _ = ((∑ j, c j) • A) i k := (matrix_smul_apply _ _ _ _).symm              -- `def_matrix_scalar_multiple`

/-- **`finite_sum_of_scalar_multiples_of_one_matrix`**: `Σ_{j=1}^{r+1} (c_jA) = (Σ_{j=1}^{r+1} c_j)A`（人手の `r` は Lean の `r + 1`）。 -/
theorem finite_sum_smul_one_matrix {m n : ℕ} (r : ℕ) (c : Fin (r + 1) → ℂ) (A : Matrix (Fin m) (Fin n) ℂ) :
    ∑ j, c j • A = (∑ j, c j) • A :=
  Matrix.ext (finite_sum_smul_one_matrix_apply r c A)   -- 全ての成分が一致する

end Ising2D
