/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairTermEquality` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairTermEquality
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairOrientationProduct
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairTermEquality

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)
open Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign (finiteOrderedSign)

variable {J : Type*} [Fintype J] [LinearOrder J]

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
