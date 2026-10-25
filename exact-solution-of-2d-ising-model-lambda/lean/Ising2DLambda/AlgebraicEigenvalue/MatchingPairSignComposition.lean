import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordSignMap
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordOrientationSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairSignComposition

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign sign_mul_self)
open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

private noncomputable def orientationSign (l : List (J × J)) (S : Set J) : ℤ :=
  (l.map (fun p => if p.1 ∈ S then (1 : ℤ) else -1)).prod

private theorem orientationSign_mul_self (l : List (J × J)) (S : Set J) :
    orientationSign l S * orientationSign l S = 1 := by
  classical
  unfold orientationSign
  induction l with
  | nil => simp
  | cons p rest ih =>
      simp only [List.map_cons, List.prod_cons]
      split_ifs <;> nlinarith [ih]

private theorem perfectMatchingSign_mul_self (D : PerfectMatching J) :
    perfectMatchingSign D * perfectMatchingSign D = 1 := by
  rcases perfectMatchingSign_eq_one_or_neg_one D with h | h <;> rw [h] <;> norm_num

private theorem matchingPairWordOrientationSign_forEnumeration
    (D : PerfectMatching J) (l : List (J × J))
    (hl : IsMatchingEnumeration D l) (S : Set J) :
    matchingWordSign (l.flatMap (fun p =>
      if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) =
      orientationSign l S * perfectMatchingSign D := by
  have h := NecSuf.AlgebraicEigenvalue.matchingPairWordOrientationSign l S
    (matchingEnumeration_complete D l hl)
  rw [perfectMatchingSign_enumeration_independent D l hl] at h
  exact h

/-- Compose the two endpoint word identities before identifying the actual pair enumerations. -/
theorem matchingPairSignComposition (τ υ : FixedPointFreeInvolution J)
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
  have hmap := matchingPairWordSignMap τ υ w hw hcomplete
  have hD := matchingPairWordOrientationSign_forEnumeration D lD hDenum S
  have hE := matchingPairWordOrientationSign_forEnumeration E lE hEenum T
  rw [hfirst] at hmap
  rw [hsecond] at hmap
  calc
    sign (fun x y : J => x < y) (matchingPairPermutation τ υ) =
        sign (fun x y : J => x < y) (matchingPairPermutation τ υ) *
          (orientationSign lD S * orientationSign lD S) := by
      rw [orientationSign_mul_self]; ring
    _ = sign (fun x y : J => x < y) (matchingPairPermutation τ υ) *
          (orientationSign lD S * orientationSign lD S) *
          (perfectMatchingSign D * perfectMatchingSign D) := by
      rw [perfectMatchingSign_mul_self]; ring
    _ = sign (fun x y : J => x < y) (matchingPairPermutation τ υ) *
          ((orientationSign lD S * perfectMatchingSign D) *
           (orientationSign lD S * perfectMatchingSign D)) := by ring
    _ = sign (fun x y : J => x < y) (matchingPairPermutation τ υ) *
          (matchingWordSign (lD.flatMap (fun p =>
            if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) *
           matchingWordSign (lD.flatMap (fun p =>
            if p.1 ∈ S then [p.1, p.2] else [p.2, p.1]))) := by rw [hD]
    _ = matchingWordSign (lE.flatMap (fun p =>
          if p.1 ∈ T then [p.1, p.2] else [p.2, p.1])) *
          matchingWordSign (lD.flatMap (fun p =>
            if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) := by rw [hmap]; ring
    _ = (orientationSign lE T * perfectMatchingSign E) *
          matchingWordSign (lD.flatMap (fun p =>
            if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) := by rw [hE]
    _ = (orientationSign lE T * perfectMatchingSign E) *
          (orientationSign lD S * perfectMatchingSign D) := by rw [hD]
    _ = orientationSign lD S * orientationSign lE T *
          perfectMatchingSign D * perfectMatchingSign E := by ring

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
