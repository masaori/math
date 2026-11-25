/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.CellVertexGraphConnected
import Ising2DLambda.KacWard.CellVertexGraphFromNecSuf
import Ising2DLambda.KacWard.ConnectedCellCornersFromNecSuf

namespace Ising2DLambda.KacWard

theorem edgeConnectedCellSet_actualVertexGraphConnected_from_necSuf
    (S : Finset GridCell) (hS : S.Nonempty)
    (hconn : EdgeConnectedCellSet (S : Set GridCell)) :
    (cellVertexGraph S).Connected := by
  obtain ⟨hV, hpath⟩ :=
    edgeConnectedCellSet_vertexGraphConnected_from_necSuf S hS hconn
  exact cellVertexStep_eqvGen_graphConnected S hV hpath

end Ising2DLambda.KacWard
