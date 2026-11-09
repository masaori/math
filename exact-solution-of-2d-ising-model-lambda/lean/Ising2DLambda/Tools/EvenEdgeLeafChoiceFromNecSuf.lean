import Ising2DLambda.Tools.EvenEdgeLeafChoice
import Ising2DLambda.NecSuf.Tools.EvenEdgeLeafChoice

namespace Ising2DLambda.Tools

open scoped symmDiff

theorem evenEdge_leafChoice_from_necSuf (n : ℕ)
    (A : Finset (Sym2 (Fin n))) (e : Sym2 (Fin n))
    (v : Fin n) (hve : v ∈ e) :
    ∃! b : Bool, edgeParity n (if b then A ∆ {e} else A) v = 0 := by
  exact Ising2DLambda.NecSuf.Tools.incidenceParity_leafChoice
    (fun v e => v ∈ e) A e v hve

end Ising2DLambda.Tools
