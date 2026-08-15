/- 必要十分版を開境界密度・一辺の倍数・実数へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.OpenFreeEnergyDensityInfimumApproximationMultiples
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenFreeEnergyDensityInfimumApproximationMultiples

namespace Ising2DLambda.ThermodynamicLimit

/-- 必要十分版から `claim_open_free_energy_density_infimum_approximation_multiples_le_one` を導く。 -/
theorem openFreeEnergyDensity_infimum_approximation_multiples_of_le_one_from_necSuf
    (t : StrictlyPositiveReal) (ht1 : t.1 ≤ 1) (v eps : ℝ)
    (hv : IsGLB (openFreeEnergyDensityValueSet t) v)
    (heps : 0 < eps) :
    ∃ a : PositiveNatural, ∀ k : PositiveNatural,
      v ≤ openSquareFreeEnergyDensity (squareSide a k) t ∧
        openSquareFreeEnergyDensity (squareSide a k) t < v + eps := by
  exact NecSuf.ThermodynamicLimit.rangeValue_infimum_approximation_multiples_necSuf
    (fun L : PositiveNatural => openSquareFreeEnergyDensity L t)
    (fun a k => squareSide a k) v (v + eps) hv
    (fun a k => (openSquareFreeEnergyDensity_blockTiling_bounds_of_le_one a k t ht1).2)
    (lt_add_of_pos_right v heps)

end Ising2DLambda.ThermodynamicLimit
