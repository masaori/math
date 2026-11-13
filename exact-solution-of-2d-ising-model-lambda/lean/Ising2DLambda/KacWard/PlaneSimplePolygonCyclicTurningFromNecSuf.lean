/-
具体版が必要十分版の特殊化として得られることの導出。

必要十分版 `plane_simple_polygon_cyclic_turning_necSuf` の整数の個数に、
実際の閉歩道の内側セル集合の頂点数・辺数・セル数・境界辺数・内部辺数・接続数の四つの類の個数と
循環総回転数を代入し、五つの接続数等式・Euler 数一・循環方向の二場合を
実際の閉歩道についての具体版の補題で満たすと、具体版と同じ主張を得る。
-/
import Ising2DLambda.KacWard.PlaneSimplePolygonCyclicTurningOfWalk
import Ising2DLambda.NecSuf.KacWard.PlaneSimplePolygonCyclicTurning

namespace Ising2DLambda.KacWard

/-- `claim_plane_simple_polygon_cyclic_turning` の個数の計算を必要十分版から導く。 -/
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
  Ising2DLambda.NecSuf.KacWard.plane_simple_polygon_cyclic_turning_necSuf
    vertexCount edgeCount cellCount boundaryEdgeCount interiorEdgeCount
    convexCount straightCount concaveCount interiorVertexCount turning
    hvertex hboundary hvertexIncidence hedgeIncidence hedge heuler hturning

/-- 実際の閉歩道についての具体版 `vertexSimpleWalk_cyclicTotalTurning_four` を必要十分版から導く。 -/
theorem vertexSimpleWalk_cyclicTotalTurning_four_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    cyclicTotalTurning γ hγ = 4 ∨ cyclicTotalTurning γ hγ = -4 := by
  classical
  set cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset with hcells
  have hvertex := cellVertices_card_eq_incidenceClasses cells
  have hboundary := interiorCellsOfWalk_boundaryEdge_card_eq_incidenceClasses
    γ hγ hh hv hdistinct
  have hvertexIncidence := interiorCellsOfWalk_vertexIncidence_by_class γ hγ hh hv
  have hedgeIncidence := interiorCellsOfWalk_edgeIncidence_boundary_interior γ hγ hh hv
  have hedge := cellEdges_card_eq_interior_add_boundary cells
  have heuler := interiorCellsOfWalk_eulerNumber_eq_one γ hγ hh hv hdistinct
  have hturnSum := interiorCellsOfWalk_boundary_turn_sum γ hγ hh hv hdistinct
  dsimp only at hvertexIncidence hedgeIncidence hturnSum
  unfold cellEulerNumber at heuler
  simp only [← hcells] at hboundary hvertexIncidence hedgeIncidence heuler hturnSum
  apply Ising2DLambda.NecSuf.KacWard.plane_simple_polygon_cyclic_turning_necSuf
    ((cellVertices cells).card : ℤ) ((cellEdges cells).card : ℤ) (cells.card : ℤ)
    ((planeCellBoundary cells).card : ℤ)
    ((cellEdges cells \ planeCellBoundary cells).card : ℤ)
    ((verticesWithIncidence cells 1).card : ℤ) ((verticesWithIncidence cells 2).card : ℤ)
    ((verticesWithIncidence cells 3).card : ℤ) ((verticesWithIncidence cells 4).card : ℤ)
    (cyclicTotalTurning γ hγ)
  · exact_mod_cast hvertex
  · exact_mod_cast hboundary
  · exact_mod_cast hvertexIncidence
  · omega
  · exact_mod_cast hedge
  · exact heuler
  · obtain ⟨side, hside⟩ :=
      vertexSimpleWalk_interior_side_constant γ hγ hh hv hdistinct
    cases side
    · left
      have h := vertexSimpleWalk_cyclicTotalTurning_eq_neg_boundary_turn_sum_right
        γ hγ hh hv hdistinct hside
      dsimp only at h
      rw [h, hturnSum]
      ring
    · right
      have h := vertexSimpleWalk_cyclicTotalTurning_eq_boundary_turn_sum_left
        γ hγ hh hv hdistinct hside
      dsimp only at h
      rw [h, hturnSum]
      ring

end Ising2DLambda.KacWard
