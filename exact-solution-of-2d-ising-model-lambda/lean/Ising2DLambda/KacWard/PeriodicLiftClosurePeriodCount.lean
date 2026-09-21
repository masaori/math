/-
章「Onsager 閉形式への接続」の「閉包の周期数の一般化」の具体版。

人手証明で周期数 c ≥ 1 を導入した箇所に対応し、整数格子の非零な一周期
並進 Bγ の c 倍が非零であることと、閉包の四部分の長さを固定する。
住処は ℕ と ℤ だけである。
-/
import Ising2DLambda.NecSuf.KacWard.PeriodicLiftClosurePeriodCount

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 正の周期数 `c` による整数格子の周期並進は、どの点も元の位置へ戻さない。 -/
theorem positivePeriodicMultiple_movesPoint
    (period point : ℤ × ℤ) (c : ℕ) (hperiod : period ≠ (0, 0)) (hc : 1 ≤ c) :
    (point.1 + c • period.1, point.2 + c • period.2) ≠ point := by
  have hcoordinate : period.1 ≠ 0 ∨ period.2 ≠ 0 := by
    by_cases hfirst : period.1 = 0
    · right
      intro hsecond
      apply hperiod
      exact Prod.ext hfirst hsecond
    · left
      exact hfirst
  intro heq
  rcases hcoordinate with hfirst | hsecond
  · have hmoved := positive_period_multiple_moves_point_necSuf
      period.1 point.1 c hfirst hc
    exact hmoved (congrArg Prod.fst heq)
  · have hmoved := positive_period_multiple_moves_point_necSuf
      period.2 point.2 c hsecond hc
    exact hmoved (congrArg Prod.snd heq)

/-- `N = 2h + 2cm` は閉包の四部分の長さの和である。 -/
theorem periodicLiftClosure_length (h m c : ℕ) :
    2 * h + 2 * (c * m) = h + c * m + h + c * m := by
  exact periodic_closure_length_necSuf h m c

end Ising2DLambda.KacWard
