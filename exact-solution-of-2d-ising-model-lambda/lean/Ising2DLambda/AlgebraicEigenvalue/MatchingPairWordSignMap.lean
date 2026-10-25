import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordMap
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairWordSignMap

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The actual alternating successor sends the first oriented endpoint word to the second. -/
theorem matchingPairWordSignMap (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : ∀ i ∈ w, i ∈ matchingPairColor τ υ)
    (hcomplete : IsCompleteWord (w.flatMap (fun i => [i, τ.val i]))) :
    matchingWordSign (w.flatMap (fun i => [τ.val i, υ.val (τ.val i)])) =
      sign (fun x y : J => x < y) (matchingPairPermutation τ υ) *
        matchingWordSign (w.flatMap (fun i => [i, τ.val i])) := by
  rw [← matchingPairWordMap τ υ w hw]
  exact matchingWordSign_map _ hcomplete _

/-- The general word argument specializes to the actual matching pair. -/
theorem matchingPairWordSignMap_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : ∀ i ∈ w, i ∈ matchingPairColor τ υ)
    (hcomplete : IsCompleteWord (w.flatMap (fun i => [i, τ.val i]))) :
    matchingWordSign (w.flatMap (fun i => [τ.val i, υ.val (τ.val i)])) =
      sign (fun x y : J => x < y) (matchingPairPermutation τ υ) *
        matchingWordSign (w.flatMap (fun i => [i, τ.val i])) := by
  apply NecSuf.AlgebraicEigenvalue.matchingPairWordSignMap_necSuf _ _ _ hcomplete
  exact (matchingPairWordMap τ υ w hw).symm

end Ising2DLambda.AlgebraicEigenvalue
