/- 必要十分版を正の格子サイズ・自由エネルギー密度・実数へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensitySupremumApproximation
import Ising2DLambda.NecSuf.ThermodynamicLimit.FreeEnergyDensitySupremumApproximation

namespace Ising2DLambda.ThermodynamicLimit

/-- 必要十分版から `claim_free_energy_density_supremum_approximation` を導く。 -/
theorem freeEnergyDensity_supremum_approximation_from_necSuf
    (t : StrictlyPositiveReal) (u eps : ℝ)
    (hu : IsRealSetSupremum (freeEnergyDensityValueSet t) u)
    (heps : 0 < eps) :
    ∃ L : PositiveNatural, u - eps < freeEnergyDensity L t := by
  have hu_lub : IsLUB (freeEnergyDensityValueSet t) u := by
    constructor
    · intro y hy
      exact hu.1 y hy
    · intro M hM
      exact hu.2 M (fun y hy => hM hy)
  exact NecSuf.ThermodynamicLimit.rangeValue_supremum_approximation_necSuf
    (fun L : PositiveNatural => freeEnergyDensity L t) u (u - eps)
    hu_lub (sub_lt_self u heps)

end Ising2DLambda.ThermodynamicLimit
