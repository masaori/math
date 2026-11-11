/-
「辺の重複がない閉歩道の平滑化で横断数の偶奇は交差形式に分かれる」
（`claim_edge_distinct_smoothing_crossing_parity`）の証明の第一段の具体版。
住処は有限集合・ℤ/4ℤ・𝔽₂・ℕ で、ℝ / ℂ は現れない。

人手証明との対応:
- 「横断する二通過は同じ頂点 v にあり、二軸をそれぞれ直進する」: `indexPairCrossing` の成分と、
  直進は方向番号が変わらないことを述べる `stepTurning_eq_zero_iff`（`crossing_straight`）。
- 「それぞれの通過が使う入出半辺は対向する二半辺であり、二通過で四半辺を使い尽くす」:
  `crossing_halfEdges_cover`。
- 「辺の標識が相異なるので、v に別の通過はない」: 同じ頂点で同じ半辺を使う二通過は等しい
  （`pass_shared_halfEdge_eq`。半辺は頂点と方向で一つの向き付き辺に決まり、入る向きと出る向きの
  向き付き辺は互いの反転なので、辺の標識が等しければ添字が等しい）と、
  `crossing_vertex_passes`。
- 「従って n_{v,0}(γ) = n_{v,1}(γ) = 1」: `crossing_vertexAxisStraightVisitCount_eq_one`。
-/
import Ising2DLambda.KacWard.DisjointWalkMutualCrossing
import Ising2DLambda.KacWard.VertexAxisStraightVisitCount
import Ising2DLambda.NecSuf.KacWard.EdgeDistinctCrossingStraightVisits

namespace Ising2DLambda.KacWard

open Finset
open Ising2DLambda.PartitionPolynomial

variable {L : ℕ} [NeZero L]

/-- 添字 `r` の通過（入辺 `γ r`・出辺 `γ (succ r)`）が方向 `d` の半辺を使うこと。 -/
def walkPassUsesHalfEdge {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (r : Fin (m + 1)) (d : ZMod 4) : Prop :=
  directionNumber (γ r) + 2 = d ∨ directionNumber (γ (closedWalkSuccessor r)) = d

/-- 横断する二通過は直進する: 出辺の方向番号は入辺の方向番号に等しい。 -/
theorem crossing_straight {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hkl : indexPairCrossing γ hγ k l) :
    directionNumber (γ (closedWalkSuccessor k)) = directionNumber (γ k) ∧
      directionNumber (γ (closedWalkSuccessor l)) = directionNumber (γ l) := by
  obtain ⟨-, hk, hl, -, hsk, hsl, -⟩ := hkl
  exact ⟨(stepTurning_eq_zero_iff _ _ hk).mp hsk, (stepTurning_eq_zero_iff _ _ hl).mp hsl⟩

/-- 横断する二通過は四方向の半辺を使い尽くす。 -/
theorem crossing_halfEdges_cover {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hkl : indexPairCrossing γ hγ k l) (d : ZMod 4) :
    walkPassUsesHalfEdge γ k d ∨ walkPassUsesHalfEdge γ l d := by
  obtain ⟨hk, hl⟩ := crossing_straight γ hγ hkl
  have haxis := hkl.2.2.2.2.2.2
  have htable : ∀ x y z : ZMod 4, directionAxis x ≠ directionAxis y →
      (x + 2 = z ∨ x = z) ∨ (y + 2 = z ∨ y = z) := by
    unfold directionAxis
    decide
  unfold walkPassUsesHalfEdge
  rw [hk, hl]
  exact htable _ _ d haxis

omit [NeZero L] in
/-- 入る向きの向き付き辺と出る向きの向き付き辺が同じ半辺を担うことはない
（両者は互いの反転であり、辺の標識が相異なる閉歩道では添字が等しくなって矛盾する）。 -/
theorem incoming_outgoing_absurd {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hinj : Function.Injective fun k => (γ k).1) (x y : Fin (m + 1)) (H : OrientedEdge L)
    (hx : γ x = reversal H) (hy : γ y = H) : False := by
  have hxy : x = y := hinj (by simp only [hx, hy, reversal])
  subst hxy
  have h2 := congrArg Prod.snd (hx.symm.trans hy)
  simp [reversal] at h2

/-- 同じ頂点で同じ半辺を使う二通過は等しい。 -/
theorem pass_shared_halfEdge_eq {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun k => (γ k).1)
    (r p : Fin (m + 1)) (d : ZMod 4) (hv : orientedTarget (γ r) = orientedTarget (γ p))
    (hr : walkPassUsesHalfEdge γ r d) (hp : walkPassUsesHalfEdge γ p d) : r = p := by
  set v := orientedTarget (γ p)
  have hinc : ∀ x, orientedTarget (γ x) = v → directionNumber (γ x) + 2 = d →
      γ x = reversal (halfEdgeOutgoing v d) :=
    fun x hx hd => (halfEdgeIncoming_iff (γ x) v d).mp ⟨hx, hd⟩
  have hout : ∀ x, orientedTarget (γ x) = v →
      directionNumber (γ (closedWalkSuccessor x)) = d →
      γ (closedWalkSuccessor x) = halfEdgeOutgoing v d :=
    fun x hx hd => (halfEdgeOutgoing_iff _ v d).mp
      ⟨(closedWalk_target_eq_source γ hγ x).symm.trans hx, hd⟩
  rcases hr with hr | hr <;> rcases hp with hp | hp
  · exact hinj (by
      change (γ r).1 = (γ p).1
      rw [hinc r hv hr, hinc p rfl hp])
  · exact (incoming_outgoing_absurd γ hinj r _ _ (hinc r hv hr) (hout p rfl hp)).elim
  · exact (incoming_outgoing_absurd γ hinj p _ _ (hinc p rfl hp) (hout r hv hr)).elim
  · exact closedWalkSuccessor_injective (hinj (by
      change (γ (closedWalkSuccessor r)).1 = (γ (closedWalkSuccessor p)).1
      rw [hout r hv hr, hout p rfl hp]))

/-- 横断の頂点の通過は、横断する二通過のどちらかに等しい。 -/
theorem crossing_vertex_passes {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun k => (γ k).1)
    {k l : Fin (m + 1)} (hkl : indexPairCrossing γ hγ k l)
    (r : Fin (m + 1)) (hr : orientedTarget (γ r) = orientedTarget (γ k)) : r = k ∨ r = l := by
  have hv : orientedTarget (γ k) = orientedTarget (γ l) := hkl.2.2.2.1
  rcases crossing_halfEdges_cover γ hγ hkl (directionNumber (γ r) + 2) with h | h
  · exact Or.inl (pass_shared_halfEdge_eq γ hγ hinj r k _ hr (Or.inl rfl) h)
  · exact Or.inr (pass_shared_halfEdge_eq γ hγ hinj r l _ (hr.trans hv) (Or.inl rfl) h)

/-- 証明の第一段: 横断の頂点 `v` で各軸の直進通過数は一である（`n_{v,0}(γ) = n_{v,1}(γ) = 1`）。 -/
theorem crossing_vertexAxisStraightVisitCount_eq_one {m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (hinj : Function.Injective fun k => (γ k).1)
    {k l : Fin (m + 1)} (hkl : indexPairCrossing γ hγ k l) (a : ZMod 2) :
    vertexAxisStraightVisitCount γ hγ (orientedTarget (γ k)) a = 1 := by
  classical
  have hv : orientedTarget (γ k) = orientedTarget (γ l) := hkl.2.2.2.1
  have hsk : stepTurning (γ k) (γ (closedWalkSuccessor k)) = 0 := hkl.2.2.2.2.1
  have hsl : stepTurning (γ l) (γ (closedWalkSuccessor l)) = 0 := hkl.2.2.2.2.2.1
  have haxis : directionAxis (directionNumber (γ k)) ≠ directionAxis (directionNumber (γ l)) :=
    hkl.2.2.2.2.2.2
  have htwo : ∀ x y z : ZMod 2, x ≠ y → x ≠ z → y = z := by decide
  unfold vertexAxisStraightVisitCount
  simp only [closedWalkPassVertex, closedWalkPass]
  rw [card_eq_one]
  by_cases hka : directionAxis (directionNumber (γ k)) = a
  · refine ⟨k, ?_⟩
    ext r
    simp only [mem_filter, mem_univ, true_and, mem_singleton]
    constructor
    · rintro ⟨hr, -, hra⟩
      rcases crossing_vertex_passes γ hγ hinj hkl r hr with h | h
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
      rcases crossing_vertex_passes γ hγ hinj hkl r hr with h | h
      · subst h
        exact absurd hra hka
      · exact h
    · rintro rfl
      exact ⟨hv.symm, hsl, htwo _ _ _ haxis hka⟩

/-- 具体版が必要十分版 `crossing_straightVisitCount_eq_one` の特殊化として得られること。
通過の添字を歩道の添字、頂点を入辺の終点、入る方向・出る方向を入辺・出辺の方向番号に取る。 -/
theorem crossing_vertexAxisStraightVisitCount_eq_one_from_necSuf {m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (hinj : Function.Injective fun k => (γ k).1)
    {k l : Fin (m + 1)} (hkl : indexPairCrossing γ hγ k l) (a : ZMod 2) :
    vertexAxisStraightVisitCount γ hγ (orientedTarget (γ k)) a = 1 := by
  classical
  obtain ⟨hk, hl⟩ := crossing_straight γ hγ hkl
  unfold vertexAxisStraightVisitCount
  simp only [closedWalkPassVertex, closedWalkPass]
  exact Ising2DLambda.NecSuf.KacWard.crossing_straightVisitCount_eq_one
    (fun r => orientedTarget (γ r)) (fun r => directionNumber (γ r))
    (fun r => directionNumber (γ (closedWalkSuccessor r)))
    (fun r => stepTurning (γ r) (γ (closedWalkSuccessor r)) = 0)
    (fun r p d hv hr hp => pass_shared_halfEdge_eq γ hγ hinj r p d hv hr hp)
    k l hkl.2.2.2.1 hk hl hkl.2.2.2.2.1 hkl.2.2.2.2.2.1 hkl.2.2.2.2.2.2 a

end Ising2DLambda.KacWard
