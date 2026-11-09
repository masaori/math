import Ising2DLambda.Tools.EvenEdgeProcessedVertexParity
import Ising2DLambda.NecSuf.Tools.EvenEdgeProcessedVertexParity

namespace Ising2DLambda.Tools

open scoped symmDiff

theorem edgeParity_toggle_unprocessed_from_necSuf (n : ℕ)
    (A : Finset (Sym2 (Fin n))) (U : Finset (Fin n)) (e : Sym2 (Fin n))
    (he : ∀ v : Fin n, v ∈ e → v ∈ U) (v : Fin n) (hv : v ∉ U) :
    edgeParity n (A ∆ {e}) v = edgeParity n A v := by
  apply Ising2DLambda.NecSuf.Tools.incidenceParity_toggle_unprocessed
    (fun v e => v ∈ e) A (↑U : Set (Fin n)) e
  · intro w hw hwe
    exact hw (he w hwe)
  · exact hv

end Ising2DLambda.Tools
