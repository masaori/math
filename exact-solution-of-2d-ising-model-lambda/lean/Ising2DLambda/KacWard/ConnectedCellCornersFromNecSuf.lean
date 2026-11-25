/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ConnectedCellCorners
import Ising2DLambda.KacWard.AdjacentCellCornersConnectedFromNecSuf
import Ising2DLambda.NecSuf.KacWard.ConnectedCellCorners

namespace Ising2DLambda.KacWard

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
