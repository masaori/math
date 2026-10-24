import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutation
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairPermutation

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 実際の相手写像の対合性と二つの色反転を供給する。 -/
theorem matchingPairSuccessor_inverse_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    matchingPairPredecessor τ υ (matchingPairSuccessor τ υ i) = i ∧
    matchingPairSuccessor τ υ (matchingPairPredecessor τ υ i) = i :=
  NecSuf.AlgebraicEigenvalue.matchingPairSuccessor_inverse τ.val υ.val
    (fun j => j ∈ matchingPairColor τ υ) τ.property.2 υ.property.2
    (matchingPairColor_alternates τ υ) (matchingPairSecondColor_alternates τ υ) i

end Ising2DLambda.AlgebraicEigenvalue
