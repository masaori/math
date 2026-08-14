/-
実対数の 1 における値の具体版が必要十分版の特殊化として得られることを明示する。
-/
import Ising2DLambda.ThermodynamicLimit.FiniteRealFreeEntropy
import Ising2DLambda.NecSuf.ThermodynamicLimit.FiniteRealFreeEntropy

namespace Ising2DLambda.ThermodynamicLimit

/-- 具体版の定理を、実対数の乗法加法性を渡して必要十分版から導いたもの。 -/
theorem realLogarithm_one_from_necSuf :
    realLogarithm ⟨1, zero_lt_one⟩ = 0 := by
  have h : Real.log (1 : ℝ) = 0 :=
    NecSuf.ThermodynamicLimit.map_one_eq_zero_necSuf Real.log
      (Real.log_mul one_ne_zero one_ne_zero)
  simpa [realLogarithm] using h

end Ising2DLambda.ThermodynamicLimit
