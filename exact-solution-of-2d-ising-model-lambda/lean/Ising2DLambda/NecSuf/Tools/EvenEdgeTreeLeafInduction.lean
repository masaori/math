import Ising2DLambda.NecSuf.Tools.FiniteRootedDescent
import Ising2DLambda.NecSuf.Tools.RootedTreeHasNonrootLeaf
import Ising2DLambda.NecSuf.Tools.InducedTreeRemoveLeaf
import Ising2DLambda.NecSuf.Tools.EvenEdgeLeafStep
import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.NecSuf.Tools

/-- Finite descent only needs a tree, incidence parity, and a prescribed complement. -/
theorem evenEdge_treeLeafInduction {V : Type*} [Fintype V] [DecidableEq V]
    (G T : SimpleGraph V) [DecidableRel G.Adj] [DecidableRel T.Adj]
    (hTG : T ≤ G)
    (hTree : (T.induce ((Finset.univ : Finset V) : Set V)).IsTree)
    (root : V) (C : Finset (Sym2 V))
    (hC : C ⊆ G.edgeFinset \ T.edgeFinset) :
    ∃ A : Finset (Sym2 V), A ⊆ G.edgeFinset ∧
      A ∩ (G.edgeFinset \ T.edgeFinset) = C ∧
      ∀ w : V, w ≠ root → incidenceParity (fun w f => w ∈ f) A w = 0 := by
  classical
  let P : Finset V → Finset (Sym2 V) → Prop :=
    fun U A => root ∈ U ∧
      (T.induce (U : Set V)).IsTree ∧
      A ⊆ G.edgeFinset ∧
      (∀ f ∈ A, f ∈ T.edgeFinset → ∃ w ∈ f, w ∉ U) ∧
      (∀ w : V, w ∉ U → incidenceParity (fun w f => w ∈ f) A w = 0) ∧
      A ∩ (G.edgeFinset \ T.edgeFinset) = C
  have hstep : ∀ U A, P U A → U ≠ {root} →
      ∃ v B, v ∈ U ∧ P (U.erase v) B := by
    intro U A hP hsingle
    obtain ⟨hr, ht, hAE, hi, hp, ho⟩ := hP
    have htwo : 2 ≤ U.card := by
      by_contra hnot
      have hle : U.card ≤ 1 := by omega
      have hcard : U.card = 1 := by
        have hpos : 0 < U.card := Finset.card_pos.mpr ⟨root, hr⟩
        omega
      obtain ⟨v, hv⟩ := Finset.card_eq_one.mp hcard
      have hvr : v = root := by
        have hm : root ∈ ({v} : Finset V) := hv ▸ hr
        have hrv : root = v := by simpa using hm
        exact hrv.symm
      exact hsingle (hv.trans (by simp [hvr]))
    let r : {w : V // w ∈ U} := ⟨root, hr⟩
    haveI : Nontrivial {w : V // w ∈ U} :=
      Fintype.one_lt_card_iff_nontrivial.mp (by simpa using (show 1 < U.card by omega))
    obtain ⟨leaf, parent, hne, hadj, hleaf⟩ :=
      rootedTree_has_nonrootLeaf (T.induce (U : Set V)) ht r
    have hrootErase :=
      inducedTree_removeLeaf T U ht r leaf parent hne.symm hadj hleaf
    let e : Sym2 V := s(leaf.1, parent.1)
    have heT : e ∈ T.edgeFinset := SimpleGraph.mem_edgeFinset.mpr hadj
    have heG : e ∈ G.edgeFinset := SimpleGraph.mem_edgeFinset.mpr (hTG hadj)
    have heU : ∀ w : V, w ∈ e → w ∈ U := by
      intro w hw
      rcases Sym2.mem_iff.mp hw with rfl | rfl
      · exact leaf.2
      · exact parent.2
    have hve : leaf.1 ∈ e := by simp [e]
    obtain ⟨B, hBE, _, hBp, hBi, hBo, _⟩ :=
      incidenceParity_leafStep (fun w f => w ∈ f)
        A G.edgeFinset T.edgeFinset (U : Set V) leaf.1 e
        hve heU heT heG hAE hi hp
    refine ⟨leaf.1, B, leaf.2, hrootErase.1, hrootErase.2,
      hBE, ?_, ?_, hBo.trans ho⟩
    · intro f hf hfT
      obtain ⟨w, hwf, hw⟩ := hBi f hf hfT
      exact ⟨w, hwf, by
        intro hwe
        exact hw ⟨(Finset.mem_erase.mp hwe).2, (Finset.mem_erase.mp hwe).1⟩⟩
    · intro w hw
      apply hBp w
      intro hwU
      exact hw (Finset.mem_erase.mpr ⟨hwU.2, hwU.1⟩)
  have hinit : P Finset.univ C := by
    refine ⟨Finset.mem_univ _, hTree,
      hC.trans (Finset.sdiff_subset), ?_, ?_, Finset.inter_eq_left.mpr hC⟩
    · intro f hf hfT
      exact False.elim ((Finset.mem_sdiff.mp (hC hf)).2 hfT)
    · intro w hw
      exact False.elim (hw (Finset.mem_univ _))
  obtain ⟨A, hfinal⟩ :=
    finiteRootedDescent root P hstep Finset.univ C hinit
  refine ⟨A, hfinal.2.2.1, hfinal.2.2.2.2.2, ?_⟩
  intro w hw
  exact hfinal.2.2.2.2.1 w (by simpa [hw])

end Ising2DLambda.NecSuf.Tools
