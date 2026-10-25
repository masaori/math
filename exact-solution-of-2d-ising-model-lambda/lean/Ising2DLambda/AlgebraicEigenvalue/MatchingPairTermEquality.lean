import Ising2DLambda.AlgebraicEigenvalue.MatchingPairActualSignComposition
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairActualMonomial
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairEntryProduct
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrientationProduct
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairTermEquality

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (ascendingMatePair orientationFactor sign)

variable {J : Type*} [Fintype J] [LinearOrder J]

private theorem orientationSign_eq_finset_product (m : J → J) (S : Set J)
    (w : List J) (hw : w.Nodup)
    (hS : ∀ i, i ∈ w ↔ i ∈ S)
    (hm : ∀ i ∈ w, m i ∉ S) :
    orientationSign (w.map (ascendingMatePair m)) S =
      ∏ i ∈ Finset.univ.filter (· ∈ S), (orientationFactor m i : ℤ) := by
  classical
  have hpoint (i : J) (hi : i ∈ w) :
      (if (ascendingMatePair m i).1 ∈ S then (1 : ℤ) else -1) =
        orientationFactor m i := by
    by_cases hlt : i < m i
    · simp [ascendingMatePair, orientationFactor, hlt, (hS i).mp hi]
    · simp [ascendingMatePair, orientationFactor, hlt, hm i hi]
  have hset : w.toFinset = Finset.univ.filter (· ∈ S) := by
    ext i
    simp [hS i]
  calc
    orientationSign (w.map (ascendingMatePair m)) S =
        (w.map (fun i => orientationFactor m i : J → ℤ)).prod := by
          unfold orientationSign
          simp only [List.map_map]
          congr 1
          apply List.map_congr_left
          intro i hi
          exact hpoint i hi
    _ = ∏ i ∈ w.toFinset, (orientationFactor m i : ℤ) :=
      (List.prod_toFinset _ hw).symm
    _ = ∏ i ∈ Finset.univ.filter (· ∈ S), (orientationFactor m i : ℤ) := by rw [hset]

private theorem orientationSign_cast_eq_product (m : J → J) (S : Set J)
    (w : List J) (hw : w.Nodup)
    (hS : ∀ i, i ∈ w ↔ i ∈ S)
    (hm : ∀ i ∈ w, m i ∉ S) :
    Polynomial.C ((orientationSign (w.map (ascendingMatePair m)) S : ℤ) : Qbar) =
      ∏ i ∈ Finset.univ.filter (· ∈ S),
        (orientationFactor m i : Polynomial Qbar) := by
  classical
  rw [orientationSign_eq_finset_product m S w hw hS hm]
  simp only [Int.cast_prod, map_prod]
  apply Finset.prod_congr rfl
  intro i hi
  by_cases hlt : i < m i <;> simp [orientationFactor, hlt]

private theorem orientationSign_sq (l : List (J × J)) (S : Set J) :
    orientationSign l S * orientationSign l S = 1 := by
  classical
  unfold orientationSign
  induction l with
  | nil => simp
  | cons p rest ih =>
      simp only [List.map_cons, List.prod_cons]
      by_cases h : p.1 ∈ S <;> simp [h] at * <;> nlinarith

private theorem matchingPairTermData (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar))
    (hA : IsZeroDiagonalSkewQbarPolynomialMatrix A)
    (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    ∃ α β : Polynomial Qbar,
      α * α = 1 ∧ β * β = 1 ∧
      Polynomial.C ((sign (fun x y : J => x < y) (matchingPairPermutation τ υ) : ℤ) : Qbar) =
        α * β * matchingSignPolynomial (involutionToPerfectMatching τ) *
          matchingSignPolynomial (involutionToPerfectMatching υ) ∧
      (∏ i : J, A i (matchingPairPermutation τ υ i)) =
        (α * β) *
          (matchingMatrixMonomial A (involutionToPerfectMatching τ) *
            matchingMatrixMonomial A (involutionToPerfectMatching υ)) := by
  classical
  let C := matchingPairColor τ υ
  let Sτ := Finset.univ.filter (· ∈ C)
  let Sυ := Finset.univ.filter (· ∉ C)
  let lτ := w.map (ascendingMatePair τ.val)
  let w₂ := w.map τ.val
  let lυ := w₂.map (ascendingMatePair υ.val)
  let ατ := orientationSign lτ C
  let αυ := orientationSign lυ {i | i ∉ C}
  have hτmate : ∀ i ∈ w, τ.val i ∉ C := by
    intro i hi hmate
    exact ((matchingPairColor_alternates τ υ i).mp hmate) ((hcolor i).mp hi)
  have hinj : Function.Injective τ.val := by
    intro i j hij
    calc
      i = τ.val (τ.val i) := (τ.property.2 i).symm
      _ = τ.val (τ.val j) := by rw [hij]
      _ = j := τ.property.2 j
  have hw₂ : w₂.Nodup := hw.map hinj
  have hcolor₂ : ∀ i : J, i ∈ w₂ ↔ i ∈ ({i | i ∉ C} : Set J) := by
    intro i
    constructor
    · intro hi
      obtain ⟨j, hj, rfl⟩ := List.mem_map.mp hi
      exact hτmate j hj
    · intro hi
      have hτi : τ.val i ∈ C := (matchingPairColor_alternates τ υ i).mpr hi
      apply List.mem_map.mpr
      exact ⟨τ.val i, (hcolor (τ.val i)).mpr hτi, τ.property.2 i⟩
  have hυmate : ∀ i ∈ w₂, υ.val i ∉ ({i | i ∉ C} : Set J) := by
    intro i hi
    have hsecond : i ∉ C := (hcolor₂ i).mp hi
    have hfirst : υ.val i ∈ C := (matchingPairSecondColor_alternates τ υ i).mpr hsecond
    simpa only [Set.mem_setOf_eq, not_not] using hfirst
  have hατ : Polynomial.C ((ατ : ℤ) : Qbar) =
      ∏ i ∈ Sτ, (orientationFactor τ.val i : Polynomial Qbar) := by
    exact orientationSign_cast_eq_product τ.val C w hw hcolor hτmate
  have hαυ : Polynomial.C ((αυ : ℤ) : Qbar) =
      ∏ i ∈ Sυ, (orientationFactor υ.val i : Polynomial Qbar) := by
    simpa only [Sυ, Finset.mem_filter, Finset.mem_univ, true_and, Set.mem_setOf_eq]
      using orientationSign_cast_eq_product υ.val {i | i ∉ C} w₂ hw₂ hcolor₂ hυmate
  have hsign := matchingPairActualSignComposition τ υ w hw hcolor
  have hsignPoly := congrArg (fun z : ℤ => Polynomial.C (z : Qbar)) hsign
  have hατsq : Polynomial.C ((ατ : ℤ) : Qbar) * Polynomial.C ((ατ : ℤ) : Qbar) = 1 := by
    have h := congrArg (fun z : ℤ => Polynomial.C (z : Qbar))
      (orientationSign_sq lτ C)
    simpa only [Int.cast_mul, map_mul, Int.cast_one, map_one] using h
  have hαυsq : Polynomial.C ((αυ : ℤ) : Qbar) * Polynomial.C ((αυ : ℤ) : Qbar) = 1 := by
    have h := congrArg (fun z : ℤ => Polynomial.C (z : Qbar))
      (orientationSign_sq lυ {i | i ∉ C})
    simpa only [Int.cast_mul, map_mul, Int.cast_one, map_one] using h
  have hprod : (∏ i : J, A i (matchingPairPermutation τ υ i)) =
      (Polynomial.C ((ατ : ℤ) : Qbar) * Polynomial.C ((αυ : ℤ) : Qbar)) *
        (matchingMatrixMonomial A (involutionToPerfectMatching τ) *
          matchingMatrixMonomial A (involutionToPerfectMatching υ)) := by
    rw [matchingPairEntryProduct τ υ A]
    rw [matchingPairOrientationProduct τ υ A hA.2]
    rw [matchingPairSecondOrientationProduct τ υ A hA.2]
    rw [← hατ, ← hαυ]
    rw [selectedAscendingPairs_eq_matchingOrientedPairs τ Sτ (by
      intro i
      simpa only [Sτ, Finset.mem_filter, Finset.mem_univ, true_and]
        using matchingPairColor_alternates τ υ i)]
    rw [selectedAscendingPairs_eq_matchingOrientedPairs υ Sυ (by
      intro i
      simpa only [Sυ, Finset.mem_filter, Finset.mem_univ, true_and]
        using not_congr (matchingPairSecondColor_alternates τ υ i))]
    simp only [matchingMatrixMonomial]
    ring
  simp only [Int.cast_mul, map_mul] at hsignPoly
  refine ⟨Polynomial.C ((ατ : ℤ) : Qbar), Polynomial.C ((αυ : ℤ) : Qbar),
    hατsq, hαυsq, ?_, hprod⟩
  simpa only [matchingSignPolynomial] using hsignPoly

/-- The determinant summand of an even-orbit permutation equals the summand of
the two matchings recovered from its alternating coloring. -/
theorem matchingPairTermEquality (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar))
    (hA : IsZeroDiagonalSkewQbarPolynomialMatrix A)
    (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    Polynomial.C ((sign (fun x y : J => x < y) (matchingPairPermutation τ υ) : ℤ) : Qbar) *
        (∏ i : J, A i (matchingPairPermutation τ υ i)) =
      (matchingSignPolynomial (involutionToPerfectMatching τ) *
        matchingSignPolynomial (involutionToPerfectMatching υ)) *
      (matchingMatrixMonomial A (involutionToPerfectMatching τ) *
        matchingMatrixMonomial A (involutionToPerfectMatching υ)) := by
  obtain ⟨α, β, hα, hβ, hs, hp⟩ := matchingPairTermData τ υ A hA w hw hcolor
  calc
    _ = (α * β * matchingSignPolynomial (involutionToPerfectMatching τ) *
          matchingSignPolynomial (involutionToPerfectMatching υ)) *
        ((α * β) * (matchingMatrixMonomial A (involutionToPerfectMatching τ) *
          matchingMatrixMonomial A (involutionToPerfectMatching υ))) := by rw [hs, hp]
    _ = (α * α) * (β * β) *
        ((matchingSignPolynomial (involutionToPerfectMatching τ) *
          matchingSignPolynomial (involutionToPerfectMatching υ)) *
          (matchingMatrixMonomial A (involutionToPerfectMatching τ) *
            matchingMatrixMonomial A (involutionToPerfectMatching υ))) := by ring
    _ = _ := by rw [hα, hβ]; ring

/-- The concrete argument specializes the same cancellation over a commutative ring. -/
theorem matchingPairTermEquality_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar))
    (hA : IsZeroDiagonalSkewQbarPolynomialMatrix A)
    (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    Polynomial.C ((sign (fun x y : J => x < y) (matchingPairPermutation τ υ) : ℤ) : Qbar) *
        (∏ i : J, A i (matchingPairPermutation τ υ i)) =
      (matchingSignPolynomial (involutionToPerfectMatching τ) *
        matchingSignPolynomial (involutionToPerfectMatching υ)) *
      (matchingMatrixMonomial A (involutionToPerfectMatching τ) *
        matchingMatrixMonomial A (involutionToPerfectMatching υ)) := by
  obtain ⟨α, β, hα, hβ, hs, hp⟩ := matchingPairTermData τ υ A hA w hw hcolor
  exact NecSuf.AlgebraicEigenvalue.matchingPairTermEquality_necSuf
    _ _ α β _ _ _ _ hs hp hα hβ

end Ising2DLambda.AlgebraicEigenvalue
