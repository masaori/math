/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordOrientationSign` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordOrientationSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairWordOrientationSign

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 必要十分版は完全列挙した端点列に適用できる。 -/
theorem matchingPairWordOrientationSign_from_necSuf (D : PerfectMatching J) (S : Set J) :
    matchingWordSign ((matchingCanonicalEnumeration D).flatMap (fun p =>
      if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) =
      ((matchingCanonicalEnumeration D).map (fun p =>
        if p.1 ∈ S then (1 : ℤ) else -1)).prod * perfectMatchingSign D := by
  apply NecSuf.AlgebraicEigenvalue.matchingPairWordOrientationSign matchingWordSign
  · intro u a b v h
    exact matchingWordSign_swap u a b v h
  · exact matchingEnumeration_complete D _ (matchingCanonicalEnumeration_spec D)

end Ising2DLambda.AlgebraicEigenvalue
