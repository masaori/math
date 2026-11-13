import Ising2DLambda.KacWard.PlaneSimplePolygonCyclicTurning
import Ising2DLambda.KacWard.InteriorCellsOfWalkEulerNumber
import Ising2DLambda.KacWard.CellBoundaryVertexEdgeCount
import Ising2DLambda.KacWard.BoundaryVertexTurnSum
import Ising2DLambda.KacWard.WalkBoundaryVertexTurnSum
import Ising2DLambda.KacWard.WalkInteriorSideConstant
import Mathlib.Tactic

/-!
`claim_plane_simple_polygon_cyclic_turning` を実際の閉歩道について述べた具体版。

本文の証明は、持ち上げ点が相異なる零巻き付き閉路の内側セル集合について
頂点数の分類 $V=v_1+v_2+v_3+v_4$、境界辺数 $E_\partial=v_1+v_2+v_3$、
頂点とセルの接続数 $4F=v_1+2v_2+3v_3+4v_4$、辺とセルの接続数 $4F=2E_\circ+E_\partial$、
辺数 $E=E_\circ+E_\partial$、Euler 数 $V-E+F=1$ を立て、
循環総回転数を境界頂点の局所回転数の和 $v_3-v_1$（内側が右ならその符号反転）に書いて、
凸頂点数と凹頂点数の差が四であることから $t_\circ(\gamma)\in\{4,-4\}$ を得る。
ここではそれらの等式を実際の閉歩道について示した具体版を呼び、
整数の計算をする具体版 `planeSimplePolygon_cyclicTurning` へ代入する。
-/

open scoped BigOperators

namespace Ising2DLambda.KacWard

/-- Every vertex of a finite cell set meets one, two, three, or four of its cells,
so the vertex count is the sum of the four incidence classes. -/
theorem cellVertices_card_eq_incidenceClasses (cells : Finset GridCell) :
    (cellVertices cells).card =
      (verticesWithIncidence cells 1).card +
      (verticesWithIncidence cells 2).card +
      (verticesWithIncidence cells 3).card +
      (verticesWithIncidence cells 4).card := by
  classical
  calc
    (cellVertices cells).card = ∑ _v ∈ cellVertices cells, (1 : ℕ) := by simp
    _ = ∑ v ∈ cellVertices cells,
          ((if vertexCellIncidenceCount cells v = 1 then 1 else 0) +
            (if vertexCellIncidenceCount cells v = 2 then 1 else 0) +
            (if vertexCellIncidenceCount cells v = 3 then 1 else 0) +
            (if vertexCellIncidenceCount cells v = 4 then 1 else 0)) := by
          -- 各頂点の接続数は一から四のどれか一つ
          apply Finset.sum_congr rfl
          intro v hv
          rcases vertexCellIncidenceCount_one_to_four cells v hv with h | h | h | h <;>
            simp [h]
    _ = (verticesWithIncidence cells 1).card +
        (verticesWithIncidence cells 2).card +
        (verticesWithIncidence cells 3).card +
        (verticesWithIncidence cells 4).card := by
          simp [Finset.sum_add_distrib, verticesWithIncidence]

/-- The edges of a finite cell set split into its boundary edges and its interior edges. -/
theorem cellEdges_card_eq_interior_add_boundary (cells : Finset GridCell) :
    (cellEdges cells).card =
      (cellEdges cells \ planeCellBoundary cells).card +
        (planeCellBoundary cells).card := by
  have hsub : planeCellBoundary cells ⊆ cellEdges cells := by
    intro e he
    exact (Finset.mem_filter.mp he).1
  rw [Finset.card_sdiff_of_subset hsub]
  have := Finset.card_le_card hsub
  omega

/-- `claim_plane_simple_polygon_cyclic_turning` の具体版（実際の閉歩道）。
持ち上げ点が相異なる零巻き付きの閉じた非後退辺列の循環総回転数は正負 4 のいずれかである。 -/
theorem vertexSimpleWalk_cyclicTotalTurning_four {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    cyclicTotalTurning γ hγ = 4 ∨ cyclicTotalTurning γ hγ = -4 := by
  classical
  set cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset with hcells
  -- 頂点数の分類 V = v₁ + v₂ + v₃ + v₄
  have hvertex := cellVertices_card_eq_incidenceClasses cells
  -- 境界辺数 E_∂ = v₁ + v₂ + v₃
  have hboundary := interiorCellsOfWalk_boundaryEdge_card_eq_incidenceClasses
    γ hγ hh hv hdistinct
  -- 頂点とセルの接続数 4F = v₁ + 2v₂ + 3v₃ + 4v₄
  have hvertexIncidence := interiorCellsOfWalk_vertexIncidence_by_class γ hγ hh hv
  -- 辺とセルの接続数 4F = E_∂ + 2E_∘
  have hedgeIncidence := interiorCellsOfWalk_edgeIncidence_boundary_interior γ hγ hh hv
  -- 辺数 E = E_∘ + E_∂
  have hedge := cellEdges_card_eq_interior_add_boundary cells
  -- Euler 数 V - E + F = 1
  have heuler := interiorCellsOfWalk_eulerNumber_eq_one γ hγ hh hv hdistinct
  -- 境界頂点の局所回転数の和 = v₃ - v₁
  have hturnSum := interiorCellsOfWalk_boundary_turn_sum γ hγ hh hv hdistinct
  dsimp only at hvertexIncidence hedgeIncidence hturnSum
  unfold cellEulerNumber at heuler
  simp only [← hcells] at hboundary hvertexIncidence hedgeIncidence heuler hturnSum
  apply planeSimplePolygon_cyclicTurning
    (cellVertices cells).card (cellEdges cells).card cells.card
    (planeCellBoundary cells).card (cellEdges cells \ planeCellBoundary cells).card
    (verticesWithIncidence cells 1).card (verticesWithIncidence cells 2).card
    (verticesWithIncidence cells 3).card (verticesWithIncidence cells 4).card
    (cyclicTotalTurning γ hγ)
  · exact_mod_cast hvertex
  · exact_mod_cast hboundary
  · exact_mod_cast hvertexIncidence
  · omega
  · exact_mod_cast hedge
  · exact heuler
  · -- 内側の側は全ての歩で同じ
    obtain ⟨side, hside⟩ :=
      vertexSimpleWalk_interior_side_constant γ hγ hh hv hdistinct
    cases side
    · -- 内側が右: t∘ = -(v₃ - v₁) = v₁ - v₃
      left
      have h := vertexSimpleWalk_cyclicTotalTurning_eq_neg_boundary_turn_sum_right
        γ hγ hh hv hdistinct hside
      dsimp only at h
      rw [h, hturnSum]
      ring
    · -- 内側が左: t∘ = v₃ - v₁ = -(v₁ - v₃)
      right
      have h := vertexSimpleWalk_cyclicTotalTurning_eq_boundary_turn_sum_left
        γ hγ hh hv hdistinct hside
      dsimp only at h
      rw [h, hturnSum]
      ring

end Ising2DLambda.KacWard
