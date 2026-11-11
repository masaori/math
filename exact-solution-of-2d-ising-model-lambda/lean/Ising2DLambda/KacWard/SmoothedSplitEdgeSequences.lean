import Ising2DLambda.KacWard.SmoothingIndexBlocks
import Ising2DLambda.NecSuf.KacWard.SmoothedSplitEdgeSequences

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `γ_A` の添字列 `(k+1, …, l)`。 -/
def smoothingIndexSequenceA {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : List (Fin (m + 1)) :=
  (Finset.univ.filter fun r => k < r ∧ r ≤ l).sort (· ≤ ·)

/-- `γ_B` の添字列 `(l+1, …, 最後, 最初, …, k)`。 -/
def smoothingIndexSequenceB {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : List (Fin (m + 1)) :=
  (Finset.univ.filter fun r => l < r).sort (· ≤ ·) ++
    (Finset.univ.filter fun r => r ≤ k).sort (· ≤ ·)

/-- The first edge sequence cut from an actual closed nonbacktracking walk. -/
def smoothedSplitEdgeSequenceA {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : List (OrientedEdge L) :=
  (smoothingIndexSequenceA γ hγ k l).map γ

/-- The second edge sequence continues across the cyclic seam. -/
def smoothedSplitEdgeSequenceB {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : List (OrientedEdge L) :=
  (smoothingIndexSequenceB γ hγ k l).map γ

theorem smoothingIndexSequenceA_mem {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l r : Fin (m + 1)) :
    r ∈ smoothingIndexSequenceA γ hγ k l ↔ r ∈ smoothingIndexBlockA γ hγ k l := by
  change _ ↔ ((closedWalkTextIndex k).val < (closedWalkTextIndex r).val ∧
    (closedWalkTextIndex r).val ≤ (closedWalkTextIndex l).val)
  rw [closedWalkTextIndex_lt_iff, closedWalkTextIndex_le_iff]
  simp [smoothingIndexSequenceA]

theorem smoothingIndexSequenceB_mem {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l r : Fin (m + 1)) :
    r ∈ smoothingIndexSequenceB γ hγ k l ↔ r ∈ smoothingIndexBlockB γ hγ k l := by
  rw [smoothingIndexBlockB_membership]
  simp [smoothingIndexSequenceB]
  omega

/-- `γ_A` の添字は `A` を一度ずつ尽くす。 -/
theorem smoothingIndexSequenceA_nodup {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l : Fin (m + 1)) :
    (smoothingIndexSequenceA γ hγ k l).Nodup :=
  Finset.sort_nodup _ _

/-- `γ_B` の添字は `B` を一度ずつ尽くす（`l` より後と `k` 以下は `k < l` で交わらない）。 -/
theorem smoothingIndexSequenceB_nodup {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    {k l : Fin (m + 1)} (hkl : k < l) :
    (smoothingIndexSequenceB γ hγ k l).Nodup := by
  rw [smoothingIndexSequenceB, List.nodup_append]
  refine ⟨Finset.sort_nodup _ _, Finset.sort_nodup _ _, ?_⟩
  intro a ha b hb hab
  subst hab
  simp at ha hb
  omega

theorem smoothingIndexSequenceA_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l : Fin (m + 1)) :
    smoothingIndexSequenceA γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothingIndexSequenceA k l := rfl

theorem smoothingIndexSequenceB_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l : Fin (m + 1)) :
    smoothingIndexSequenceB γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothingIndexSequenceB k l := rfl

theorem smoothedSplitEdgeSequenceA_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedSplitEdgeSequenceA γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothedSplitEdgeSequenceA γ k l := rfl

theorem smoothedSplitEdgeSequenceB_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedSplitEdgeSequenceB γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothedSplitEdgeSequenceB γ k l := rfl

theorem smoothedSplitEdgeSequences_nonempty {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    {k l : Fin (m + 1)} (hkl : k < l) :
    smoothedSplitEdgeSequenceA γ hγ k l ≠ [] ∧
      smoothedSplitEdgeSequenceB γ hγ k l ≠ [] := by
  have h := smoothingIndexBlocks_nonempty γ hγ hkl
  constructor
  · intro he
    have hl : l ∈ smoothingIndexSequenceA γ hγ k l :=
      (smoothingIndexSequenceA_mem γ hγ k l l).2 h.1
    simp [smoothedSplitEdgeSequenceA] at he
    simp [he] at hl
  · intro he
    have hk : k ∈ smoothingIndexSequenceB γ hγ k l :=
      (smoothingIndexSequenceB_mem γ hγ k l k).2 h.2
    simp [smoothedSplitEdgeSequenceB] at he
    simp [he] at hk

end Ising2DLambda.KacWard
