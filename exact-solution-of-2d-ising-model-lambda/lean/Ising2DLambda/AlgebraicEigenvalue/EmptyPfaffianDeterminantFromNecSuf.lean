import Ising2DLambda.AlgebraicEigenvalue.EmptyPfaffianDeterminant
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.EmptyPfaffianDeterminant
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFunctionExpansionFromNecSuf

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 空和・空積の具体版が必要十分版からも得られる。 -/
theorem emptyPfaffianDeterminant_from_necSuf
    (A : Matrix Empty Empty (Polynomial Qbar)) :
    qbarPolynomialPfaffian A = 1 ∧ Matrix.det A = 1 ∧
      qbarPolynomialPfaffian A ^ 2 = Matrix.det A := by
  exact emptyWeightedPfaffianDeterminant A
    (fun D => matchingSignPolynomial D)
    (fun D => matchingMatrixMonomial A D)
    (fun D => by simp [matchingSignPolynomial, perfectMatchingSign_empty D])
    (fun D => by simp [matchingMatrixMonomial, matchingOrientedPairs])
    (by
      calc
        Matrix.det A = ∑ σ : Equiv.Perm Empty,
            Polynomial.C ((sign (fun i j : Empty => i < j) σ : ℤ) : Qbar) *
              ∏ i : Empty, A i (σ i) := qbarPolynomial_det_row_expansion_from_necSuf A
        _ = 1 := by
          simp [NecSuf.AlgebraicEigenvalue.sign,
            NecSuf.AlgebraicEigenvalue.inversionCount,
            NecSuf.AlgebraicEigenvalue.orderedPairs])

end Ising2DLambda.AlgebraicEigenvalue
