/-
「平滑化で分けた二本の横断数の和は真に減る」の具体版。
人手証明で既に得た横断数の分割等式と全体更新式に、選んだ横断の
二軸それぞれの直進通過数が一以上であることを代入する。
-/
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitCrossingDescent

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 平滑化で得た二本の閉歩道の横断数の和は、元の閉歩道の横断数より小さい。 -/
theorem smoothing_split_crossing_descent
    (original smoothed crossingA crossingB mutualCrossings axisZero axisOne : ℕ)
    (hpartition : crossingA + crossingB + mutualCrossings = smoothed)
    (hupdate : original + 1 = smoothed + axisZero + axisOne)
    (haxisZero : 1 ≤ axisZero) (haxisOne : 1 ≤ axisOne) :
    crossingA + crossingB < original := by
  exact smoothing_split_crossing_descent_necSuf original smoothed
    (crossingA + crossingB) mutualCrossings axisZero axisOne hpartition hupdate haxisZero haxisOne

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_split_crossing_descent_from_necSuf
    (original smoothed crossingA crossingB mutualCrossings axisZero axisOne : ℕ)
    (hpartition : crossingA + crossingB + mutualCrossings = smoothed)
    (hupdate : original + 1 = smoothed + axisZero + axisOne)
    (haxisZero : 1 ≤ axisZero) (haxisOne : 1 ≤ axisOne) :
    crossingA + crossingB < original :=
  smoothing_split_crossing_descent original smoothed crossingA crossingB mutualCrossings
    axisZero axisOne hpartition hupdate haxisZero haxisOne

end Ising2DLambda.KacWard
