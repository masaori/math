/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairBijection` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairBijection
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairBijection

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]
open Classical

noncomputable def matchingPairEvenOrbitEquiv_from_necSuf :
    (FixedPointFreeInvolution J × FixedPointFreeInvolution J) ≃ EvenOrbitPermutation J :=
  NecSuf.AlgebraicEigenvalue.equivalenceOfTwoSidedInverse
    matchingPairToEvenOrbit evenOrbitToMatchingPair
    matchingPair_bijection_left matchingPair_bijection_right

end Ising2DLambda.AlgebraicEigenvalue
