import Ising2DLambda.Tools.RootedTreeHasNonrootLeaf

namespace Ising2DLambda.Tools

open SimpleGraph Walk

/-- The leaf theorem applies to the actual tree on the unprocessed vertices. -/
theorem inducedTree_has_nonrootLeaf (n : ℕ) (T : SimpleGraph (Fin n))
    [DecidableRel T.Adj] (U : Finset (Fin n))
    (hU : 2 ≤ U.card) (hTree : (T.induce (U : Set (Fin n))).IsTree)
    (root : {w : Fin n // w ∈ U}) :
    ∃ leaf parent : {w : Fin n // w ∈ U}, leaf ≠ root ∧
      (T.induce (U : Set (Fin n))).Adj leaf parent ∧
      ∀ w : {w : Fin n // w ∈ U},
        (T.induce (U : Set (Fin n))).Adj leaf w → w = parent := by
  classical
  haveI : Nontrivial {w : Fin n // w ∈ U} :=
    Fintype.one_lt_card_iff_nontrivial.mp (by simpa using (show 1 < U.card by omega))
  -- The maximal-path proof is the same for the finite type of unprocessed vertices.
  obtain ⟨x, y, p, hp, hmax⟩ :=
    Walk.exists_isPath_forall_isPath_length_le_length (T.induce (U : Set (Fin n)))
  obtain ⟨a, b, hab⟩ := exists_pair_ne {w : Fin n // w ∈ U}
  obtain ⟨q, hq⟩ := hTree.connected.preconnected.exists_isPath a b
  have hqpos : 0 < q.length := by
    have hne : q.length ≠ 0 := by
      intro hz
      exact hab (SimpleGraph.Walk.exists_length_eq_zero_iff.mp ⟨q, hz⟩)
    exact Nat.pos_of_ne_zero hne
  have hpos : 0 < p.length := lt_of_lt_of_le hqpos (hmax a b q hq)
  have hnotnil : ¬ p.Nil := by simpa [SimpleGraph.Walk.not_nil_iff_lt_length] using hpos
  have hendpoint : ∀ (u v : {w : Fin n // w ∈ U})
      (r : (T.induce (U : Set (Fin n))).Walk u v), r.IsPath →
      r.length = p.length → ∀ w, (T.induce (U : Set (Fin n))).Adj u w → w = r.snd := by
    intro u v r hr hlen w hw
    have hmem : w ∈ r.support := by
      by_contra hnot
      have hlong := hmax w v (.cons hw.symm r) (hr.cons hnot)
      simp [hlen] at hlong
    exact hTree.isAcyclic.eq_snd_of_adj_start hr hw hmem
  have hstart := hendpoint x y p hp rfl
  have hend : ∀ w, (T.induce (U : Set (Fin n))).Adj y w → w = p.penultimate := by
    simpa [SimpleGraph.Walk.snd_reverse] using
      hendpoint y x p.reverse hp.reverse (by simp)
  by_cases hxr : x = root
  · refine ⟨y, p.penultimate, ?_, (p.adj_penultimate hnotnil).symm, hend⟩
    intro hyr
    have hxy : x ≠ y := by
      intro hxy
      have hnil : p.Nil := hp.nil_iff_eq.mpr hxy
      exact (SimpleGraph.Walk.not_nil_iff_lt_length.mpr hpos) hnil
    exact hxy (hxr.trans hyr.symm)
  · exact ⟨x, p.snd, hxr, p.adj_snd hnotnil, hstart⟩

end Ising2DLambda.Tools
