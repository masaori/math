/-
「持ち上げ点が相異なる零巻き付き閉路の循環総回転数は正負 4 のいずれかである」
の必要十分版。

平面格子多角形から切り離すと、必要なのは頂点・辺・単位正方形の接続数を
二通りに数えた五つの等式、Euler 数が一であること、および巡回方向が回転数の
符号だけを変えることだけである。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Euler の等式と接続数の二重計数から、境界の循環総回転数は正負四になる。 -/
theorem plane_simple_polygon_cyclic_turning_necSuf
    (vertexCount edgeCount cellCount boundaryEdgeCount interiorEdgeCount : ℤ)
    (convexCount straightCount concaveCount interiorVertexCount turning : ℤ)
    (hvertex :
      vertexCount = convexCount + straightCount + concaveCount + interiorVertexCount)
    (hboundary : boundaryEdgeCount = convexCount + straightCount + concaveCount)
    (hvertexIncidence :
      4 * cellCount =
        convexCount + 2 * straightCount + 3 * concaveCount + 4 * interiorVertexCount)
    (hedgeIncidence : 4 * cellCount = 2 * interiorEdgeCount + boundaryEdgeCount)
    (hedge : edgeCount = interiorEdgeCount + boundaryEdgeCount)
    (heuler : vertexCount - edgeCount + cellCount = 1)
    (hturning : turning = convexCount - concaveCount ∨
      turning = -(convexCount - concaveCount)) :
    turning = 4 ∨ turning = -4 := by
  have hconvexConcave : convexCount - concaveCount = 4 := by
    omega
  rcases hturning with hforward | hreverse
  · left
    omega
  · right
    omega

end Ising2DLambda.NecSuf.KacWard
