/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.CellGraphEvenEdgeBijection
import Ising2DLambda.KacWard.CellGridIncidentParityFromNecSuf
import Ising2DLambda.NecSuf.KacWard.CellGraphEvenEdgeBijection

namespace Ising2DLambda.KacWard

theorem cellGraphEvenEdge_bijective_from_necSuf (cells : Finset GridCell) :
    Function.Bijective
      (fun A : {A : Finset (cellEdges cells) // IsEvenEncodedCellEdgeSet cells A} =>
        (⟨A.1.image (cellGraphEdgeEquiv cells),
          (cellGraphEdge_even_iff cells A.1).mp A.2⟩ :
          {B : Finset (cellVertexGraph cells).edgeFinset //
            IsEvenCellGraphEdgeSet cells B})) := by
  exact Ising2DLambda.NecSuf.KacWard.subsetProperty_bijective_of_edgeEquiv
    (cellGraphEdgeEquiv cells)
    (IsEvenEncodedCellEdgeSet cells)
    (IsEvenCellGraphEdgeSet cells)
    (cellGraphEdge_even_iff cells)

end Ising2DLambda.KacWard
