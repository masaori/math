import Ising2DLambda.KacWard.VertexSimpleBoundaryOtherEdgesZero
import Ising2DLambda.NecSuf.KacWard.VertexSimpleBoundaryOtherEdgesZero

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The general incidence argument specializes to the height-one torus cell boundary. -/
theorem vertexSimple_boundary_other_edges_zero_from_necSuf (L m : ℕ) [NeZero L]
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
  have hstep : ∀ j : Fin m,
      orientedTarget (γ j.castSucc) = orientedSource (γ j.succ) := by
    intro j
    exact (Finset.mem_filter.mp (hγ.1 j)).2.1
  have hclose : orientedTarget (γ (Fin.last m)) = orientedSource (γ 0) :=
    (Finset.mem_filter.mp hγ.2).2.1
  have hinj : Function.Injective (orientedTarget ∘ γ) :=
    (contactPairCount_eq_zero_iff_pass_vertices_injective γ hγ).mp hcontact
  have hnext : orientedSource (γ (closedWalkSuccessor k)) = v :=
    (Finset.mem_filter.mp (closedWalkPass_valid γ hγ k)).2.1.symm
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
  exact Ising2DLambda.NecSuf.KacWard.vertexSimple_other_edge_contribution_zero
    γ orientedSource orientedTarget hstep hclose hinj
    k (closedWalkSuccessor k) hnext Prod.fst
    (cellSetEdgeCoefficient L (heightOneCells L m γ)) incidence
    hsupport hincident b hfirst hsecond

end Ising2DLambda.KacWard
