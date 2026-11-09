import Ising2DLambda.Tools.EvenEdgeTreeExtension

namespace Ising2DLambda.Tools

/-- Even edge subsets are indexed exactly by their edges outside a spanning tree. -/
theorem evenEdge_treeComplementBijection (n : ℕ) (G T : SimpleGraph (Fin n))
    [DecidableRel G.Adj] [DecidableRel T.Adj]
    (hTG : T ≤ G) (hTree : T.IsTree) (root : Fin n) :
    Function.Bijective
      (fun A : {A : Finset (Sym2 (Fin n)) // IsEvenEdgeSubsetOf n G A} =>
        (⟨A.1 ∩ (G.edgeFinset \ T.edgeFinset), Finset.inter_subset_right⟩ :
          {C : Finset (Sym2 (Fin n)) // C ⊆ G.edgeFinset \ T.edgeFinset})) := by
  classical
  constructor
  · intro A B h
    apply Subtype.ext
    exact evenEdgeSubset_treeComplement_injective n G T hTree hTG
      A.1 B.1 A.2 B.2 (congrArg Subtype.val h)
  · intro C
    obtain ⟨A, hA, _⟩ := evenEdge_treeExtension n G T hTG hTree root C.1 C.2
    refine ⟨⟨A, hA.1⟩, ?_⟩
    apply Subtype.ext
    exact hA.2

end Ising2DLambda.Tools
