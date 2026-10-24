import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialPfaffian
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFunctionExpansion
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.EmptyPfaffianDeterminant

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 空集合での一項のマッチング和と一項の置換和。 -/
theorem emptyPfaffianDeterminant
    (A : Matrix Empty Empty (Polynomial Qbar)) :
    qbarPolynomialPfaffian A = 1 ∧ Matrix.det A = 1 ∧
      qbarPolynomialPfaffian A ^ 2 = Matrix.det A := by
  classical
  have hmatch : ∀ D : PerfectMatching Empty, matchingSignPolynomial D = 1 := by
    intro D
    simp [matchingSignPolynomial, perfectMatchingSign_empty D]
  have hmonomial : ∀ D : PerfectMatching Empty, matchingMatrixMonomial A D = 1 := by
    intro D
    simp [matchingMatrixMonomial, matchingOrientedPairs]
  have hpf : qbarPolynomialPfaffian A = 1 := by
    simp [qbarPolynomialPfaffian, hmatch, hmonomial]
  have hdet : Matrix.det A = 1 := by
    calc
      Matrix.det A = ∑ σ : Equiv.Perm Empty,
          Polynomial.C ((sign (fun i j : Empty => i < j) σ : ℤ) : Qbar) *
            ∏ i : Empty, A i (σ i) := qbarPolynomial_det_row_expansion A
      _ = 1 := by simp [sign, inversionCount, orderedPairs]
  refine ⟨hpf, hdet, ?_⟩
  rw [hpf, hdet]
  norm_num

/-- 同じ空和・空積の論法を必要十分版から具体化する。 -/
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
              ∏ i : Empty, A i (σ i) := qbarPolynomial_det_row_expansion A
        _ = 1 := by simp [sign, inversionCount, orderedPairs])

end Ising2DLambda.AlgebraicEigenvalue
