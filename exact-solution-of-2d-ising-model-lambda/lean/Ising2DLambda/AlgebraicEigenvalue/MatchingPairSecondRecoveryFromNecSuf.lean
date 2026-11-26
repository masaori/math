import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondRecovery
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutationFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairMinimumRecovery

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

theorem matchingPair_second_neighbor_recovered_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    alternatingNeighbor (matchingPairPermutation τ υ).symm (matchingPairColor τ υ) i = υ.val i := by
  rw [matchingPairPermutation_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.matchingPairMinimum_second_neighbor_recovered τ υ i

end Ising2DLambda.AlgebraicEigenvalue
