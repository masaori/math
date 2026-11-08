import Ising2DLambda.Tools.EvenEdgeSymmDiff
import Ising2DLambda.NecSuf.Tools.EvenEdgeSymmDiff

namespace Ising2DLambda.Tools

open scoped symmDiff

theorem evenEdgeSubset_symmDiff_from_necSuf (n : ℕ)
    (G : SimpleGraph (Fin n)) [DecidableRel G.Adj]
    (A B : Finset (Sym2 (Fin n)))
    (hA : IsEvenEdgeSubsetOf n G A) (hB : IsEvenEdgeSubsetOf n G B) :
    IsEvenEdgeSubsetOf n G (A ∆ B) := by
  exact Ising2DLambda.NecSuf.Tools.evenIncidenceSubset_symmDiff
    (fun v e => v ∈ e) G.edgeFinset A B hA hB

end Ising2DLambda.Tools
