/-
# 行列の有限和を左の因子とする積は各項の積の有限和（**具体版**）

対応する人手証明のラベル: `finite_sum_of_matrices_distributes_in_left_factor`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_finite_sum_of_matrices_distributes_in_left_factor`）。

**必要十分版**: `Ising2D/NecSuf/FiniteSumMulMatrix.lean`。具体版をその系として導くのは
`ClaimFiniteSumOfMatricesDistributesInLeftFactorFromNecSuf.lean`。

## 人手証明との対応

* 人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる（`Fin (r + 1)` の上の和）。`r` の帰納法で書く。
* `r = 1` の 2 行と、帰納の段の 4 行は、`finite_sum_mul_of_matrices` の `calc` の 2 段・4 段と 1 対 1 である。
  `def_finite_sum_of_matrices` の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で出す（mathlib の `Finset.sum` を
  人手の左から足す和の定義へ読み替える段）。`mat_mult_distributes_over_sum_in_left_factor` は具体版 `add_mul_matrix`。
* 人手の `m, n, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSum
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

open Matrix

/-- **`finite_sum_of_matrices_distributes_in_left_factor`**: `(Σ_{j=1}^{r+1} X_j)C = Σ_{j=1}^{r+1} (X_jC)`
（人手の `r` は Lean の `r + 1`）。`r` についての帰納法。 -/
theorem finite_sum_mul_of_matrices {m n p : ℕ} (C : Matrix (Fin n) (Fin p) ℂ) :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix (Fin m) (Fin n) ℂ), (∑ j, X j) * C = ∑ j, X j * C
  | 0, X =>
    calc (∑ j : Fin 1, X j) * C
        = X 0 * C := by rw [Fin.sum_univ_one]                                 -- `def_finite_sum_of_matrices`
      _ = ∑ j : Fin 1, X j * C := (Fin.sum_univ_one (fun j => X j * C)).symm  -- `def_finite_sum_of_matrices`（項 `X_jC`）を右辺から左辺へ
  | r + 1, X =>
    calc (∑ j : Fin (r + 2), X j) * C
        = ((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _)) * C := by
          rw [Fin.sum_univ_castSucc X]                                        -- `def_finite_sum_of_matrices`
      _ = (∑ j : Fin (r + 1), X j.castSucc) * C + X (Fin.last _) * C :=
          add_mul_matrix _ _ _                                                -- `mat_mult_distributes_over_sum_in_left_factor`
      _ = (∑ j : Fin (r + 1), X j.castSucc * C) + X (Fin.last _) * C := by
          rw [finite_sum_mul_of_matrices C r (fun j => X j.castSucc)]         -- 帰納法の仮定
      _ = ∑ j : Fin (r + 2), X j * C :=
          (Fin.sum_univ_castSucc (fun j => X j * C)).symm                     -- `def_finite_sum_of_matrices`（項 `X_jC`）を右辺から左辺へ

end Ising2D
