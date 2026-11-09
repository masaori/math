/-
面数の等式と平面 Euler 等式を仮定した旧経路の補題。
現在の `claim_hole_free_cell_set_euler_number_one` の必要十分版には数えない。
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
