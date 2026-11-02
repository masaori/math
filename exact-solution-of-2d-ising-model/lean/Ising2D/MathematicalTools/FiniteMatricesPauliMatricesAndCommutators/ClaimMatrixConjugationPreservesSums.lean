/-
# 行列の共役は和・スカラー倍・有限和を保つ（**具体版**）

対応する人手証明のラベル: `mat_conj`, `matrix_conjugation_preserves_finite_sum`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の `calc_formulae_005_matrix_conjugation`,
`calc_formulae_claim_matrix_conjugation_preserves_finite_sum`）。

**必要十分版**: `Ising2D/NecSuf/MatrixConjugationSum.lean`。具体版をその系として導くのは
`ClaimMatrixConjugationPreservesSumsFromNecSuf.lean`。

## 人手証明との対応

* 人手の正則な `B ∈ Mat(n,ℂ)` は、Lean の単元 `B : (Matrix (Fin n) (Fin n) ℂ)ˣ`（`↑B` が `B`、`↑B⁻¹` が `B^{-1}`）である。
  人手の `T_B(A) := BAB^{-1}`（`(BA)B^{-1}` と読む）は `Conjugation.T B A = ↑B * A * ↑B⁻¹`（`conjugation_is_ring_homomorphism` の
  Lean の `T`）で、Lean の `↑B * A * ↑B⁻¹` は `(↑B * A) * ↑B⁻¹` と同じ括弧である。
* `mat_conj` の和の鎖の 4 行は `conj_add_matrix` の `calc` の 4 段と、スカラー倍の鎖の 4 行は `conj_smul_matrix` の 4 段と 1 対 1 である
  （`mul_add_matrix`・`add_mul_matrix`（`mat_mult_distributes_over_sum_in_right_factor`・`..._left_factor`）、
  `mul_smul_matrix`・`smul_mul_matrix`（`scalar_multiple_factors_out_of_right_factor`・`..._left_factor`））。
* `matrix_conjugation_preserves_finite_sum` の帰納法は、Lean では `r + 1` 項の和（`Fin (r + 1)` の上の和）について `r` の帰納法で書く
  （`conj_finite_sum_of_matrices`）。人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。`def_finite_sum_of_matrices` の 2 つの式は
  `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で出す（mathlib の `Finset.sum` を人手の左から足す和の定義へ読み替える段）。
* 人手の `n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSum
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.InvertibleMatricesLinearMapCorrespondenceAndConjugation.ClaimConjugationIsRingHom

namespace Ising2D

open Matrix

/-- **`mat_conj`**（和を保つ）: `T_B(A + C) = T_B(A) + T_B(C)`。人手の和の鎖の 4 行。 -/
theorem conj_add_matrix {n : ℕ} (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) (A C : Matrix (Fin n) (Fin n) ℂ) :
    Conjugation.T B (A + C) = Conjugation.T B A + Conjugation.T B C :=
  calc Conjugation.T B (A + C)
      = ((B : Matrix (Fin n) (Fin n) ℂ) * (A + C)) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) :=
        rfl                                                                   -- `T_B` の定義
    _ = ((B : Matrix (Fin n) (Fin n) ℂ) * A + (B : Matrix (Fin n) (Fin n) ℂ) * C)
          * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [mul_add_matrix]                                                   -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = ((B : Matrix (Fin n) (Fin n) ℂ) * A) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
          + ((B : Matrix (Fin n) (Fin n) ℂ) * C) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) :=
        add_mul_matrix _ _ _                                                  -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = Conjugation.T B A + Conjugation.T B C := rfl                          -- `T_B` の定義を 2 か所

/-- **`mat_conj`**（スカラー倍を保つ）: `T_B(αA) = α T_B(A)`。人手のスカラー倍の鎖の 4 行。 -/
theorem conj_smul_matrix {n : ℕ} (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) (α : ℂ) (A : Matrix (Fin n) (Fin n) ℂ) :
    Conjugation.T B (α • A) = α • Conjugation.T B A :=
  calc Conjugation.T B (α • A)
      = ((B : Matrix (Fin n) (Fin n) ℂ) * (α • A)) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) :=
        rfl                                                                   -- `T_B` の定義
    _ = (α • ((B : Matrix (Fin n) (Fin n) ℂ) * A)) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [mul_smul_matrix]                                                  -- `scalar_multiple_factors_out_of_right_factor`
    _ = α • (((B : Matrix (Fin n) (Fin n) ℂ) * A) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)) :=
        smul_mul_matrix _ _ _                                                 -- `scalar_multiple_factors_out_of_left_factor`
    _ = α • Conjugation.T B A := rfl                                          -- `T_B` の定義

/-- **`matrix_conjugation_preserves_finite_sum`**: `T_B(Σ_{j=1}^{r+1} X_j) = Σ_{j=1}^{r+1} T_B(X_j)`
（人手の `r` は Lean の `r + 1`）。`r` についての帰納法。 -/
theorem conj_finite_sum_of_matrices {n : ℕ} (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix (Fin n) (Fin n) ℂ),
      Conjugation.T B (∑ j, X j) = ∑ j, Conjugation.T B (X j)
  | 0, X =>
    calc Conjugation.T B (∑ j : Fin 1, X j)
        = Conjugation.T B (X 0) := by rw [Fin.sum_univ_one]                  -- `def_finite_sum_of_matrices`
      _ = ∑ j : Fin 1, Conjugation.T B (X j) := (Fin.sum_univ_one (fun j => Conjugation.T B (X j))).symm     -- `def_finite_sum_of_matrices`（項 `T_B(X_j)`）
  | r + 1, X =>
    calc Conjugation.T B (∑ j : Fin (r + 2), X j)
        = Conjugation.T B ((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _)) := by
          rw [Fin.sum_univ_castSucc]                                          -- `def_finite_sum_of_matrices`
      _ = Conjugation.T B (∑ j : Fin (r + 1), X j.castSucc) + Conjugation.T B (X (Fin.last _)) :=
          conj_add_matrix _ _ _                                               -- `mat_conj` の和を保つこと
      _ = (∑ j : Fin (r + 1), Conjugation.T B (X j.castSucc)) + Conjugation.T B (X (Fin.last _)) := by
          rw [conj_finite_sum_of_matrices B r (fun j => X j.castSucc)]        -- 帰納法の仮定
      _ = ∑ j : Fin (r + 2), Conjugation.T B (X j) :=
          (Fin.sum_univ_castSucc (fun j => Conjugation.T B (X j))).symm      -- `def_finite_sum_of_matrices`（項 `T_B(X_j)`）

end Ising2D
