import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReconstructedOrbit
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairReconstructedOrbit
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairMinimumOrbit
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutationFromNecSuf

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 有限順序集合上の具体的な二色付けは、必要十分版の色反転仮定を満たす。 -/
theorem matchingPairPermutation_orbit_eq_component_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    finitePermutationOrbit (matchingPairPermutation τ υ) i = matchingPairComponent τ υ i := by
  rw [matchingPairPermutation_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.matchingPairMinimumPermutation_orbit_eq_component τ υ i

end Ising2DLambda.AlgebraicEigenvalue
