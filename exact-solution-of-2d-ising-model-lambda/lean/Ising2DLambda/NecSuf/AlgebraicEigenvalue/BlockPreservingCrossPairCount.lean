import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockPreservingPermutationBijection

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- Reindexing ordered pairs requires only a decidable relation, not order axioms. -/
theorem blockPreserving_crossPair_count
    {J K : Type*} [Fintype J] [Fintype K] [DecidableEq J] [DecidableEq K]
    (block : J → K) (r : J → J → Prop) [DecidableRel r]
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) (k l : K) :
    ((univ : Finset ({j : J // block j = k} × {j : J // block j = l})).filter
      (fun p => r (σ.1 p.1.val) (σ.1 p.2.val))).card =
    ((univ : Finset ({j : J // block j = k} × {j : J // block j = l})).filter
      (fun p => r p.1.val p.2.val)).card := by
  classical
  let e : ({j : J // block j = k} × {j : J // block j = l}) ≃
      ({j : J // block j = k} × {j : J // block j = l}) :=
    Equiv.prodCongr (blockRestriction block σ k) (blockRestriction block σ l)
  apply Finset.card_bijective e e.bijective
  intro p
  simp only [mem_filter, mem_univ, true_and]
  rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
