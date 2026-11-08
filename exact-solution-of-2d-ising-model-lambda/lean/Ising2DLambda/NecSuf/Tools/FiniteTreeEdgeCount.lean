import Mathlib.Combinatorics.SimpleGraph.Acyclic
import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.NecSuf.Tools

open SimpleGraph Walk

/-- The edge count only needs a finite vertex type and the tree property. -/
theorem finiteTree_edge_count {V : Type*} [Fintype V] (G : SimpleGraph V)
    [DecidableRel G.Adj] (h : G.IsTree) :
    G.edgeFinset.card + 1 = Fintype.card V := by
  classical
  haveI : Nonempty V := h.connected.nonempty
  let o : V := Classical.choice inferInstance
  have hcard : ({o}ᶜ : Finset V).card + 1 = Fintype.card V := by
    rw [Finset.card_compl, Finset.card_singleton, Nat.sub_add_cancel Fintype.card_pos]
  rw [← hcard, add_left_inj]
  choose p hp hp_unique using (h.existsUnique_path · o)
  refine Eq.symm <| Finset.card_bij
    (fun v hv => ((p v).firstDart <| ?notNil).edge)
    (fun e he => ?memEdges) ?inj ?surj
  case notNil => exact not_nil_of_ne (by simpa using hv)
  case memEdges => simp
  case inj =>
    intro a ha b hb hab
    wlog hlength : (p a).length ≤ (p b).length generalizing a b
    · exact Eq.symm (this _ hb _ ha hab.symm (le_of_not_ge hlength))
    rw [dart_edge_eq_iff] at hab
    obtain (hsame | hreverse) := hab
    · exact congrArg (·.fst) hsame
    · have hstart : ((p a).firstDart <| not_nil_of_ne (by simpa using ha)).snd = b :=
        congrArg (·.snd) hreverse
      have hshort := congrArg length
        (hp_unique _ ((p a).tail.copy hstart rfl) (by
          simpa only [isPath_copy] using (hp _).tail))
      rw [length_copy, ← add_left_inj 1,
        length_tail_add_one (not_nil_of_ne (by simpa using ha))] at hshort
      omega
  case surj =>
    simp only [mem_edgeFinset, Finset.mem_compl, Finset.mem_singleton,
      Sym2.forall, SimpleGraph.mem_edgeSet]
    intro x y hxy
    wlog hlength : (p x).length ≤ (p y).length generalizing x y
    · rw [Sym2.eq_swap]
      exact this y x hxy.symm (le_of_not_ge hlength)
    refine ⟨y, ?_, dart_edge_eq_mk'_iff.2 <| Or.inr ?_⟩
    · rintro rfl
      rw [← hp_unique _ nil IsPath.nil,
        length_nil,
        ← hp_unique _ (.cons hxy .nil) (IsPath.nil.cons <| by
          simpa using hxy.ne),
        length_cons, length_nil] at hlength
      simp at hlength
    rw [← hp_unique _ (.cons hxy.symm (p x))
      ((cons_isPath_iff _ _).2 ⟨hp _, fun hy => ?contra⟩)]
    · simp
    case contra =>
      suffices (p x).takeUntil y hy = .cons hxy .nil by
        rw [← take_spec _ hy] at hlength
        simp [this, hp_unique _ _ ((hp _).dropUntil hy)] at hlength
      refine (h.existsUnique_path _ _).unique ((hp _).takeUntil _) ?_
      simp [hxy.ne]

end Ising2DLambda.NecSuf.Tools
