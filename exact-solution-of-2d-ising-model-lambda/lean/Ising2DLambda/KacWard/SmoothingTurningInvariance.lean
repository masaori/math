/-
「横断の平滑化は循環総回転数を保つ」の具体版。
人手証明と同じく、横断の直進性（旧二項は 0）、接続の組み替えの回転差
（新二項の和は 4 の整除域 {-4,0,4} に入る）、一歩の回転数の値域 {0,1,-1}
から新二項の和が 0 になることを出し、二点更新の有限和保存で閉じる。
組み替えの回転差は方向番号のデータを持たない通過モデルでは導けないので、
`claim_reconnection_turning_difference` の帰結を仮定 `hrec` として受け取る。
-/
import Ising2DLambda.KacWard.TransverseCrossing
import Ising2DLambda.NecSuf.KacWard.TotalTurning
import Ising2DLambda.NecSuf.KacWard.SmoothingTurningInvariance

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 横断の平滑化は一歩の回転数の総和（循環総回転数）を変えない。
`visit` が平滑化前、`visit'` が平滑化後の通過族、`a`・`b` が横断する二添字。 -/
theorem smoothing_cyclic_turning_invariance {m : ℕ}
    (visit visit' : Fin m → LocalVisit) (a b : Fin m) (hab : a ≠ b)
    (ha0 : (visit a).turn = .straight) (hb0 : (visit b).turn = .straight)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (hrec : (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = -4
        ∨ (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = 0
        ∨ (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = 4) :
    ∑ r : Fin m, turnValue (visit' r).turn = ∑ r : Fin m, turnValue (visit r).turn := by
  -- 第一の準備: 横断の直進性により旧二項は 0
  have hva : turnValue (visit a).turn = 0 := by rw [ha0]; rfl
  have hvb : turnValue (visit b).turn = 0 := by rw [hb0]; rfl
  -- 一歩の回転数の値域は {0, 1, -1}
  have hra : turnValue (visit' a).turn = 0 ∨ turnValue (visit' a).turn = 1 ∨
      turnValue (visit' a).turn = -1 := by
    cases h : (visit' a).turn <;> simp [turnValue]
  have hrb : turnValue (visit' b).turn = 0 ∨ turnValue (visit' b).turn = 1 ∨
      turnValue (visit' b).turn = -1 := by
    cases h : (visit' b).turn <;> simp [turnValue]
  -- 第二の準備: 新二項の和は 0（4 の整除域と値域の交わり）
  have hpair : turnValue (visit' a).turn + turnValue (visit' b).turn
      = turnValue (visit a).turn + turnValue (visit b).turn := by
    omega
  -- 二点更新の有限和保存
  exact two_point_preserved_sum_necSuf
    (fun r => turnValue (visit r).turn) (fun r => turnValue (visit' r).turn)
    a b hab hpair (fun r hra' hrb' => by rw [hother r hra' hrb'])

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_cyclic_turning_invariance_from_necSuf {m : ℕ}
    (visit visit' : Fin m → LocalVisit) (a b : Fin m) (hab : a ≠ b)
    (ha0 : (visit a).turn = .straight) (hb0 : (visit b).turn = .straight)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (hrec : (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = -4
        ∨ (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = 0
        ∨ (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = 4) :
    ∑ r : Fin m, turnValue (visit' r).turn = ∑ r : Fin m, turnValue (visit r).turn :=
  smoothing_cyclic_turning_invariance visit visit' a b hab ha0 hb0 hother hrec

end Ising2DLambda.KacWard
