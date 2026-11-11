import Ising2DLambda.NecSuf.KacWard.SmoothingIndexBlocks
import Mathlib.Data.Finset.Sort

namespace Ising2DLambda.NecSuf.KacWard

/-- The ordered indices strictly after `k` and at most `l`. -/
def smoothingIndexSequenceA {m : ℕ} (k l : Fin (m + 1)) : List (Fin (m + 1)) :=
  (Finset.univ.filter fun r => k < r ∧ r ≤ l).sort (· ≤ ·)

/-- The ordered indices after `l`, followed by the indices through `k`. -/
def smoothingIndexSequenceB {m : ℕ} (k l : Fin (m + 1)) : List (Fin (m + 1)) :=
  (Finset.univ.filter fun r => l < r).sort (· ≤ ·) ++
    (Finset.univ.filter fun r => r ≤ k).sort (· ≤ ·)

def smoothedSplitEdgeSequenceA {E : Type*} {m : ℕ}
    (γ : Fin (m + 1) → E) (k l : Fin (m + 1)) : List E :=
  (smoothingIndexSequenceA k l).map γ

def smoothedSplitEdgeSequenceB {E : Type*} {m : ℕ}
    (γ : Fin (m + 1) → E) (k l : Fin (m + 1)) : List E :=
  (smoothingIndexSequenceB k l).map γ

theorem smoothingIndexSequenceA_mem {m : ℕ} (k l r : Fin (m + 1)) :
    r ∈ smoothingIndexSequenceA k l ↔ r ∈ smoothingIndexBlockA k l := by
  simp [smoothingIndexSequenceA, smoothingIndexBlockA]

theorem smoothingIndexSequenceB_mem {m : ℕ} (k l r : Fin (m + 1)) :
    r ∈ smoothingIndexSequenceB k l ↔ r ∈ smoothingIndexBlockB k l := by
  rw [smoothingIndexBlockB_membership]
  simp [smoothingIndexSequenceB]
  omega

theorem smoothingIndexSequenceA_nodup {m : ℕ} (k l : Fin (m + 1)) :
    (smoothingIndexSequenceA k l).Nodup :=
  Finset.sort_nodup _ _

/-- The second sequence lists each index of block `B` once; this uses `k < l`. -/
theorem smoothingIndexSequenceB_nodup {m : ℕ} {k l : Fin (m + 1)} (hkl : k < l) :
    (smoothingIndexSequenceB k l).Nodup := by
  rw [smoothingIndexSequenceB, List.nodup_append]
  refine ⟨Finset.sort_nodup _ _, Finset.sort_nodup _ _, ?_⟩
  intro a ha b hb hab
  subst hab
  simp at ha hb
  omega

theorem smoothingIndexSequences_nonempty {m : ℕ}
    {k l : Fin (m + 1)} (hkl : k < l) :
    smoothingIndexSequenceA k l ≠ [] ∧ smoothingIndexSequenceB k l ≠ [] := by
  have h := smoothingIndexBlocks_nonempty hkl
  constructor
  · intro he
    have hl : l ∈ smoothingIndexSequenceA k l :=
      (smoothingIndexSequenceA_mem k l l).2 h.1
    simp [he] at hl
  · intro he
    have hk : k ∈ smoothingIndexSequenceB k l :=
      (smoothingIndexSequenceB_mem k l k).2 h.2
    simp [he] at hk

end Ising2DLambda.NecSuf.KacWard
