import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialPfaffian
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFunctionExpansion

namespace Ising2DLambda.AlgebraicEigenvalue

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
          Polynomial.C ((qbarPermutationSign σ : ℤ) : Qbar) *
            ∏ i : Empty, A i (σ i) := by
              simp [Matrix.det_apply, qbarPermutationSign]
      _ = 1 := by
        simp [qbarPermutationSign]
  refine ⟨hpf, hdet, ?_⟩
  rw [hpf, hdet]
  norm_num

end Ising2DLambda.AlgebraicEigenvalue
