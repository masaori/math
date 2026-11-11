/-
「横断の平滑化は循環総回転数を保つ」（`claim_smoothing_cyclic_turning_invariance`）の、
閉じた辺列についての必要十分版。具体版
`Ising2DLambda.KacWard.closedWalk_smoothing_cyclic_turning_invariance` と同じ手順
（四つの接続から方向の二通りの展開 → 剰余の一致 → 差の整除 → 値域から新二項の和が零 →
二項を分けた有限和の保存 → 巡回後続による循環総回転数の書き直し）で示す。

仮定と、それが要る理由:
- 方向の値 `G` は `AddCancelCommMonoid`。二通りの展開を並べ替えるのに可換性と結合性、
  共通の `dir e + dir e'` を消すのに左簡約、`π(D) + π(S₂) = π(S₁)` から `π(D) = 0` を出すのに右簡約が要る。
  減法は要らない。
- 整数から方向への写像 `π : ℤ →+ G`。加法性が二項の和を一つの像にまとめるのに要る。
- `hker`: `π(D) = 0` なら `4 ∣ D`。具体版の `ZMod.intCast_zmod_eq_zero_iff_dvd` の向きだけを使う。
  これを外すと、値域 {0,1,-1} だけでは新二項の和が零に決まらない。
- `hrange`: 一歩の回転数は 0, 1, -1 のいずれか。差が −4 以上 4 以下に収まること、
  および新二項の和が −2 以上 2 以下であることに要る。
- `hadv`: 接続する二辺では、方向が回転数の像だけ進む（`claim_step_advances_direction`）。
  四つの接続にだけ使う。
- 四つの接続と旧二項の直進性（`hk`・`hl`・`hkl'`・`hlk'`・`h0k`・`h0l`）は、横断の定義と
  平滑化後の出辺の確認（`def_smoothed_cyclic_total_turning`）が与えるものである。
-/
import Mathlib.Algebra.Group.Hom.Defs
import Mathlib.Algebra.BigOperators.Fin
import Ising2DLambda.NecSuf.KacWard.CyclicTotalTurning
import Ising2DLambda.NecSuf.KacWard.SmoothedCyclicTotalTurning
import Ising2DLambda.NecSuf.KacWard.SmoothingTurningInvariance

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

/-- 巡回後続で書いた和は循環総回転数である（`def_closed_walk_passes` の `σ` の定義）。 -/
theorem cyclicTotalTurning_eq_sum_cyclicSuccessor_necSuf {E : Type*} {m : ℕ}
    (turn : E → E → ℤ) (γ : Fin (m + 1) → E) :
    ∑ r : Fin (m + 1), turn (γ r) (γ (cyclicSuccessor r)) = cyclicTotalTurning turn γ := by
  rw [Fin.sum_univ_castSucc]
  have hinner : ∀ j : Fin m, cyclicSuccessor (Fin.castSucc j) = Fin.succ j := by
    intro j
    simp [cyclicSuccessor, Fin.ext_iff]
  have hlast : cyclicSuccessor (Fin.last m) = 0 := by
    simp [cyclicSuccessor]
  simp only [hinner, hlast, cyclicTotalTurning, edgeSequenceTotalTurning]

/-- 接続の組み替えの回転差は −4, 0, 4 に限る（四つの接続について、具体版
`edge_reconnection_turning_difference` と同じ手順）。 -/
theorem reconnection_turning_difference_walk_necSuf
    {E G : Type*} [AddCancelCommMonoid G]
    (next : E → E → Prop) (turn : E → E → ℤ) (dir : E → G) (π : ℤ →+ G)
    (hker : ∀ D : ℤ, π D = 0 → (4 : ℤ) ∣ D)
    (hrange : ∀ e f : E, turn e f = 0 ∨ turn e f = 1 ∨ turn e f = -1)
    (hadv : ∀ e f : E, next e f → dir f = dir e + π (turn e f))
    {e e' f f' : E} (hef : next e f) (he'f' : next e' f') (hef' : next e f') (he'f : next e' f) :
    (turn e f + turn e' f') - (turn e f' + turn e' f) = -4 ∨
      (turn e f + turn e' f') - (turn e f' + turn e' f) = 0 ∨
      (turn e f + turn e' f') - (turn e f' + turn e' f) = 4 := by
  -- 組 (e→f, e'→f') の接続での展開
  have h1 : dir f + dir f' = (dir e + dir e') + π (turn e f + turn e' f') := by
    rw [hadv e f hef, hadv e' f' he'f', map_add, add_add_add_comm]
  -- 組 (e→f', e'→f) の接続での展開
  have h2 : dir f + dir f' = (dir e + dir e') + π (turn e f' + turn e' f) := by
    rw [hadv e' f he'f, hadv e f' hef', map_add, add_add_add_comm, add_comm (dir e') (dir e),
      add_comm (π (turn e' f)) (π (turn e f'))]
  -- 左辺が同じなので π(S₁) = π(S₂)
  have hcong : π (turn e f + turn e' f') = π (turn e f' + turn e' f) :=
    add_left_cancel (h1.symm.trans h2)
  -- π(D) = 0 から 4 ∣ D
  have hzero : π ((turn e f + turn e' f') - (turn e f' + turn e' f)) = 0 := by
    apply add_right_cancel (b := π (turn e f' + turn e' f))
    rw [← map_add, sub_add_cancel, zero_add, hcong]
  have hdvd := hker _ hzero
  -- 一歩の回転数の値域から −4 ≤ D ≤ 4
  rcases hrange e f with h₁ | h₁ | h₁ <;> rcases hrange e' f' with h₂ | h₂ | h₂ <;>
    rcases hrange e f' with h₃ | h₃ | h₃ <;> rcases hrange e' f with h₄ | h₄ | h₄ <;> omega

/-- 横断の平滑化は循環総回転数を保つ（必要十分版）。 -/
theorem smoothing_cyclic_turning_invariance_walk_necSuf
    {E G : Type*} [AddCancelCommMonoid G] {m : ℕ}
    (next : E → E → Prop) (turn : E → E → ℤ) (dir : E → G) (π : ℤ →+ G)
    (hker : ∀ D : ℤ, π D = 0 → (4 : ℤ) ∣ D)
    (hrange : ∀ e f : E, turn e f = 0 ∨ turn e f = 1 ∨ turn e f = -1)
    (hadv : ∀ e f : E, next e f → dir f = dir e + π (turn e f))
    (γ : Fin (m + 1) → E) {k l : Fin (m + 1)} (hkl : k ≠ l)
    (hk : next (γ k) (γ (cyclicSuccessor k))) (hl : next (γ l) (γ (cyclicSuccessor l)))
    (hkl' : next (γ k) (γ (cyclicSuccessor l))) (hlk' : next (γ l) (γ (cyclicSuccessor k)))
    (h0k : turn (γ k) (γ (cyclicSuccessor k)) = 0)
    (h0l : turn (γ l) (γ (cyclicSuccessor l)) = 0) :
    smoothedCyclicTotalTurning turn γ k l = cyclicTotalTurning turn γ := by
  -- 組み替えの回転差の適用
  have hD := reconnection_turning_difference_walk_necSuf next turn dir π hker hrange hadv
    hk hl hkl' hlk'
  -- 第一の準備と値域から新二項の和は零
  have hS : turn (γ k) (γ (cyclicSuccessor l)) + turn (γ l) (γ (cyclicSuccessor k)) = 0 := by
    rcases hrange (γ k) (γ (cyclicSuccessor l)) with h | h | h <;>
      rcases hrange (γ l) (γ (cyclicSuccessor k)) with h' | h' | h' <;> omega
  -- 二点更新の有限和保存と巡回後続による書き直し
  have hpair : turn (γ k) (smoothedSuccessorEdge γ k l k)
      + turn (γ l) (smoothedSuccessorEdge γ k l l)
      = turn (γ k) (γ (cyclicSuccessor k)) + turn (γ l) (γ (cyclicSuccessor l)) := by
    have hexk : smoothedSuccessorEdge γ k l k = γ (cyclicSuccessor l) := by
      simp [smoothedSuccessorEdge]
    have hexl : smoothedSuccessorEdge γ k l l = γ (cyclicSuccessor k) := by
      simp [smoothedSuccessorEdge, Ne.symm hkl]
    rw [hexk, hexl, hS, h0k, h0l, add_zero]
  rw [smoothedCyclicTotalTurning, ← cyclicTotalTurning_eq_sum_cyclicSuccessor_necSuf]
  exact two_point_preserved_sum_necSuf
    (fun r => turn (γ r) (γ (cyclicSuccessor r)))
    (fun r => turn (γ r) (smoothedSuccessorEdge γ k l r)) k l hkl hpair
    (fun r hrk hrl => by simp only [smoothedSuccessorEdge, if_neg hrk, if_neg hrl])

end Ising2DLambda.NecSuf.KacWard
