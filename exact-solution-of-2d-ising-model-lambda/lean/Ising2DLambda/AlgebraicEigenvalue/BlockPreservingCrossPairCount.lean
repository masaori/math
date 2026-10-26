import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingPermutationBijection

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- The two fiber permutations reindex the pairs counted in the first line of
`claim_block_preserving_permutation_sign`. -/
theorem blockPreserving_crossPair_order_count
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [DecidableEq K]
    (block : J → K) (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j})
    (k l : K) :
    ((univ : Finset ({j : J // block j = k} × {j : J // block j = l})).filter
      (fun p => σ.1 p.1.val < σ.1 p.2.val)).card =
    ((univ : Finset ({j : J // block j = k} × {j : J // block j = l})).filter
      (fun p => p.1.val < p.2.val)).card := by
  classical
  let e : ({j : J // block j = k} × {j : J // block j = l}) ≃
      ({j : J // block j = k} × {j : J // block j = l}) :=
    Equiv.prodCongr (blockRestriction block σ k) (blockRestriction block σ l)
  apply Finset.card_bijective e e.bijective
  intro p
  simp only [mem_filter, mem_univ, true_and]
  rfl

end Ising2DLambda.AlgebraicEigenvalue
