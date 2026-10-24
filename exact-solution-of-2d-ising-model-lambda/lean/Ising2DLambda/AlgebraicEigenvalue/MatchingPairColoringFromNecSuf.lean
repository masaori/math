import Ising2DLambda.AlgebraicEigenvalue.MatchingPairColoring
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairColoring

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 比較の反対称性と実際の最小元の所属・下界性を供給する。 -/
theorem matchingPairComponentMinimum_basepoint_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i j : J)
    (hj : j ∈ matchingPairComponent τ υ i) :
    matchingPairComponentMinimum τ υ j = matchingPairComponentMinimum τ υ i :=
  NecSuf.AlgebraicEigenvalue.matchingPairMinimum_basepoint τ υ (· ≤ ·)
    (fun _ _ => le_antisymm) (matchingPairComponentMinimum τ υ)
    (matchingPairComponentMinimum_mem τ υ) (matchingPairComponentMinimum_le τ υ) i j hj

theorem matchingPairColor_alternates_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    τ.val i ∈ matchingPairColor τ υ ↔ i ∉ matchingPairColor τ υ :=
  NecSuf.AlgebraicEigenvalue.matchingPairColor_alternates τ υ (· ≤ ·)
    (fun _ _ => le_antisymm) (matchingPairComponentMinimum τ υ)
    (matchingPairComponentMinimum_mem τ υ) (matchingPairComponentMinimum_le τ υ) i

end Ising2DLambda.AlgebraicEigenvalue
