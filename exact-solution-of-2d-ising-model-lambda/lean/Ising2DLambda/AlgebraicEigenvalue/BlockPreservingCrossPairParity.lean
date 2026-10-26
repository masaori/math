import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingCrossPairCount

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- The cross-fiber pairs whose order changes occur in two equally large classes. -/
theorem blockPreserving_crossPair_order_disagreement_even
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [DecidableEq K]
    (block : J → K) (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j})
    (k l : K) :
    Even (((univ : Finset ({j : J // block j = k} × {j : J // block j = l})).filter
      (fun p => (p.1.val < p.2.val) != (σ.1 p.1.val < σ.1 p.2.val))).card) := by
  classical
  let pairs : Finset ({j : J // block j = k} × {j : J // block j = l}) := univ
  let before := pairs.filter (fun p => p.1.val < p.2.val)
  let after := pairs.filter (fun p => σ.1 p.1.val < σ.1 p.2.val)
  have hcard : before.card = after.card :=
    (blockPreserving_crossPair_order_count block σ k l).symm
  have hdiff : (before \ after).card = (after \ before).card :=
    Finset.card_sdiff_comm hcard
  have hdisj : Disjoint (before \ after) (after \ before) := by
    apply Finset.disjoint_left.mpr
    intro p hp hq
    exact (Finset.mem_sdiff.mp hp).2 (Finset.mem_sdiff.mp hq).1
  have hfilter :
      pairs.filter (fun p => (p.1.val < p.2.val) !=
        (σ.1 p.1.val < σ.1 p.2.val)) = (before \ after) ∪ (after \ before) := by
    ext p
    simp only [before, after, pairs, mem_filter, mem_union, mem_sdiff, mem_univ,
      true_and]
    by_cases hp : p.1.val < p.2.val <;>
      by_cases hq : σ.1 p.1.val < σ.1 p.2.val <;> simp [hp, hq]
  rw [show (univ : Finset ({j : J // block j = k} × {j : J // block j = l})) = pairs from rfl]
  rw [hfilter, card_union_of_disjoint hdisj, ← hdiff]
  exact ⟨_, rfl⟩

end Ising2DLambda.AlgebraicEigenvalue
