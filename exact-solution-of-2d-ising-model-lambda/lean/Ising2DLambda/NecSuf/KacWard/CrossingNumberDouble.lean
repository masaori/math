/-
「順序つき横断対の個数は横断数の二倍である」（`claim_ordered_crossing_pairs_double`）の必要十分版。

人手証明が使うのは、添字の全順序の三分律（`k ≠ l` を `k < l` と `l < k` へ分ける）、
互いに交わらない有限集合の個数の和、そして入れ替え写像が二つの半分の間の全単射になること
（関係の対称性）だけである。頂点・方向番号・直進性・閉歩道の構造は使わない。
関係 `r` の対称性が仮定に残るのは、入れ替え写像の行き先が集合に入るために必要だからである。
-/
import Mathlib.Data.Finset.Prod
import Mathlib.Order.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 対称な関係について、順序を無視した対（`p.1 ≠ p.2`）の個数は、
順序を固定した対（`p.1 < p.2`）の個数の二倍である。
人手証明と同じく、三分律による分割・個数の和・入れ替え写像の全単射の三段で示す。 -/
theorem ordered_pairs_double_necSuf {ι : Type} [LinearOrder ι]
    (s : Finset ι) (r : ι → ι → Prop) [DecidableRel r]
    (symm : ∀ k l, r k l → r l k) :
    ((s ×ˢ s).filter fun p => p.1 ≠ p.2 ∧ r p.1 p.2).card
      = 2 * ((s ×ˢ s).filter fun p => p.1 < p.2 ∧ r p.1 p.2).card := by
  -- 三分律による分割: A = A_< ∪ A_>（人手証明の第一段）
  have hsplit :
      ((s ×ˢ s).filter fun p => p.1 ≠ p.2 ∧ r p.1 p.2)
        = ((s ×ˢ s).filter fun p => p.1 < p.2 ∧ r p.1 p.2)
          ∪ ((s ×ˢ s).filter fun p => p.2 < p.1 ∧ r p.1 p.2) := by
    ext p
    simp only [Finset.mem_union, Finset.mem_filter]
    constructor
    · rintro ⟨hp, hne, hr⟩
      rcases lt_or_gt_of_ne hne with h | h
      · exact Or.inl ⟨hp, h, hr⟩
      · exact Or.inr ⟨hp, h, hr⟩
    · rintro (⟨hp, h, hr⟩ | ⟨hp, h, hr⟩)
      · exact ⟨hp, ne_of_lt h, hr⟩
      · exact ⟨hp, (ne_of_lt h).symm, hr⟩
  -- A_< と A_> は交わらない（三分律の残り半分）
  have hdisj :
      Disjoint ((s ×ˢ s).filter fun p => p.1 < p.2 ∧ r p.1 p.2)
        ((s ×ˢ s).filter fun p => p.2 < p.1 ∧ r p.1 p.2) := by
    rw [Finset.disjoint_left]
    rintro p hp hq
    exact lt_asymm (Finset.mem_filter.mp hp).2.1 (Finset.mem_filter.mp hq).2.1
  -- 入れ替え写像 sw による全単射: |A_>| = |A_<|（人手証明の第二段）
  have hswap :
      ((s ×ˢ s).filter fun p => p.2 < p.1 ∧ r p.1 p.2).card
        = ((s ×ˢ s).filter fun p => p.1 < p.2 ∧ r p.1 p.2).card := by
    refine Finset.card_bij' (fun p _ => Prod.swap p) (fun p _ => Prod.swap p)
      ?_ ?_ ?_ ?_
    · rintro ⟨k, l⟩ hp
      obtain ⟨hmem, hlt, hr⟩ := Finset.mem_filter.mp hp
      obtain ⟨hk, hl⟩ := Finset.mem_product.mp hmem
      exact Finset.mem_filter.mpr
        ⟨Finset.mem_product.mpr ⟨hl, hk⟩, hlt, symm k l hr⟩
    · rintro ⟨k, l⟩ hp
      obtain ⟨hmem, hlt, hr⟩ := Finset.mem_filter.mp hp
      obtain ⟨hk, hl⟩ := Finset.mem_product.mp hmem
      exact Finset.mem_filter.mpr
        ⟨Finset.mem_product.mpr ⟨hl, hk⟩, hlt, symm k l hr⟩
    · rintro ⟨k, l⟩ _
      rfl
    · rintro ⟨k, l⟩ _
      rfl
  -- 個数の和と二倍（人手証明の最終の式変形）
  rw [hsplit, Finset.card_union_of_disjoint hdisj, hswap]
  omega

end Ising2DLambda.NecSuf.KacWard
