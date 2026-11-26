/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstWordComplete` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstWordComplete
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairFirstWordComplete

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The generic involution argument applies to the actual first color. -/
theorem matchingPairFirstWordComplete_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    IsCompleteWord (w.flatMap (fun i => [i, τ.val i])) := by
  exact NecSuf.AlgebraicEigenvalue.matchingPairFirstWordComplete_necSuf
    τ.val (matchingPairColor τ υ) w τ.property.2
    (matchingPairColor_alternates τ υ) hw hcolor

end Ising2DLambda.AlgebraicEigenvalue
