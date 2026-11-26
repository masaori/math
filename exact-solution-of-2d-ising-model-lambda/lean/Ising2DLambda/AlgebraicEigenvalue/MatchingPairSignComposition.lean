import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordSignMap
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordOrientationSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign (finiteOrderedSign)
open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

noncomputable def orientationSign (l : List (J × J)) (S : Set J) : ℤ :=
  (l.map (fun p => if p.1 ∈ S then (1 : ℤ) else -1)).prod

theorem orientationSign_mul_self (l : List (J × J)) (S : Set J) :
    orientationSign l S * orientationSign l S = 1 := by
  classical
  unfold orientationSign
  induction l with
  | nil => simp
  | cons p rest ih =>
      simp only [List.map_cons, List.prod_cons]
      split_ifs <;> nlinarith [ih]

theorem perfectMatchingSign_mul_self (D : PerfectMatching J) :
    perfectMatchingSign D * perfectMatchingSign D = 1 := by
  rcases perfectMatchingSign_eq_one_or_neg_one D with h | h <;> rw [h] <;> norm_num

theorem matchingPairWordOrientationSign_forEnumeration
    (D : PerfectMatching J) (l : List (J × J))
    (hl : IsMatchingEnumeration D l) (S : Set J) :
    matchingWordSign (l.flatMap (fun p =>
      if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) =
      orientationSign l S * perfectMatchingSign D := by
  have h := matchingOrientationSignAux S l []
    (by simpa using matchingEnumeration_complete D l hl)
  simp only [List.nil_append] at h
  rw [perfectMatchingSign_enumeration_independent D l hl] at h
  simpa [orientationSign] using h

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
    finiteOrderedSign (matchingPairPermutation τ υ) =
      orientationSign lD S * orientationSign lE T *
        perfectMatchingSign D * perfectMatchingSign E := by
  have hmap := matchingPairWordSignMap τ υ w hw hcomplete
  have hD := matchingPairWordOrientationSign_forEnumeration D lD hDenum S
  have hE := matchingPairWordOrientationSign_forEnumeration E lE hEenum T
  rw [hfirst] at hmap
  rw [hsecond] at hmap
  change matchingWordSign (lE.flatMap (fun p =>
      if p.1 ∈ T then [p.1, p.2] else [p.2, p.1])) =
    finiteOrderedSign (matchingPairPermutation τ υ) *
      matchingWordSign (lD.flatMap (fun p =>
        if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) at hmap
  calc
    finiteOrderedSign (matchingPairPermutation τ υ) =
        finiteOrderedSign (matchingPairPermutation τ υ) *
          (orientationSign lD S * orientationSign lD S) := by
      rw [orientationSign_mul_self]; ring
    _ = finiteOrderedSign (matchingPairPermutation τ υ) *
          (orientationSign lD S * orientationSign lD S) *
          (perfectMatchingSign D * perfectMatchingSign D) := by
      rw [perfectMatchingSign_mul_self]; ring
    _ = finiteOrderedSign (matchingPairPermutation τ υ) *
          ((orientationSign lD S * perfectMatchingSign D) *
           (orientationSign lD S * perfectMatchingSign D)) := by ring
    _ = finiteOrderedSign (matchingPairPermutation τ υ) *
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

end Ising2DLambda.AlgebraicEigenvalue
