/-
# 一つを除く項が零行列である行列の有限和は、その一つの項に等しい（具体版を必要十分版から導く）

具体版 `ClaimFiniteSumOfMatricesWithSingleNonzeroTerm.lean` の `finite_sum_of_matrices_with_single_nonzero_term`
（人手 `finite_sum_of_matrices_with_single_nonzero_term`）の添字 `κ := Fin (r + 1)` の場合を、必要十分版
`Ising2D/NecSuf/FiniteSumWithSingleNonzeroTerm.lean` の `NecSuf.finSumLeft_matrix_single'` の `R := ℂ` の特殊化として得る。
行列の有限和（`Finset.sum`）と `finSumLeft` は、どちらも `def_finite_sum_of_matrices` の 2 つの式を節に持つので一致する
（`matrix_finset_sum_eq_finSumLeft`）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteSumOfMatricesWithSingleNonzeroTerm
import Ising2D.NecSuf.FiniteSumWithSingleNonzeroTerm
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

/-- 行列の `Finset.sum` は `NecSuf.finSumLeft`（`G := Matrix α β ℂ`）である（2 つの節が一致する）。 -/
theorem matrix_finset_sum_eq_finSumLeft {α β : Type*} :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix α β ℂ), ∑ a, X a = NecSuf.finSumLeft r X
  | 0, X => by rw [Fin.sum_univ_one, NecSuf.finSumLeft_zero]
  | r + 1, X => by
    rw [Fin.sum_univ_castSucc, NecSuf.finSumLeft_succ, matrix_finset_sum_eq_finSumLeft r]

/-- `finite_sum_of_matrices_with_single_nonzero_term`（`κ := Fin (r + 1)`）を `NecSuf.finSumLeft_matrix_single'`（`R := ℂ`）として得る。 -/
theorem finite_sum_of_matrices_with_single_nonzero_term_of_necSuf {α β : Type*} (r : ℕ)
    (X : Fin (r + 1) → Matrix α β ℂ) (q : Fin (r + 1)) (hX : ∀ a, a ≠ q → X a = 0) :
    ∑ a, X a = X q := by
  rw [matrix_finset_sum_eq_finSumLeft]
  exact NecSuf.finSumLeft_matrix_single' r X q hX

end Ising2D
