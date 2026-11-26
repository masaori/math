import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairMinimumPermutation
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairSecondRecovery

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

theorem matchingPairMinimum_first_neighbor_recovered
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    alternatingNeighbor (matchingPairMinimumPermutation τ υ)
      (matchingPairMinimumPermutation τ υ).symm
      (matchingPairFirstColor τ υ) i = τ.val i := by
  exact matchingPair_first_neighbor_recovered τ.val υ.val
    (fun j => j ∈ matchingPairFirstColor τ υ) τ.property.2 υ.property.2
    (matchingPairFirstColor_first_mate τ υ)
    (matchingPairFirstColor_second_mate τ υ) i

theorem matchingPairMinimum_second_neighbor_recovered
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    alternatingNeighbor (matchingPairMinimumPermutation τ υ).symm
      (matchingPairMinimumPermutation τ υ)
      (matchingPairFirstColor τ υ) i = υ.val i := by
  exact matchingPair_second_neighbor_recovered τ.val υ.val
    (fun j => j ∈ matchingPairFirstColor τ υ) τ.property.2 υ.property.2
    (matchingPairFirstColor_first_mate τ υ)
    (matchingPairFirstColor_second_mate τ υ) i

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
