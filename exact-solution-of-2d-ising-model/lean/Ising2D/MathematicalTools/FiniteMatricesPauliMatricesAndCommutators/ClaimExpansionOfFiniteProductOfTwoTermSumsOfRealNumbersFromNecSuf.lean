/-
# 実数の二項の和の有限積の展開（具体版を必要十分版から導く）

具体版 `ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbers.lean` の 2 つの主張を、必要十分版
`Ising2D/NecSuf/BinaryWordSum.lean` の特殊化として得る。

* `binaryWordRealSum_mul`（人手 `real_sum_over_binary_words_distributes_in_left_factor`）は `binWordSum_map` の
  `α, β := ℝ`、`f := (· * c)`、`hf := add_mul`（ℝ の分配則）の特殊化である。
* `expansion_of_finite_product_of_two_term_sums_of_real`（人手 `expansion_of_finite_product_of_two_term_sums_of_real_numbers`）は、
  行列の場合と同じ `finProdLeft_add_eq_binWordSum` の `R := ℝ` の特殊化である。必要十分版が仮定するのは二つの分配律
  （`Distrib R`）だけなので、因子が行列であることも実数であることも効いていない。

具体版の和・積と必要十分版の `binWordSum`・`finProdLeft` の一致は `binaryWordRealSum_eq_binWordSum`・`real_finset_prod_eq_finProdLeft`。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbers
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWordsFromNecSuf
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSumFromNecSuf

namespace Ising2D

/-- `binaryWordRealSum_mul` を `NecSuf.binWordSum_map`（`f := (· * c)`、`hf := add_mul`）の特殊化として得る。 -/
theorem binaryWordRealSum_mul_of_necSuf (r : ℕ) (x : (Fin (r + 1) → Fin 2) → ℝ) (c : ℝ) :
    binaryWordRealSum r x * c = binaryWordRealSum r (fun ε => x ε * c) := by
  rw [binaryWordRealSum_eq_binWordSum, binaryWordRealSum_eq_binWordSum]
  exact NecSuf.binWordSum_map (fun t : ℝ => t * c) (fun a b => add_mul a b c) r x

/-- `expansion_of_finite_product_of_two_term_sums_of_real` を `NecSuf.finProdLeft_add_eq_binWordSum`（`R := ℝ`）の特殊化として得る。 -/
theorem expansion_of_finite_product_of_two_term_sums_of_real_of_necSuf (r : ℕ) (a : Fin (r + 1) → Fin 2 → ℝ) :
    ∏ j, (a j 1 + a j 0) = binaryWordRealSum r (fun ε => ∏ j, a j (ε j)) := by
  rw [real_finset_prod_eq_finProdLeft, binaryWordRealSum_eq_binWordSum]
  simp only [real_finset_prod_eq_finProdLeft]
  exact NecSuf.finProdLeft_add_eq_binWordSum r a

end Ising2D
