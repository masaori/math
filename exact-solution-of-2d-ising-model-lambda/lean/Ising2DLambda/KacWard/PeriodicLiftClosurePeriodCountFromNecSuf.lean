/- 必要十分版を整数格子へ特殊化した「閉包の周期数の一般化」の導出版。 -/
import Ising2DLambda.KacWard.PeriodicLiftClosurePeriodCount
import Ising2DLambda.NecSuf.KacWard.PeriodicLiftClosurePeriodCount

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 正の周期数による非零並進を、ねじれの無い加法群 ℤ の各座標へ必要十分版を特殊化して導く。 -/
theorem positivePeriodicMultiple_movesPoint_from_necSuf
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

/-- 閉包の長さ表示を必要十分版から導く。 -/
theorem periodicLiftClosure_length_from_necSuf (h m c : ℕ) :
    2 * h + 2 * (c * m) = h + c * m + h + c * m :=
  periodic_closure_length_necSuf h m c

end Ising2DLambda.KacWard
