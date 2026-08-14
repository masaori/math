/-
人手証明「自由エネルギー密度の値集合の上限の存在」の具体版。

値集合の非空性を格子サイズ 1 で示し、自由エネルギー密度の一様上界を上界として与え、
最後に実数の完備性を一度だけ適用する。
-/
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensityUpperBound

namespace Ising2DLambda.ThermodynamicLimit

/-- `def_free_energy_density_value_set`。正の格子サイズにわたる値の集合。 -/
def freeEnergyDensityValueSet (t : StrictlyPositiveReal) : Set ℝ :=
  Set.range fun L : PositiveNatural => freeEnergyDensity L t

/-- `claim_free_energy_density_supremum_exists`。人手証明の二つの準備と完備性の適用を辿る。 -/
theorem freeEnergyDensityValueSet_has_supremum (t : StrictlyPositiveReal) :
    ∃ s : ℝ, IsLUB (freeEnergyDensityValueSet t) s := by
  let one : PositiveNatural := ⟨1, by norm_num⟩
  let upper : ℝ :=
    realLogarithm (⟨2, by norm_num⟩ : StrictlyPositiveReal) +
      2 * realLogarithm (⟨1 + t.1, by linarith [t.2]⟩ : StrictlyPositiveReal)
  have hnonempty : (freeEnergyDensityValueSet t).Nonempty := by
    exact ⟨freeEnergyDensity one t, ⟨one, rfl⟩⟩
  have hbounded : BddAbove (freeEnergyDensityValueSet t) := by
    refine ⟨upper, ?_⟩
    intro y hy
    rcases hy with ⟨L, rfl⟩
    exact freeEnergyDensity_le_upperBound L t
  exact real_nonempty_bddAbove_has_supremum
    (freeEnergyDensityValueSet t) hnonempty hbounded

end Ising2DLambda.ThermodynamicLimit
