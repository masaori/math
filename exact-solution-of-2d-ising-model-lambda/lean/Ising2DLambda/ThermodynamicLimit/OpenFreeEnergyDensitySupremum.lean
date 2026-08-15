/- 開境界自由エネルギー密度の値集合と、その上限の存在。 -/
import Ising2DLambda.ThermodynamicLimit.OpenFreeEnergyDensityUpperBound
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensitySupremum
import Ising2DLambda.NecSuf.ThermodynamicLimit.FreeEnergyDensitySupremum

namespace Ising2DLambda.ThermodynamicLimit

/-- `def_open_free_energy_density_value_set`。 -/
def openFreeEnergyDensityValueSet (t : StrictlyPositiveReal) : Set ℝ :=
  Set.range fun L : PositiveNatural => openSquareFreeEnergyDensity L t

/-- `claim_open_free_energy_density_supremum_exists` の具体版。 -/
theorem openFreeEnergyDensityValueSet_has_supremum (t : StrictlyPositiveReal) :
    ∃ s : ℝ, IsLUB (openFreeEnergyDensityValueSet t) s := by
  let one : PositiveNatural := ⟨1, by norm_num⟩
  let upper : ℝ :=
    realLogarithm (⟨2, by norm_num⟩ : StrictlyPositiveReal) +
      2 * realLogarithm (⟨1 + t.1, by linarith [t.2]⟩ : StrictlyPositiveReal)
  have hnonempty : (openFreeEnergyDensityValueSet t).Nonempty := by
    exact ⟨openSquareFreeEnergyDensity one t, ⟨one, rfl⟩⟩
  have hbounded : BddAbove (openFreeEnergyDensityValueSet t) := by
    refine ⟨upper, ?_⟩
    intro y hy
    rcases hy with ⟨L, rfl⟩
    exact openSquareFreeEnergyDensity_le_upperBound L t
  exact real_nonempty_bddAbove_has_supremum _ hnonempty hbounded

/-- 必要十分版から開境界値集合の上限の存在を導く。 -/
theorem openFreeEnergyDensityValueSet_has_supremum_from_necSuf
    (t : StrictlyPositiveReal) :
    ∃ s : ℝ, IsLUB (openFreeEnergyDensityValueSet t) s := by
  let one : PositiveNatural := ⟨1, by norm_num⟩
  let upper : ℝ :=
    realLogarithm (⟨2, by norm_num⟩ : StrictlyPositiveReal) +
      2 * realLogarithm (⟨1 + t.1, by linarith [t.2]⟩ : StrictlyPositiveReal)
  have habstract :=
    NecSuf.ThermodynamicLimit.indexedValueSet_has_supremum_necSuf
      (fun L : PositiveNatural => openSquareFreeEnergyDensity L t) one upper
      (fun L => openSquareFreeEnergyDensity_le_upperBound L t)
      real_nonempty_bddAbove_has_supremum
  simpa [openFreeEnergyDensityValueSet] using habstract

end Ising2DLambda.ThermodynamicLimit
