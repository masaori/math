import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockAcrossFiberPairPartition

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    (block : J → K)
    (σ : Equiv.Perm J)

def blockFiberPairDisagreements (k l : K) : Finset (J × J) :=
  (univ : Finset (J × J)).filter fun p =>
    block p.1 = k ∧ block p.2 = l ∧
      ((p.1 < p.2) != (σ p.1 < σ p.2))

/-- An inversion between two fibers corresponds to the same unordered pair
    written with its first point in the first fiber. -/
theorem blockAcrossFiberPairInversions_card_eq_disagreements
    (k l : K) (hkl : k < l) :
    (blockAcrossFiberPairInversions block (· < ·) σ k l).card =
      (blockFiberPairDisagreements block σ k l).card := by
  classical
  let s := blockAcrossFiberPairInversions block (· < ·) σ k l
  let t := blockFiberPairDisagreements block σ k l
  let orient : J × J → J × J := fun p =>
    if block p.1 = k then p else (p.2, p.1)
  let sort : J × J → J × J := fun p =>
    if p.1 < p.2 then p else (p.2, p.1)
  have hsource : ∀ p ∈ s, p.1 < p.2 ∧ σ p.2 < σ p.1 ∧
      ((block p.1 = k ∧ block p.2 = l) ∨
       (block p.1 = l ∧ block p.2 = k)) := by
    intro p hp
    simp only [s, blockAcrossFiberPairInversions, mem_filter,
      blockAcrossFiberInversions, blockInversionPairs, mem_orderedPairs, mem_univ,
      true_and] at hp
    exact ⟨hp.1.1.1, hp.1.1.2, hp.2⟩
  have htarget : ∀ p ∈ t, block p.1 = k ∧ block p.2 = l ∧
      ((p.1 < p.2) != (σ p.1 < σ p.2)) := by
    intro p hp
    simpa only [t, blockFiberPairDisagreements, mem_filter, mem_univ,
      true_and] using hp
  have hi : ∀ p ∈ s, orient p ∈ t := by
    intro p hp
    obtain ⟨hbefore, hafter, hblocks⟩ := hsource p hp
    rcases hblocks with ⟨hk, hl⟩ | ⟨hl, hk⟩
    · simp only [orient, if_pos hk]
      simp only [t, blockFiberPairDisagreements, mem_filter, mem_univ, true_and]
      exact ⟨hk, hl, by simp [hbefore, not_lt.mpr (le_of_lt hafter)]⟩
    · have hnk : block p.1 ≠ k := by rw [hl]; exact ne_of_gt hkl
      simp only [orient, if_neg hnk]
      simp only [t, blockFiberPairDisagreements, mem_filter, mem_univ, true_and]
      exact ⟨hk, hl, by simp [hafter, not_lt.mpr (le_of_lt hbefore)]⟩
  have hj : ∀ p ∈ t, sort p ∈ s := by
    intro p hp
    obtain ⟨hk, hl, hdiff⟩ := htarget p hp
    have hne : p.1 ≠ p.2 := by
      intro heq
      apply (ne_of_lt hkl)
      calc k = block p.1 := hk.symm
        _ = block p.2 := congrArg block heq
        _ = l := hl
    by_cases hbefore : p.1 < p.2
    · have hafter : σ p.2 < σ p.1 := by
        have hn : ¬ σ p.1 < σ p.2 := by simpa [hbefore] using hdiff
        exact lt_of_le_of_ne (le_of_not_gt hn) (σ.injective.ne hne).symm
      simp only [sort, if_pos hbefore]
      simp only [s, blockAcrossFiberPairInversions, mem_filter,
        blockAcrossFiberInversions, blockInversionPairs, mem_orderedPairs, mem_univ,
        true_and]
      exact ⟨⟨⟨hbefore, hafter⟩, by rw [hk, hl]; exact ne_of_lt hkl⟩,
        Or.inl ⟨hk, hl⟩⟩
    · have hreverse : p.2 < p.1 := lt_of_le_of_ne (le_of_not_gt hbefore) hne.symm
      have hafter : σ p.1 < σ p.2 := by simpa [hbefore] using hdiff
      simp only [sort, if_neg hbefore]
      simp only [s, blockAcrossFiberPairInversions, mem_filter,
        blockAcrossFiberInversions, blockInversionPairs, mem_orderedPairs, mem_univ,
        true_and]
      exact ⟨⟨⟨hreverse, hafter⟩, by rw [hl, hk]; exact ne_of_gt hkl⟩,
        Or.inr ⟨hl, hk⟩⟩
  have hleft : ∀ p ∈ s, sort (orient p) = p := by
    intro p hp
    obtain ⟨hbefore, _, hblocks⟩ := hsource p hp
    rcases hblocks with ⟨hk, _⟩ | ⟨hl, _⟩
    · simp [orient, sort, hk, hbefore]
    · have hnk : block p.1 ≠ k := by rw [hl]; exact ne_of_gt hkl
      simp [orient, sort, hnk, not_lt.mpr (le_of_lt hbefore)]
  have hright : ∀ p ∈ t, orient (sort p) = p := by
    intro p hp
    obtain ⟨hk, hl, _⟩ := htarget p hp
    by_cases hbefore : p.1 < p.2
    · simp [sort, orient, hbefore, hk]
    · have hnk : block p.2 ≠ k := by rw [hl]; exact ne_of_gt hkl
      simp [sort, orient, hbefore, hnk]
  exact Finset.card_bij' (fun p _ => orient p) (fun p _ => sort p)
    hi hj hleft hright

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
