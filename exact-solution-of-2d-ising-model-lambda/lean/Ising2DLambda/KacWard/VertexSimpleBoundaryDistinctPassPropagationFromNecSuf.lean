import Ising2DLambda.KacWard.VertexSimpleBoundaryDistinctPassPropagation
import Ising2DLambda.NecSuf.KacWard.VertexSimpleBoundaryDistinctPassPropagation

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The abstract same-base argument specializes to lattice oriented edges. -/
theorem same_base_successor_is_loop_from_necSuf {L : ℕ}
    (e f : OrientedEdge L) (hf : f ∈ nonbacktrackingSuccessors e)
    (hbase : e.1 = f.1) : orientedSource e = orientedTarget e := by
  have hclass : e.1 = f.1 → f = e ∨ f = reversal e := by
    intro hb
    rcases e with ⟨b, false | true⟩ <;>
      rcases f with ⟨c, false | true⟩ <;>
      simp_all [reversal]
  exact Ising2DLambda.NecSuf.KacWard.same_base_successor_is_loop
    e f Prod.fst orientedSource orientedTarget reversal hclass hbase
    (Finset.mem_filter.mp hf).2.2 (Finset.mem_filter.mp hf).2.1

/-- The abstract nonloop implication specializes to the lattice passage. -/
theorem nonloop_successor_distinct_base_from_necSuf {L : ℕ}
    (e f : OrientedEdge L) (hf : f ∈ nonbacktrackingSuccessors e)
    (hnotloop : orientedSource e ≠ orientedTarget e) : e.1 ≠ f.1 := by
  have hclass : e.1 = f.1 → f = e ∨ f = reversal e := by
    intro hb
    rcases e with ⟨b, false | true⟩ <;>
      rcases f with ⟨c, false | true⟩ <;>
      simp_all [reversal]
  exact Ising2DLambda.NecSuf.KacWard.nonloop_successor_distinct_base
    e f Prod.fst orientedSource orientedTarget reversal hclass
    (Finset.mem_filter.mp hf).2.2 (Finset.mem_filter.mp hf).2.1 hnotloop

/-- The abstract two-edge argument applies to the height-one cell boundary. -/
theorem vertexSimple_boundary_distinct_pass_propagation_from_necSuf
    (L m : ℕ) [NeZero L] (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0)
    (k : Fin (m + 1))
    (hdistinct : (γ k).1 ≠ (γ (closedWalkSuccessor k)).1)
    (hnotin : orientedSource (γ k) ≠ orientedTarget (γ k))
    (hnotout : orientedTarget (γ (closedWalkSuccessor k)) ≠
      orientedSource (γ (closedWalkSuccessor k))) :
    cellSetEdgeCoefficient L (heightOneCells L m γ) (γ k).1 *
        (1 - 2 * ((γ k).2.toNat : ℤ)) =
      cellSetEdgeCoefficient L (heightOneCells L m γ)
          (γ (closedWalkSuccessor k)).1 *
        (1 - 2 * ((γ (closedWalkSuccessor k)).2.toNat : ℤ)) := by
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
  have hbalance : (∑ edge : Edge L,
      cellSetEdgeCoefficient L (heightOneCells L m γ) edge * incidence edge) = 0 :=
    cellSetBoundary_coefficient_vertex_balance L (heightOneCells L m γ) v
  have hin : incidence (γ k).1 = -(1 - 2 * ((γ k).2.toNat : ℤ)) := by
    cases h: γ k with
    | mk edge direction =>
      cases direction <;> simp [incidence, v, orientedSource, orientedTarget] at hnotin ⊢
      all_goals simp_all [orientedSource, orientedTarget]
  have hout : incidence (γ (closedWalkSuccessor k)).1 =
      1 - 2 * ((γ (closedWalkSuccessor k)).2.toNat : ℤ) := by
    cases h: γ (closedWalkSuccessor k) with
    | mk edge direction =>
      cases direction <;> simp [incidence, v, orientedSource, orientedTarget] at hnext hnotout ⊢
      all_goals simp_all [orientedSource, orientedTarget]
  exact Ising2DLambda.NecSuf.KacWard.vertexSimple_distinct_pass_coefficient_propagation
    γ orientedSource orientedTarget hstep hclose hinj k (closedWalkSuccessor k) hnext
    Prod.fst (cellSetEdgeCoefficient L (heightOneCells L m γ)) incidence
    hsupport hincident hdistinct hbalance
    (1 - 2 * ((γ k).2.toNat : ℤ))
    (1 - 2 * ((γ (closedWalkSuccessor k)).2.toNat : ℤ)) hin hout

end Ising2DLambda.KacWard
