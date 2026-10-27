import Ising2DLambda.AlgebraicEigenvalue.BlockDiagonalTermFactorization
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialProductSum

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue
  (FamilyOn insertFamilyEquiv prod_attach_insertFamily familyOnUnivEquiv)

/-- The finite distributive law for polynomial weights on dependent finite fibers.
    This repeats the insertion proof used for the polynomial product-of-sums claim. -/
private theorem polynomial_prod_sum_fibers
    {K : Type*} [Fintype K] [DecidableEq K]
    {P : K → Type*} [∀ k, Fintype (P k)]
    (g : (k : K) → P k → Polynomial Qbar) :
    (∏ k : K, ∑ p : P k, g k p) =
      ∑ parts : (∀ k, P k), ∏ k : K, g k (parts k) := by
  classical
  have hind : ∀ S : Finset K,
      (∏ k ∈ S, ∑ p : P k, g k p) =
        ∑ parts : FamilyOn P S, ∏ k ∈ S.attach, g k.1 (parts k.1 k.2) := by
    intro S
    induction S using Finset.induction_on with
    | empty => simp
    | insert k S hk ih =>
        let W : FamilyOn P S → Polynomial Qbar :=
          fun parts => ∏ i ∈ S.attach, g i.1 (parts i.1 i.2)
        let V : FamilyOn P (insert k S) → Polynomial Qbar :=
          fun parts => ∏ i ∈ (insert k S).attach, g i.1 (parts i.1 i.2)
        calc
          (∏ i ∈ insert k S, ∑ p : P i, g i p) =
              (∑ p : P k, g k p) * ∏ i ∈ S, ∑ p : P i, g i p :=
            Finset.prod_insert hk
          _ = (∑ p : P k, g k p) * ∑ parts : FamilyOn P S, W parts :=
            congrArg ((∑ p : P k, g k p) * ·) ih
          _ = ∑ p : P k, g k p * (∑ parts : FamilyOn P S, W parts) :=
            Finset.sum_mul _ _ _
          _ = ∑ p : P k, ∑ parts : FamilyOn P S, g k p * W parts := by
            refine Finset.sum_congr rfl ?_
            intro p _
            exact Finset.mul_sum _ _ _
          _ = ∑ pair : P k × FamilyOn P S, g k pair.1 * W pair.2 := by
            rw [Fintype.sum_prod_type]
          _ = ∑ pair : P k × FamilyOn P S,
              V (insertFamilyEquiv (B := P) hk pair) := by
            refine Finset.sum_congr rfl ?_
            intro pair _
            exact (prod_attach_insertFamily hk g pair.1 pair.2).symm
          _ = ∑ parts : FamilyOn P (insert k S), V parts :=
            Equiv.sum_comp (insertFamilyEquiv (B := P) hk) V
  calc
    (∏ k : K, ∑ p : P k, g k p) =
        ∑ parts : FamilyOn P (univ : Finset K),
          ∏ k ∈ (univ : Finset K).attach, g k.1 (parts k.1 k.2) :=
      hind univ
    _ = ∑ parts : (∀ k, P k),
        ∏ k ∈ (univ : Finset K).attach, g k.1 (parts k.1) :=
      Equiv.sum_comp (familyOnUnivEquiv P)
        (fun parts => ∏ k ∈ (univ : Finset K).attach, g k.1 (parts k.1))
    _ = ∑ parts : (∀ k, P k), ∏ k : K, g k (parts k) := by
      refine Finset.sum_congr rfl ?_
      intro parts _
      exact Finset.prod_attach (univ : Finset K) (fun k => g k (parts k))

/-- A block diagonal polynomial matrix has the product of the determinants
    of its restrictions to all fibers, including empty fibers. -/
theorem blockDiagonal_det_eq_prod_fiber_dets
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    (block : J → K) (B : Matrix J J (Polynomial Qbar))
    (hoff : ∀ i j, block i ≠ block j → B i j = 0) :
    Matrix.det B = ∏ k : K,
      Matrix.det (fun i j : {v : J // block v = k} => B i.1 j.1) := by
  classical
  let weight (k : K) (τ : Equiv.Perm {v : J // block v = k}) : Polynomial Qbar :=
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign
      (fun i j : {v : J // block v = k} => i < j) τ : ℤ) : Qbar) *
      ∏ i : {v : J // block v = k}, B i.1 (τ i).1
  calc
    Matrix.det B =
        ∑ parts : (∀ k : K, Equiv.Perm {v : J // block v = k}),
          Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign
            (fun i j : J => i < j)
            ((blockPreservingPermutationEquiv block).symm parts).1 : ℤ) : Qbar) *
            ∏ i : J, B i (((blockPreservingPermutationEquiv block).symm parts).1 i) :=
      blockDiagonal_det_eq_sum_fiber_permutation_families block B hoff
    _ = ∑ parts : (∀ k : K, Equiv.Perm {v : J // block v = k}),
          ∏ k : K, weight k (parts k) := by
      refine Finset.sum_congr rfl ?_
      intro parts _
      exact blockDiagonal_term_eq_prod_fiber_terms block B parts
    _ = ∏ k : K, ∑ τ : Equiv.Perm {v : J // block v = k}, weight k τ :=
      (polynomial_prod_sum_fibers weight).symm
    _ = ∏ k : K, Matrix.det (fun i j : {v : J // block v = k} => B i.1 j.1) := by
      refine Finset.prod_congr rfl ?_
      intro k _
      exact (qbarPolynomial_det_row_expansion
        (fun i j : {v : J // block v = k} => B i.1 j.1)).symm

end Ising2DLambda.AlgebraicEigenvalue
