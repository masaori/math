/-
「平滑化で分けた二本の横断数の和は真に減る」の必要十分版。
閉歩道や格子は使わず、分割等式、平滑化更新式、選んだ横断が
二軸の直進通過を一つずつ含むことだけから自然数の狭義減少を得る。
-/
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 分割等式と更新式で、二本の横断数の和は元の横断数より小さくなる。 -/
theorem smoothing_split_crossing_descent_necSuf
    (original smoothed split mutualCrossings axisZero axisOne : ℕ)
    (hpartition : split + mutualCrossings = smoothed)
    (hupdate : original + 1 = smoothed + axisZero + axisOne)
    (haxisZero : 1 ≤ axisZero) (haxisOne : 1 ≤ axisOne) :
    split < original := by
  omega

end Ising2DLambda.NecSuf.KacWard
