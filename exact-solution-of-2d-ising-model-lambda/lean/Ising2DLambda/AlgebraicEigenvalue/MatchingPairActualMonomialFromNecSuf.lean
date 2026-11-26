/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairActualMonomial` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairActualMonomial
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingEnumerationMonomial
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairOrientationProduct

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (ascendingMatePair)

variable {J : Type*} [Fintype J] [LinearOrder J]

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
  simp only [show concreteAscendingMatePair υ.val = ascendingMatePair υ.val from rfl] at hυ
  constructor
  · exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingEnumerationMonomial_necSuf
      (matchingOrientedPairs (involutionToPerfectMatching τ))
      (w.map (ascendingMatePair τ.val)) hτ.1 hτ.2 (fun p => A p.1 p.2)
  · exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingEnumerationMonomial_necSuf
      (matchingOrientedPairs (involutionToPerfectMatching υ))
      ((w.map τ.val).map (ascendingMatePair υ.val)) hυ.1 hυ.2 (fun p => A p.1 p.2)

end Ising2DLambda.AlgebraicEigenvalue
