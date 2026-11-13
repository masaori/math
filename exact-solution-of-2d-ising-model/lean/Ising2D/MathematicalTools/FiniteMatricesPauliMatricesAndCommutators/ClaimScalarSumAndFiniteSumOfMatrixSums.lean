/-
# 係数の和によるスカラー倍と、行列の和の有限和（**具体版**）

対応する人手証明のラベル: `scalar_sum_distributes_over_matrix`, `finite_sum_of_matrix_sums`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_scalar_sum_distributes_over_matrix`,
`linear_space_general_claim_finite_sum_of_matrix_sums`）。

**必要十分版**: `Ising2D/NecSuf/ScalarSumAndFiniteSumOfMatrixSums.lean`。具体版をその系として導くのは
`ClaimScalarSumAndFiniteSumOfMatrixSumsFromNecSuf.lean`。

## 人手証明との対応

* `scalar_sum_distributes_over_matrix` の `(i, j)` 成分の鎖の 4 行は、`matrix_add_smul_apply` の `calc` の 4 段と 1 対 1 である。
  成分の式との接点は `matrix_smul_apply`（`def_matrix_scalar_multiple`）と `matrix_sum_apply`（`def_matrix_sum`）である。
  `ℂ` の分配律 `(a + b)c = ac + bc`（`complex_numbers_form_a_field`）は `add_mul`。最後の「全ての成分が一致する」は `Matrix.ext`。
* `finite_sum_of_matrix_sums` の `(i, k)` 成分の鎖の 5 行は、`finite_sum_of_matrix_sums_apply` の `calc` の 5 段と 1 対 1 である。
  人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる（`Fin (r + 1)` の上の和）。`finite_sum_of_matrices_entrywise` には Lean の具体版が無いので
  mathlib の `Matrix.sum_apply` で出す（兄弟の `finite_sum_smul_one_matrix_apply` と同じ扱い）。`finite_sum_of_complex_sums` は
  同じ名前の Lean の具体版（`ClaimMatMultDistributesOverSum.lean`）を引く。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSum
import Mathlib.Data.Matrix.Basic

namespace Ising2D

open Matrix

/-- **`scalar_sum_distributes_over_matrix`** の成分の鎖: `((a + b)A)_{ij} = (aA + bA)_{ij}`。 -/
theorem matrix_add_smul_apply {m n : ℕ} (a b : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (j : Fin n) :
    ((a + b) • A) i j = (a • A + b • A) i j :=
  calc ((a + b) • A) i j
      = (a + b) * A i j := matrix_smul_apply _ _ _ _                         -- `def_matrix_scalar_multiple`
    _ = a * A i j + b * A i j := add_mul _ _ _                               -- `ℂ` の分配律 `(a + b)c = ac + bc`
    _ = (a • A) i j + (b • A) i j := by rw [matrix_smul_apply, matrix_smul_apply]  -- `def_matrix_scalar_multiple` を 2 箇所
    _ = (a • A + b • A) i j := (matrix_sum_apply _ _ _ _).symm               -- `def_matrix_sum`

/-- **`scalar_sum_distributes_over_matrix`**: `(a + b)A = aA + bA`。 -/
theorem matrix_add_smul {m n : ℕ} (a b : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) :
    (a + b) • A = a • A + b • A :=
  Matrix.ext (matrix_add_smul_apply a b A)   -- 全ての成分が一致する

/-- **`finite_sum_of_matrix_sums`** の成分の鎖: `(Σ_{j=1}^{r+1}(X_j + Y_j))_{ik} = (Σ X_j + Σ Y_j)_{ik}`。 -/
theorem finite_sum_of_matrix_sums_apply {m n : ℕ} (r : ℕ) (X Y : Fin (r + 1) → Matrix (Fin m) (Fin n) ℂ)
    (i : Fin m) (k : Fin n) :
    (∑ j, (X j + Y j)) i k = ((∑ j, X j) + ∑ j, Y j) i k :=
  calc (∑ j, (X j + Y j)) i k
      = ∑ j, (X j + Y j) i k := Matrix.sum_apply _ _ _ _                      -- `finite_sum_of_matrices_entrywise`（mathlib の `Matrix.sum_apply`）
    _ = ∑ j, (X j i k + Y j i k) := by simp only [matrix_sum_apply]          -- `def_matrix_sum` を人手の `r` 個（Lean の `r + 1` 個）の項へ同時適用
    _ = (∑ j, X j i k) + ∑ j, Y j i k :=
        finite_sum_of_complex_sums _ (fun j => X j i k) (fun j => Y j i k)   -- `finite_sum_of_complex_sums`
    _ = (∑ j, X j) i k + (∑ j, Y j) i k := by
        rw [Matrix.sum_apply, Matrix.sum_apply]                              -- `finite_sum_of_matrices_entrywise` を右辺から左辺へ 2 箇所
    _ = ((∑ j, X j) + ∑ j, Y j) i k := (matrix_sum_apply _ _ _ _).symm        -- `def_matrix_sum`

/-- **`finite_sum_of_matrix_sums`**: `Σ_{j=1}^{r+1}(X_j + Y_j) = Σ X_j + Σ Y_j`（人手の `r` は Lean の `r + 1`）。 -/
theorem finite_sum_of_matrix_sums {m n : ℕ} (r : ℕ) (X Y : Fin (r + 1) → Matrix (Fin m) (Fin n) ℂ) :
    ∑ j, (X j + Y j) = (∑ j, X j) + ∑ j, Y j :=
  Matrix.ext (finite_sum_of_matrix_sums_apply r X Y)   -- 全ての成分が一致する

end Ising2D
