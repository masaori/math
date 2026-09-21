/-
章「Onsager 閉形式への接続」の
「有限な辺連結セル集合の補集合も辺連結なら Euler 数は 1 である」
（`claim_hole_free_cell_set_euler_number_one`）の具体版。

人手証明で得た面数の等式と有限連結平面グラフの Euler 等式を、整数格子
セル集合の頂点数・辺数・セル数へ特殊化して結論を得る。
-/
import Ising2DLambda.KacWard.CellComplexOneCellIncrement
import Ising2DLambda.NecSuf.KacWard.HoleFreeCellSetEulerNumber

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `claim_hole_free_cell_set_euler_number_one` の具体版。 -/
theorem cellEulerNumber_eq_one_of_region_count
    (cells : Finset GridCell) (regionCount : ℕ)
    (hregions : regionCount = cells.card + 1)
    (hplanarEuler :
      ((cellVertices cells).card : ℤ) - ((cellEdges cells).card : ℤ) +
        (regionCount : ℤ) = 2) :
    cellEulerNumber cells = 1 := by
  unfold cellEulerNumber
  exact cellEuler_eq_one_of_region_count_necSuf
    (cellVertices cells).card (cellEdges cells).card cells.card regionCount
    hregions hplanarEuler

end Ising2DLambda.KacWard
