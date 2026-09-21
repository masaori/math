/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる零巻き付き閉路の循環総回転数は正負 4 のいずれかである」
（`claim_plane_simple_polygon_cyclic_turning`）の具体版。

人手証明と同じく、格子多角形の頂点・辺・単位正方形の個数を用い、
Euler の等式と接続数の二重計数から凸頂点数と凹頂点数の差が四であることを導く。
-/
import Ising2DLambda.NecSuf.KacWard.PlaneSimplePolygonCyclicTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `claim_plane_simple_polygon_cyclic_turning` の具体版。 -/
theorem planeSimplePolygon_cyclicTurning
    (vertexCount edgeCount cellCount boundaryEdgeCount interiorEdgeCount : ℕ)
    (convexCount straightCount concaveCount interiorVertexCount : ℕ)
    (turning : ℤ)
    (hvertex :
      (vertexCount : ℤ) =
        convexCount + straightCount + concaveCount + interiorVertexCount)
    (hboundary :
      (boundaryEdgeCount : ℤ) = convexCount + straightCount + concaveCount)
    (hvertexIncidence :
      4 * (cellCount : ℤ) =
        convexCount + 2 * straightCount + 3 * concaveCount + 4 * interiorVertexCount)
    (hedgeIncidence :
      4 * (cellCount : ℤ) = 2 * interiorEdgeCount + boundaryEdgeCount)
    (hedge : (edgeCount : ℤ) = interiorEdgeCount + boundaryEdgeCount)
    (heuler : (vertexCount : ℤ) - edgeCount + cellCount = 1)
    (hturning : turning = (convexCount : ℤ) - concaveCount ∨
      turning = -((convexCount : ℤ) - concaveCount)) :
    turning = 4 ∨ turning = -4 := by
  exact plane_simple_polygon_cyclic_turning_necSuf
    vertexCount edgeCount cellCount boundaryEdgeCount interiorEdgeCount
    convexCount straightCount concaveCount interiorVertexCount turning
    hvertex hboundary hvertexIncidence hedgeIncidence hedge heuler hturning

end Ising2DLambda.KacWard
