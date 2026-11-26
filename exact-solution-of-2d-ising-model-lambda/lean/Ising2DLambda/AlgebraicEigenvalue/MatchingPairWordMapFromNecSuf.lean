/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordMap` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordMap
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairWordMap

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 必要十分版の二つの場合を実際の相手写像と色へ代入する。 -/
theorem matchingPairWordMap_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : ∀ i ∈ w, i ∈ matchingPairColor τ υ) :
    (w.flatMap (fun i => [i, τ.val i])).map (matchingPairPermutation τ υ) =
      w.flatMap (fun i => [τ.val i, υ.val (τ.val i)]) := by
  classical
  apply NecSuf.AlgebraicEigenvalue.matchingPairWordMap_necSuf
    (matchingPairColor τ υ) (matchingPairPermutation τ υ) τ.val υ.val w hw
  · intro i hi
    simp [matchingPairPermutation, matchingPairSuccessor, hi]
  · intro i hi hmate
    exact ((matchingPairColor_alternates τ υ i).mp hmate) hi
  · intro j hj
    simp [matchingPairPermutation, matchingPairSuccessor, hj]

end Ising2DLambda.AlgebraicEigenvalue
