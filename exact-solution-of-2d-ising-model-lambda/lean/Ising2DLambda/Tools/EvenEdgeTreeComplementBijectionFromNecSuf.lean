import Ising2DLambda.Tools.EvenEdgeTreeComplementBijection
import Ising2DLambda.NecSuf.Tools.EvenEdgeTreeComplementBijection

namespace Ising2DLambda.Tools

/-- The necessary and sufficient version specializes to finite labelled vertices. -/
theorem evenEdge_treeComplementBijection_from_necSuf (n : ℕ)
    (G T : SimpleGraph (Fin n)) [DecidableRel G.Adj] [DecidableRel T.Adj]
    (hTG : T ≤ G) (hTree : T.IsTree) (root : Fin n) :
    Function.Bijective
      (fun A : {A : Finset (Sym2 (Fin n)) // IsEvenEdgeSubsetOf n G A} =>
        (⟨A.1 ∩ (G.edgeFinset \ T.edgeFinset), Finset.inter_subset_right⟩ :
          {C : Finset (Sym2 (Fin n)) // C ⊆ G.edgeFinset \ T.edgeFinset})) := by
  classical
  exact Ising2DLambda.NecSuf.Tools.evenEdge_treeComplementBijection
    G T hTG hTree root

end Ising2DLambda.Tools
