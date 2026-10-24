import Ising2DLambda.AlgebraicEigenvalue.MatchingPairComponent
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairComponent

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J]

/-- 不動点なし対合から、必要な対合性のみを供給する。 -/
theorem matchingPairComponent_basepoint_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i j : J)
    (h : j ∈ matchingPairComponent τ υ i) :
    matchingPairComponent τ υ j = matchingPairComponent τ υ i :=
  NecSuf.AlgebraicEigenvalue.matchingPairComponent_basepoint
    τ.val υ.val τ.property.2 υ.property.2 i j h

end Ising2DLambda.AlgebraicEigenvalue
