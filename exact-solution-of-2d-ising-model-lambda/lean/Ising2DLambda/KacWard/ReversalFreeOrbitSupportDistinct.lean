/-
章「トーラス上の Kac--Ward 行列式」の
「反転対を含まない非後退置換の軌道列は台の辺が相異なる」
（`claim_reversal_free_orbit_support_edges_distinct`）の具体版。

人手証明と同じく、軌道の各項が動くことと向き付き辺としての相異性を準備し、
台が一致する二項を同じ向きの場合と反転した向きの場合に分ける。
-/
import Mathlib.Tactic
import Ising2DLambda.KacWard.MovedOrbitClosedWalk
import Ising2DLambda.KacWard.ReversalFreeMovedSupportEven
import Ising2DLambda.NecSuf.KacWard.ReversalFreeOrbitSupportDistinct

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

private lemma sameBase_or_reversal {L : ℕ} {e f : OrientedEdge L}
    (hbase : e.1 = f.1) : e = f ∨ reversal e = f := by
  rcases e with ⟨e, false | true⟩ <;> rcases f with ⟨f, false | true⟩ <;>
    change e = f at hbase <;> subst f <;>
    simp [reversal, Ising2DLambda.NecSuf.KacWard.reverseBool]

/-- `claim_reversal_free_orbit_support_edges_distinct` の具体版。 -/
theorem reversalFreeOrbitSupportEdges_distinct (L : ℕ) [NeZero L]
    (σ : Equiv.Perm (OrientedEdge L))
    (hfree : ∀ f, f ∈ movedOrientedEdges σ → reversal f ∉ movedOrientedEdges σ)
    (e : OrientedEdge L) (he : e ∈ movedOrientedEdges σ) :
    ∀ j k : ℕ, 1 ≤ j → j ≤ minimalReturnTime σ e →
      1 ≤ k → k ≤ minimalReturnTime σ e →
      (((⇑σ)^[j - 1] e).1 = ((⇑σ)^[k - 1] e).1) → j = k := by
  have heMoved : σ e ≠ e := (Finset.mem_filter.mp he).2
  have horbit := movedOrbit_closed_nonbacktracking σ
    (fun _ _ ↦ True) (fun _ _ ↦ trivial) e heMoved
  have hmoved := horbit.1
  have hdistinctOrbit := horbit.2.2.2
  intro j k hjpos hjle hkpos hkle hbase
  have hjr : j - 1 < minimalReturnTime σ e := by omega
  have hkr : k - 1 < minimalReturnTime σ e := by omega
  have hindex := Ising2DLambda.NecSuf.KacWard.reversalFreeProjectedSequence_distinct_necSuf
    (fun n ↦ (⇑σ)^[n] e) Prod.fst reversal (minimalReturnTime σ e)
    (fun i l hir hlr hil ↦ by
      rcases lt_or_gt_of_ne hil with hilt | hlti
      · exact hdistinctOrbit i l hilt hlr
      · exact (hdistinctOrbit l i hlti hir).symm)
    (fun a b h ↦ sameBase_or_reversal h)
    (fun i l hir hlr hrev ↦ by
      have hui : (⇑σ)^[i] e ∈ movedOrientedEdges σ := by
        rw [movedOrientedEdges, Finset.mem_filter]
        exact ⟨Finset.mem_univ _, hmoved i⟩
      have hul : (⇑σ)^[l] e ∈ movedOrientedEdges σ := by
        rw [movedOrientedEdges, Finset.mem_filter]
        exact ⟨Finset.mem_univ _, hmoved l⟩
      exact hfree _ hui (hrev ▸ hul))
    (j - 1) (k - 1) hjr hkr hbase
  omega

end Ising2DLambda.KacWard
