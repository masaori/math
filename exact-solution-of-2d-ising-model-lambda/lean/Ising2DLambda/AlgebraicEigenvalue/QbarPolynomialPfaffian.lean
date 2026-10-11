/-
零対角反対称な代数的数係数多項式行列の Pfaffian の定義と平方展開。
符号付き完全マッチング和を定義し、その平方を本文と同じ十等号で二重和へ展開する。
住処は Polynomial Qbar。必要十分版や行列式との一致は使わない。
-/
import Ising2DLambda.AlgebraicEigenvalue.PerfectMatchingSign
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Mathlib.Algebra.Polynomial.Basic
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Powerset
import Mathlib.LinearAlgebra.Matrix.Defs

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 完全マッチングは有限集合の冪集合の冪集合の部分型なので有限である。 -/
noncomputable instance perfectMatchingFintype (J : Type*) [Fintype J] :
    Fintype (PerfectMatching J) := by
  classical
  unfold PerfectMatching
  exact Fintype.ofFinite _

/-- 零対角と反対称性を別々の等式で要求する。 -/
def IsZeroDiagonalSkewQbarPolynomialMatrix {J : Type*}
    (A : Matrix J J (Polynomial Qbar)) : Prop :=
  (∀ i : J, A i i = 0) ∧ ∀ i j : J, A j i = -A i j

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- マッチングの整数符号を代数的数係数の定数多項式へ写す。 -/
noncomputable def matchingSignPolynomial (D : PerfectMatching J) : Polynomial Qbar :=
  Polynomial.C ((perfectMatchingSign D : ℤ) : Qbar)

/-- 各対を昇順に向けた行列成分の積。空のマッチングでは空積になる。 -/
noncomputable def matchingMatrixMonomial
    (A : Matrix J J (Polynomial Qbar)) (D : PerfectMatching J) : Polynomial Qbar :=
  ∏ p ∈ matchingOrientedPairs D, A p.1 p.2

/-- 完全マッチング全体にわたる符号付き有限和。 -/
noncomputable def qbarPolynomialPfaffian (A : Matrix J J (Polynomial Qbar)) :
    Polynomial Qbar :=
  ∑ D : PerfectMatching J, matchingSignPolynomial D * matchingMatrixMonomial A D

/-- 本文の十等号。零対角反対称性は Pfaffian の対象を定める仮定であり、
この平方展開は有限和と乗法の法則だけを使う。空添字も除外しない。 -/
theorem qbarPolynomialPfaffian_sq_eq_sum_matching_pairs
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
    _ = ∑ D : PerfectMatching J, (c D * b D) * (∑ E : PerfectMatching J, c E * b E) :=
      Finset.sum_mul _ _ _
    _ = ∑ D : PerfectMatching J, ∑ E : PerfectMatching J, (c D * b D) * (c E * b E) := by
      exact Finset.sum_congr rfl (fun D _ => Finset.mul_sum _ _ _)
    _ = ∑ D : PerfectMatching J, ∑ E : PerfectMatching J, ((c D * b D) * c E) * b E := by
      exact Finset.sum_congr rfl (fun D _ => Finset.sum_congr rfl (fun E _ =>
        (mul_assoc (c D * b D) (c E) (b E)).symm))
    _ = ∑ D : PerfectMatching J, ∑ E : PerfectMatching J, (c D * (b D * c E)) * b E := by
      exact Finset.sum_congr rfl (fun D _ => Finset.sum_congr rfl (fun E _ =>
        congrArg (· * b E) (mul_assoc (c D) (b D) (c E))))
    _ = ∑ D : PerfectMatching J, ∑ E : PerfectMatching J, (c D * (c E * b D)) * b E := by
      exact Finset.sum_congr rfl (fun D _ => Finset.sum_congr rfl (fun E _ =>
        congrArg (fun z => (c D * z) * b E) (mul_comm (b D) (c E))))
    _ = ∑ D : PerfectMatching J, ∑ E : PerfectMatching J, ((c D * c E) * b D) * b E := by
      exact Finset.sum_congr rfl (fun D _ => Finset.sum_congr rfl (fun E _ =>
        congrArg (· * b E) (mul_assoc (c D) (c E) (b D)).symm))
    _ = ∑ D : PerfectMatching J, ∑ E : PerfectMatching J, (c D * c E) * (b D * b E) := by
      exact Finset.sum_congr rfl (fun D _ => Finset.sum_congr rfl (fun E _ =>
        mul_assoc (c D * c E) (b D) (b E)))
    _ = ∑ p : PerfectMatching J × PerfectMatching J, (c p.1 * c p.2) * (b p.1 * b p.2) :=
      (Fintype.sum_prod_type (fun p : PerfectMatching J × PerfectMatching J =>
        (c p.1 * c p.2) * (b p.1 * b p.2))).symm

end Ising2DLambda.AlgebraicEigenvalue
