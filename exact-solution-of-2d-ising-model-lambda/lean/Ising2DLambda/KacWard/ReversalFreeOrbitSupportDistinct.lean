/-
章「Kac--Ward 行列式の置換展開」の
「反転対を含まない非後退置換の軌道列は台の辺が相異なる」
（`claim_reversal_free_orbit_support_edges_distinct`）の具体版。

人手証明と同じく、軌道の各項が動くことと向き付き辺としての相異性を準備し、
台が一致する二項を同じ向きの場合と反転した向きの場合に分ける。
-/
import Mathlib.Tactic
import Ising2DLambda.KacWard.MovedOrbitClosedWalk
import Ising2DLambda.KacWard.ReversalFreeMovedSupportEven

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

private lemma sameBase_or_reversal {L : ℕ} {e f : OrientedEdge L}
    (hbase : e.1 = f.1) : e = f ∨ reversal e = f := by
  rcases e with ⟨e, false | true⟩ <;> rcases f with ⟨f, false | true⟩ <;>
    change e = f at hbase <;> subst f <;>
    simp [reversal]

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
  rcases sameBase_or_reversal hbase with hsame | hreverse
  · have hindex : j - 1 = k - 1 := by
      by_contra hne
      rcases lt_or_gt_of_ne hne with hlt | hgt
      · exact hdistinctOrbit (j - 1) (k - 1) hlt hkr hsame
      · exact hdistinctOrbit (k - 1) (j - 1) hgt hjr hsame.symm
    omega
  · have hjmoved : (⇑σ)^[j - 1] e ∈ movedOrientedEdges σ := by
      rw [movedOrientedEdges, Finset.mem_filter]
      exact ⟨Finset.mem_univ _, hmoved (j - 1)⟩
    have hkmoved : (⇑σ)^[k - 1] e ∈ movedOrientedEdges σ := by
      rw [movedOrientedEdges, Finset.mem_filter]
      exact ⟨Finset.mem_univ _, hmoved (k - 1)⟩
    exact False.elim (hfree _ hjmoved (hreverse ▸ hkmoved))

end Ising2DLambda.KacWard
