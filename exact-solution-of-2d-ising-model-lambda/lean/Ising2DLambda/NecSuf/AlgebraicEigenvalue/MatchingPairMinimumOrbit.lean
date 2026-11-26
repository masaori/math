import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairMinimumPermutation
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairReconstructedOrbit

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 最小元から選んだ第一色の後続置換は、二つの相手写像の成分を巡る。 -/
theorem matchingPairMinimumPermutation_orbit_eq_component
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    permutationOrbit (matchingPairMinimumPermutation τ υ) i =
      matchingPairComponent τ.val υ.val τ.property.2 υ.property.2 i := by
  exact matchingPairPermutation_orbit_eq_component τ.val υ.val
    (fun j => j ∈ matchingPairFirstColor τ υ) τ.property.2 υ.property.2
    (matchingPairFirstColor_first_mate τ υ)
    (matchingPairFirstColor_second_mate τ υ) i

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
