import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondRecovery
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairSecondRecovery

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

theorem matchingPair_second_neighbor_recovered_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    alternatingNeighbor (matchingPairPermutation τ υ).symm (matchingPairColor τ υ) i = υ.val i := by
  exact NecSuf.AlgebraicEigenvalue.matchingPair_second_neighbor_recovered
    τ.val υ.val (fun j => j ∈ matchingPairColor τ υ)
    τ.property.2 υ.property.2
    (matchingPairColor_alternates τ υ) (matchingPairSecondColor_alternates τ υ) i

end Ising2DLambda.AlgebraicEigenvalue
