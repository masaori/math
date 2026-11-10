/-
章「Onsager 閉形式への接続」の
面数の等式と平面 Euler 等式を仮定した旧経路の補題。
現在の `claim_hole_free_cell_set_euler_number_one` の具体版には数えない。
-/
import Ising2DLambda.KacWard.CellComplexOneCellIncrement
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The two counts of even edge sets determine the cell count and Euler number. -/
theorem cellEulerNumber_eq_one_of_even_edge_counts
    (cells : Finset GridCell) (evenEdgeCount : ℕ)
    (hboundary : evenEdgeCount = 2 ^ cells.card)
    (hgraph : evenEdgeCount =
      2 ^ ((cellEdges cells).card + 1 - (cellVertices cells).card))
    (hvertices : (cellVertices cells).card ≤ (cellEdges cells).card + 1) :
    cellEulerNumber cells = 1 := by
  have hpowers :
      2 ^ cells.card =
        2 ^ ((cellEdges cells).card + 1 - (cellVertices cells).card) := by
    calc
      2 ^ cells.card = evenEdgeCount := hboundary.symm
      _ = 2 ^ ((cellEdges cells).card + 1 - (cellVertices cells).card) := hgraph
  have hcells : cells.card =
      (cellEdges cells).card + 1 - (cellVertices cells).card :=
    Nat.pow_right_injective (by decide : 1 < 2) hpowers
  unfold cellEulerNumber
  omega

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
