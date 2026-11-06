import Ising2DLambda.KacWard.HeightOneBoundaryAllEdges
import Ising2DLambda.KacWard.VertexSimpleIncidentEdges

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- At a passage of a vertex-simple walk, no other base edge contributes to the cell boundary balance. -/
theorem vertexSimple_boundary_other_edges_zero (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0)
    (k : Fin (m + 1)) (b : Edge L)
    (hfirst : b ≠ (γ k).1)
    (hsecond : b ≠ (γ (closedWalkSuccessor k)).1) :
    cellSetEdgeCoefficient L (heightOneCells L m γ) b *
      ((if orientedSource (b, false) = orientedTarget (γ k) then (1 : ℤ) else 0) -
        (if orientedTarget (b, false) = orientedTarget (γ k) then (1 : ℤ) else 0)) = 0 := by
  classical
  let v := orientedTarget (γ k)
  let incidence : Edge L → ℤ := fun edge =>
    (if orientedSource (edge, false) = v then 1 else 0) -
      (if orientedTarget (edge, false) = v then 1 else 0)
  have hinj : Function.Injective (orientedTarget ∘ γ) :=
    (contactPairCount_eq_zero_iff_pass_vertices_injective γ hγ).mp hcontact
  have hnext : orientedSource (γ (closedWalkSuccessor k)) = v := by
    exact (Finset.mem_filter.mp (closedWalkPass_valid γ hγ k)).2.1.symm
  have hsupport (edge : Edge L)
      (hc : cellSetEdgeCoefficient L (heightOneCells L m γ) edge ≠ 0) :
      ∃ j : Fin (m + 1), (γ j).1 = edge := by
    have hp := (heightOneBoundary_all_edges L m γ hγ hh hv edge).mp hc
    by_contra hn
    push Not at hn
    have hs : (∑ j : Fin (m + 1), if (γ j).1 = edge then 1 else 0) = 0 := by
      simp [hn]
    simp [walkBaseEdgeParity, hs] at hp
  have hincident (e : OrientedEdge L) (hi : incidence e.1 ≠ 0) :
      orientedSource e = v ∨ orientedTarget e = v := by
    cases e with
    | mk edge direction =>
      cases direction <;> (by_contra hn; push Not at hn)
      · rcases hn with ⟨h0, h1⟩
        have hb0 : boundary0 L edge ≠ v := by simpa [orientedSource] using h0
        have hb1 : boundary1 L edge ≠ v := by simpa [orientedTarget] using h1
        exact hi (by simp [incidence, orientedSource, orientedTarget, hb0, hb1])
      · rcases hn with ⟨h1, h0⟩
        have hb0 : boundary0 L edge ≠ v := by simpa [orientedTarget] using h0
        have hb1 : boundary1 L edge ≠ v := by simpa [orientedSource] using h1
        exact hi (by simp [incidence, orientedSource, orientedTarget, hb0, hb1])
  by_cases hc : cellSetEdgeCoefficient L (heightOneCells L m γ) b = 0
  · simp [hc]
  by_cases hd : incidence b = 0
  · change cellSetEdgeCoefficient L (heightOneCells L m γ) b * incidence b = 0
    simp [hd]
  obtain ⟨j, hj⟩ := hsupport b hc
  have hlocal : orientedSource (γ j) = v ∨ orientedTarget (γ j) = v := by
    apply hincident
    simpa [hj] using hd
  rcases hlocal with hs | ht
  · have htargetCount :
        (∑ i : Fin (m + 1), if orientedTarget (γ i) = v then 1 else 0) = 1 := by
      have heq (i : Fin (m + 1)) : orientedTarget (γ i) = v ↔ i = k :=
        hinj.eq_iff
      simp_rw [heq]
      simp
    have hsourceCount :
        (∑ i : Fin (m + 1), if orientedSource (γ i) = v then 1 else 0) = 1 := by
      have htotal := vertexSimple_incident_edges γ hγ hcontact k
      rw [Finset.sum_add_distrib] at htotal
      rw [htargetCount] at htotal
      exact Nat.add_right_cancel (htotal.trans (by omega))
    have hcard :
        (Finset.univ.filter (fun i : Fin (m + 1) =>
          orientedSource (γ i) = v)).card = 1 := by
      simpa [Finset.sum_boole] using hsourceCount
    obtain ⟨i, hi⟩ := Finset.card_eq_one.mp hcard
    have hjmem : j ∈ Finset.univ.filter (fun i : Fin (m + 1) =>
        orientedSource (γ i) = v) := by simp [hs]
    have hnmem : closedWalkSuccessor k ∈ Finset.univ.filter (fun i : Fin (m + 1) =>
        orientedSource (γ i) = v) := by simp [hnext]
    rw [hi] at hjmem hnmem
    simp only [Finset.mem_singleton] at hjmem hnmem
    exact (hsecond (hj ▸ congrArg (fun e : OrientedEdge L => e.1)
      (congrArg γ (hjmem.trans hnmem.symm)))).elim
  · have hindex : j = k := hinj (by simpa only [Function.comp_apply] using ht)
    exact (hfirst (hj ▸ congrArg (fun e : OrientedEdge L => e.1)
      (congrArg γ hindex))).elim

end Ising2DLambda.KacWard
