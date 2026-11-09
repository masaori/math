import Ising2DLambda.Tools.NonemptyTreeEdgeSubsetLeaf
import Ising2DLambda.Tools.EvenEdgeSymmDiff

namespace Ising2DLambda.Tools

open scoped symmDiff

private theorem edgeParity_eq_one_of_unique (n : ℕ)
    (D : Finset (Sym2 (Fin n))) (v w : Fin n)
    (hvw : s(v, w) ∈ D)
    (hunique : ∀ u : Fin n, s(v, u) ∈ D → u = w) :
    edgeParity n D v = 1 := by
  classical
  unfold edgeParity
  rw [Finset.sum_eq_single (s(v, w))]
  · simp [hvw]
  · intro e _ hne
    by_cases he : e ∈ D
    · by_cases hv : v ∈ e
      · obtain ⟨u, rfl⟩ := Sym2.mem_iff_exists.mp hv
        exact (hne (congrArg (fun u => s(v, u)) (hunique u he))).elim
      · simp [hv]
    · simp [he]
  · simp

theorem evenEdgeSubset_treeComplement_injective (n : ℕ)
    (G T : SimpleGraph (Fin n)) [DecidableRel G.Adj] [DecidableRel T.Adj]
    (hT : T.IsTree) (_hTG : T ≤ G)
    (A B : Finset (Sym2 (Fin n)))
    (hA : IsEvenEdgeSubsetOf n G A) (hB : IsEvenEdgeSubsetOf n G B)
    (hsame : A ∩ (G.edgeFinset \ T.edgeFinset) =
      B ∩ (G.edgeFinset \ T.edgeFinset)) : A = B := by
  classical
  let D := A ∆ B
  -- 本文の対称差の偶数性。
  have hD_even : IsEvenEdgeSet n D := evenEdgeSet_symmDiff n A B hA.2 hB.2
  -- 木外辺での一致により、対称差に残る辺は木の辺だけである。
  have hD_tree : D ⊆ T.edgeFinset := by
    intro e he
    by_contra hnot
    have heG : e ∈ G.edgeFinset := by
      rcases Finset.mem_union.mp (Finset.symmDiff_subset_union he) with ha | hb
      · exact hA.1 ha
      · exact hB.1 hb
    have hs : e ∈ A ↔ e ∈ B := by
      have h := congrArg (fun S : Finset (Sym2 (Fin n)) => e ∈ S) hsame
      simpa [heG, hnot] using h
    rcases (Finset.mem_symmDiff.mp he) with ⟨ha, hnb⟩ | ⟨hb, hna⟩
    · exact hnb (hs.mp ha)
    · exact hna (hs.mpr hb)
  -- 非空なら端点で接続辺数が一となり、偶数性に反する。
  have hD_empty : D = ∅ := by
    by_contra hne
    obtain ⟨v, w, hvw, hunique⟩ :=
      nonemptyTreeEdgeSubset_has_leaf n T hT D hD_tree (Finset.nonempty_iff_ne_empty.mpr hne)
    have hodd : edgeParity n D v = 1 := edgeParity_eq_one_of_unique n D v w hvw hunique
    have heven := hD_even v
    have : (1 : ZMod 2) = 0 := hodd.symm.trans heven
    norm_num at this
  exact Finset.symmDiff_eq_empty.mp hD_empty

end Ising2DLambda.Tools
