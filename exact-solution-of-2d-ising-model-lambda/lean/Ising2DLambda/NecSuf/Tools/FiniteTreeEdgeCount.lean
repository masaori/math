import Mathlib.Combinatorics.SimpleGraph.Acyclic
import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.NecSuf.Tools

/-- The edge count only needs a finite vertex type and the tree property. -/
theorem finiteTree_edge_count {V : Type*} [Fintype V] (G : SimpleGraph V)
    [DecidableRel G.Adj] (h : G.IsTree) :
    G.edgeFinset.card + 1 = Fintype.card V := by
  exact h.card_edgeFinset

end Ising2DLambda.NecSuf.Tools
