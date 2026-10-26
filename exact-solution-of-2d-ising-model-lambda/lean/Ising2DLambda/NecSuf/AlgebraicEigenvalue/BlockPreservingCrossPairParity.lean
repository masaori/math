import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockPreservingCrossPairCount

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- A bijection preserving each fiber makes disagreement of a binary relation even. -/
theorem blockPreserving_crossPair_disagreement_even
    {J K : Type*} [Fintype J] [Fintype K] [DecidableEq J] [DecidableEq K]
    (block : J → K) (r : J → J → Prop) [DecidableRel r]
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) (k l : K) :
    Even (((univ : Finset ({j : J // block j = k} × {j : J // block j = l})).filter
      (fun p => decide (r p.1.val p.2.val) !=
        decide (r (σ.1 p.1.val) (σ.1 p.2.val)))).card) := by
  classical
  let pairs : Finset ({j : J // block j = k} × {j : J // block j = l}) := univ
  let before := pairs.filter (fun p => r p.1.val p.2.val)
  let after := pairs.filter (fun p => r (σ.1 p.1.val) (σ.1 p.2.val))
  have hcard : before.card = after.card :=
    (blockPreserving_crossPair_count block r σ k l).symm
  have hdiff : (before \ after).card = (after \ before).card :=
    Finset.card_sdiff_comm hcard
  have hdisj : Disjoint (before \ after) (after \ before) := by
    apply Finset.disjoint_left.mpr
    intro p hp hq
    exact (Finset.mem_sdiff.mp hp).2 (Finset.mem_sdiff.mp hq).1
  have hfilter :
      pairs.filter (fun p => decide (r p.1.val p.2.val) !=
        decide (r (σ.1 p.1.val) (σ.1 p.2.val))) =
        (before \ after) ∪ (after \ before) := by
    ext p
    simp only [before, after, pairs, mem_filter, mem_union, mem_sdiff, mem_univ,
      true_and]
    by_cases hp : r p.1.val p.2.val <;>
      by_cases hq : r (σ.1 p.1.val) (σ.1 p.2.val) <;> simp [hp, hq]
  rw [show (univ : Finset ({j : J // block j = k} × {j : J // block j = l})) = pairs from rfl]
  rw [hfilter, card_union_of_disjoint hdisj, ← hdiff]
  exact ⟨_, rfl⟩

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
