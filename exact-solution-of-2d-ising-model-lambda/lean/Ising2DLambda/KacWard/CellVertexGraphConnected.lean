import Ising2DLambda.KacWard.CellVertexGraph
import Ising2DLambda.KacWard.ConnectedCellCorners
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- A grid-edge step is an adjacency step in the graph of cell corners. -/
theorem cellVertexStep_graphAdj (S : Finset GridCell)
    (u v : cellVertices S) (h : CellVertexStep S u.1 v.1) :
    (cellVertexGraph S).Adj u v := by
  obtain ⟨e, he, hend⟩ := h
  let edge : cellEdges S := ⟨e, he⟩
  have hpair : cellGraphEdge S edge = s(u, v) := by
    apply Sym2.ext
    intro x
    have hset : (cellGraphEdge S edge).toFinset = (s(u, v)).toFinset := by
      apply Finset.image_injective Subtype.val_injective
      rw [cellGraphEdge_endpointSet]
      change gridEdgeEndpoints e = _
      rw [hend]
      simp [Sym2.toFinset_mk_eq]
    rw [← Sym2.mem_toFinset, ← Sym2.mem_toFinset, hset]
  rw [cellVertexGraph, SimpleGraph.fromEdgeSet_adj]
  constructor
  · exact Finset.mem_coe.mpr (Finset.mem_image.mpr
      ⟨edge, Finset.mem_attach _ _, hpair⟩)
  · intro huv
    have hdiag : (cellGraphEdge S edge).IsDiag := by
      rw [hpair, Sym2.mk_isDiag_iff]
      exact huv
    exact cellGraphEdge_not_diag S edge hdiag

private theorem cellVertexStep_eqvGen_graphConnected (S : Finset GridCell)
    (hV : (cellVertices S).Nonempty)
    (hpath : ∀ u ∈ cellVertices S, ∀ v ∈ cellVertices S,
      Relation.EqvGen (CellVertexStep S) u v) :
    (cellVertexGraph S).Connected := by
  classical
  have hnonempty : Nonempty (cellVertices S) := by
    obtain ⟨v, hv⟩ := hV
    exact ⟨⟨v, hv⟩⟩
  refine { preconnected := ?_, nonempty := hnonempty }
  intro u v
  have hclosed : ∀ a b : GridVertex,
      Relation.EqvGen (CellVertexStep S) a b →
        (a ∈ cellVertices S ↔ b ∈ cellVertices S) := by
    intro a b h
    induction h with
    | rel a b hab =>
        obtain ⟨e, he, hend⟩ := hab
        have hs := gridEdgeEndpoints_subset_cellVertices S e he
        have ha : a ∈ cellVertices S := hs (by simp [hend])
        have hb : b ∈ cellVertices S := hs (by simp [hend])
        exact iff_of_true ha hb
    | refl => rfl
    | symm a b _ ih => exact ih.symm
    | trans a b c _ _ hab hbc => exact hab.trans hbc
  have hreach : ∀ a b : GridVertex,
      (h : Relation.EqvGen (CellVertexStep S) a b) →
      (ha : a ∈ cellVertices S) → (hb : b ∈ cellVertices S) →
        (cellVertexGraph S).Reachable ⟨a, ha⟩ ⟨b, hb⟩ := by
    intro a b h
    induction h with
    | rel a b hab =>
        intro ha hb
        exact (cellVertexStep_graphAdj S ⟨a, ha⟩ ⟨b, hb⟩ hab).reachable
    | refl a =>
        intro ha hb
        have heq : (⟨a, ha⟩ : cellVertices S) = ⟨a, hb⟩ := Subtype.ext rfl
        rw [← heq]
    | symm a b hab ih =>
        intro ha hb
        exact (ih hb ha).symm
    | trans a b c hab hbc ihab ihbc =>
        intro ha hc
        have hb := (hclosed a b hab).mp ha
        exact (ihab ha hb).trans (ihbc hb hc)
  exact hreach u.1 v.1 (hpath u.1 u.2 v.1 v.2) u.2 v.2

/-- Edge-connected cells give a connected graph on their actual corners. -/
theorem edgeConnectedCellSet_actualVertexGraphConnected (S : Finset GridCell)
    (hS : S.Nonempty) (hconn : EdgeConnectedCellSet (S : Set GridCell)) :
    (cellVertexGraph S).Connected := by
  obtain ⟨hV, hpath⟩ := edgeConnectedCellSet_vertexGraphConnected S hS hconn
  exact cellVertexStep_eqvGen_graphConnected S hV hpath

theorem edgeConnectedCellSet_actualVertexGraphConnected_from_necSuf
    (S : Finset GridCell) (hS : S.Nonempty)
    (hconn : EdgeConnectedCellSet (S : Set GridCell)) :
    (cellVertexGraph S).Connected := by
  obtain ⟨hV, hpath⟩ :=
    edgeConnectedCellSet_vertexGraphConnected_from_necSuf S hS hconn
  exact cellVertexStep_eqvGen_graphConnected S hV hpath

end Ising2DLambda.KacWard
