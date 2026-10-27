import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Four directional identities imply the identity without a direction restriction.
Only multiplication is retained: the inverse powers belong to the four supplied weights. -/
theorem seamModePhase_allDirections_necSuf {F : Type*} [Monoid F]
    (d : ZMod 4) (lhs base : F) (weight : ZMod 4 → F)
    (hzero : d = 0 → lhs = weight 0 * base)
    (hone : d = 1 → lhs = weight 1 * base)
    (htwo : d = 2 → lhs = weight 2 * base)
    (hthree : d = 3 → lhs = weight 3 * base) :
    lhs = weight d * base := by
  fin_cases d
  · exact hzero rfl
  · exact hone rfl
  · exact htwo rfl
  · exact hthree rfl

end Ising2DLambda.NecSuf.KacWard
