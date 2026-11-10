/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる零巻き付き閉路の循環総回転数は正負 4 のいずれかである」
（`claim_plane_simple_polygon_cyclic_turning`）の具体版。

人手証明の頂点・辺・単位正方形の接続数等式と Euler の等式を仮定し、
整数の計算から凸頂点数と凹頂点数の差が四であることを導く。
実際の閉歩道が各計数等式を満たすことは別に示す。
-/
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

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
  have hedgeTwice : 2 * (edgeCount : ℤ) =
      4 * cellCount + boundaryEdgeCount := by
    omega
  have hconvexConcave : (convexCount : ℤ) - concaveCount = 4 := by
    omega
  rcases hturning with hforward | hreverse
  · left
    omega
  · right
    omega

end Ising2DLambda.KacWard
