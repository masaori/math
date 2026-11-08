import Mathlib.Combinatorics.SimpleGraph.Acyclic
import Mathlib.Combinatorics.SimpleGraph.Paths
import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.Tools

open SimpleGraph Walk

theorem nonemptyTreeEdgeSubset_has_leaf (n : ℕ)
    (G : SimpleGraph (Fin n)) [DecidableRel G.Adj] (hG : G.IsTree)
    (A : Finset (Sym2 (Fin n))) (hA : A ⊆ G.edgeFinset) (hne : A.Nonempty) :
    ∃ v w : Fin n, s(v, w) ∈ A ∧ ∀ u : Fin n, s(v, u) ∈ A → u = w := by
  classical
  let H : SimpleGraph (Fin n) := SimpleGraph.fromEdgeSet (A : Set (Sym2 (Fin n)))
  have hH_le : H ≤ G := by
    rw [SimpleGraph.fromEdgeSet_le]
    intro e he
    exact SimpleGraph.mem_edgeFinset.mp (hA he.1)
  have hH : H.IsAcyclic := hG.isAcyclic.anti hH_le
  haveI : Nonempty (Fin n) := hG.connected.nonempty
  obtain ⟨x, y, p, hp, hmax⟩ := Walk.exists_isPath_forall_isPath_length_le_length H
  -- A selected edge gives a positive length path, so the maximal path has a first edge.
  have hpos : 0 < p.length := by
    obtain ⟨e, he⟩ := hne
    induction e using Sym2.ind with
    | _ a b =>
      have hab : H.Adj a b := by
        have habG : G.Adj a b := SimpleGraph.mem_edgeFinset.mp (hA he)
        change s(a, b) ∈ (A : Set (Sym2 (Fin n))) ∧ a ≠ b
        exact ⟨he, habG.ne⟩
      have hlen := hmax a b (.cons hab .nil) (IsPath.nil.cons (by simpa using hab.ne))
      simp only [Walk.length_cons, Walk.length_nil] at hlen
      omega
  have hnotnil : ¬ p.Nil := by simpa [not_nil_iff_lt_length] using hpos
  refine ⟨x, p.snd, ?_, ?_⟩
  · have hfirst : H.Adj x p.snd := p.adj_snd hnotnil
    exact hfirst.1
  · intro u hu
    have hadj : H.Adj x u := by
      have hadjG : G.Adj x u := SimpleGraph.mem_edgeFinset.mp (hA hu)
      change s(x, u) ∈ (A : Set (Sym2 (Fin n))) ∧ x ≠ u
      exact ⟨hu, hadjG.ne⟩
    -- A neighbor outside the path would extend it; a neighbor on the path is its second vertex.
    have husupp : u ∈ p.support := by
      by_contra hnot
      have hlong := hmax u y (.cons hadj.symm p) (hp.cons hnot)
      simp at hlong
    exact hH.eq_snd_of_adj_start hp hadj husupp

end Ising2DLambda.Tools
