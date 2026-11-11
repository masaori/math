/-
「横断のない閉歩道を接触点で分けても各子に横断は生じない」の具体版が、必要十分版
`contact_vertex_passes`・`contact_split_child_crossing_free` の特殊化として得られることの記録。
通過の添字を歩道の添字、頂点を入辺の終点、入る方向・出る方向を入辺・出辺の方向番号、
元の横断と子の横断を `indexPairCrossing`、子の添字の写像を `smoothedSplitIndexA`・`smoothedSplitIndexB` に取る。
-/
import Ising2DLambda.KacWard.CrossingFreeContactSplitChildren
import Ising2DLambda.NecSuf.KacWard.CrossingFreeContactSplitChildren

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

variable {L m : ℕ} [NeZero L]

theorem contact_vertex_passes_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k ≠ l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l))
    (r : Fin (m + 1)) (hr : orientedTarget (γ r) = orientedTarget (γ k)) : r = k ∨ r = l :=
  Ising2DLambda.NecSuf.KacWard.contact_vertex_passes (fun r => orientedTarget (γ r))
    (fun r => directionNumber (γ r)) (fun r => directionNumber (γ (closedWalkSuccessor r)))
    (fun r p d hv hr hp => pass_shared_halfEdge_eq γ hγ hinj r p d hv hr hp)
    (pass_halfEdges_ne γ hγ) k l hkl hcontact r hr

theorem contact_split_child_crossing_free_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k ≠ l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l))
    (hzero : closedWalkCrossingNumber γ hγ = 0)
    {n : ℕ} (δ : Fin (n + 1) → OrientedEdge L) (hδ : closedNonbacktrackingWalk δ)
    (p : Fin (n + 1) → Fin (m + 1)) (hp : Function.Injective p) (hpos : ∀ j, δ j = γ (p j))
    (hsucc : ∀ j, δ (closedWalkSuccessor j) = smoothedExitEdge γ k l (p j))
    (hnot : ∀ i j, p i = k → p j = l → False) :
    closedWalkCrossingNumber δ hδ = 0 := by
  unfold closedWalkCrossingNumber at hzero ⊢
  convert Ising2DLambda.NecSuf.KacWard.contact_split_child_crossing_free
    (fun r => orientedTarget (γ r)) (indexPairCrossing γ hγ) (indexPairCrossing δ hδ) p hp k l
    (contact_vertex_passes_from_necSuf γ hγ hinj hkl hcontact) hcontact
    (fun i j hc => ⟨hc.1, by rw [← hpos i, ← hpos j]; exact hc.2.2.2.1⟩)
    (fun i j hc hik hil hjk hjl =>
      contact_split_child_original_crossing γ hγ k l δ hδ p hp hpos hsucc hc hik hil hjk hjl)
    (fun a b h => ⟨Ne.symm h.1, h.2.2.1, h.2.1, h.2.2.2.1.symm, h.2.2.2.2.2.1, h.2.2.2.2.1,
      Ne.symm h.2.2.2.2.2.2⟩)
    (by convert hzero) hnot

theorem crossing_free_contact_split_children_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    (hzero : closedWalkCrossingNumber γ hγ = 0)
    {k l : Fin (m + 1)} (hkl : k < l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) :
    closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l)
        (contactSplitWalkA_closed γ hγ hinj hkl hcontact) = 0 ∧
      closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
        (contactSplitWalkB_closed γ hγ hinj hkl hcontact) = 0 := by
  have hne : k ≠ l := ne_of_lt hkl
  refine ⟨contact_split_child_crossing_free_from_necSuf γ hγ hinj hne hcontact hzero _ _
      (smoothedSplitIndexA k l) (smoothedSplitIndexA_injective hkl)
      (smoothedSplitWalkA_apply γ hγ k l) (smoothedSplitWalkA_successor γ hγ hkl) ?_,
    contact_split_child_crossing_free_from_necSuf γ hγ hinj hne hcontact hzero _ _
      (smoothedSplitIndexB k l) (smoothedSplitIndexB_injective hkl)
      (smoothedSplitWalkB_apply γ hγ k l) (smoothedSplitWalkB_successor γ hγ hkl) ?_⟩
  · intro i _ hi _
    exact lt_irrefl _ ((smoothedSplitIndexA_range γ hγ hkl k).2 ⟨i, hi⟩).1
  · intro _ j _ hj
    apply (smoothedSplitIndexB_range γ hγ hkl l).2 ⟨j, hj⟩
    change (closedWalkTextIndex k).val < (closedWalkTextIndex l).val ∧
      (closedWalkTextIndex l).val ≤ (closedWalkTextIndex l).val
    rw [closedWalkTextIndex_lt_iff, closedWalkTextIndex_le_iff]
    exact ⟨hkl, le_refl _⟩

end Ising2DLambda.KacWard
