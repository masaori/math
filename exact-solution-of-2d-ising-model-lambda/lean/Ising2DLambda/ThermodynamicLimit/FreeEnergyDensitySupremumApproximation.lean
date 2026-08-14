/-
人手証明「上界・最小上界の定義と上限への任意近接」の具体版。

上界と上限を本文どおりに定義し、u - ε < u、u - ε が上界でないこと、
上界でないことから反例を取ること、値集合の定義を展開することを同じ順で辿る。
-/
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensitySupremum

namespace Ising2DLambda.ThermodynamicLimit

/-- `def_real_set_upper_bound`。 -/
def IsRealSetUpperBound (S : Set ℝ) (M : ℝ) : Prop :=
  ∀ s : ℝ, s ∈ S → s ≤ M

/-- `def_real_set_supremum`。 -/
def IsRealSetSupremum (S : Set ℝ) (u : ℝ) : Prop :=
  IsRealSetUpperBound S u ∧
    ∀ M : ℝ, IsRealSetUpperBound S M → u ≤ M

/-- `claim_free_energy_density_supremum_approximation`。人手証明の背理法を辿る。 -/
theorem freeEnergyDensity_supremum_approximation
    (t : StrictlyPositiveReal) (u eps : ℝ)
    (hu : IsRealSetSupremum (freeEnergyDensityValueSet t) u)
    (heps : 0 < eps) :
    ∃ L : PositiveNatural, u - eps < freeEnergyDensity L t := by
  have hlower_lt_u : u - eps < u := by
    exact sub_lt_self u heps
  have hlower_not_upper :
      ¬IsRealSetUpperBound (freeEnergyDensityValueSet t) (u - eps) := by
    intro hlower_upper
    have hu_le_lower : u ≤ u - eps := hu.2 (u - eps) hlower_upper
    exact (not_le_of_gt hlower_lt_u) hu_le_lower
  have hexample :
      ∃ y : ℝ, y ∈ freeEnergyDensityValueSet t ∧ ¬y ≤ u - eps := by
    by_contra hno_example
    push_neg at hno_example
    apply hlower_not_upper
    intro y hy
    exact hno_example y hy
  obtain ⟨y, hy, hy_not_le⟩ := hexample
  have hlower_lt_y : u - eps < y := lt_of_not_ge hy_not_le
  rcases hy with ⟨L, rfl⟩
  exact ⟨L, hlower_lt_y⟩

end Ising2DLambda.ThermodynamicLimit
