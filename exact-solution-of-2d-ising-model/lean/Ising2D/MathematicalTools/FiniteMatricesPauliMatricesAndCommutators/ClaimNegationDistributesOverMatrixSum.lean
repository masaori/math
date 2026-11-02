/-
# 行列の和・有限和の符号反転は符号反転の和・有限和に等しい（**具体版**）

対応する人手証明のラベル: `negation_distributes_over_matrix_sum`, `finite_sum_of_negated_matrices`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_negation_distributes_over_matrix_sum`,
`linear_space_general_claim_finite_sum_of_negated_matrices`）。

**必要十分版**: `Ising2D/NecSuf/NegMatrixSum.lean`。具体版をその系として導くのは
`ClaimNegationDistributesOverMatrixSumFromNecSuf.lean`。

## 人手証明との対応

* `negation_distributes_over_matrix_sum` の `(i, j)` 成分の鎖の 7 行は、`neg_add_matrix_apply` の `calc` の 7 段と 1 対 1 である。
  成分の式との接点は `matrix_neg_apply`（`def_matrix_negation`）と `matrix_sum_apply`（`def_matrix_sum`）である。
  人手の `-z := (-1_ℂ)·z`（`multiply_by_minus_one`）は、Lean の `ℂ` の符号反転が積で定義されていないので `neg_one_mul` で出す。
  `ℂ` の分配律（`complex_numbers_form_a_field`）は `mul_add` である。最後の「全ての成分が一致する」は `Matrix.ext`。
* `finite_sum_of_negated_matrices` の帰納法は、Lean では `r + 1` 項の和（`Fin (r + 1)` の上の和）について `r` の帰納法で書く
  （`neg_finite_sum_of_matrices`）。人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。`def_finite_sum_of_matrices` の 2 つの式は
  `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で出す（mathlib の `Finset.sum` を人手の左から足す和の定義へ読み替える段）。
  帰納法の段の 4 行（有限和の定義 → 帰納法の仮定 → `negation_distributes_over_matrix_sum` → 有限和の定義）は `calc` の 4 段と 1 対 1 である。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix

namespace Ising2D

open Matrix

/-- **`negation_distributes_over_matrix_sum`** の成分の鎖: `(-(A + B))_{ij} = ((-A) + (-B))_{ij}`。 -/
theorem neg_add_matrix_apply {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) (i : Fin m) (j : Fin n) :
    (-(A + B)) i j = ((-A) + (-B)) i j :=
  calc (-(A + B)) i j
      = -((A + B) i j) := matrix_neg_apply _ _ _                             -- `def_matrix_negation`
    _ = -(A i j + B i j) := by rw [matrix_sum_apply]                         -- `def_matrix_sum`
    _ = (-1) * (A i j + B i j) := (neg_one_mul _).symm                       -- `multiply_by_minus_one`
    _ = (-1) * A i j + (-1) * B i j := mul_add _ _ _                         -- `ℂ` の分配律
    _ = (-A i j) + (-B i j) := by rw [neg_one_mul, neg_one_mul]              -- `multiply_by_minus_one`（2 か所へ同時適用）
    _ = (-A) i j + (-B) i j := by rw [matrix_neg_apply, matrix_neg_apply]    -- `def_matrix_negation`（2 か所へ同時適用）
    _ = ((-A) + (-B)) i j := (matrix_sum_apply _ _ _ _).symm                 -- `def_matrix_sum`

/-- **`negation_distributes_over_matrix_sum`**: `-(A + B) = (-A) + (-B)`。 -/
theorem neg_add_matrix {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) : -(A + B) = (-A) + (-B) :=
  Matrix.ext (neg_add_matrix_apply A B)   -- 全ての成分が一致する

/-- **`finite_sum_of_negated_matrices`**: `Σ_{j=1}^{r+1} (-X_j) = -Σ_{j=1}^{r+1} X_j`
（人手の `r` は Lean の `r + 1`）。`r` についての帰納法。 -/
theorem neg_finite_sum_of_matrices {m n : ℕ} :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix (Fin m) (Fin n) ℂ),
      ∑ j, -X j = -∑ j, X j
  | 0, X =>
    calc ∑ j : Fin 1, -X j
        = -X 0 := Fin.sum_univ_one (fun j => -X j)                           -- `def_finite_sum_of_matrices`（項 `-X_j`）
      _ = -∑ j : Fin 1, X j := by rw [Fin.sum_univ_one]                      -- `def_finite_sum_of_matrices`
  | r + 1, X =>
    calc ∑ j : Fin (r + 2), -X j
        = (∑ j : Fin (r + 1), -X j.castSucc) + -X (Fin.last _) :=
          Fin.sum_univ_castSucc (fun j => -X j)                              -- `def_finite_sum_of_matrices`（項 `-X_j`）
      _ = (-∑ j : Fin (r + 1), X j.castSucc) + -X (Fin.last _) := by
          rw [neg_finite_sum_of_matrices r (fun j => X j.castSucc)]          -- 帰納法の仮定
      _ = -((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _)) :=
          (neg_add_matrix _ _).symm                                          -- `negation_distributes_over_matrix_sum`
      _ = -∑ j : Fin (r + 2), X j := by rw [Fin.sum_univ_castSucc X]          -- `def_finite_sum_of_matrices`

end Ising2D
