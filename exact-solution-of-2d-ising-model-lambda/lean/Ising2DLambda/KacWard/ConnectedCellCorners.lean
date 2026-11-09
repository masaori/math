import Ising2DLambda.KacWard.AdjacentCellCornersConnected
import Ising2DLambda.NecSuf.KacWard.ConnectedCellCorners
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

private theorem cornerStep_mono (S : Finset GridCell) (p : GridCell)
    (hp : p ∈ S) :
    ∀ ⦃u v⦄, CellVertexStep ({p} : Finset GridCell) u v →
      CellVertexStep S u v := by
  intro u v h
  obtain ⟨e, he, hend⟩ := h
  refine ⟨e, ?_, hend⟩
  simp only [cellEdges, Finset.mem_biUnion] at he ⊢
  obtain ⟨x, hx, hex⟩ := he
  have hxp : x = p := by simpa using hx
  subst x
  exact ⟨p, hp, hex⟩

private theorem adjacentCornerStep_mono (S : Finset GridCell)
    (p q : GridCell) (hp : p ∈ S) (hq : q ∈ S) :
    ∀ ⦃u v⦄, CellVertexStep ({p, q} : Finset GridCell) u v →
      CellVertexStep S u v := by
  intro u v h
  obtain ⟨e, he, hend⟩ := h
  refine ⟨e, ?_, hend⟩
  simp only [cellEdges, Finset.mem_biUnion] at he ⊢
  obtain ⟨x, hx, hex⟩ := he
  rcases Finset.mem_insert.mp hx with hxp | hxq
  · subst x
    exact ⟨p, hp, hex⟩
  · have hxq' : x = q := by simpa using hxq
    subst x
    exact ⟨q, hq, hex⟩

private theorem cellCornerPaths (S : Finset GridCell) (p : GridCell)
    (hp : p ∈ S) :
    ∀ u ∈ verticesOfCell p, ∀ v ∈ verticesOfCell p,
      Relation.EqvGen (CellVertexStep S) u v := by
  have h := cellCorners_connected p.1 p.2
  simpa only [Prod.mk.eta] using
    (fun u hu v hv => (h u hu v hv).mono (cornerStep_mono S p hp))

private theorem adjacentCornerPaths (S : Finset GridCell) (p q : GridCell)
    (hp : p ∈ S) (hq : q ∈ S) (hadj : CellEdgeAdjacent p q) :
    ∀ u ∈ verticesOfCell p, ∀ v ∈ verticesOfCell q,
      Relation.EqvGen (CellVertexStep S) u v := by
  have h := adjacentCellCorners_connected p q hadj
  intro u hu v hv
  have hu' : u ∈ cellVertices ({p, q} : Finset GridCell) := by
    simp [cellVertices, hu]
  have hv' : v ∈ cellVertices ({p, q} : Finset GridCell) := by
    simp [cellVertices, hv]
  exact (h u hu' v hv').mono (adjacentCornerStep_mono S p q hp hq)

/-- The concrete cell chain gives paths between all vertices of the actual cell graph. -/
theorem edgeConnectedCellSet_vertexGraphConnected (S : Finset GridCell)
    (hS : S.Nonempty) (hconn : EdgeConnectedCellSet (S : Set GridCell)) :
    (cellVertices S).Nonempty ∧
      ∀ u ∈ cellVertices S, ∀ v ∈ cellVertices S,
        Relation.EqvGen (CellVertexStep S) u v := by
  constructor
  · obtain ⟨p, hp⟩ := hS
    refine ⟨p, ?_⟩
    exact Finset.mem_biUnion.mpr ⟨p, hp, by simp [verticesOfCell]⟩
  intro u hu v hv
  obtain ⟨p, hp, hup⟩ := Finset.mem_biUnion.mp hu
  obtain ⟨q, hq, hvq⟩ := Finset.mem_biUnion.mp hv
  have hpath := hconn (Finset.mem_coe.mpr hp) (Finset.mem_coe.mpr hq)
  have hchain : ∀ ⦃a b : GridCell⦄,
      Relation.ReflTransGen
        (fun x y => x ∈ (S : Set GridCell) ∧ y ∈ (S : Set GridCell) ∧
          CellEdgeAdjacent x y) a b →
      a ∈ S → ∀ x ∈ verticesOfCell a, ∀ y ∈ verticesOfCell b,
        Relation.EqvGen (CellVertexStep S) x y := by
    intro a b hab ha
    induction hab with
    | refl => exact cellCornerPaths S a ha
    | @tail mid last hbefore hlast ih =>
        obtain ⟨hm, hl, hadj⟩ := hlast
        have hm' : mid ∈ S := Finset.mem_coe.mp hm
        have hl' : last ∈ S := Finset.mem_coe.mp hl
        let w : GridVertex := mid
        have hw : w ∈ verticesOfCell mid := by simp [w, verticesOfCell]
        intro x hx y hy
        exact Relation.EqvGen.trans _ _ _ (ih x hx w hw)
          (adjacentCornerPaths S mid last hm' hl' hadj w hw y hy)
  exact hchain hpath hp u hup v hvq

/-- The abstract chain lemma specializes to the actual grid cell graph. -/
theorem edgeConnectedCellSet_vertexGraphConnected_from_necSuf
    (S : Finset GridCell) (hS : S.Nonempty)
    (hconn : EdgeConnectedCellSet (S : Set GridCell)) :
    (cellVertices S).Nonempty ∧
      ∀ u ∈ cellVertices S, ∀ v ∈ cellVertices S,
        Relation.EqvGen (CellVertexStep S) u v := by
  constructor
  · obtain ⟨p, hp⟩ := hS
    refine ⟨p, ?_⟩
    exact Finset.mem_biUnion.mpr ⟨p, hp, by simp [verticesOfCell]⟩
  intro u hu v hv
  obtain ⟨p, hp, hup⟩ := Finset.mem_biUnion.mp hu
  obtain ⟨q, hq, hvq⟩ := Finset.mem_biUnion.mp hv
  exact Ising2DLambda.NecSuf.KacWard.connectedCellCorners_connected
    (S : Set GridCell) verticesOfCell CellEdgeAdjacent (CellVertexStep S)
    (fun a ha => cellCornerPaths S a (Finset.mem_coe.mp ha))
    (fun a ha b hb hab => adjacentCornerPaths S a b
      (Finset.mem_coe.mp ha) (Finset.mem_coe.mp hb) hab)
    (fun a _ => by rcases a with ⟨r, c⟩; exact ⟨(r, c), by simp [verticesOfCell]⟩)
    (hconn (Finset.mem_coe.mpr hp) (Finset.mem_coe.mpr hq))
    (Finset.mem_coe.mpr hp) u hup v hvq

end Ising2DLambda.KacWard
