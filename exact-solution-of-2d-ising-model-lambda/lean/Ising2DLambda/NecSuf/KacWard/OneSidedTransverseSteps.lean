/-
「一側閉包の横断二列の歩ベクトルは基点に依らない」の必要十分版。
基点の分離に加法の結合律と零元、差の消去に可換加法群の法則を使う。
整数格子、単位歩、周期長の正値性、添字の範囲条件は使わない。
順向き・逆向きの読み方も、任意の自然数添字写像へ置き換えられる。
-/
import Ising2DLambda.NecSuf.KacWard.IteratedTransverseStaircase

namespace Ising2DLambda.NecSuf.KacWard

theorem iteratedStaircase_reindexed_steps_base_independent_necSuf
    {G : Type*} [AddCommGroup G]
    (n : ℕ) (path : ℕ → G) (period base : G) (index : ℕ → ℕ) (i : ℕ) :
    iteratedStaircase n path period base (index (i + 1)) -
        iteratedStaircase n path period base (index i) =
      iteratedStaircase n path period 0 (index (i + 1)) -
        iteratedStaircase n path period 0 (index i) := by
  -- 具体版と同じ準備: 定義展開、結合律、零の挿入、定義の畳み込み。
  have hbase (s : ℕ) :
      iteratedStaircase n path period base s =
        base + iteratedStaircase n path period 0 s := by
    let quotient := s / n
    let remainder := s % n
    calc
      iteratedStaircase n path period base s =
          base + quotient • period + path remainder := rfl
      _ = base + (quotient • period + path remainder) := add_assoc _ _ _
      _ = base + ((0 + quotient • period) + path remainder) := by rw [zero_add]
      _ = base + iteratedStaircase n path period 0 s := rfl
  -- 具体版と同じ本体: 二点の表示を代入してから共通基点を消す。
  calc
    iteratedStaircase n path period base (index (i + 1)) -
        iteratedStaircase n path period base (index i) =
      (base + iteratedStaircase n path period 0 (index (i + 1))) -
        (base + iteratedStaircase n path period 0 (index i)) := by rw [hbase, hbase]
    _ = iteratedStaircase n path period 0 (index (i + 1)) -
        iteratedStaircase n path period 0 (index i) := by abel

end Ising2DLambda.NecSuf.KacWard
