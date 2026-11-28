import Ising2DLambda.Tools.EvenEdgeSymmDiff
import Ising2DLambda.NecSuf.Tools.EvenEdgeSymmDiff

namespace Ising2DLambda.Tools

open scoped symmDiff

theorem evenEdgeSubset_symmDiff_from_necSuf (n : ℕ)
    (G : FiniteSimpleGraphEdgeData n)
    (A B : Finset (Sym2 (Fin n)))
    (hA : IsEvenEdgeSubsetOfData n G A) (hB : IsEvenEdgeSubsetOfData n G B) :
    IsEvenEdgeSubsetOfData n G (A ∆ B) := by
  exact Ising2DLambda.NecSuf.Tools.evenIncidenceSubset_symmDiff
    (fun v e => v ∈ e) G.edges A B hA hB

end Ising2DLambda.Tools
