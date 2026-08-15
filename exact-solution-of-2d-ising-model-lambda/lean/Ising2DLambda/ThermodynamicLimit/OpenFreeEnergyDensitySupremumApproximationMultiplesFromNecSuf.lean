/- 必要十分版を開境界密度・一辺の倍数・実数へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.OpenFreeEnergyDensitySupremumApproximationMultiples
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenFreeEnergyDensitySupremumApproximationMultiples

namespace Ising2DLambda.ThermodynamicLimit

/-- 必要十分版から `claim_open_free_energy_density_supremum_approximation_multiples_one_le` を導く。 -/
theorem openFreeEnergyDensity_supremum_approximation_multiples_of_one_le_from_necSuf
    (t : StrictlyPositiveReal) (ht : 1 ≤ t.1) (u eps : ℝ)
    (hu : IsRealSetSupremum (openFreeEnergyDensityValueSet t) u)
    (heps : 0 < eps) :
    ∃ a : PositiveNatural, ∀ k : PositiveNatural,
      u - eps < openSquareFreeEnergyDensity (squareSide a k) t ∧
        openSquareFreeEnergyDensity (squareSide a k) t ≤ u := by
  have hu_lub : IsLUB (openFreeEnergyDensityValueSet t) u := by
    constructor
    · intro y hy
      exact hu.1 y hy
    · intro M hM
      exact hu.2 M (fun y hy => hM hy)
  exact NecSuf.ThermodynamicLimit.rangeValue_supremum_approximation_multiples_necSuf
    (fun L : PositiveNatural => openSquareFreeEnergyDensity L t)
    (fun a k => squareSide a k) u (u - eps) hu_lub
    (fun a k => (openSquareFreeEnergyDensity_blockTiling_bounds_of_one_le a k t ht).1)
    (sub_lt_self u heps)

end Ising2DLambda.ThermodynamicLimit
