import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrbitExchange
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairOrbitExchange

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J]

/-- 不動点なし対合から対合性だけを供給する特殊化。 -/
theorem matchingPairStep_mate_image_from_necSuf (τ υ : FixedPointFreeInvolution J) (i : J) :
    τ.val '' finitePermutationOrbit (matchingPairStep τ υ) i =
      finitePermutationOrbit (matchingPairStep τ υ) (τ.val i) :=
  NecSuf.AlgebraicEigenvalue.matchingPairStep_mate_image τ.val υ.val τ.property.2 υ.property.2 i

end Ising2DLambda.AlgebraicEigenvalue
