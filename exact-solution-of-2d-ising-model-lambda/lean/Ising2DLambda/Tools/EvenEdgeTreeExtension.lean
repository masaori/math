import Ising2DLambda.Tools.EvenEdgeTreeLeafInduction
import Ising2DLambda.Tools.EvenEdgeRootParity
import Ising2DLambda.Tools.EvenEdgeTreeComplementInjective

namespace Ising2DLambda.Tools

/-- Prescribing the non-tree edges determines exactly one even edge set. -/
theorem evenEdge_treeExtension (n : ℕ) (G T : SimpleGraph (Fin n))
    [DecidableRel G.Adj] [DecidableRel T.Adj]
    (hTG : T ≤ G) (hTree : T.IsTree) (root : Fin n)
    (C : Finset (Sym2 (Fin n)))
    (hC : C ⊆ G.edgeFinset \ T.edgeFinset) :
    ∃! A : Finset (Sym2 (Fin n)),
      IsEvenEdgeSubsetOf n G A ∧
        A ∩ (G.edgeFinset \ T.edgeFinset) = C := by
  classical
  have hInduced :
      (T.induce ((Finset.univ : Finset (Fin n)) : Set (Fin n))).IsTree :=
    by
      have hset : ((Finset.univ : Finset (Fin n)) : Set (Fin n)) = Set.univ := by
        ext v
        simp
      rw [hset]
      exact (SimpleGraph.induceUnivIso T).isTree_iff.mpr hTree
  -- The leaf induction constructs the prescribed edge set away from the root.
  obtain ⟨A, hAE, houtside, hother⟩ :=
    evenEdge_treeLeafInduction n G T hTG hInduced root C hC
  -- Recounting endpoints supplies parity at the remaining root.
  have hroot := evenEdgeSubset_root_of_other_even n G A root hAE hother
  have hEven : IsEvenEdgeSubsetOf n G A := by
    refine ⟨hAE, ?_⟩
    intro w
    by_cases hw : w = root
    · simpa [hw] using hroot
    · exact hother w hw
  refine ⟨A, ⟨hEven, houtside⟩, ?_⟩
  intro B hB
  exact (evenEdgeSubset_treeComplement_injective n G T hTree hTG
    B A hB.1 hEven (hB.2.trans houtside.symm))

end Ising2DLambda.Tools
