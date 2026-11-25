/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothedSplitClosedWalks
import Ising2DLambda.NecSuf.KacWard.SmoothedSplitClosedWalks

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

section Swapped

variable {L : ℕ} [NeZero L]

theorem swappedExit_mem_nonbacktrackingSuccessors_from_necSuf {e f e' f' : OrientedEdge L}
    (h : edgeTransverseCrossing e f e' f') : f' ∈ nonbacktrackingSuccessors e := by
  obtain ⟨_, hf', htgt, _, hst', hax⟩ := h
  have hf'' := Finset.mem_filter.mp hf'
  have hstraight : ∀ a b : OrientedEdge L, orientedSource b = orientedTarget a →
      b ≠ reversal a → stepTurning a b = 0 → directionNumber b = directionNumber a :=
    fun a b hs hr ht => (stepTurning_eq_zero_iff a b
      (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hs.symm, hr⟩)).1 ht
  have h := Ising2DLambda.NecSuf.KacWard.swappedExit_next_necSuf
    orientedSource orientedTarget reversal directionNumber (· + 2) directionAxis
    (fun a b => stepTurning a b = 0) directionNumber_reversal directionAxis_add_two
    hstraight htgt hf''.2.1.symm hf''.2.2 hst' hax
  exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, h.1.symm, h.2⟩

end Swapped

section Segment

variable {L m : ℕ}

theorem closedWalkSegment_from_necSuf (γ : Fin (m + 1) → OrientedEdge L) (s n : ℕ) :
    closedWalkSegment γ s n = Ising2DLambda.NecSuf.KacWard.cyclicSegment γ s n := rfl

theorem closedWalkSegment_closed_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (s n : ℕ)
    (hclose : γ ⟨s % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ ∈
      nonbacktrackingSuccessors (γ ⟨(s + n) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩)) :
    closedNonbacktrackingWalk (closedWalkSegment γ s n) :=
  Ising2DLambda.NecSuf.KacWard.cyclicSegment_closed_necSuf
    (fun e f => f ∈ nonbacktrackingSuccessors e) γ
    (fun r => closedWalkPass_valid γ hγ r) s n hclose

end Segment

section Split

variable {L m : ℕ}

theorem smoothedSplitWalkA_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedSplitWalkA γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.cyclicSegment γ (k.val + 1) (l.val - k.val - 1) := rfl

theorem smoothedSplitWalkB_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedSplitWalkB γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.cyclicSegment γ (l.val + 1) (m - l.val + k.val) := rfl

variable [NeZero L]

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothedSplitWalks_closed_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    closedNonbacktrackingWalk (smoothedSplitWalkA γ hγ k l) ∧
      closedNonbacktrackingWalk (smoothedSplitWalkB γ hγ k l) :=
  Ising2DLambda.NecSuf.KacWard.smoothedSplitSegments_closed_necSuf
    (fun e f => f ∈ nonbacktrackingSuccessors e) γ
    (fun r => closedWalkPass_valid γ hγ r) hkl
    (swappedExit_mem_nonbacktrackingSuccessors hcross.2)
    (swappedExit_mem_nonbacktrackingSuccessors' hcross.2)

end Split

end Ising2DLambda.KacWard
