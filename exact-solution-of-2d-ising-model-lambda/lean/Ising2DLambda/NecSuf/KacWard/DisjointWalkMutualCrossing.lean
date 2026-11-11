/-
「辺を共有しない二本の閉歩道の混合横断数は交差形式に等しい」
（`claim_disjoint_walk_mutual_crossing_intersection`）の必要十分版。

具体版と同じ手順で証明する。
- `halfEdgeUse_local_crossing`: 同じ頂点の二通過について、横断の指示子が
  局所項「左を `C`・上を `D`」+「下を `C`・右を `D`」に等しい（四半辺の場合分け）。
- `mutualCrossing_parity`: 通過の対の和へ頂点の和を差し込み、分配して
  頂点ごとの半辺の使用回数の積の和にする（有限和）。
- `halfEdgeUse_vertex_sum`: 各頂点で四つの半辺の使用回数の和は零（台が偶辺鎖であること）。

格子・トーラス・辺の標識は取り去った。残した仮定と、その理由:
- 方向を `ZMod 4` に置き、入辺は `a + 2`、出辺は `a'` の半辺を使うとする。四半辺のうち
  左（2）・上（3）・下（1）・右（0）を局所項が名指すので、四方向の構造は外せない。
- 共通の頂点で二本の使う半辺が交わらないこと。外すと `a = a' = 0`（直進）と
  `b = 0, b' = 3`（左の半辺を共有する）で、横断しないのに局所項が一になる。
- 係数は `𝔽₂`。`a = 0, a' = 1` と `b = 1, b' = 0` のように二本がともに曲がると、
  局所項の二つの真偽値がともに一になり、和 `2` を零と読む必要がある。
- 非後退 `a' ≠ a + 2` は仮定しない。局所の場合分けは、半辺が交わらなければ非後退なしで通る
  （具体版で非後退を使うのは、一歩の回転数が零であることを `a' = a` へ直す段だけである）。
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 方向 `d ∈ ℤ/4ℤ` の軸（横 0・縦 1）。 -/
def halfEdgeAxis (d : ZMod 4) : ZMod 2 := (d.val : ZMod 2)

/-- 入る方向 `a`・出る方向 `a'` の通過が、方向 `d` の半辺を使う回数（𝔽₂）。 -/
def halfEdgeUse (a a' d : ZMod 4) : ZMod 2 :=
  (if a + 2 = d then 1 else 0) + (if a' = d then 1 else 0)

/-- 同じ頂点の二通過の局所の場合分け。横断の指示子は局所項に等しい。 -/
theorem halfEdgeUse_local_crossing (a a' b b' : ZMod 4)
    (hdisj : ∀ d, ¬ ((a + 2 = d ∨ a' = d) ∧ (b + 2 = d ∨ b' = d))) :
    (if a' = a ∧ b' = b ∧ halfEdgeAxis a ≠ halfEdgeAxis b then (1 : ZMod 2) else 0) =
      halfEdgeUse a a' 2 * halfEdgeUse b b' 3 + halfEdgeUse a a' 1 * halfEdgeUse b b' 0 := by
  revert a a' b b'
  unfold halfEdgeUse halfEdgeAxis
  decide

/-- 各頂点で四つの半辺の使用回数の和は零である。 -/
theorem halfEdgeUse_four_directions (a a' : ZMod 4) :
    halfEdgeUse a a' 0 + halfEdgeUse a a' 1 + halfEdgeUse a a' 2 + halfEdgeUse a a' 3 = 0 := by
  revert a a'
  unfold halfEdgeUse
  decide

/-- 頂点 `v` で通過の族が方向 `d` の半辺を使う回数の和。 -/
def vertexHalfEdgeUse {I V : Type*} [Fintype I] [DecidableEq V]
    (p : I → V) (a a' : I → ZMod 4) (v : V) (d : ZMod 4) : ZMod 2 :=
  ∑ r, if p r = v then halfEdgeUse (a r) (a' r) d else 0

/-- 頂点ごとの四半辺の使用回数の和は零（台が偶辺鎖であること）。 -/
theorem vertexHalfEdgeUse_four_directions {I V : Type*} [Fintype I] [DecidableEq V]
    (p : I → V) (a a' : I → ZMod 4) (v : V) :
    vertexHalfEdgeUse p a a' v 0 + vertexHalfEdgeUse p a a' v 1 +
      vertexHalfEdgeUse p a a' v 2 + vertexHalfEdgeUse p a a' v 3 = 0 := by
  unfold vertexHalfEdgeUse
  rw [← sum_add_distrib, ← sum_add_distrib, ← sum_add_distrib]
  apply sum_eq_zero
  intro r _
  split_ifs
  · exact halfEdgeUse_four_directions (a r) (a' r)
  · simp

/-- 混合横断の指示子の和は、頂点ごとの半辺の使用回数の積の和に等しい。 -/
theorem mutualCrossing_parity {I J V : Type*} [Fintype I] [Fintype J] [Fintype V]
    [DecidableEq V]
    (p : I → V) (q : J → V) (a a' : I → ZMod 4) (b b' : J → ZMod 4)
    (hdisj : ∀ r s, p r = q s →
      ∀ d, ¬ ((a r + 2 = d ∨ a' r = d) ∧ (b s + 2 = d ∨ b' s = d))) :
    (∑ r, ∑ s, if p r = q s ∧ a' r = a r ∧ b' s = b s ∧
        halfEdgeAxis (a r) ≠ halfEdgeAxis (b s) then (1 : ZMod 2) else 0) =
      ∑ v, (vertexHalfEdgeUse p a a' v 2 * vertexHalfEdgeUse q b b' v 3 +
        vertexHalfEdgeUse p a a' v 1 * vertexHalfEdgeUse q b b' v 0) := by
  calc
    (∑ r, ∑ s, if p r = q s ∧ a' r = a r ∧ b' s = b s ∧
        halfEdgeAxis (a r) ≠ halfEdgeAxis (b s) then (1 : ZMod 2) else 0)
        = ∑ r, ∑ s, if p r = q s then
            (halfEdgeUse (a r) (a' r) 2 * halfEdgeUse (b s) (b' s) 3 +
              halfEdgeUse (a r) (a' r) 1 * halfEdgeUse (b s) (b' s) 0) else 0 := by
          refine sum_congr rfl fun r _ => sum_congr rfl fun s _ => ?_
          by_cases hv : p r = q s
          · rw [if_pos hv, ← halfEdgeUse_local_crossing _ _ _ _ (hdisj r s hv)]
            simp [hv]
          · simp [hv]
    _ = ∑ r, ∑ s, ∑ v, if p r = v then (if q s = v then
            (halfEdgeUse (a r) (a' r) 2 * halfEdgeUse (b s) (b' s) 3 +
              halfEdgeUse (a r) (a' r) 1 * halfEdgeUse (b s) (b' s) 0) else 0) else 0 := by
          refine sum_congr rfl fun r _ => sum_congr rfl fun s _ => ?_
          rw [sum_ite_eq]
          simp [eq_comm]
    _ = ∑ r, ∑ s, ∑ v, ((if p r = v then halfEdgeUse (a r) (a' r) 2 else 0) *
            (if q s = v then halfEdgeUse (b s) (b' s) 3 else 0) +
          (if p r = v then halfEdgeUse (a r) (a' r) 1 else 0) *
            (if q s = v then halfEdgeUse (b s) (b' s) 0 else 0)) := by
          refine sum_congr rfl fun r _ => sum_congr rfl fun s _ => sum_congr rfl fun v _ => ?_
          split_ifs <;> simp
    _ = ∑ v, ∑ r, ∑ s, ((if p r = v then halfEdgeUse (a r) (a' r) 2 else 0) *
            (if q s = v then halfEdgeUse (b s) (b' s) 3 else 0) +
          (if p r = v then halfEdgeUse (a r) (a' r) 1 else 0) *
            (if q s = v then halfEdgeUse (b s) (b' s) 0 else 0)) := by
          exact (sum_congr rfl fun r _ => sum_comm).trans sum_comm
    _ = ∑ v, (vertexHalfEdgeUse p a a' v 2 * vertexHalfEdgeUse q b b' v 3 +
          vertexHalfEdgeUse p a a' v 1 * vertexHalfEdgeUse q b b' v 0) := by
          refine sum_congr rfl fun v _ => ?_
          simp only [vertexHalfEdgeUse, sum_mul_sum, ← sum_add_distrib]

end Ising2DLambda.NecSuf.KacWard
