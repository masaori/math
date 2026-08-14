/- 具体版の自由エネルギー密度下界が必要十分版の特殊化であることを示す。 -/
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensityLowerBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.FreeEnergyDensityLowerBound

namespace Ising2DLambda.ThermodynamicLimit

open PartitionPolynomial

/-- 具体版の下界を、配位・破れボンド数・実対数へ特殊化して導く。 -/
theorem freeEnergyDensity_nonnegative_from_necSuf
    (L : PositiveNatural) (t : StrictlyPositiveReal) :
    0 ≤ freeEnergyDensity L t := by
  letI : NeZero L.1 := ⟨Nat.ne_of_gt L.2⟩
  have hscale : 0 ≤ (((1 / ((L.1 : ℚ) ^ 2) : ℚ) : ℝ)) := by positivity
  have habstract := NecSuf.ThermodynamicLimit.scaled_monotone_sum_nonnegative_necSuf
    (allPlusConfig L.1) (brokenBondCount L.1)
    (allPlusConfig_brokenBondCount_eq_zero L.1) t.2 realLogarithm realLogarithm_one
    realLogarithm_strictMono hscale
  simpa [freeEnergyDensity, finiteRealFreeEntropy, eval_partitionPolynomial_real] using habstract

end Ising2DLambda.ThermodynamicLimit
