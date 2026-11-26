import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordMap
import Ising2DLambda.AlgebraicEigenvalue.PerfectMatchingSign
import Ising2DLambda.AlgebraicEigenvalue.PermutationSignFiniteOrderedSetIndependent

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign (finiteOrderedSign)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The actual alternating successor sends the first oriented endpoint word to the second. -/
theorem matchingPairWordSignMap (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : ∀ i ∈ w, i ∈ matchingPairColor τ υ)
    (hcomplete : IsCompleteWord (w.flatMap (fun i => [i, τ.val i]))) :
    matchingWordSign (w.flatMap (fun i => [τ.val i, υ.val (τ.val i)])) =
      finiteOrderedSign (matchingPairPermutation τ υ) *
        matchingWordSign (w.flatMap (fun i => [i, τ.val i])) := by
  rw [← matchingPairWordMap τ υ w hw]
  exact matchingWordSign_map _ hcomplete _

end Ising2DLambda.AlgebraicEigenvalue
