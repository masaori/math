import Ising2DLambda.Tools.EvenEdgeTreeComplementInjective
import Ising2DLambda.NecSuf.Tools.EvenEdgeTreeComplementInjective

namespace Ising2DLambda.Tools

theorem evenEdgeSubset_treeComplement_injective_from_necSuf (n : ℕ)
    (G T : SimpleGraph (Fin n)) [DecidableRel G.Adj] [DecidableRel T.Adj]
    (hT : T.IsTree) (_hTG : T ≤ G)
    (A B : Finset (Sym2 (Fin n)))
    (hA : IsEvenEdgeSubsetOf n G A) (hB : IsEvenEdgeSubsetOf n G B)
    (hsame : A ∩ (G.edgeFinset \ T.edgeFinset) =
      B ∩ (G.edgeFinset \ T.edgeFinset)) : A = B := by
  classical
  have hLeaf : ∀ D : Finset (Sym2 (Fin n)), D ⊆ T.edgeFinset → D.Nonempty →
      ∃ v : Fin n, ∃ e : Sym2 (Fin n), e ∈ D ∧ v ∈ e ∧
        ∀ f ∈ D, v ∈ f → f = e := by
    intro D hD hne
    obtain ⟨v, w, hvw, hunique⟩ :=
      nonemptyTreeEdgeSubset_has_leaf n T hT D hD hne
    refine ⟨v, s(v, w), hvw, Sym2.mem_mk_left v w, ?_⟩
    intro f hf hvf
    obtain ⟨u, rfl⟩ := Sym2.mem_iff_exists.mp hvf
    exact congrArg (fun u => s(v, u)) (hunique u hf)
  exact Ising2DLambda.NecSuf.Tools.evenIncidenceSubset_treeComplement_injective
    (fun v e => v ∈ e) G.edgeFinset T.edgeFinset A B
    ⟨hA.1, hA.2⟩ ⟨hB.1, hB.2⟩ hLeaf hsame

end Ising2DLambda.Tools
