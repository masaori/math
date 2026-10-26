import Ising2DLambda.AlgebraicEigenvalue.BlockWithinFiberInversions

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- The integer sign defined by inversion pairs of a block-preserving permutation. -/
def blockPermutationSign {J K : Type*} [Fintype J] [LinearOrder J]
    [Fintype K] [DecidableEq K] (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) : ℤ :=
  (-1) ^ blockInversionCount block σ

/-- The integer sign defined by inversion pairs inside a single fiber. -/
noncomputable def fiberPermutationSign {J K : Type*} [Fintype J] [LinearOrder J]
    [Fintype K] [DecidableEq K] (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) (k : K) : ℤ :=
  (-1) ^ (fiberInversionPairs block σ k).card

/-- Once cross-fiber inversions are even, the inversion decomposition gives the product of signs. -/
theorem blockPreserving_sign_eq_prod_of_even_cross_count
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [DecidableEq K]
    (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j})
    (hcross : Even (blockAcrossFiberInversions block σ).card) :
    blockPermutationSign block σ = ∏ k : K, fiberPermutationSign block σ k := by
  classical
  obtain ⟨m, hm⟩ := hcross
  have hcross_count : (blockAcrossFiberInversions block σ).card = 2 * m := by omega
  have htotal : blockInversionCount block σ =
      (∑ k : K, (fiberInversionPairs block σ k).card) + 2 * m := by
    rw [blockPreserving_inversionCount_fiber_decomposition, hcross_count]
    congr 1
    apply Finset.sum_congr rfl
    intro k _
    exact blockWithinFiberInversions_card_eq_restriction block σ k
  calc
    blockPermutationSign block σ
        = (-1 : ℤ) ^ blockInversionCount block σ := rfl
    _ = (-1 : ℤ) ^ ((∑ k : K, (fiberInversionPairs block σ k).card) + 2 * m) := by
        rw [htotal]
    _ = (-1 : ℤ) ^ (∑ k : K, (fiberInversionPairs block σ k).card) *
          (-1 : ℤ) ^ (2 * m) := pow_add _ _ _
    _ = (-1 : ℤ) ^ (∑ k : K, (fiberInversionPairs block σ k).card) := by
        simp [pow_mul]
    _ = ∏ k : K, (-1 : ℤ) ^ (fiberInversionPairs block σ k).card := by
        rw [Finset.prod_pow_eq_pow_sum]
    _ = ∏ k : K, fiberPermutationSign block σ k := rfl

end Ising2DLambda.AlgebraicEigenvalue
