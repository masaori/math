/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstEnumeration` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstEnumeration
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairFirstEnumeration

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The abstract one-endpoint-per-pair argument gives the concrete word result. -/
theorem matchingPairFirstEnumeration_from_necSuf
    (τ υ : FixedPointFreeInvolution J) (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    (w.map (concreteAscendingMatePair τ.val)).Nodup ∧
      (w.map (concreteAscendingMatePair τ.val)).flatMap
        (fun p => if p.1 ∈ matchingPairColor τ υ then [p.1, p.2] else [p.2, p.1]) =
        w.flatMap (fun i => [i, τ.val i]) := by
  exact NecSuf.AlgebraicEigenvalue.matchingPairFirstEnumeration_necSuf
    τ.val (matchingPairColor τ υ) w (matchingPairColor_alternates τ υ) hw hcolor

end Ising2DLambda.AlgebraicEigenvalue
