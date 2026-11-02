/-
# 二項の和の有限積の展開（具体版を必要十分版から導く）

具体版 `ClaimExpansionOfFiniteProductOfTwoTermSums.lean` の主張を、必要十分版 `Ising2D/NecSuf/BinaryWordSum.lean` の
`finProdLeft_add_eq_binWordSum`（`R := Mat(n,ℂ)`）の特殊化として得る。人手のラベルは `expansion_of_finite_product_of_two_term_sums`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimExpansionOfFiniteProductOfTwoTermSums
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatricesFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWordsFromNecSuf

namespace Ising2D

/-- `expansion_of_finite_product_of_two_term_sums` を `NecSuf.finProdLeft_add_eq_binWordSum`（`R := Mat(n,ℂ)`）の特殊化として得る。 -/
theorem expansion_of_finite_product_of_two_term_sums_of_necSuf {n : ℕ} (r : ℕ)
    (A : Fin (r + 1) → Fin 2 → Matrix (Fin n) (Fin n) ℂ) :
    finiteMatrixProduct r (fun j => A j 1 + A j 0)
      = binaryWordMatrixSum r (fun ε => finiteMatrixProduct r (fun j => A j (ε j))) := by
  rw [finiteMatrixProduct_eq_finProdLeft, binaryWordMatrixSum_eq_binWordSum]
  simp only [finiteMatrixProduct_eq_finProdLeft]
  exact NecSuf.finProdLeft_add_eq_binWordSum r A

/-- `expansion_of_finite_product_of_two_term_sums` の `TensorPow M` での系。 -/
theorem expansion_of_finite_product_of_two_term_sums_tensorPow {M : ℕ} (r : ℕ) (A : Fin (r + 1) → Fin 2 → TensorPow M) :
    NecSuf.finProdLeft r (fun j => A j 1 + A j 0)
      = NecSuf.binWordSum r (fun ε => NecSuf.finProdLeft r (fun j => A j (ε j))) :=
  NecSuf.finProdLeft_add_eq_binWordSum r A

end Ising2D
