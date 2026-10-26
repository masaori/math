import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingInversionDecomposition

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j})

def blockAcrossFiberPairInversions (k l : K) : Finset (J × J) :=
  (blockAcrossFiberInversions block σ).filter (fun p =>
    (block p.1 = k ∧ block p.2 = l) ∨ (block p.1 = l ∧ block p.2 = k))

/-- Every cross-fiber inversion belongs to exactly one increasing pair of fibers. -/
theorem blockAcrossFiberInversions_card_pair_sum :
    (blockAcrossFiberInversions block σ).card =
      ∑ kl ∈ (univ : Finset (K × K)).filter (fun kl => kl.1 < kl.2),
        (blockAcrossFiberPairInversions block σ kl.1 kl.2).card := by
  classical
  let s := blockAcrossFiberInversions block σ
  let f : J × J → K × K := fun p =>
    if block p.1 < block p.2 then (block p.1, block p.2)
    else (block p.2, block p.1)
  have hf : ∀ p ∈ s, f p ∈ (univ : Finset (K × K)).filter (fun kl => kl.1 < kl.2) := by
    intro p hp
    have hne : block p.1 ≠ block p.2 := (mem_filter.mp hp).2
    simp only [mem_filter, mem_univ, true_and]
    by_cases h : block p.1 < block p.2
    · simp [f, h]
    · have h' : block p.2 < block p.1 := lt_of_le_of_ne (le_of_not_gt h) (Ne.symm hne)
      simp [f, h, h']
  have hsum := Finset.card_eq_sum_card_fiberwise (s := s)
    (t := (univ : Finset (K × K)).filter (fun kl => kl.1 < kl.2)) (f := f) hf
  apply hsum.trans
  apply Finset.sum_congr rfl
  intro kl hkl
  congr 1
  ext p
  have hlt : kl.1 < kl.2 := (mem_filter.mp hkl).2
  simp only [blockAcrossFiberPairInversions, mem_filter]
  constructor
  · intro hp
    refine ⟨hp.1, ?_⟩
    dsimp [f] at hp
    split at hp
    · left; exact Prod.mk.inj hp.2
    · obtain ⟨ha, hb⟩ := Prod.mk.inj hp.2
      right; exact ⟨hb, ha⟩
  · intro hp
    refine ⟨hp.1, ?_⟩
    rcases hp.2 with h | h
    · have horder : block p.1 < block p.2 := h.1.symm ▸ h.2.symm ▸ hlt
      simp only [f, if_pos horder]
      exact Prod.ext h.1 h.2
    · have horder : ¬ block p.1 < block p.2 := by
        rw [h.1, h.2]
        exact not_lt_of_ge (le_of_lt hlt)
      simp only [f, if_neg horder]
      exact Prod.ext h.2 h.1

end Ising2DLambda.AlgebraicEigenvalue
