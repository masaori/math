/-
# 実数の有限和は添字の全単射による付け替えで変わらない（必要十分版からの導出）

具体版 `ClaimFiniteSumOfRealNumbersReindexedByBijection.lean` の主張を、必要十分版
`Ising2D/NecSuf/FiniteSumReindexedByBijection.lean` の係数を `ℝ` にした特殊化として得る。人手のラベルは
`finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`。人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumOfRealNumbersReindexedByBijection
import Ising2D.NecSuf.FiniteSumReindexedByBijection

namespace Ising2D

/-- `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing` を `NecSuf.finite_sum_reindex_bijective'`（係数 `ℝ`）の特殊化として得る。 -/
theorem finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing_of_necSuf (n : ℕ) (a : Fin (n + 1) → ℝ)
    (π : Fin (n + 1) → Fin (n + 1)) (hπ : Function.Bijective π) :
    ∑ j, a (π j) = ∑ j, a j :=
  NecSuf.finite_sum_reindex_bijective' (R := ℝ) n a π hπ

end Ising2D
