/- 必要十分版を整数格子へ特殊化した「閉包の周期数の一般化」の導出版。 -/
import Ising2DLambda.KacWard.PeriodicLiftClosurePeriodCount

namespace Ising2DLambda.KacWard

/-- 正の周期数による非零並進を必要十分版から導く。 -/
theorem positivePeriodicMultiple_movesPoint_from_necSuf
    (period point : ℤ × ℤ) (c : ℕ) (hperiod : period ≠ (0, 0)) (hc : 1 ≤ c) :
    (point.1 + c • period.1, point.2 + c • period.2) ≠ point :=
  positivePeriodicMultiple_movesPoint period point c hperiod hc

/-- 閉包の長さ表示を必要十分版から導く。 -/
theorem periodicLiftClosure_length_from_necSuf (h m c : ℕ) :
    2 * h + 2 * (c * m) = h + c * m + h + c * m :=
  periodicLiftClosure_length h m c

end Ising2DLambda.KacWard
