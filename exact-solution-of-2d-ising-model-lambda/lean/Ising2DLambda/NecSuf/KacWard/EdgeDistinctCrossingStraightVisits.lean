/-
「辺の重複がない閉歩道の平滑化で横断数の偶奇は交差形式に分かれる」
（`claim_edge_distinct_smoothing_crossing_parity`）の証明の第一段
「横断の頂点では各軸の直進通過数が一である」の必要十分版。

具体版と同じ手順で証明する。
- `crossing_halfEdges_cover`: 横断する二通過は直進で軸が異なるので、四方向の半辺を使い尽くす。
- `crossing_vertex_passes`: 同じ頂点の通過は半辺を一つは共有するので、二通過のどちらかに等しい。
- `crossing_straightVisitCount_eq_one`: 各軸の直進通過は、二通過のうち軸がその値のもの一つだけである。

格子・トーラス・辺の標識は取り去った。残した仮定と、その理由:
- 方向を `ZMod 4` に置き、入辺の方向 `a` の通過は半辺 `a + 2` を、出辺の方向 `a'` の通過は
  半辺 `a'` を使うとする。四半辺を使い尽くす段が、軸の異なる二方向とその反対で `ZMod 4` の
  四元を尽くすことに依るので、四方向の構造は外せない。
- 同じ頂点で半辺を共有する二通過は等しいこと（`hshared`）。具体版では辺の標識が相異なること
  から従う。外すと、同じ頂点を同じ向きに二度直進する閉歩道で直進通過数が二になる。
- 横断する二通過が直進すること（出る方向が入る方向に等しい）。外すと、入る方向が軸の異なる二通過でも
  使う半辺が `a + 2, a'` の二つとその相手の二つで重なり得て、四半辺を尽くさない。
- 軸の値は `ZMod 2` に取る（二値であることを、軸が異なる二通過の一方が任意の軸の値を取る段で使う）。
- 直進の述語 `straight` は任意でよい。横断する二通過で成り立つことだけを使う。
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Fintype.Card

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 入る方向 `a`・出る方向 `a'` の通過が方向 `d` の半辺を使うこと。 -/
def passUsesHalfEdge (a a' d : ZMod 4) : Prop := a + 2 = d ∨ a' = d

/-- 方向 `d ∈ ℤ/4ℤ` の軸（横 0・縦 1）。 -/
def straightVisitAxis (d : ZMod 4) : ZMod 2 := (d.val : ZMod 2)

/-- 直進で軸の異なる二通過は四方向の半辺を使い尽くす。 -/
theorem crossing_halfEdges_cover (a a' b b' : ZMod 4) (ha : a' = a) (hb : b' = b)
    (haxis : straightVisitAxis a ≠ straightVisitAxis b) (d : ZMod 4) :
    passUsesHalfEdge a a' d ∨ passUsesHalfEdge b b' d := by
  have htable : ∀ x y z : ZMod 4, straightVisitAxis x ≠ straightVisitAxis y →
      (x + 2 = z ∨ x = z) ∨ (y + 2 = z ∨ y = z) := by
    unfold straightVisitAxis
    decide
  unfold passUsesHalfEdge
  rw [ha, hb]
  exact htable a b d haxis

/-- 横断の頂点の通過は、横断する二通過のどちらかに等しい。 -/
theorem crossing_vertex_passes {ι V : Type*} (vertex : ι → V) (dIn dOut : ι → ZMod 4)
    (hshared : ∀ r p d, vertex r = vertex p →
      passUsesHalfEdge (dIn r) (dOut r) d → passUsesHalfEdge (dIn p) (dOut p) d → r = p)
    (k l : ι) (hv : vertex k = vertex l)
    (hk : dOut k = dIn k) (hl : dOut l = dIn l)
    (haxis : straightVisitAxis (dIn k) ≠ straightVisitAxis (dIn l))
    (r : ι) (hr : vertex r = vertex k) : r = k ∨ r = l := by
  rcases crossing_halfEdges_cover (dIn k) (dOut k) (dIn l) (dOut l) hk hl haxis
      (dIn r + 2) with h | h
  · exact Or.inl (hshared r k _ hr (Or.inl rfl) h)
  · exact Or.inr (hshared r l _ (hr.trans hv) (Or.inl rfl) h)

/-- 各軸の直進通過数は一である。 -/
theorem crossing_straightVisitCount_eq_one {ι V : Type*} [Fintype ι] [DecidableEq ι]
    [DecidableEq V] (vertex : ι → V) (dIn dOut : ι → ZMod 4)
    (straight : ι → Prop) [DecidablePred straight]
    (hshared : ∀ r p d, vertex r = vertex p →
      passUsesHalfEdge (dIn r) (dOut r) d → passUsesHalfEdge (dIn p) (dOut p) d → r = p)
    (k l : ι) (hv : vertex k = vertex l)
    (hk : dOut k = dIn k) (hl : dOut l = dIn l)
    (hsk : straight k) (hsl : straight l)
    (haxis : straightVisitAxis (dIn k) ≠ straightVisitAxis (dIn l)) (a : ZMod 2) :
    (univ.filter fun r => vertex r = vertex k ∧ straight r ∧
      straightVisitAxis (dIn r) = a).card = 1 := by
  have htwo : ∀ x y z : ZMod 2, x ≠ y → x ≠ z → y = z := by decide
  rw [card_eq_one]
  by_cases hka : straightVisitAxis (dIn k) = a
  · refine ⟨k, ?_⟩
    ext r
    simp only [mem_filter, mem_univ, true_and, mem_singleton]
    constructor
    · rintro ⟨hr, -, hra⟩
      rcases crossing_vertex_passes vertex dIn dOut hshared k l hv hk hl haxis r hr with h | h
      · exact h
      · subst h
        exact absurd (hka.trans hra.symm) haxis
    · rintro rfl
      exact ⟨rfl, hsk, hka⟩
  · refine ⟨l, ?_⟩
    ext r
    simp only [mem_filter, mem_univ, true_and, mem_singleton]
    constructor
    · rintro ⟨hr, -, hra⟩
      rcases crossing_vertex_passes vertex dIn dOut hshared k l hv hk hl haxis r hr with h | h
      · subst h
        exact absurd hra hka
      · exact h
    · rintro rfl
      exact ⟨hv.symm, hsl, htwo _ _ _ haxis hka⟩

end Ising2DLambda.NecSuf.KacWard
