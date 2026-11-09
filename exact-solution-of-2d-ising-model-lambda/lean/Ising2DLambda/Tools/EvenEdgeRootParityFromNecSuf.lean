import Ising2DLambda.Tools.EvenEdgeRootParity
import Ising2DLambda.NecSuf.Tools.EvenEdgeRootParity

namespace Ising2DLambda.Tools

theorem evenEdgeSubset_root_of_other_even_from_necSuf
    (n : ℕ) (G : SimpleGraph (Fin n)) [DecidableRel G.Adj]
    (A : Finset (Sym2 (Fin n))) (root : Fin n)
    (hA : A ⊆ G.edgeFinset)
    (hother : ∀ v ≠ root, edgeParity n A v = 0) :
    edgeParity n A root = 0 := by
  classical
  exact Ising2DLambda.NecSuf.Tools.incidenceParity_root_of_other_even
    (fun v e => v ∈ e) A root (simpleGraph_edge_incidence_even n G A hA) hother

end Ising2DLambda.Tools
