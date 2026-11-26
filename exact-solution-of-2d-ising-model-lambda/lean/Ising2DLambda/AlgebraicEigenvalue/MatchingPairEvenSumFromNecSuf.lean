/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairEvenSum` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairEvenSum
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairOrientationProduct
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairEvenSum

namespace Ising2DLambda.AlgebraicEigenvalue

open Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)
open Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign (finiteOrderedSign)
variable {J : Type*} [Fintype J] [LinearOrder J]

theorem matchingPair_even_sum_from_necSuf
    (A : Matrix J J (Polynomial Qbar))
    (hA : IsZeroDiagonalSkewQbarPolynomialMatrix A) :
    (∑ s : EvenOrbitPermutation J,
      Polynomial.C ((sign (fun x y : J => x < y) s.val : ℤ) : Qbar) *
        ∏ i : J, A i (s.val i)) =
      ∑ p : PerfectMatching J × PerfectMatching J,
        (matchingSignPolynomial p.1 * matchingSignPolynomial p.2) *
          (matchingMatrixMonomial A p.1 * matchingMatrixMonomial A p.2) := by
  exact NecSuf.AlgebraicEigenvalue.weightedSum_reindex_of_term_eq
    perfectMatchingPairEvenOrbitEquiv
    (fun s => Polynomial.C ((sign (fun x y : J => x < y) s.val : ℤ) : Qbar) *
      ∏ i : J, A i (s.val i))
    (fun p => (matchingSignPolynomial p.1 * matchingSignPolynomial p.2) *
      (matchingMatrixMonomial A p.1 * matchingMatrixMonomial A p.2))
    (matchingPair_even_term A hA)

end Ising2DLambda.AlgebraicEigenvalue
