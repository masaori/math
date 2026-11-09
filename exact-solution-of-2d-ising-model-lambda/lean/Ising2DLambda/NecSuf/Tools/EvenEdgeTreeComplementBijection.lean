import Ising2DLambda.NecSuf.Tools.EvenEdgeTreeExtension

namespace Ising2DLambda.NecSuf.Tools

/-- Finiteness, even incidence, and unique extension are sufficient for the bijection. -/
theorem evenEdge_treeComplementBijection {V : Type*} [Fintype V] [DecidableEq V]
    (G T : SimpleGraph V) [DecidableRel G.Adj] [DecidableRel T.Adj]
    (hTG : T ≤ G) (hTree : T.IsTree) (root : V) :
    Function.Bijective
      (fun A : {A : Finset (Sym2 V) //
          A ⊆ G.edgeFinset ∧ IsEvenIncidence (fun v e => v ∈ e) A} =>
        (⟨A.1 ∩ (G.edgeFinset \ T.edgeFinset), Finset.inter_subset_right⟩ :
          {C : Finset (Sym2 V) // C ⊆ G.edgeFinset \ T.edgeFinset})) := by
  classical
  constructor
  · intro A B h
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
    apply Subtype.ext
    exact evenIncidenceSubset_treeComplement_injective
      (fun v e => v ∈ e) G.edgeFinset T.edgeFinset A.1 B.1
      A.2 B.2 hLeaf (congrArg Subtype.val h)
  · intro C
    obtain ⟨A, hA, _⟩ := evenEdge_treeExtension G T hTG hTree root C.1 C.2
    refine ⟨⟨A, hA.1⟩, ?_⟩
    apply Subtype.ext
    exact hA.2

end Ising2DLambda.NecSuf.Tools
