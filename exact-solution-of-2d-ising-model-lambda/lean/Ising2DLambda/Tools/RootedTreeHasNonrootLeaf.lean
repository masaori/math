import Mathlib.Combinatorics.SimpleGraph.Acyclic
import Mathlib.Combinatorics.SimpleGraph.Paths
import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.Tools

open SimpleGraph Walk

/-- A nontrivial finite tree has a leaf distinct from any prescribed root. -/
theorem rootedTree_has_nonrootLeaf (n : ℕ) (hn : 2 ≤ n)
    (G : SimpleGraph (Fin n)) [DecidableRel G.Adj] (hG : G.IsTree) (root : Fin n) :
    ∃ leaf parent : Fin n, leaf ≠ root ∧ G.Adj leaf parent ∧
      ∀ w : Fin n, G.Adj leaf w → w = parent := by
  classical
  haveI : Nontrivial (Fin n) := Fin.nontrivial_iff_two_le.mpr hn
  obtain ⟨x, y, p, hp, hmax⟩ := Walk.exists_isPath_forall_isPath_length_le_length G
  obtain ⟨a, b, hab⟩ := exists_pair_ne (Fin n)
  obtain ⟨q, hq⟩ := hG.connected.preconnected.exists_isPath a b
  have hqpos : 0 < q.length := by
    have hne : q.length ≠ 0 := by
      intro hz
      exact hab (Walk.exists_length_eq_zero_iff.mp ⟨q, hz⟩)
    exact Nat.pos_of_ne_zero hne
  have hpos : 0 < p.length := lt_of_lt_of_le hqpos (hmax a b q hq)
  have hnotnil : ¬ p.Nil := by simpa [not_nil_iff_lt_length] using hpos
  have hendpoint : ∀ (u v : Fin n) (r : G.Walk u v), r.IsPath →
      r.length = p.length → ∀ w : Fin n, G.Adj u w → w = r.snd := by
    intro u v r hr hlen w hw
    have hmem : w ∈ r.support := by
      by_contra hnot
      have hlong := hmax w v (.cons hw.symm r) (hr.cons hnot)
      simp [hlen] at hlong
    exact hG.isAcyclic.eq_snd_of_adj_start hr hw hmem
  have hstart := hendpoint x y p hp rfl
  have hend : ∀ w : Fin n, G.Adj y w → w = p.penultimate := by
    simpa [Walk.snd_reverse] using hendpoint y x p.reverse hp.reverse (by simp)
  by_cases hxr : x = root
  · refine ⟨y, p.penultimate, ?_, (p.adj_penultimate hnotnil).symm, hend⟩
    intro hyr
    have hxy : x ≠ y := by
      intro hxy
      have hnil : p.Nil := hp.nil_iff_eq.mpr hxy
      exact (Walk.not_nil_iff_lt_length.mpr hpos) hnil
    exact hxy (hxr.trans hyr.symm)
  · exact ⟨x, p.snd, hxr, p.adj_snd hnotnil, hstart⟩

end Ising2DLambda.Tools
