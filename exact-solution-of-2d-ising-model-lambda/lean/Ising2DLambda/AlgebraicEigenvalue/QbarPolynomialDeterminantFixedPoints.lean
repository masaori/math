/-
零対角の多項式行列について、不動点を持つ置換の項を消す具体版。
有限積の四等号、符号付き項の二等号、有限和の五等号を独立に辿る。
反対称性と添字集合の非空性は使わない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFunctionExpansion

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 空添字集合では、唯一の空置換を含む。 -/
def fixedPointFreePermutations (J : Type*) [Fintype J] [DecidableEq J] :
    Finset (Equiv.Perm J) :=
  univ.filter (fun σ => ∀ i : J, σ i ≠ i)

theorem qbarPolynomial_signedPermutationTerm_eq_zero_of_fixed
    {J : Type*} [Fintype J] [LinearOrder J]
    (A : Matrix J J (Polynomial Qbar)) (hdiag : ∀ i : J, A i i = 0)
    (σ : Equiv.Perm J) (j : J) (hfixed : σ j = j) :
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
      (∏ i : J, A i (σ i)) = 0 := by
  classical
  let c : Polynomial Qbar :=
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  let R : Polynomial Qbar := ∏ i ∈ (univ : Finset J).erase j, A i (σ i)
  have hProduct : (∏ i : J, A i (σ i)) = 0 := by
    calc
      (∏ i : J, A i (σ i)) = A j (σ j) * R :=
        (Finset.mul_prod_erase univ (fun i => A i (σ i)) (mem_univ j)).symm
      _ = A j j * R := congrArg (fun k => A j k * R) hfixed
      _ = 0 * R := congrArg (· * R) (hdiag j)
      _ = 0 := zero_mul R
  calc
    c * (∏ i : J, A i (σ i)) = c * 0 := congrArg (c * ·) hProduct
    _ = 0 := mul_zero c

theorem qbarPolynomial_det_eq_sum_fixedPointFree
    {J : Type*} [Fintype J] [LinearOrder J]
    (A : Matrix J J (Polynomial Qbar)) (hdiag : ∀ i : J, A i i = 0) :
    Matrix.det A = ∑ σ ∈ fixedPointFreePermutations J,
      Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, A i (σ i) := by
  classical
  let c : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j : J => i < j) σ : ℤ) : Qbar)
  let excluded : Finset (Equiv.Perm J) :=
    univ.filter (fun σ => ¬ ∀ i : J, σ i ≠ i)
  have hExcluded : ∀ σ ∈ excluded, c σ * (∏ i : J, A i (σ i)) = 0 := by
    intro σ hσ
    have hNotAll : ¬ ∀ i : J, σ i ≠ i := (Finset.mem_filter.mp hσ).2
    obtain ⟨j, hj⟩ := not_forall.mp hNotAll
    exact qbarPolynomial_signedPermutationTerm_eq_zero_of_fixed A hdiag σ j (not_not.mp hj)
  calc
    Matrix.det A = ∑ σ : Equiv.Perm J, c σ * ∏ i : J, A i (σ i) :=
      qbarPolynomial_det_row_expansion A
    _ = (∑ σ ∈ fixedPointFreePermutations J, c σ * ∏ i : J, A i (σ i)) +
        ∑ σ ∈ excluded, c σ * ∏ i : J, A i (σ i) := by
      simpa only [fixedPointFreePermutations, excluded] using
        (Finset.sum_filter_add_sum_filter_not univ
        (fun σ : Equiv.Perm J => ∀ i : J, σ i ≠ i)
        (fun σ => c σ * ∏ i : J, A i (σ i))).symm
    _ = (∑ σ ∈ fixedPointFreePermutations J, c σ * ∏ i : J, A i (σ i)) +
        ∑ _σ ∈ excluded, (0 : Polynomial Qbar) := by
      apply congrArg (_ + ·)
      exact Finset.sum_congr rfl hExcluded
    _ = (∑ σ ∈ fixedPointFreePermutations J, c σ * ∏ i : J, A i (σ i)) + 0 :=
      congrArg (_ + ·) (Finset.sum_const_zero)
    _ = ∑ σ ∈ fixedPointFreePermutations J, c σ * ∏ i : J, A i (σ i) := add_zero _

end Ising2DLambda.AlgebraicEigenvalue
