import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondColoring
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairSecondColoring

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 実際の最小元の仕様と比較の反対称性を供給する。 -/
theorem matchingPairSecondColor_alternates_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    υ.val i ∈ matchingPairColor τ υ ↔ i ∉ matchingPairColor τ υ :=
  NecSuf.AlgebraicEigenvalue.matchingPairSecondColor_alternates τ υ (· ≤ ·)
    (fun _ _ => le_antisymm) (matchingPairComponentMinimum τ υ)
    (matchingPairComponentMinimum_mem τ υ) (matchingPairComponentMinimum_le τ υ) i

end Ising2DLambda.AlgebraicEigenvalue
