import Ising2DLambda.Tools.InducedTreeNonrootLeaf
import Ising2DLambda.Tools.RootedLeafEdge
import Ising2DLambda.Tools.EvenEdgeLeafStep

namespace Ising2DLambda.Tools

/-- The leaf of the actual unprocessed tree supplies an admissible parity step. -/
theorem inducedTree_leafStep (n : ℕ) (G T : SimpleGraph (Fin n))
    [DecidableRel G.Adj] [DecidableRel T.Adj] (hTG : T ≤ G)
    (U : Finset (Fin n)) (hU : 2 ≤ U.card)
    (hTree : (T.induce (U : Set (Fin n))).IsTree)
    (root : {w : Fin n // w ∈ U}) (A : Finset (Sym2 (Fin n)))
    (hAE : A ⊆ G.edgeFinset)
    (hinside : ∀ f ∈ A, f ∈ T.edgeFinset → ∃ w ∈ f, w ∉ U)
    (hprocessed : ∀ w : Fin n, w ∉ U → edgeParity n A w = 0) :
    ∃ (leaf parent : {w : Fin n // w ∈ U}) (A' : Finset (Sym2 (Fin n))),
      leaf ≠ root ∧
      (T.induce (U : Set (Fin n))).Adj leaf parent ∧
      s(leaf.1, parent.1) ∉ A ∧
      A' ⊆ G.edgeFinset ∧
      (∀ w : Fin n, w ∉ U.erase leaf.1 → edgeParity n A' w = 0) ∧
      (∀ f ∈ A', f ∈ T.edgeFinset → ∃ w ∈ f, w ∉ U.erase leaf.1) ∧
      A' ∩ (G.edgeFinset \ T.edgeFinset) = A ∩ (G.edgeFinset \ T.edgeFinset) := by
  classical
  obtain ⟨leaf, parent, hleaf, hadj, _⟩ :=
    inducedTree_has_nonrootLeaf n T U hU hTree root
  let e : Sym2 (Fin n) := s(leaf.1, parent.1)
  have heT : e ∈ T.edgeFinset := SimpleGraph.mem_edgeFinset.mpr hadj
  have heG : e ∈ G.edgeFinset := SimpleGraph.mem_edgeFinset.mpr (hTG hadj)
  have heU : ∀ w : Fin n, w ∈ e → w ∈ U := by
    intro w hw
    rcases Sym2.mem_iff.mp hw with rfl | rfl
    · exact leaf.2
    · exact parent.2
  have hve : leaf.1 ∈ e := by simp [e]
  have hnotA : e ∉ A :=
    rootedLeafEdge_unselected n G T hTG U A hinside leaf parent hadj
  obtain ⟨A', hA'E, _, hA'processed, hA'inside, hA'outside, _⟩ :=
    evenEdge_leafStep n A G.edgeFinset T.edgeFinset U leaf.1 e
      hve heU heT heG hAE hinside hprocessed
  exact ⟨leaf, parent, A', hleaf, hadj, hnotA,
    hA'E, hA'processed, hA'inside, hA'outside⟩

end Ising2DLambda.Tools
