/-
# 行列の和・スカラー倍・差・有限和の転置（**具体版**）

対応する人手証明のラベル: `transpose_of_matrix_sum`, `transpose_of_matrix_scalar_multiple`,
`transpose_of_matrix_difference`, `transpose_of_finite_sum_of_matrices`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_transpose_of_matrix_sum`,
`linear_space_general_claim_transpose_of_matrix_scalar_multiple`, `linear_space_general_claim_transpose_of_matrix_difference`,
`linear_space_general_claim_transpose_of_finite_sum_of_matrices`）。

**必要十分版**: `Ising2D/NecSuf/TransposeOfMatrixSums.lean`。具体版をその系として導き、`TensorPow M` の系を置くのは
`ClaimTransposeOfMatrixSumsAndScalarMultiplesFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `transpose_of_matrix_sum` の `(p, q)` 成分の鎖の 4 行（`def_matrix_transpose` → `def_matrix_sum` → `def_matrix_transpose` を 2 箇所 → `def_matrix_sum`） | `matrix_transpose_add_apply` の `calc` の 4 段 |
| `transpose_of_matrix_scalar_multiple` の 4 行（`def_matrix_transpose` → `def_matrix_scalar_multiple` → `def_matrix_transpose` → `def_matrix_scalar_multiple`） | `matrix_transpose_smul_apply` の `calc` の 4 段 |
| `transpose_of_matrix_difference` の `(k, i)` 成分の 4 行（`def_matrix_transpose` → `def_matrix_difference` → `def_matrix_transpose` を 2 箇所 → `def_matrix_difference`） | `matrix_transpose_sub_apply` の `calc` の 4 段 |
| 3 つの主張の「全ての成分が一致する」 | `Matrix.ext` |
| `transpose_of_finite_sum_of_matrices` の `r = 1` の 2 行と、帰納法の段の 4 行（`def_finite_sum_of_matrices` → `transpose_of_matrix_sum` → 帰納法の仮定 → `def_finite_sum_of_matrices`） | `finite_sum_transpose_of_matrices` の `0` の `calc` の 2 段と、`r + 1` の `calc` の 4 段 |

* 成分の式との接点は `matrix_transpose_apply`（`def_matrix_transpose`）・`matrix_sum_apply`（`def_matrix_sum`）・
  `matrix_smul_apply`（`def_matrix_scalar_multiple`）・`matrix_sub_apply`（`def_matrix_difference`）である。
* 有限和は `ClaimScalarMultipleDistributesOverMatrixSum.lean` の `finite_sum_smul_of_matrices` と同じく、`r + 1` 項の和（`Fin (r + 1)` の上の和）
  について `r` の帰納法で書く。人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。`def_finite_sum_of_matrices` の 2 つの式は
  `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で出す（mathlib の `Finset.sum` を人手の左から足す和の定義へ読み替える段）。
* 人手の `m, n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

open Matrix

/-- **`transpose_of_matrix_sum`** の成分の鎖: `((A + B)^⊤)_{pq} = (A^⊤ + B^⊤)_{pq}`。必要十分版は `NecSuf.transpose_add_matrix_apply'`（同じ段の並び）。 -/
theorem matrix_transpose_add_apply {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) (p : Fin n) (q : Fin m) :
    (A + B)ᵀ p q = (Aᵀ + Bᵀ) p q :=
  calc (A + B)ᵀ p q
      = (A + B) q p := matrix_transpose_apply _ _ _                           -- `def_matrix_transpose`（`B → A + B`）
    _ = A q p + B q p := matrix_sum_apply _ _ _ _                             -- `def_matrix_sum`（`i → q`, `j → p`）
    _ = Aᵀ p q + Bᵀ p q := by rw [matrix_transpose_apply, matrix_transpose_apply]  -- `def_matrix_transpose` を 2 箇所
    _ = (Aᵀ + Bᵀ) p q := (matrix_sum_apply _ _ _ _).symm                      -- `def_matrix_sum`（`A → A^⊤`, `B → B^⊤`）

/-- **`transpose_of_matrix_sum`**: `(A + B)^⊤ = A^⊤ + B^⊤`。必要十分版は `NecSuf.transpose_add_matrix'`（同じ段の並び）。 -/
theorem matrix_transpose_add {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) : (A + B)ᵀ = Aᵀ + Bᵀ :=
  Matrix.ext (matrix_transpose_add_apply A B)   -- 全ての成分が一致する

/-- **`transpose_of_matrix_scalar_multiple`** の成分の鎖: `((cA)^⊤)_{pq} = (cA^⊤)_{pq}`。必要十分版は `NecSuf.transpose_smul_matrix_apply'`（同じ段の並び）。 -/
theorem matrix_transpose_smul_apply {m n : ℕ} (c : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) (p : Fin n) (q : Fin m) :
    (c • A)ᵀ p q = (c • Aᵀ) p q :=
  calc (c • A)ᵀ p q
      = (c • A) q p := matrix_transpose_apply _ _ _                           -- `def_matrix_transpose`（`B → cA`）
    _ = c * A q p := matrix_smul_apply _ _ _ _                                -- `def_matrix_scalar_multiple`（`a → c`, `i → q`, `j → p`）
    _ = c * Aᵀ p q := by rw [matrix_transpose_apply]                          -- `def_matrix_transpose`（`B → A`）
    _ = (c • Aᵀ) p q := (matrix_smul_apply _ _ _ _).symm                      -- `def_matrix_scalar_multiple`（`A → A^⊤`）

/-- **`transpose_of_matrix_scalar_multiple`**: `(cA)^⊤ = cA^⊤`。必要十分版は `NecSuf.transpose_smul_matrix'`（同じ段の並び）。 -/
theorem matrix_transpose_smul {m n : ℕ} (c : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) : (c • A)ᵀ = c • Aᵀ :=
  Matrix.ext (matrix_transpose_smul_apply c A)   -- 全ての成分が一致する

/-- **`transpose_of_matrix_difference`** の成分の鎖: `((A - B)^⊤)_{ki} = (A^⊤ - B^⊤)_{ki}`。必要十分版は `NecSuf.transpose_sub_matrix_apply'`（同じ段の並び）。 -/
theorem matrix_transpose_sub_apply {m p : ℕ} (A B : Matrix (Fin m) (Fin p) ℂ) (k : Fin p) (i : Fin m) :
    (A - B)ᵀ k i = (Aᵀ - Bᵀ) k i :=
  calc (A - B)ᵀ k i
      = (A - B) i k := matrix_transpose_apply _ _ _                           -- `def_matrix_transpose`（`B → A - B`, `p → k`, `q → i`）
    _ = A i k - B i k := matrix_sub_apply _ _ _ _                             -- `def_matrix_difference`
    _ = Aᵀ k i - Bᵀ k i := by rw [matrix_transpose_apply, matrix_transpose_apply]  -- `def_matrix_transpose` を 2 箇所
    _ = (Aᵀ - Bᵀ) k i := (matrix_sub_apply _ _ _ _).symm                      -- `def_matrix_difference`（`A → A^⊤`, `B → B^⊤`, `i → k`, `k → i`）

/-- **`transpose_of_matrix_difference`**: `(A - B)^⊤ = A^⊤ - B^⊤`。必要十分版は `NecSuf.transpose_sub_matrix'`（同じ段の並び）。 -/
theorem matrix_transpose_sub {m p : ℕ} (A B : Matrix (Fin m) (Fin p) ℂ) : (A - B)ᵀ = Aᵀ - Bᵀ :=
  Matrix.ext (matrix_transpose_sub_apply A B)   -- 全ての成分が一致する

/-- **`transpose_of_finite_sum_of_matrices`**: `(Σ_{j=1}^{r+1} X_j)^⊤ = Σ_{j=1}^{r+1} X_j^⊤`
（人手の `r` は Lean の `r + 1`）。`r` についての帰納法。必要十分版は `NecSuf.finite_sum_transpose_matrix'`（同じ段の並び）。 -/
theorem finite_sum_transpose_of_matrices {m n : ℕ} :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix (Fin m) (Fin n) ℂ), (∑ j, X j)ᵀ = ∑ j, (X j)ᵀ
  | 0, X =>
    calc (∑ j : Fin 1, X j)ᵀ
        = (X 0)ᵀ := by rw [Fin.sum_univ_one]                                  -- `def_finite_sum_of_matrices`
      _ = ∑ j : Fin 1, (X j)ᵀ := (Fin.sum_univ_one (fun j => (X j)ᵀ)).symm    -- `def_finite_sum_of_matrices`（`X_j → X_j^⊤`）
  | r + 1, X =>
    calc (∑ j : Fin (r + 2), X j)ᵀ
        = ((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _))ᵀ := by
          rw [Fin.sum_univ_castSucc X]                                        -- `def_finite_sum_of_matrices`
      _ = (∑ j : Fin (r + 1), X j.castSucc)ᵀ + (X (Fin.last _))ᵀ :=
          matrix_transpose_add _ _                                            -- `transpose_of_matrix_sum`（`A → Σ_{j=1}^{r} X_j`, `B → X_{r+1}`）
      _ = (∑ j : Fin (r + 1), (X j.castSucc)ᵀ) + (X (Fin.last _))ᵀ := by
          rw [finite_sum_transpose_of_matrices r (fun j => X j.castSucc)]     -- 帰納法の仮定
      _ = ∑ j : Fin (r + 2), (X j)ᵀ :=
          (Fin.sum_univ_castSucc (fun j => (X j)ᵀ)).symm                      -- `def_finite_sum_of_matrices`（`X_j → X_j^⊤`）

end Ising2D
