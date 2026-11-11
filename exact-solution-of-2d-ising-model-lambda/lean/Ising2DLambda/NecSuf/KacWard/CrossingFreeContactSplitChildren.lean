/-
「横断のない閉歩道を接触点で分けても各子に横断は生じない」
（`claim_crossing_free_contact_split_children`）の必要十分版。

具体版と同じ手順で証明する。
- `four_distinct_directions_cover`: 相異なる四方向は `ZMod 4` を尽くす。
- `contact_vertex_passes`: 接触頂点の二通過は相異なる四半辺を使い、四方向を尽くすので、
  同じ頂点の通過は半辺を共有して二通過のどちらかに等しい。
- `contact_split_child_crossing_free`: 子の横断が接触頂点にあるなら、相手の通過も接触頂点にあり、
  二つの添字は `k`・`l` を一つずつ占めるが、子の添字の像は二つを同時には含まない。
  接触頂点の外では出辺が元と同じなので元の横断になり、元の横断数が零であることに反する。

格子・トーラス・辺の標識・閉歩道は取り去った。残した仮定と、その理由:
- 方向を `ZMod 4` に置き、入る方向 `a` の通過は半辺 `a + 2` を、出る方向 `a'` の通過は半辺 `a'` を使う。
  接触頂点の通過が二つだけである段が、二通過の四半辺で `ZMod 4` の四元を尽くすことに依るので、
  四方向の構造は外せない。
- 同じ頂点で半辺を共有する二通過は等しいこと（`hshared`）。具体版では辺の標識が相異なることから従う。
  外すと、接触頂点を三度通る歩道で子に横断が残り得る。
- 一つの通過の入る半辺と出る半辺は異なること（`hown`）。具体版では非後退から従う。外すと、
  二通過の使う半辺が四つに満たず、三つ目の通過を排除できない。
- 元の横断の述語の対称性（`hsymm`）。横断数は `a < b` の対だけを数えるので、子の横断の添字の像が
  逆順のときに要る。
- 子の添字の像は `k` と `l` を同時には含まないこと（`hnot`）。外すと、二つの子に分ける前の元の歩道
  そのもの（像が全体）でも結論が従うことになり、接触頂点での横断が排除できない。
- 子の横断は相異なる二つの添字の同じ頂点の通過であること（`hδ`）と、接触頂点の外では元の横断で
  あること（`horig`）。横断の中身（直進・軸）は使わない。
-/
import Ising2DLambda.NecSuf.KacWard.EdgeDistinctCrossingStraightVisits

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 相異なる四方向は `ZMod 4` を尽くす。 -/
theorem four_distinct_directions_cover (a b c e z : ZMod 4) (hab : a ≠ b) (hce : c ≠ e)
    (hac : a ≠ c) (hae : a ≠ e) (hbc : b ≠ c) (hbe : b ≠ e) :
    z = a ∨ z = b ∨ z = c ∨ z = e := by
  revert a b c e z
  decide

/-- 接触頂点の通過は、接触する二通過のどちらかに等しい。 -/
theorem contact_vertex_passes {ι V : Type*} (vertex : ι → V) (dIn dOut : ι → ZMod 4)
    (hshared : ∀ r p d, vertex r = vertex p →
      passUsesHalfEdge (dIn r) (dOut r) d → passUsesHalfEdge (dIn p) (dOut p) d → r = p)
    (hown : ∀ r, dIn r + 2 ≠ dOut r)
    (k l : ι) (hkl : k ≠ l) (hv : vertex k = vertex l)
    (r : ι) (hr : vertex r = vertex k) : r = k ∨ r = l := by
  have hsep : ∀ d, passUsesHalfEdge (dIn k) (dOut k) d →
      passUsesHalfEdge (dIn l) (dOut l) d → False :=
    fun d h1 h2 => hkl (hshared k l d hv h1 h2)
  rcases four_distinct_directions_cover (dIn k + 2) (dOut k) (dIn l + 2) (dOut l) (dIn r + 2)
      (hown k) (hown l)
      (fun h => hsep _ (Or.inl rfl) (Or.inl h.symm))
      (fun h => hsep _ (Or.inl rfl) (Or.inr h.symm))
      (fun h => hsep _ (Or.inr rfl) (Or.inl h.symm))
      (fun h => hsep _ (Or.inr rfl) (Or.inr h.symm)) with h | h | h | h
  · exact Or.inl (hshared r k _ hr (Or.inl rfl) (Or.inl h.symm))
  · exact Or.inl (hshared r k _ hr (Or.inl rfl) (Or.inr h.symm))
  · exact Or.inr (hshared r l _ (hr.trans hv) (Or.inl rfl) (Or.inl h.symm))
  · exact Or.inr (hshared r l _ (hr.trans hv) (Or.inl rfl) (Or.inr h.symm))

open Classical in
/-- 接触点分割の子の横断数は零である。 -/
theorem contact_split_child_crossing_free {ι κ V : Type*} [Fintype ι] [LinearOrder ι]
    [Fintype κ] [LinearOrder κ]
    (vertex : ι → V) (crossγ : ι → ι → Prop) (crossδ : κ → κ → Prop)
    (p : κ → ι) (hp : Function.Injective p) (k l : ι)
    (hpasses : ∀ r, vertex r = vertex k → r = k ∨ r = l)
    (hv : vertex k = vertex l)
    (hδ : ∀ i j, crossδ i j → i ≠ j ∧ vertex (p i) = vertex (p j))
    (horig : ∀ i j, crossδ i j → p i ≠ k → p i ≠ l → p j ≠ k → p j ≠ l → crossγ (p i) (p j))
    (hsymm : ∀ a b, crossγ a b → crossγ b a)
    (hzero : ((univ ×ˢ univ).filter fun q : ι × ι => q.1 < q.2 ∧ crossγ q.1 q.2).card = 0)
    (hnot : ∀ i j, p i = k → p j = l → False) :
    ((univ ×ˢ univ).filter fun q : κ × κ => q.1 < q.2 ∧ crossδ q.1 q.2).card = 0 := by
  rw [card_eq_zero, filter_eq_empty_iff]
  rintro ⟨i, j⟩ - ⟨-, hc⟩
  obtain ⟨hij, hvij⟩ := hδ i j hc
  have hpij : p i ≠ p j := fun h => hij (hp h)
  -- 接触頂点の横断: 相手の通過も接触頂点にあり、二つの添字は `k`・`l` を一つずつ占める。
  have hat : ∀ a b, (p a = k ∨ p a = l) → vertex (p a) = vertex (p b) → p a ≠ p b → False := by
    intro a b ha hab hne
    have hb : vertex (p b) = vertex k := by
      rcases ha with h | h
      · rw [← hab, h]
      · rw [← hab, h, hv]
    rcases ha with ha | ha <;> rcases hpasses (p b) hb with hb' | hb'
    · exact hne (ha.trans hb'.symm)
    · exact hnot a b ha hb'
    · exact hnot b a hb' ha
    · exact hne (ha.trans hb'.symm)
  by_cases hi : p i = k ∨ p i = l
  · exact hat i j hi hvij hpij
  by_cases hj : p j = k ∨ p j = l
  · exact hat j i hj hvij.symm hpij.symm
  push Not at hi hj
  -- 接触頂点の外: 元の横断であり、元の横断数が零であることに反する。
  have hcγ := horig i j hc hi.1 hi.2 hj.1 hj.2
  have hempty := filter_eq_empty_iff.mp (card_eq_zero.mp hzero)
  rcases lt_or_gt_of_ne hpij with hlt | hlt
  · exact hempty (x := (p i, p j)) (mem_product.mpr ⟨mem_univ _, mem_univ _⟩) ⟨hlt, hcγ⟩
  · exact hempty (x := (p j, p i)) (mem_product.mpr ⟨mem_univ _, mem_univ _⟩)
      ⟨hlt, hsymm _ _ hcγ⟩

end Ising2DLambda.NecSuf.KacWard
