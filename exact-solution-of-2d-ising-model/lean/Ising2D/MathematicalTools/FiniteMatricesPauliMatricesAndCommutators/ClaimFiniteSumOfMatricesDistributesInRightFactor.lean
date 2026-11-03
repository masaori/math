/-
# 行列の有限和を右の因子とする積は各項の積の有限和（**具体版**）

対応する人手証明のラベル: `finite_sum_of_matrices_distributes_in_right_factor`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_finite_sum_of_matrices_distributes_in_right_factor`）。

**必要十分版**: `Ising2D/NecSuf/MatrixMulFiniteSum.lean`。具体版をその系として導くのは
`ClaimFiniteSumOfMatricesDistributesInRightFactorFromNecSuf.lean`。

## 人手証明との対応

* 人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる（`Fin (r + 1)` の上の和）。`r` の帰納法で書く。
* `r = 1` の 2 行と、帰納の段の 4 行は、`mul_finite_sum_of_matrices` の `calc` の 2 段・4 段と 1 対 1 である。
  `def_finite_sum_of_matrices` の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc` で出す（mathlib の `Finset.sum` を
  人手の左から足す和の定義へ読み替える段）。`mat_mult_distributes_over_sum_in_right_factor` は具体版 `mul_add_matrix`。
* 人手の `m, n, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSum
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

open Matrix

/-- **`finite_sum_of_matrices_distributes_in_right_factor`**: `C(Σ_{j=1}^{r+1} X_j) = Σ_{j=1}^{r+1} (CX_j)`
（人手の `r` は Lean の `r + 1`）。`r` についての帰納法。 -/
theorem mul_finite_sum_of_matrices {m n p : ℕ} (C : Matrix (Fin m) (Fin n) ℂ) :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix (Fin n) (Fin p) ℂ), C * (∑ j, X j) = ∑ j, C * X j
  | 0, X =>
    calc C * (∑ j : Fin 1, X j)
        = C * X 0 := by rw [Fin.sum_univ_one]                                 -- `def_finite_sum_of_matrices`
      _ = ∑ j : Fin 1, C * X j := (Fin.sum_univ_one (fun j => C * X j)).symm  -- `def_finite_sum_of_matrices`（項 `CX_j`）を右辺から左辺へ
  | r + 1, X =>
    calc C * (∑ j : Fin (r + 2), X j)
        = C * ((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _)) := by
          rw [Fin.sum_univ_castSucc X]                                        -- `def_finite_sum_of_matrices`
      _ = C * (∑ j : Fin (r + 1), X j.castSucc) + C * X (Fin.last _) :=
          mul_add_matrix _ _ _                                                -- `mat_mult_distributes_over_sum_in_right_factor`
      _ = (∑ j : Fin (r + 1), C * X j.castSucc) + C * X (Fin.last _) := by
          rw [mul_finite_sum_of_matrices C r (fun j => X j.castSucc)]         -- 帰納法の仮定
      _ = ∑ j : Fin (r + 2), C * X j :=
          (Fin.sum_univ_castSucc (fun j => C * X j)).symm                     -- `def_finite_sum_of_matrices`（項 `CX_j`）を右辺から左辺へ

end Ising2D
