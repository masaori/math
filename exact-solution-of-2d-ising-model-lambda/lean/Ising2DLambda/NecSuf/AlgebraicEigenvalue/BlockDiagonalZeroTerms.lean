import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

theorem blockDiagonal_product_zero
    {J K R : Type*} [Fintype J] [DecidableEq J] [DecidableEq K]
    [CommMonoidWithZero R] (block : J → K) (entry : J → J → R)
    (hoff : ∀ i j, block i ≠ block j → entry i j = 0)
    (σ : Equiv.Perm J) (j : J) (hj : block (σ j) ≠ block j) :
    (∏ i : J, entry i (σ i)) = 0 := by
  classical
  have hfactor : entry j (σ j) = 0 := hoff j (σ j) (Ne.symm hj)
  calc
    (∏ i : J, entry i (σ i)) = entry j (σ j) * ∏ i ∈ (univ : Finset J).erase j, entry i (σ i) :=
      (Finset.mul_prod_erase univ (fun i => entry i (σ i)) (mem_univ j)).symm
    _ = 0 * ∏ i ∈ (univ : Finset J).erase j, entry i (σ i) :=
      congrArg (· * ∏ i ∈ (univ : Finset J).erase j, entry i (σ i)) hfactor
    _ = 0 := zero_mul _

theorem blockDiagonal_weighted_sum_filter
    {J K R : Type*} [Fintype J] [DecidableEq J] [DecidableEq K]
    [CommSemiring R] (block : J → K) (entry : J → J → R)
    (hoff : ∀ i j, block i ≠ block j → entry i j = 0)
    (weight : Equiv.Perm J → R) :
    (∑ σ : Equiv.Perm J, weight σ * ∏ i : J, entry i (σ i)) =
      ∑ σ ∈ (univ.filter (fun σ : Equiv.Perm J => ∀ j, block (σ j) = block j)),
        weight σ * ∏ i : J, entry i (σ i) := by
  classical
  let term : Equiv.Perm J → R := fun σ => weight σ * ∏ i : J, entry i (σ i)
  have hzero : ∀ σ ∈ (univ : Finset (Equiv.Perm J)),
      ¬ (∀ j, block (σ j) = block j) → term σ = 0 := by
    intro σ _ hσ
    obtain ⟨j, hj⟩ := not_forall.mp hσ
    change weight σ * (∏ i : J, entry i (σ i)) = 0
    rw [blockDiagonal_product_zero block entry hoff σ j hj, mul_zero]
  exact (Finset.sum_filter_of_ne (s := (univ : Finset (Equiv.Perm J)))
    (p := fun σ => ∀ j, block (σ j) = block j) (f := term)
    (by intro σ hmem hne
        by_contra hnot
        exact hne (hzero σ hmem hnot))).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
