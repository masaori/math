/- 完全列挙上の実際の転倒符号を必要十分版の四交換へ入力する。 -/
import Ising2DLambda.AlgebraicEigenvalue.PerfectMatchingSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatchingSign

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 具体の隣接交換則と整数の二重符号反転を入力し、実際のマッチングへ戻す。 -/
theorem perfectMatchingSign_enumeration_independent_from_necSuf (D : PerfectMatching J)
    (l : List (J × J)) (hl : IsMatchingEnumeration D l) :
    matchingWordSign (matchingPairWord l) = perfectMatchingSign D := by
  have hp := matchingEnumerations_perm D (matchingCanonicalEnumeration_spec D) hl
  exact NecSuf.AlgebraicEigenvalue.matchingWord_value_pair_perm
    matchingWordSign Neg.neg (fun z : ℤ => neg_neg z)
    (fun u a b v h => matchingWordSign_swap u a b v h) hp []
    (matchingEnumeration_complete D _ (matchingCanonicalEnumeration_spec D))

end Ising2DLambda.AlgebraicEigenvalue
