import Ising2DLambda.AlgebraicEigenvalue.BlockDiagonalDeterminantZeroTerms
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockDiagonalZeroTerms

namespace Ising2DLambda.AlgebraicEigenvalue

theorem blockDiagonal_det_eq_sum_preserving_from_necSuf
    {J K : Type*} [Fintype J] [LinearOrder J] [DecidableEq K]
    (block : J → K) (B : Matrix J J (Polynomial Qbar))
    (hoff : ∀ i j, block i ≠ block j → B i j = 0) :
    Matrix.det B = ∑ σ ∈ blockPreservingPermutations block,
      Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i k : J => i < k) σ : ℤ) : Qbar) *
        ∏ i : J, B i (σ i) := by
  classical
  calc
    Matrix.det B = ∑ σ : Equiv.Perm J,
      Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i k : J => i < k) σ : ℤ) : Qbar) *
        ∏ i : J, B i (σ i) := qbarPolynomial_det_row_expansion B
    _ = ∑ σ ∈ blockPreservingPermutations block,
      Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i k : J => i < k) σ : ℤ) : Qbar) *
        ∏ i : J, B i (σ i) := by
      simpa only [blockPreservingPermutations] using
        NecSuf.AlgebraicEigenvalue.blockDiagonal_weighted_sum_filter block B hoff
          (fun σ => Polynomial.C
            ((NecSuf.AlgebraicEigenvalue.sign (fun i k : J => i < k) σ : ℤ) : Qbar))

end Ising2DLambda.AlgebraicEigenvalue
