/-
# 二項の和の有限積の展開（**具体版**）

対応する人手証明のラベル: `expansion_of_finite_product_of_two_term_sums`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_expansion_of_finite_product_of_two_term_sums`）。

**必要十分版**: `Ising2D/NecSuf/BinaryWordSum.lean` の `finProdLeft_add_eq_binWordSum`。具体版をその系として導くのは
`ClaimExpansionOfFiniteProductOfTwoTermSumsFromNecSuf.lean`。

## 人手証明との対応

* 人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。人手の `A_j^{(e)}` が Lean の `A (j - 1) e`、`{0,1}^r` が `Fin (r + 1) → Fin 2`、
  `(ε', e)` が `Fin.snoc ε' e` である。有限積は `finiteMatrixProduct`、`{0,1}^r` の上の和は `binaryWordMatrixSum` である。
* 帰納法の 2 つの鎖（`r = 1` の 4 行、`r → r + 1` の 7 行）は、`expansion_of_finite_product_of_two_term_sums` の 2 つの節の `calc` と 1 対 1 である。
  `sum_over_binary_words_distributes_in_left_factor` は `binaryWordMatrixSum_mul`、`mat_mult_distributes_over_sum_in_right_factor` は `mul_add_matrix` である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatrices
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWords

namespace Ising2D

open Matrix

/-- **`expansion_of_finite_product_of_two_term_sums`**: `∏_{j=1}^{r}(A_j^{(1)} + A_j^{(0)}) = Σ_{ε∈{0,1}^r} ∏_{j=1}^{r} A_j^{(ε_j)}`（人手の `r` は Lean の `r + 1`）。 -/
theorem expansion_of_finite_product_of_two_term_sums {n : ℕ} :
    ∀ (r : ℕ) (A : Fin (r + 1) → Fin 2 → Matrix (Fin n) (Fin n) ℂ),
      finiteMatrixProduct r (fun j => A j 1 + A j 0)
        = binaryWordMatrixSum r (fun ε => finiteMatrixProduct r (fun j => A j (ε j)))
  | 0, A =>
    calc finiteMatrixProduct 0 (fun j => A j 1 + A j 0)
        = A 0 1 + A 0 0 := finiteMatrixProduct_zero _                           -- `def_finite_product_of_matrices`
      _ = A 0 ((fun _ : Fin 1 => (1 : Fin 2)) 0) + A 0 ((fun _ : Fin 1 => (0 : Fin 2)) 0) := rfl
                                                                               -- `def_sum_over_binary_words` の `(1)_1 = 1`、`(0)_1 = 0`
      _ = finiteMatrixProduct 0 (fun j => A j ((fun _ : Fin 1 => (1 : Fin 2)) j))
            + finiteMatrixProduct 0 (fun j => A j ((fun _ : Fin 1 => (0 : Fin 2)) j)) := rfl
                                                                               -- `def_finite_product_of_matrices` を右辺から左辺へ 2 か所
      _ = binaryWordMatrixSum 0 (fun ε => finiteMatrixProduct 0 (fun j => A j (ε j))) := rfl
                                                                               -- `def_sum_over_binary_words` を右辺から左辺へ
  | r + 1, A =>
    calc finiteMatrixProduct (r + 1) (fun j => A j 1 + A j 0)
        = finiteMatrixProduct r (fun j => A (Fin.castSucc j) 1 + A (Fin.castSucc j) 0)
            * (A (Fin.last (r + 1)) 1 + A (Fin.last (r + 1)) 0) := finiteMatrixProduct_succ r _
                                                                               -- `def_finite_product_of_matrices`
      _ = binaryWordMatrixSum r (fun ε' => finiteMatrixProduct r (fun j => A (Fin.castSucc j) (ε' j)))
            * (A (Fin.last (r + 1)) 1 + A (Fin.last (r + 1)) 0) := by
          rw [expansion_of_finite_product_of_two_term_sums r (fun j => A (Fin.castSucc j))]
                                                                               -- 帰納法の仮定
      _ = binaryWordMatrixSum r (fun ε' => finiteMatrixProduct r (fun j => A (Fin.castSucc j) (ε' j))
            * (A (Fin.last (r + 1)) 1 + A (Fin.last (r + 1)) 0)) :=
          binaryWordMatrixSum_mul r _ _                                         -- `sum_over_binary_words_distributes_in_left_factor`
      _ = binaryWordMatrixSum r (fun ε' => finiteMatrixProduct r (fun j => A (Fin.castSucc j) (ε' j)) * A (Fin.last (r + 1)) 1
            + finiteMatrixProduct r (fun j => A (Fin.castSucc j) (ε' j)) * A (Fin.last (r + 1)) 0) := by
          congr 1; funext ε'; exact mul_add_matrix _ _ _                        -- `mat_mult_distributes_over_sum_in_right_factor` を各項へ
      _ = binaryWordMatrixSum r (fun ε' =>
            finiteMatrixProduct r (fun j => A (Fin.castSucc j) (Fin.snoc (α := fun _ => Fin 2) ε' 1 (Fin.castSucc j)))
              * A (Fin.last (r + 1)) (Fin.snoc (α := fun _ => Fin 2) ε' 1 (Fin.last (r + 1)))
            + finiteMatrixProduct r (fun j => A (Fin.castSucc j) (Fin.snoc (α := fun _ => Fin 2) ε' 0 (Fin.castSucc j)))
              * A (Fin.last (r + 1)) (Fin.snoc (α := fun _ => Fin 2) ε' 0 (Fin.last (r + 1)))) := by
          simp only [Fin.snoc_castSucc, Fin.snoc_last]                         -- `def_sum_over_binary_words` の `(ε', e)_j = ε'_j`、`(ε', e)_{r+1} = e`
      _ = binaryWordMatrixSum r (fun ε' =>
            finiteMatrixProduct (r + 1) (fun j => A j (Fin.snoc (α := fun _ => Fin 2) ε' 1 j))
            + finiteMatrixProduct (r + 1) (fun j => A j (Fin.snoc (α := fun _ => Fin 2) ε' 0 j))) := rfl
                                                                               -- `def_finite_product_of_matrices` を右辺から左辺へ（各項の 2 か所）
      _ = binaryWordMatrixSum (r + 1) (fun ε => finiteMatrixProduct (r + 1) (fun j => A j (ε j))) := rfl
                                                                               -- `def_sum_over_binary_words` を右辺から左辺へ

end Ising2D
