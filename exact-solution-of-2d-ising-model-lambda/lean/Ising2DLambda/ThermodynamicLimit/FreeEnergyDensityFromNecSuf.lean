/- 人手証明の具体的な定式化が、必要十分版の述語と完備性の特殊化であることを明示する。 -/
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensity
import Ising2DLambda.NecSuf.ThermodynamicLimit.FreeEnergyDensity

namespace Ising2DLambda.ThermodynamicLimit

/-- 自由エネルギー密度の極限述語は、二側極限述語の実数への特殊化である。 -/
theorem isFreeEnergyDensityLimit_iff_twoSidedLimitOn
    (t : StrictlyPositiveReal) (f : ℝ) :
    IsFreeEnergyDensityLimit t f ↔
      NecSuf.ThermodynamicLimit.twoSidedLimitOn
        (fun L : PositiveNatural => L.1)
        (fun L : PositiveNatural => freeEnergyDensity L t)
        (fun eps : ℝ => 0 < eps) f := by
  constructor
  · intro h eps heps
    exact h ⟨eps, heps⟩
  · intro h eps
    exact h eps.1 eps.2

/-- 実数の完備性宣言を、上限の存在だけを持つ必要十分版へ特殊化する。 -/
theorem real_upperBoundComplete_from_necSuf :
    NecSuf.ThermodynamicLimit.UpperBoundComplete ℝ := by
  intro S hne hbdd
  exact real_nonempty_bddAbove_has_supremum S hne hbdd

end Ising2DLambda.ThermodynamicLimit
