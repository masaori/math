/-
具体版が必要十分版の特殊化として得られることの導出。

格子多角形の個数と人手証明の五つの接続数等式、Euler 数一、
循環方向による符号の二場合を具体版へ渡す。
-/
import Ising2DLambda.KacWard.PlaneSimplePolygonCyclicTurning

namespace Ising2DLambda.KacWard

/-- `claim_plane_simple_polygon_cyclic_turning` を必要十分版から導く。 -/
theorem planeSimplePolygon_cyclicTurning_from_necSuf
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
    turning = 4 ∨ turning = -4 :=
  planeSimplePolygon_cyclicTurning
    vertexCount edgeCount cellCount boundaryEdgeCount interiorEdgeCount
    convexCount straightCount concaveCount interiorVertexCount turning
    hvertex hboundary hvertexIncidence hedgeIncidence hedge heuler hturning

end Ising2DLambda.KacWard
