import Ising2DLambda.Tools.FiniteRootedDescent
import Ising2DLambda.Tools.InducedTreeNonrootLeaf
import Ising2DLambda.Tools.InducedTreeRemoveLeaf
import Ising2DLambda.Tools.EvenEdgeLeafStep
import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.Tools

/-- A prescribed set of non-tree edges extends to even incidence away from the root. -/
theorem evenEdge_treeLeafInduction (n : ℕ) (G T : SimpleGraph (Fin n))
    [DecidableRel G.Adj] [DecidableRel T.Adj]
    (hTG : T ≤ G)
    (hTree : (T.induce ((Finset.univ : Finset (Fin n)) : Set (Fin n))).IsTree)
    (root : Fin n)
    (C : Finset (Sym2 (Fin n)))
    (hC : C ⊆ G.edgeFinset \ T.edgeFinset) :
    ∃ A : Finset (Sym2 (Fin n)), A ⊆ G.edgeFinset ∧
      A ∩ (G.edgeFinset \ T.edgeFinset) = C ∧
      ∀ w : Fin n, w ≠ root → edgeParity n A w = 0 := by
  classical
  let P : Finset (Fin n) → Finset (Sym2 (Fin n)) → Prop :=
    fun U A => root ∈ U ∧
      (T.induce (U : Set (Fin n))).IsTree ∧
      A ⊆ G.edgeFinset ∧
      (∀ f ∈ A, f ∈ T.edgeFinset → ∃ w ∈ f, w ∉ U) ∧
      (∀ w : Fin n, w ∉ U → edgeParity n A w = 0) ∧
      A ∩ (G.edgeFinset \ T.edgeFinset) = C
  have hroot : ∀ U A, P U A → root ∈ U := by
    intro U A h
    exact h.1
  have hstep : ∀ U A, P U A → U ≠ {root} →
      ∃ v B, v ∈ U ∧ v ≠ root ∧ P (U.erase v) B := by
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
        have : root ∈ ({v} : Finset (Fin n)) := hv ▸ hr
        have hrv : root = v := by simpa using this
        exact hrv.symm
      exact hsingle (hv.trans (by simp [hvr]))
    let r : {w : Fin n // w ∈ U} := ⟨root, hr⟩
    obtain ⟨leaf, parent, hne, hadj, hleaf⟩ :=
      inducedTree_has_nonrootLeaf n T U htwo ht r
    have hrootErase :=
      inducedTree_removeLeaf n T U ht r leaf parent hne.symm hadj hleaf
    let e : Sym2 (Fin n) := s(leaf.1, parent.1)
    have heT : e ∈ T.edgeFinset := SimpleGraph.mem_edgeFinset.mpr hadj
    have heG : e ∈ G.edgeFinset := SimpleGraph.mem_edgeFinset.mpr (hTG hadj)
    have heU : ∀ w : Fin n, w ∈ e → w ∈ U := by
      intro w hw
      rcases Sym2.mem_iff.mp hw with rfl | rfl
      · exact leaf.2
      · exact parent.2
    have hve : leaf.1 ∈ e := by simp [e]
    obtain ⟨B, hBE, _, hBp, hBi, hBo, _⟩ :=
      evenEdge_leafStep n A G.edgeFinset T.edgeFinset U leaf.1 e
        hve heU heT heG hAE hi hp
    refine ⟨leaf.1, B, leaf.2, ?_, hrootErase.1, hrootErase.2,
      hBE, hBi, hBp, ?_⟩
    · intro heq
      exact hne (Subtype.ext heq)
    · exact hBo.trans ho
  have hinit : P Finset.univ C := by
    refine ⟨Finset.mem_univ _, ?_, hC.trans (Finset.sdiff_subset), ?_, ?_, ?_⟩
    · exact hTree
    · intro f hf hfT
      exact False.elim ((Finset.mem_sdiff.mp (hC hf)).2 hfT)
    · intro w hw
      exact False.elim (hw (Finset.mem_univ _))
    · exact Finset.inter_eq_left.mpr hC
  obtain ⟨A, hfinal⟩ :=
    finiteRootedDescent n root P hroot hstep Finset.univ C hinit
  refine ⟨A, hfinal.2.2.1, hfinal.2.2.2.2.2, ?_⟩
  intro w hw
  exact hfinal.2.2.2.2.1 w (by simpa [hw])

end Ising2DLambda.Tools
