/-
面数の等式と平面 Euler 等式を仮定した旧経路の補題。
現在の `claim_hole_free_cell_set_euler_number_one` の必要十分版には数えない。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Counting the same finite family by cells and by graph cycles gives Euler number one. -/
theorem cellEuler_eq_one_of_even_edge_counts
    (vertexCount edgeCount cellCount evenEdgeCount : ℕ)
    (hboundary : evenEdgeCount = 2 ^ cellCount)
    (hgraph : evenEdgeCount = 2 ^ (edgeCount + 1 - vertexCount))
    (hvertices : vertexCount ≤ edgeCount + 1) :
    (vertexCount : ℤ) - edgeCount + cellCount = 1 := by
  have hpowers : 2 ^ cellCount = 2 ^ (edgeCount + 1 - vertexCount) := by
    calc
      2 ^ cellCount = evenEdgeCount := hboundary.symm
      _ = 2 ^ (edgeCount + 1 - vertexCount) := hgraph
  have hcells : cellCount = edgeCount + 1 - vertexCount :=
    Nat.pow_right_injective (by decide : 1 < 2) hpowers
  omega

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
