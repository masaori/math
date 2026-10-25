import Ising2DLambda.AlgebraicEigenvalue.MatchingPairFirstEnumeration
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairSecondEnumeration
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialPfaffian
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingEnumerationMonomial

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (ascendingMatePair)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The actual ascending-pair lists give the two matching monomials. -/
theorem matchingPairActualMonomial (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar)) (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    ((w.map (ascendingMatePair τ.val)).map (fun p => A p.1 p.2)).prod =
        matchingMatrixMonomial A (involutionToPerfectMatching τ) ∧
      (((w.map τ.val).map (ascendingMatePair υ.val)).map
        (fun p => A p.1 p.2)).prod =
        matchingMatrixMonomial A (involutionToPerfectMatching υ) := by
  classical
  obtain ⟨hτ, _⟩ := matchingPairFirstEnumeration τ υ w hw hcolor
  obtain ⟨hυ, _⟩ := matchingPairSecondEnumeration τ υ w hw hcolor
  constructor
  · have hset : (w.map (ascendingMatePair τ.val)).toFinset =
        matchingOrientedPairs (involutionToPerfectMatching τ) :=
      Finset.ext fun p => by simpa only [List.mem_toFinset] using hτ.2 p
    calc
      ((w.map (ascendingMatePair τ.val)).map (fun p => A p.1 p.2)).prod =
          ∏ p ∈ (w.map (ascendingMatePair τ.val)).toFinset, A p.1 p.2 :=
        (List.prod_toFinset _ hτ.1).symm
      _ = matchingMatrixMonomial A (involutionToPerfectMatching τ) := by
        rw [hset]
        rfl
  · have hset : ((w.map τ.val).map (ascendingMatePair υ.val)).toFinset =
        matchingOrientedPairs (involutionToPerfectMatching υ) :=
      Finset.ext fun p => by simpa only [List.mem_toFinset] using hυ.2 p
    calc
      (((w.map τ.val).map (ascendingMatePair υ.val)).map
          (fun p => A p.1 p.2)).prod =
          ∏ p ∈ ((w.map τ.val).map (ascendingMatePair υ.val)).toFinset, A p.1 p.2 :=
        (List.prod_toFinset _ hυ.1).symm
      _ = matchingMatrixMonomial A (involutionToPerfectMatching υ) := by
        rw [hset]
        rfl

/-- The generic finite-product theorem gives the same two concrete identities. -/
theorem matchingPairActualMonomial_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar)) (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    ((w.map (ascendingMatePair τ.val)).map (fun p => A p.1 p.2)).prod =
        matchingMatrixMonomial A (involutionToPerfectMatching τ) ∧
      (((w.map τ.val).map (ascendingMatePair υ.val)).map
        (fun p => A p.1 p.2)).prod =
        matchingMatrixMonomial A (involutionToPerfectMatching υ) := by
  classical
  obtain ⟨hτ, _⟩ := matchingPairFirstEnumeration τ υ w hw hcolor
  obtain ⟨hυ, _⟩ := matchingPairSecondEnumeration τ υ w hw hcolor
  constructor
  · exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingEnumerationMonomial_necSuf
      (matchingOrientedPairs (involutionToPerfectMatching τ))
      (w.map (ascendingMatePair τ.val)) hτ.1 hτ.2 (fun p => A p.1 p.2)
  · exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingEnumerationMonomial_necSuf
      (matchingOrientedPairs (involutionToPerfectMatching υ))
      ((w.map τ.val).map (ascendingMatePair υ.val)) hυ.1 hυ.2 (fun p => A p.1 p.2)

end Ising2DLambda.AlgebraicEigenvalue
