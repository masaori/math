/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairSignComposition` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSignComposition
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairSignComposition
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordSignMapFromNecSuf

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)
open Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign (finiteOrderedSign)
open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The same composition follows from the necessary hypotheses in a commutative ring. -/
theorem matchingPairSignComposition_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (D E : PerfectMatching J) (lD lE : List (J × J))
    (hDenum : IsMatchingEnumeration D lD) (hEenum : IsMatchingEnumeration E lE)
    (S T : Set J) (w : List J)
    (hw : ∀ i ∈ w, i ∈ matchingPairColor τ υ)
    (hcomplete : IsCompleteWord (w.flatMap (fun i => [i, τ.val i])))
    (hfirst : w.flatMap (fun i => [i, τ.val i]) =
      lD.flatMap (fun p =>
        if p.1 ∈ S then [p.1, p.2] else [p.2, p.1]))
    (hsecond : w.flatMap (fun i => [τ.val i, υ.val (τ.val i)]) =
      lE.flatMap (fun p =>
        if p.1 ∈ T then [p.1, p.2] else [p.2, p.1])) :
    sign (fun x y : J => x < y) (matchingPairPermutation τ υ) =
      orientationSign lD S * orientationSign lE T *
        perfectMatchingSign D * perfectMatchingSign E := by
  have hmap := matchingPairWordSignMap_from_necSuf τ υ w hw hcomplete
  have hD := matchingPairWordOrientationSign_forEnumeration D lD hDenum S
  have hE := matchingPairWordOrientationSign_forEnumeration E lE hEenum T
  rw [hfirst] at hmap
  rw [hsecond] at hmap
  exact NecSuf.AlgebraicEigenvalue.matchingPairSignComposition_necSuf
    _ _ _ _ _ _ _ hmap hD hE (orientationSign_mul_self lD S)
      (perfectMatchingSign_mul_self D)

end Ising2DLambda.AlgebraicEigenvalue
