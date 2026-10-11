/-
重み付き有限和の自己積の必要十分版へ、マッチングの符号と行列成分の積を供給する。
多項式の零・加法・乗法の法則で仮定を満たし、平方展開の具体版は使わない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialPfaffian
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.WeightedSumSquare

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- Pfaffian の定義と平方の定義を、重み付き有限和の必要十分版へ接続する。 -/
theorem qbarPolynomialPfaffian_sq_eq_sum_matching_pairs_from_necSuf
    {J : Type*} [Fintype J] [LinearOrder J]
    (A : Matrix J J (Polynomial Qbar)) (_hA : IsZeroDiagonalSkewQbarPolynomialMatrix A) :
    qbarPolynomialPfaffian A ^ 2 =
      ∑ p : PerfectMatching J × PerfectMatching J,
        (matchingSignPolynomial p.1 * matchingSignPolynomial p.2) *
          (matchingMatrixMonomial A p.1 * matchingMatrixMonomial A p.2) := by
  classical
  let c := fun D : PerfectMatching J => matchingSignPolynomial D
  let b := fun D : PerfectMatching J => matchingMatrixMonomial A D
  calc
    qbarPolynomialPfaffian A ^ 2 = qbarPolynomialPfaffian A * qbarPolynomialPfaffian A :=
      pow_two _
    _ = (∑ D : PerfectMatching J, c D * b D) * (∑ E : PerfectMatching J, c E * b E) := rfl
    _ = ∑ p : PerfectMatching J × PerfectMatching J, (c p.1 * c p.2) * (b p.1 * b p.2) :=
      NecSuf.AlgebraicEigenvalue.weightedSum_mul_self_necSuf c b
        (zero_mul _) (fun u v => add_mul u v _)
        (fun D => mul_zero (c D * b D)) (fun D u v => mul_add (c D * b D) u v)
        (fun D E => mul_comm (b D) (c E))

end Ising2DLambda.AlgebraicEigenvalue
