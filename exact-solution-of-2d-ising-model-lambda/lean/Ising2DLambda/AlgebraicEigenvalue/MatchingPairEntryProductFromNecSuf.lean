/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairEntryProduct` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairEntryProduct
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairEntryProduct

namespace Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 必要十分版を実際の二つの相手写像へ代入した等式。 -/
theorem matchingPairEntryProduct_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar)) :
    (∏ i : J, A i (matchingPairPermutation τ υ i)) =
      (∏ i ∈ Finset.univ.filter (· ∈ matchingPairColor τ υ), A i (τ.val i)) *
        (∏ i ∈ Finset.univ.filter (· ∉ matchingPairColor τ υ), A i (υ.val i)) := by
  classical
  apply NecSuf.AlgebraicEigenvalue.matchingPairEntryProduct_necSuf
    (matchingPairColor τ υ) (matchingPairPermutation τ υ) τ.val υ.val A
  intro i
  rfl

end Ising2DLambda.AlgebraicEigenvalue
