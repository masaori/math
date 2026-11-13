/-
# 行列の二重の有限和は和の順序を入れ替えても等しい（具体版を必要十分版から導く）

具体版 `ClaimFiniteDoubleSumOfMatricesInterchange.lean` の `finite_double_sum_of_matrices_interchange`
（人手 `finite_double_sum_of_matrices_interchange`）を、必要十分版 `Ising2D/NecSuf/FiniteDoubleSumOfMatricesInterchange.lean` の
`NecSuf.finite_double_sum_of_matrices_interchange'` の `R := ℂ` の特殊化として得る。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteDoubleSumOfMatricesInterchange
import Ising2D.NecSuf.FiniteDoubleSumOfMatricesInterchange

namespace Ising2D

/-- `finite_double_sum_of_matrices_interchange` を `NecSuf.finite_double_sum_of_matrices_interchange'`（`R := ℂ`）として得る。 -/
theorem finite_double_sum_of_matrices_interchange_of_necSuf {κ ι α β : Type*} [Fintype κ] [Fintype ι]
    (X : κ → ι → Matrix α β ℂ) :
    ∑ a, ∑ b, X a b = ∑ b, ∑ a, X a b :=
  NecSuf.finite_double_sum_of_matrices_interchange' X

end Ising2D
