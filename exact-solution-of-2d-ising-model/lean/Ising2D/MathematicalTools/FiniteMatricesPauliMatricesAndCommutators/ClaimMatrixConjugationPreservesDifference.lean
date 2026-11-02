/-
# 行列の共役は符号反転と差を保つ（**具体版**）

対応する人手証明のラベル: `matrix_conjugation_preserves_negation`, `matrix_conjugation_preserves_difference`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の `calc_formulae_claim_matrix_conjugation_preserves_negation`,
`calc_formulae_claim_matrix_conjugation_preserves_difference`）。

**必要十分版**: `Ising2D/NecSuf/MatrixConjugationNegSub.lean`。具体版をその系として導くのは
`ClaimMatrixConjugationPreservesDifferenceFromNecSuf.lean`。

## 人手証明との対応

* 人手の正則な `B ∈ Mat(n,ℂ)` と `T_B(A) := (BA)B^{-1}`（`mat_conj`）は、`ClaimMatrixConjugationPreservesSums.lean` と同じく
  単元 `B : (Matrix (Fin n) (Fin n) ℂ)ˣ` と `Conjugation.T B A = (↑B * A) * ↑B⁻¹` である。
* `matrix_conjugation_preserves_negation` の 4 行は `conj_neg_matrix` の `calc` の 4 段と 1 対 1 である
  （`T_B` の定義 → `mul_neg_matrix`（`negation_factors_out_of_right_factor`）→ `neg_mul_matrix`（`..._left_factor`）→ `T_B` の定義）。
* `matrix_conjugation_preserves_difference` の 4 行は `conj_sub_matrix` の `calc` の 4 段と 1 対 1 である
  （`matrix_sub_eq_add_neg`（`matrix_difference_is_sum_with_negation`）→ `conj_add_matrix`（`mat_conj` の和を保つこと）→
  `conj_neg_matrix` → `matrix_sub_eq_add_neg` を右辺から左辺へ）。
* 人手の `n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixConjugationPreservesSums
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfMatrixProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDifferenceIsSumWithNegation

namespace Ising2D

open Matrix

/-- **`matrix_conjugation_preserves_negation`**: `T_B(-W) = -T_B(W)`。人手の 4 行。 -/
theorem conj_neg_matrix {n : ℕ} (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) (W : Matrix (Fin n) (Fin n) ℂ) :
    Conjugation.T B (-W) = -Conjugation.T B W :=
  calc Conjugation.T B (-W)
      = ((B : Matrix (Fin n) (Fin n) ℂ) * (-W)) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) :=
        rfl                                                                   -- `T_B` の定義
    _ = (-((B : Matrix (Fin n) (Fin n) ℂ) * W)) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ) := by
        rw [mul_neg_matrix]                                                   -- `negation_factors_out_of_right_factor`
    _ = -(((B : Matrix (Fin n) (Fin n) ℂ) * W) * ((B⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)) :=
        neg_mul_matrix _ _                                                    -- `negation_factors_out_of_left_factor`
    _ = -Conjugation.T B W := rfl                                             -- `T_B` の定義

/-- **`matrix_conjugation_preserves_difference`**: `T_B(X - W) = T_B(X) - T_B(W)`。人手の 4 行。 -/
theorem conj_sub_matrix {n : ℕ} (B : (Matrix (Fin n) (Fin n) ℂ)ˣ) (X W : Matrix (Fin n) (Fin n) ℂ) :
    Conjugation.T B (X - W) = Conjugation.T B X - Conjugation.T B W :=
  calc Conjugation.T B (X - W)
      = Conjugation.T B (X + (-W)) := by rw [matrix_sub_eq_add_neg]           -- `matrix_difference_is_sum_with_negation`
    _ = Conjugation.T B X + Conjugation.T B (-W) := conj_add_matrix _ _ _     -- `mat_conj` の和を保つこと
    _ = Conjugation.T B X + (-Conjugation.T B W) := by rw [conj_neg_matrix]   -- `matrix_conjugation_preserves_negation`
    _ = Conjugation.T B X - Conjugation.T B W := (matrix_sub_eq_add_neg _ _).symm   -- `matrix_difference_is_sum_with_negation`

end Ising2D
