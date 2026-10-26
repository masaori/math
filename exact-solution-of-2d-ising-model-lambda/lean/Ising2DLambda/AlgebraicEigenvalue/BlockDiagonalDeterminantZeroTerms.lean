import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFunctionExpansion

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

def blockPreservingPermutations {J K : Type*} [Fintype J] [DecidableEq J]
    (block : J → K) [DecidableEq K] : Finset (Equiv.Perm J) :=
  univ.filter (fun σ => ∀ j, block (σ j) = block j)

theorem blockDiagonal_signedPermutationTerm_eq_zero
    {J K : Type*} [Fintype J] [LinearOrder J] [DecidableEq K]
    (block : J → K) (B : Matrix J J (Polynomial Qbar))
    (hoff : ∀ i j, block i ≠ block j → B i j = 0)
    (σ : Equiv.Perm J) (j : J) (hj : block (σ j) ≠ block j) :
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i k : J => i < k) σ : ℤ) : Qbar) *
      (∏ i : J, B i (σ i)) = 0 := by
  classical
  have hfactor : B j (σ j) = 0 := hoff j (σ j) (Ne.symm hj)
  have hproduct : (∏ i : J, B i (σ i)) = 0 := by
    calc
      (∏ i : J, B i (σ i)) = B j (σ j) * ∏ i ∈ (univ : Finset J).erase j, B i (σ i) :=
        (Finset.mul_prod_erase univ (fun i => B i (σ i)) (mem_univ j)).symm
      _ = 0 * ∏ i ∈ (univ : Finset J).erase j, B i (σ i) :=
        congrArg (· * ∏ i ∈ (univ : Finset J).erase j, B i (σ i)) hfactor
      _ = 0 := zero_mul _
  rw [hproduct, mul_zero]

theorem blockDiagonal_det_eq_sum_preserving
    {J K : Type*} [Fintype J] [LinearOrder J] [DecidableEq K]
    (block : J → K) (B : Matrix J J (Polynomial Qbar))
    (hoff : ∀ i j, block i ≠ block j → B i j = 0) :
    Matrix.det B = ∑ σ ∈ blockPreservingPermutations block,
      Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i k : J => i < k) σ : ℤ) : Qbar) *
        ∏ i : J, B i (σ i) := by
  classical
  let term : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i k : J => i < k) σ : ℤ) : Qbar) *
      ∏ i : J, B i (σ i)
  have hzero : ∀ σ ∈ (univ : Finset (Equiv.Perm J)),
      ¬ (∀ j, block (σ j) = block j) → term σ = 0 := by
    intro σ _ hσ
    obtain ⟨j, hj⟩ := not_forall.mp hσ
    exact blockDiagonal_signedPermutationTerm_eq_zero block B hoff σ j hj
  calc
    Matrix.det B = ∑ σ : Equiv.Perm J, term σ := qbarPolynomial_det_row_expansion B
    _ = ∑ σ ∈ blockPreservingPermutations block, term σ := by
      simpa only [blockPreservingPermutations] using
        (Finset.sum_filter_of_ne (s := (univ : Finset (Equiv.Perm J)))
          (p := fun σ => ∀ j, block (σ j) = block j) (f := term)
          (by intro σ hmem hne
              by_contra hnot
              exact hne (hzero σ hmem hnot))).symm

end Ising2DLambda.AlgebraicEigenvalue
