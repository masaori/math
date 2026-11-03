import Ising2DLambda.KacWard.SmoothingIndexBlocks
import Ising2DLambda.NecSuf.KacWard.SmoothedSplitEdgeSequences

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The first edge sequence cut from an actual closed nonbacktracking walk. -/
def smoothedSplitEdgeSequenceA {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : List (OrientedEdge L) :=
  ((Finset.univ.filter fun r => k < r ∧ r ≤ l).sort (· ≤ ·)).map γ

/-- The second edge sequence continues across the cyclic seam. -/
def smoothedSplitEdgeSequenceB {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : List (OrientedEdge L) :=
  (((Finset.univ.filter fun r => l < r).sort (· ≤ ·)) ++
    ((Finset.univ.filter fun r => 0 < r ∧ r ≤ k).sort (· ≤ ·))).map γ

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
    {k l : Fin (m + 1)} (hk : 0 < k) (hkl : k < l) :
    smoothedSplitEdgeSequenceA γ hγ k l ≠ [] ∧
      smoothedSplitEdgeSequenceB γ hγ k l ≠ [] := by
  constructor
  · have hl : l ∈ (Finset.univ.filter fun r => k < r ∧ r ≤ l).sort (· ≤ ·) := by
      simp [hkl]
    have hA : (Finset.univ.filter fun r => k < r ∧ r ≤ l).sort (· ≤ ·) ≠ [] := by
      intro he
      simp [he] at hl
    simpa [smoothedSplitEdgeSequenceA] using hA
  · have hkMem : k ∈ ((Finset.univ.filter fun r => l < r).sort (· ≤ ·)) ++
        ((Finset.univ.filter fun r => 0 < r ∧ r ≤ k).sort (· ≤ ·)) := by
      simp [hk]
    have hB : ((Finset.univ.filter fun r => l < r).sort (· ≤ ·)) ++
        ((Finset.univ.filter fun r => 0 < r ∧ r ≤ k).sort (· ≤ ·)) ≠ [] := by
      intro he
      simp [he] at hkMem
    simpa [smoothedSplitEdgeSequenceB] using hB

end Ising2DLambda.KacWard
