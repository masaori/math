import Ising2DLambda.AlgebraicEigenvalue.PfaffianDeterminant
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFixedPointsFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PfaffianDeterminant

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 必要十分版の有限和合成を、具体的な置換とマッチング対へ適用する。 -/
theorem qbarPolynomialPfaffian_sq_eq_det_from_necSuf
    (A : Matrix J J (Polynomial Qbar))
    (hA : IsZeroDiagonalSkewQbarPolynomialMatrix A) :
    qbarPolynomialPfaffian A ^ 2 = Matrix.det A := by
  classical
  have hpartition := derangement_partition A
  have hcancel := oddOrbit_signed_sum_zero A hA.2
  have hsplit := NecSuf.AlgebraicEigenvalue.sum_split_cancel
    _ _ _ hpartition hcancel
  apply Eq.symm
  calc
    Matrix.det A = ∑ σ ∈ fixedPointFreePermutations J,
      Polynomial.C ((qbarPermutationSign σ : ℤ) : Qbar) *
        ∏ i : J, A i (σ i) := qbarPolynomial_det_eq_sum_fixedPointFree A hA.1
    _ = ∑ σ ∈ fixedPointFreePermutations J,
      Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, A i (σ i) := qbarPolynomial_fixedPointFree_sum_sign_from_necSuf A
    _ = ∑ σ : EvenOrbitPermutation J,
      Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
        ∏ i : J, A i (σ.val i) := hsplit
    _ = ∑ p : PerfectMatching J × PerfectMatching J,
        (matchingSignPolynomial p.1 * matchingSignPolynomial p.2) *
          (matchingMatrixMonomial A p.1 * matchingMatrixMonomial A p.2) := matchingPair_even_sum A hA
    _ = qbarPolynomialPfaffian A ^ 2 :=
      (qbarPolynomialPfaffian_sq_eq_sum_matching_pairs A hA).symm

end Ising2DLambda.AlgebraicEigenvalue
