import Ising2DLambda.Tools.NonemptyTreeEdgeSubsetLeaf
import Ising2DLambda.NecSuf.Tools.NonemptyTreeEdgeSubsetLeaf

namespace Ising2DLambda.Tools

theorem nonemptyTreeEdgeSubset_has_leaf_from_necSuf (n : ℕ)
    (G : SimpleGraph (Fin n)) [DecidableRel G.Adj] (hG : G.IsTree)
    (A : Finset (Sym2 (Fin n))) (hA : A ⊆ G.edgeFinset) (hne : A.Nonempty) :
    ∃ v w : Fin n, s(v, w) ∈ A ∧ ∀ u : Fin n, s(v, u) ∈ A → u = w := by
  exact Ising2DLambda.NecSuf.Tools.nonemptyTreeEdgeSubset_has_leaf G hG A hA hne

end Ising2DLambda.Tools
