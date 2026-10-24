import Mathlib.Data.Fintype.BigOperators

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open scoped Classical

variable {J R : Type*} [Fintype J] [CommMonoid R]

/-- 有限積を二色へ分けるのに要るのは、各点での後続先の二場合だけである。 -/
theorem matchingPairEntryProduct_necSuf (C : Set J) (σ τ υ : J → J)
    (A : J → J → R) (hσ : ∀ i, σ i = if i ∈ C then τ i else υ i) :
    (∏ i : J, A i (σ i)) =
      (∏ i ∈ Finset.univ.filter (· ∈ C), A i (τ i)) *
        (∏ i ∈ Finset.univ.filter (· ∉ C), A i (υ i)) := by
  classical
  calc
    (∏ i : J, A i (σ i)) =
        (∏ i ∈ Finset.univ.filter (· ∈ C), A i (σ i)) *
          (∏ i ∈ Finset.univ.filter (· ∉ C), A i (σ i)) :=
      (Finset.prod_filter_mul_prod_filter_not Finset.univ (· ∈ C) (fun i => A i (σ i))).symm
    _ = (∏ i ∈ Finset.univ.filter (· ∈ C), A i (τ i)) *
          (∏ i ∈ Finset.univ.filter (· ∉ C), A i (υ i)) := by
      congr 1
      · apply Finset.prod_congr rfl
        intro i hi
        have hC : i ∈ C := (Finset.mem_filter.mp hi).2
        rw [hσ i, if_pos hC]
      · apply Finset.prod_congr rfl
        intro i hi
        have hC : i ∉ C := (Finset.mem_filter.mp hi).2
        rw [hσ i, if_neg hC]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
