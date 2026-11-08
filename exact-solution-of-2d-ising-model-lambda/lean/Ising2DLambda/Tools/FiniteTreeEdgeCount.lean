import Mathlib.Combinatorics.SimpleGraph.Acyclic
import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.Tools

/-- Edge count for an actual finite graph on numbered vertices. -/
theorem finiteTree_edge_count (n : ℕ) (G : SimpleGraph (Fin n))
    [DecidableRel G.Adj] (h : G.IsTree) :
    G.edgeFinset.card + 1 = n := by
  simpa using h.card_edgeFinset

end Ising2DLambda.Tools
