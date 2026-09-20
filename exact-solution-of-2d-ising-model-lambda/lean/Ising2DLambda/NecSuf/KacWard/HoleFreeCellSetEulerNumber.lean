/-
「有限な辺連結セル集合の補集合も辺連結なら Euler 数は 1 である」の
必要十分版。

格子から切り離すと、必要なのは面数がセル数より一つ多いことと、有限連結
平面グラフの Euler 等式だけである。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 面数がセル数より一つ多く、頂点・辺・面が平面 Euler 等式を満たすなら、
頂点・辺・セルからなる Euler 数は一である。 -/
theorem cellEuler_eq_one_of_region_count_necSuf
    (vertexCount edgeCount cellCount regionCount : ℕ)
    (hregions : regionCount = cellCount + 1)
    (hplanarEuler :
      (vertexCount : ℤ) - (edgeCount : ℤ) + (regionCount : ℤ) = 2) :
    (vertexCount : ℤ) - (edgeCount : ℤ) + (cellCount : ℤ) = 1 := by
  omega

end Ising2DLambda.NecSuf.KacWard
