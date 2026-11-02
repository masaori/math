/-
# スカラー倍は行列の和・有限和に分配する（**具体版**）

対応する人手証明のラベル: `scalar_multiple_distributes_over_matrix_sum`, `finite_sum_of_scalar_multiples`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_scalar_multiple_distributes_over_matrix_sum`,
`linear_space_general_claim_finite_sum_of_scalar_multiples`）。

**必要十分版**: `Ising2D/NecSuf/SmulMatrixSum.lean`。具体版をその系として導くのは
`ClaimScalarMultipleDistributesOverMatrixSumFromNecSuf.lean`。

## 人手証明との対応

* `scalar_multiple_distributes_over_matrix_sum` の `(i, j)` 成分の鎖の 5 行は、`matrix_smul_add_apply` の `calc` の 5 段と 1 対 1 である。
  成分の式との接点は `matrix_smul_apply`（`def_matrix_scalar_multiple`）と `matrix_sum_apply`（`def_matrix_sum`）である。
  `ℂ` の分配律（`complex_numbers_form_a_field`）は `mul_add`。最後の「全ての成分が一致する」は `Matrix.ext`。
* `finite_sum_of_scalar_multiples` の帰納法は、Lean では `r + 1` 項の和（`Fin (r + 1)` の上の和）について `r` の帰納法で書く
  （`finite_sum_smul_of_matrices`）。人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。`def_finite_sum_of_matrices` の 2 つの式は
  `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で出す（mathlib の `Finset.sum` を人手の左から足す和の定義へ読み替える段）。
  帰納法の段の 4 行（有限和の定義 → 帰納法の仮定 → `scalar_multiple_distributes_over_matrix_sum` を右辺から左辺へ → 有限和の定義）は `calc` の 4 段と 1 対 1 である。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

open Matrix

/-- **`scalar_multiple_distributes_over_matrix_sum`** の成分の鎖: `(c(A + B))_{ij} = (cA + cB)_{ij}`。 -/
theorem matrix_smul_add_apply {m n : ℕ} (c : ℂ) (A B : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (j : Fin n) :
    (c • (A + B)) i j = (c • A + c • B) i j :=
  calc (c • (A + B)) i j
      = c * (A + B) i j := matrix_smul_apply _ _ _ _                          -- `def_matrix_scalar_multiple`
    _ = c * (A i j + B i j) := by rw [matrix_sum_apply]                       -- `def_matrix_sum`
    _ = c * A i j + c * B i j := mul_add _ _ _                                -- `ℂ` の分配律
    _ = (c • A) i j + (c • B) i j := by rw [matrix_smul_apply, matrix_smul_apply]  -- `def_matrix_scalar_multiple` を 2 箇所
    _ = (c • A + c • B) i j := (matrix_sum_apply _ _ _ _).symm                -- `def_matrix_sum`

/-- **`scalar_multiple_distributes_over_matrix_sum`**: `c(A + B) = cA + cB`。 -/
theorem matrix_smul_add {m n : ℕ} (c : ℂ) (A B : Matrix (Fin m) (Fin n) ℂ) :
    c • (A + B) = c • A + c • B :=
  Matrix.ext (matrix_smul_add_apply c A B)   -- 全ての成分が一致する

/-- **`finite_sum_of_scalar_multiples`**: `Σ_{j=1}^{r+1} (cX_j) = cΣ_{j=1}^{r+1} X_j`
（人手の `r` は Lean の `r + 1`）。`r` についての帰納法。 -/
theorem finite_sum_smul_of_matrices {m n : ℕ} (c : ℂ) :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix (Fin m) (Fin n) ℂ),
      ∑ j, c • X j = c • ∑ j, X j
  | 0, X =>
    calc ∑ j : Fin 1, c • X j
        = c • X 0 := Fin.sum_univ_one (fun j => c • X j)                      -- `def_finite_sum_of_matrices`（項 `cX_j`）
      _ = c • ∑ j : Fin 1, X j := by rw [Fin.sum_univ_one]                    -- `def_finite_sum_of_matrices`
  | r + 1, X =>
    calc ∑ j : Fin (r + 2), c • X j
        = (∑ j : Fin (r + 1), c • X j.castSucc) + c • X (Fin.last _) :=
          Fin.sum_univ_castSucc (fun j => c • X j)                            -- `def_finite_sum_of_matrices`（項 `cX_j`）
      _ = (c • ∑ j : Fin (r + 1), X j.castSucc) + c • X (Fin.last _) := by
          rw [finite_sum_smul_of_matrices c r (fun j => X j.castSucc)]        -- 帰納法の仮定
      _ = c • ((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _)) :=
          (matrix_smul_add c _ _).symm                                        -- `scalar_multiple_distributes_over_matrix_sum`（右辺から左辺へ）
      _ = c • ∑ j : Fin (r + 2), X j := by rw [Fin.sum_univ_castSucc X]        -- `def_finite_sum_of_matrices`

end Ising2D
