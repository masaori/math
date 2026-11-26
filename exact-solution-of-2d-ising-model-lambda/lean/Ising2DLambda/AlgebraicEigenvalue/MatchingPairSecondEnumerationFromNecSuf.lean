/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondEnumeration` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondEnumeration
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairSecondEnumeration

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (ascendingMatePair)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The abstract color-transfer argument yields the endpoint-word equality. -/
theorem matchingPairSecondEnumeration_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    let w₂ := w.map τ.val
    let l := w₂.map (ascendingMatePair υ.val)
    l.Nodup ∧
      l.flatMap (fun p => if p.1 ∉ matchingPairColor τ υ then
        [p.1, p.2] else [p.2, p.1]) =
        w₂.flatMap (fun i => [i, υ.val i]) := by
  exact NecSuf.AlgebraicEigenvalue.matchingPairSecondEnumeration_necSuf
    τ.val υ.val (matchingPairColor τ υ) w τ.property.2
    (matchingPairColor_alternates τ υ)
    (matchingPairSecondColor_alternates τ υ) hw hcolor

end Ising2DLambda.AlgebraicEigenvalue
