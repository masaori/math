/- 必要十分版を正の格子サイズ・自由エネルギー密度・実数の完備性へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensitySupremum
import Ising2DLambda.NecSuf.ThermodynamicLimit.FreeEnergyDensitySupremum

namespace Ising2DLambda.ThermodynamicLimit

/-- 必要十分版から `claim_free_energy_density_supremum_exists` を導く。 -/
theorem freeEnergyDensityValueSet_has_supremum_from_necSuf
    (t : StrictlyPositiveReal) :
    ∃ s : ℝ, IsLUB (freeEnergyDensityValueSet t) s := by
  let one : PositiveNatural := ⟨1, by norm_num⟩
  let upper : ℝ :=
    realLogarithm (⟨2, by norm_num⟩ : StrictlyPositiveReal) +
      2 * realLogarithm (⟨1 + t.1, by linarith [t.2]⟩ : StrictlyPositiveReal)
  have habstract :=
    NecSuf.ThermodynamicLimit.indexedValueSet_has_supremum_necSuf
      (fun L : PositiveNatural => freeEnergyDensity L t) one upper
      (fun L => freeEnergyDensity_le_upperBound L t)
      real_nonempty_bddAbove_has_supremum
  simpa [freeEnergyDensityValueSet] using habstract

end Ising2DLambda.ThermodynamicLimit
