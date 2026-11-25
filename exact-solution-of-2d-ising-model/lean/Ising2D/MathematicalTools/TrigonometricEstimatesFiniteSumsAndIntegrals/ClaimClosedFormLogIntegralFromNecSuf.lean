/-
# `log(2y) ≤ arcsinh y ≤ log(2y) + 1/(4y²)`（具体版を必要十分版から導く）

具体版 `ClaimClosedFormLogIntegral.lean` の `arsinh_log_bounds` の主張を、必要十分版
`Ising2D/NecSuf/HyperbolicBounds.lean` の `log_two_mul_le_arsinh`・`arsinh_le_log_two_mul_add` の組として得る。
人手のラベルは `arcsinh_two_sided_log_bounds`。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimClosedFormLogIntegral
import Ising2D.NecSuf.HyperbolicBounds

namespace Ising2D

/-- `arsinh_log_bounds` を `NecSuf.log_two_mul_le_arsinh`・`NecSuf.arsinh_le_log_two_mul_add` の組として得る。 -/
theorem arsinh_log_bounds_of_necSuf {y : ℝ} (hy : 0 < y) :
    Real.log (2 * y) ≤ Real.arsinh y ∧ Real.arsinh y ≤ Real.log (2 * y) + 1 / (4 * y ^ 2) :=
  ⟨NecSuf.log_two_mul_le_arsinh hy, NecSuf.arsinh_le_log_two_mul_add hy⟩

end Ising2D
