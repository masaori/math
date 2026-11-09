import Ising2DLambda.NecSuf.Tools.EvenEdgeTreeLeafInduction
import Ising2DLambda.NecSuf.Tools.EvenEdgeRootParity
import Ising2DLambda.NecSuf.Tools.EvenEdgeTreeComplementInjective
import Ising2DLambda.NecSuf.Tools.NonemptyTreeEdgeSubsetLeaf

namespace Ising2DLambda.NecSuf.Tools

/-- Only finiteness, a tree, and parity of the two endpoints are used. -/
theorem evenEdge_treeExtension {V : Type*} [Fintype V] [DecidableEq V]
    (G T : SimpleGraph V) [DecidableRel G.Adj] [DecidableRel T.Adj]
    (hTG : T ≤ G) (hTree : T.IsTree) (root : V)
    (C : Finset (Sym2 V)) (hC : C ⊆ G.edgeFinset \ T.edgeFinset) :
    ∃! A : Finset (Sym2 V),
      (A ⊆ G.edgeFinset ∧ IsEvenIncidence (fun v e => v ∈ e) A) ∧
        A ∩ (G.edgeFinset \ T.edgeFinset) = C := by
  classical
  have hset : ((Finset.univ : Finset V) : Set V) = Set.univ := by
    ext v
    simp
  have hInduced :
      (T.induce ((Finset.univ : Finset V) : Set V)).IsTree := by
    rw [hset]
    exact (SimpleGraph.induceUnivIso T).isTree_iff.mpr hTree
  obtain ⟨A, hAE, houtside, hother⟩ :=
    evenEdge_treeLeafInduction G T hTG hInduced root C hC
  have hedge : ∀ e ∈ A,
      (∑ v : V, if v ∈ e then (1 : ZMod 2) else 0) = 0 := by
    intro e he
    induction e using Sym2.ind with
    | _ a b =>
      have hab : a ≠ b := (SimpleGraph.mem_edgeFinset.mp (hAE he)).ne
      have hcard : (Finset.univ.filter (fun v : V => v = a ∨ v = b)).card = 2 := by
        have heq : Finset.univ.filter (fun v : V => v = a ∨ v = b) = {a, b} := by
          ext v
          simp [Finset.mem_filter, eq_comm]
        rw [heq]
        simp [hab]
      simpa [Sym2.mem_iff, hcard] using (show (2 : ZMod 2) = 0 by decide)
  have hroot := incidenceParity_root_of_other_even
    (fun v e => v ∈ e) A root hedge hother
  have hEven : A ⊆ G.edgeFinset ∧ IsEvenIncidence (fun v e => v ∈ e) A := by
    refine ⟨hAE, ?_⟩
    intro w
    by_cases hw : w = root
    · simpa [hw] using hroot
    · exact hother w hw
  have hLeaf : ∀ D : Finset (Sym2 V), D ⊆ T.edgeFinset → D.Nonempty →
      ∃ v : V, ∃ e : Sym2 V, e ∈ D ∧ v ∈ e ∧
        ∀ f ∈ D, v ∈ f → f = e := by
    intro D hD hne
    obtain ⟨v, w, hvw, hunique⟩ :=
      nonemptyTreeEdgeSubset_has_leaf T hTree D hD hne
    refine ⟨v, s(v, w), hvw, Sym2.mem_mk_left v w, ?_⟩
    intro f hf hvf
    obtain ⟨u, rfl⟩ := Sym2.mem_iff_exists.mp hvf
    exact congrArg (fun u => s(v, u)) (hunique u hf)
  refine ⟨A, ⟨hEven, houtside⟩, ?_⟩
  intro B hB
  exact evenIncidenceSubset_treeComplement_injective
    (fun v e => v ∈ e) G.edgeFinset T.edgeFinset B A
    hB.1 hEven hLeaf (hB.2.trans houtside.symm)

end Ising2DLambda.NecSuf.Tools
