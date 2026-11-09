import Ising2DLambda.KacWard.CellCornerConnected
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected
import Ising2DLambda.NecSuf.KacWard.AdjacentCellCornersConnected
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

private theorem glueCornerPaths {α : Type*} [DecidableEq α]
    (A B : Finset α) (stepA stepB step : α → α → Prop)
    (hA : ∀ u ∈ A, ∀ v ∈ A, Relation.EqvGen stepA u v)
    (hB : ∀ u ∈ B, ∀ v ∈ B, Relation.EqvGen stepB u v)
    (hstepA : ∀ ⦃u v⦄, stepA u v → step u v)
    (hstepB : ∀ ⦃u v⦄, stepB u v → step u v)
    (w : α) (hwA : w ∈ A) (hwB : w ∈ B) :
    ∀ u ∈ A ∪ B, ∀ v ∈ A ∪ B, Relation.EqvGen step u v := by
  have hA' : ∀ u ∈ A, Relation.EqvGen step u w := by
    intro u hu
    exact (hA u hu w hwA).mono (fun _ _ h => hstepA h)
  have hB' : ∀ u ∈ B, Relation.EqvGen step w u := by
    intro u hu
    exact (hB w hwB u hu).mono (fun _ _ h => hstepB h)
  intro u hu v hv
  rcases Finset.mem_union.mp hu with huA | huB
  · rcases Finset.mem_union.mp hv with hvA | hvB
    · exact (hA u huA v hvA).mono (fun _ _ h => hstepA h)
    · exact Relation.EqvGen.trans _ _ _ (hA' u huA) (hB' v hvB)
  · rcases Finset.mem_union.mp hv with hvA | hvB
    · exact Relation.EqvGen.trans _ _ _
        (Relation.EqvGen.symm _ _ (hB' u huB))
        (Relation.EqvGen.symm _ _ (hA' v hvA))
    · exact (hB u huB v hvB).mono (fun _ _ h => hstepB h)

private theorem adjacentCells_commonCorner (p q : GridCell)
    (hadj : CellEdgeAdjacent p q) :
    ∃ w, w ∈ verticesOfCell p ∧ w ∈ verticesOfCell q := by
  rcases p with ⟨r, c⟩
  rcases q with ⟨s, d⟩
  rcases hadj with ⟨hrs, hdc | hdc⟩ | ⟨hdc, hrs | hrs⟩
  · refine ⟨(r, c), by simp [verticesOfCell], ?_⟩
    simp [verticesOfCell]
    omega
  · refine ⟨(r, c + 1), by simp [verticesOfCell], ?_⟩
    simp [verticesOfCell]
    omega
  · refine ⟨(r, c), by simp [verticesOfCell], ?_⟩
    simp [verticesOfCell]
    omega
  · refine ⟨(r + 1, c), by simp [verticesOfCell], ?_⟩
    simp [verticesOfCell]
    omega

private theorem singleCellStep_le_cells (p : GridCell) (cells : Finset GridCell)
    (hp : p ∈ cells) :
    ∀ ⦃u v⦄, CellVertexStep ({p} : Finset GridCell) u v →
      CellVertexStep cells u v := by
  intro u v h
  obtain ⟨e, he, hend⟩ := h
  refine ⟨e, ?_, hend⟩
  simp only [cellEdges, Finset.mem_biUnion] at he ⊢
  obtain ⟨x, hx, hex⟩ := he
  have hxp : x = p := by simpa using hx
  subst x
  exact ⟨p, hp, hex⟩

/-- Adjacent actual cells connect every pair of corners through their union. -/
theorem adjacentCellCorners_connected (p q : GridCell)
    (hadj : CellEdgeAdjacent p q) :
    ∀ u ∈ cellVertices ({p, q} : Finset GridCell),
      ∀ v ∈ cellVertices ({p, q} : Finset GridCell),
        Relation.EqvGen (CellVertexStep ({p, q} : Finset GridCell)) u v := by
  obtain ⟨w, hwp, hwq⟩ := adjacentCells_commonCorner p q hadj
  have hp := cellCorners_connected p.1 p.2
  have hq := cellCorners_connected q.1 q.2
  have h := glueCornerPaths
    (verticesOfCell p) (verticesOfCell q)
    (CellVertexStep ({p} : Finset GridCell))
    (CellVertexStep ({q} : Finset GridCell))
    (CellVertexStep ({p, q} : Finset GridCell))
    (by simpa only [Prod.mk.eta] using hp)
    (by simpa only [Prod.mk.eta] using hq)
    (singleCellStep_le_cells p {p, q} (by simp))
    (singleCellStep_le_cells q {p, q} (by simp))
    w hwp hwq
  simpa [cellVertices] using h

/-- The concrete statement follows from the necessary-sufficient gluing proof. -/
theorem adjacentCellCorners_connected_from_necSuf (p q : GridCell)
    (hadj : CellEdgeAdjacent p q) :
    ∀ u ∈ cellVertices ({p, q} : Finset GridCell),
      ∀ v ∈ cellVertices ({p, q} : Finset GridCell),
        Relation.EqvGen (CellVertexStep ({p, q} : Finset GridCell)) u v := by
  obtain ⟨w, hwp, hwq⟩ := adjacentCells_commonCorner p q hadj
  have hp := cellCorners_connected p.1 p.2
  have hq := cellCorners_connected q.1 q.2
  have h := Ising2DLambda.NecSuf.KacWard.adjacentCornerSets_connected
    (verticesOfCell p) (verticesOfCell q)
    (CellVertexStep ({p} : Finset GridCell))
    (CellVertexStep ({q} : Finset GridCell))
    (CellVertexStep ({p, q} : Finset GridCell))
    (by simpa only [Prod.mk.eta] using hp)
    (by simpa only [Prod.mk.eta] using hq)
    (singleCellStep_le_cells p {p, q} (by simp))
    (singleCellStep_le_cells q {p, q} (by simp))
    w hwp hwq
  simpa [cellVertices] using h

end Ising2DLambda.KacWard
