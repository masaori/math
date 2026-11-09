import Ising2DLambda.NecSuf.Tools.RootedTreeHasNonrootLeaf
import Ising2DLambda.NecSuf.Tools.EvenEdgeLeafStep
import Ising2DLambda.NecSuf.Tools.RootedLeafEdge
import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.NecSuf.Tools

/-- Only the finite induced tree and incidence of its leaf edge are needed. -/
theorem inducedTree_leafStep {V : Type*} [Fintype V] [DecidableEq V]
    (G T : SimpleGraph V) [DecidableRel G.Adj] [DecidableRel T.Adj]
    (hTG : T ≤ G) (U : Finset V) (hU : 2 ≤ U.card)
    (hTree : (T.induce (U : Set V)).IsTree)
    (root : {w : V // w ∈ U}) (A : Finset (Sym2 V))
    (hAE : A ⊆ G.edgeFinset)
    (hinside : ∀ f ∈ A, f ∈ T.edgeFinset → ∃ w ∈ f, w ∉ U)
    (hprocessed : ∀ w : V, w ∉ U →
      incidenceParity (fun w f => w ∈ f) A w = 0) :
    ∃ (leaf parent : {w : V // w ∈ U}) (A' : Finset (Sym2 V)),
      leaf ≠ root ∧
      (T.induce (U : Set V)).Adj leaf parent ∧
      s(leaf.1, parent.1) ∉ A ∧
      A' ⊆ G.edgeFinset ∧
      (∀ w : V, w ∉ U.erase leaf.1 →
        incidenceParity (fun w f => w ∈ f) A' w = 0) ∧
      (∀ f ∈ A', f ∈ T.edgeFinset → ∃ w ∈ f, w ∉ U.erase leaf.1) ∧
      A' ∩ (G.edgeFinset \ T.edgeFinset) = A ∩ (G.edgeFinset \ T.edgeFinset) := by
  classical
  haveI : Nontrivial {w : V // w ∈ U} :=
    Fintype.one_lt_card_iff_nontrivial.mp (by simpa using (show 1 < U.card by omega))
  obtain ⟨leaf, parent, hleaf, hadj, _⟩ :=
    rootedTree_has_nonrootLeaf (T.induce (U : Set V)) hTree root
  let e : Sym2 V := s(leaf.1, parent.1)
  have heT : e ∈ T.edgeFinset := SimpleGraph.mem_edgeFinset.mpr hadj
  have heG : e ∈ G.edgeFinset := SimpleGraph.mem_edgeFinset.mpr (hTG hadj)
  have heU : ∀ w : V, w ∈ e → w ∈ U := by
    intro w hw
    rcases Sym2.mem_iff.mp hw with rfl | rfl
    · exact leaf.2
    · exact parent.2
  have hve : leaf.1 ∈ e := by simp [e]
  have hnotA : e ∉ A := by
    intro heA
    obtain ⟨w, hwe, hwU⟩ := hinside e heA heT
    exact hwU (heU w hwe)
  obtain ⟨A', hA'E, _, hA'processed, hA'inside, hA'outside, _⟩ :=
    incidenceParity_leafStep (fun w f => w ∈ f)
      A G.edgeFinset T.edgeFinset (U : Set V) leaf.1 e
      hve heU heT heG hAE hinside hprocessed
  refine ⟨leaf, parent, A', hleaf, hadj, hnotA,
    hA'E, ?_, ?_, hA'outside⟩
  · intro w hw
    apply hA'processed w
    intro hwU
    exact hw (Finset.mem_erase.mpr ⟨hwU.2, hwU.1⟩)
  · intro f hf hfT
    obtain ⟨w, hwf, hw⟩ := hA'inside f hf hfT
    refine ⟨w, hwf, ?_⟩
    intro hwErase
    obtain ⟨hne, hU⟩ := Finset.mem_erase.mp hwErase
    exact hw ⟨hU, hne⟩

end Ising2DLambda.NecSuf.Tools
