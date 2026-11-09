/-
章「Onsager 閉形式への接続」の
面数の等式と平面 Euler 等式を仮定した旧経路の補題。
現在の `claim_hole_free_cell_set_euler_number_one` の具体版には数えない。
-/
import Ising2DLambda.KacWard.CellComplexOneCellIncrement

namespace Ising2DLambda.KacWard

/-- 旧経路の面数・平面 Euler 等式からの代数的帰結。 -/
theorem cellEulerNumber_eq_one_of_region_count
    (cells : Finset GridCell) (regionCount : ℕ)
    (hregions : regionCount = cells.card + 1)
    (hplanarEuler :
      ((cellVertices cells).card : ℤ) - ((cellEdges cells).card : ℤ) +
        (regionCount : ℤ) = 2) :
    cellEulerNumber cells = 1 := by
  unfold cellEulerNumber
  omega

end Ising2DLambda.KacWard
