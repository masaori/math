import Ising2DLambda.AlgebraicEigenvalue.BlockAcrossFiberPairCorrespondence
import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingCrossPairParity

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j})

/-- Disagreements between two fibers are counted equally with or without subtype indices. -/
private theorem fiberPairDisagreements_card_eq_subtype (k l : K) :
    (blockFiberPairDisagreements block σ k l).card =
      ((univ : Finset ({j : J // block j = k} × {j : J // block j = l})).filter
        (fun p => (p.1.val < p.2.val) !=
          (σ.1 p.1.val < σ.1 p.2.val))).card := by
  classical
  apply Finset.card_bij'
    (fun p hp =>
      (⟨p.1, (mem_filter.mp hp).2.1⟩, ⟨p.2, (mem_filter.mp hp).2.2.1⟩))
    (fun p _ => (p.1.val, p.2.val))
  · intro p hp
    rfl
  · intro p hp
    rfl
  · intro p hp
    simpa only [mem_filter, mem_univ, true_and] using (mem_filter.mp hp).2.2.2
  · intro p hp
    simp only [blockFiberPairDisagreements, mem_filter, mem_univ, true_and]
    exact ⟨p.1.property, p.2.property, (mem_filter.mp hp).2⟩

/-- Cross-fiber inversions are an even sum of pairwise disagreements. -/
theorem blockAcrossFiberInversions_card_even :
    Even (blockAcrossFiberInversions block σ).card := by
  classical
  rw [blockAcrossFiberInversions_card_pair_sum]
  apply Finset.even_sum
  intro kl hkl
  have hlt : kl.1 < kl.2 := (mem_filter.mp hkl).2
  rw [blockAcrossFiberPairInversions_card_eq_disagreements block σ kl.1 kl.2 hlt,
    fiberPairDisagreements_card_eq_subtype]
  exact blockPreserving_crossPair_order_disagreement_even block σ kl.1 kl.2

end Ising2DLambda.AlgebraicEigenvalue
