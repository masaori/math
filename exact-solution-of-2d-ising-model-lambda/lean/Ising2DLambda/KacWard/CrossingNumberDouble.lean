/-
「添字対の横断」「閉歩道の横断数」「順序つき横断対の個数は横断数の二倍である」
（`def_index_pair_crossing`・`def_closed_walk_crossing_number`・
`claim_ordered_crossing_pairs_double`）の具体版。
通過の添字を `Fin m`、通過の頂点と局所データを添字からの写像で持つ。
住処は有限集合の数え上げ（ℕ）であり、ℝ / ℂ は現れない。
-/
import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.KacWard.TransverseCrossing
import Ising2DLambda.NecSuf.KacWard.CrossingNumberDouble

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 添字対の横断（`def_index_pair_crossing`）: 通過の頂点が等しく、
二つの通過がその頂点で横断すること。 -/
def IndexCrossing {m : ℕ} {V : Type} (vertex : Fin m → V)
    (visit : Fin m → LocalVisit) (k l : Fin m) : Prop :=
  vertex k = vertex l ∧ TransverseCrossing (visit k) (visit l)

instance {m : ℕ} {V : Type} [DecidableEq V] (vertex : Fin m → V)
    (visit : Fin m → LocalVisit) (k l : Fin m) :
    Decidable (IndexCrossing vertex visit k l) := by
  unfold IndexCrossing TransverseCrossing
  infer_instance

/-- 横断の対称性（人手証明の第二段が使う形）: 頂点の等式の対称性と
`transverse_crossing_symmetric` を合わせる。 -/
theorem indexCrossing_symm {m : ℕ} {V : Type} (vertex : Fin m → V)
    (visit : Fin m → LocalVisit) (k l : Fin m)
    (h : IndexCrossing vertex visit k l) : IndexCrossing vertex visit l k :=
  ⟨h.1.symm, (transverse_crossing_symmetric (visit k) (visit l)).mp h.2⟩

/-- 順序つき横断対の個数は横断数（`k < l` の対の個数）の二倍である（具体版）。
人手証明と同じ三段: 三分律による分割・入れ替え写像の全単射・個数の和。 -/
theorem ordered_crossing_pairs_double {m : ℕ} {V : Type} [DecidableEq V]
    (vertex : Fin m → V) (visit : Fin m → LocalVisit) :
    ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 ≠ p.2 ∧ IndexCrossing vertex visit p.1 p.2).card
      = 2 * ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).card := by
  -- 三分律による分割: A = A_< ∪ A_>
  have hsplit :
      ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 ≠ p.2 ∧ IndexCrossing vertex visit p.1 p.2)
        = ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
            p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2)
          ∪ ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
            p.2 < p.1 ∧ IndexCrossing vertex visit p.1 p.2) := by
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
  -- A_< と A_> は交わらない
  have hdisj :
      Disjoint ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2)
        ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.2 < p.1 ∧ IndexCrossing vertex visit p.1 p.2) := by
    rw [Finset.disjoint_left]
    rintro p hp hq
    exact lt_asymm (Finset.mem_filter.mp hp).2.1 (Finset.mem_filter.mp hq).2.1
  -- 入れ替え写像による全単射: |A_>| = |A_<|
  have hswap :
      ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.2 < p.1 ∧ IndexCrossing vertex visit p.1 p.2).card
        = ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).card := by
    refine Finset.card_bij' (fun p _ => Prod.swap p) (fun p _ => Prod.swap p)
      ?_ ?_ ?_ ?_
    · rintro ⟨k, l⟩ hp
      obtain ⟨hmem, hlt, hr⟩ := Finset.mem_filter.mp hp
      exact Finset.mem_filter.mpr
        ⟨Finset.mem_product.mpr
          ⟨Finset.mem_univ _, Finset.mem_univ _⟩, hlt,
          indexCrossing_symm vertex visit k l hr⟩
    · rintro ⟨k, l⟩ hp
      obtain ⟨hmem, hlt, hr⟩ := Finset.mem_filter.mp hp
      exact Finset.mem_filter.mpr
        ⟨Finset.mem_product.mpr
          ⟨Finset.mem_univ _, Finset.mem_univ _⟩, hlt,
          indexCrossing_symm vertex visit k l hr⟩
    · rintro ⟨k, l⟩ _
      rfl
    · rintro ⟨k, l⟩ _
      rfl
  -- 個数の和と二倍
  rw [hsplit, Finset.card_union_of_disjoint hdisj, hswap]
  omega

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem ordered_crossing_pairs_double_from_necSuf {m : ℕ} {V : Type} [DecidableEq V]
    (vertex : Fin m → V) (visit : Fin m → LocalVisit) :
    ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 ≠ p.2 ∧ IndexCrossing vertex visit p.1 p.2).card
      = 2 * ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).card :=
  ordered_pairs_double_necSuf Finset.univ (IndexCrossing vertex visit)
    (fun k l => indexCrossing_symm vertex visit k l)

end Ising2DLambda.KacWard
