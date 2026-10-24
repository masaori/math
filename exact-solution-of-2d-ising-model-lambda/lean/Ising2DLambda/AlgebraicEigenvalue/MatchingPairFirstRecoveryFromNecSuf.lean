import Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstRecovery
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairFirstRecovery

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

theorem matchingPair_first_neighbor_recovered_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    alternatingNeighbor (matchingPairPermutation τ υ) (matchingPairColor τ υ) i = τ.val i := by
  exact NecSuf.AlgebraicEigenvalue.matchingPair_first_neighbor_recovered
    τ.val υ.val (fun j => j ∈ matchingPairColor τ υ)
    τ.property.2 υ.property.2
    (matchingPairColor_alternates τ υ) (matchingPairSecondColor_alternates τ υ) i

end Ising2DLambda.AlgebraicEigenvalue
