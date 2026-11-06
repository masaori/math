import Ising2DLambda.KacWard.CellSetBoundaryCoefficients
import Ising2DLambda.KacWard.StandardDualHeight

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

def heightOneCells (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) : Finset (ZMod L × ZMod L) :=
  Finset.univ.filter (fun p => standardDualHeight L m γ p = 1)

private theorem height_one_indicator (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (p : ZMod L × ZMod L) :
    (if p ∈ heightOneCells L m γ then (1 : ℤ) else 0) =
      (standardDualHeight L m γ p : ℤ) := by
  have hb : standardDualHeight L m γ p < 2 := by
    unfold standardDualHeight
    omega
  simp only [heightOneCells, Finset.mem_filter, Finset.mem_univ, true_and]
  split_ifs with h
  · simp [h]
  · have hz : standardDualHeight L m γ p = 0 := by omega
    simp [hz]

theorem heightOneBoundary_horizontal_support (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (i j : ZMod L) :
    cellSetEdgeCoefficient L (heightOneCells L m γ) (edgeOfRow L false i j) ≠ 0 ↔
      standardDualHeight L m γ (i, j) ≠
        standardDualHeight L m γ (i - 1, j) := by
  rw [cellSetEdgeCoefficient_horizontal,
    height_one_indicator L m γ (i, j),
    height_one_indicator L m γ (i - 1, j)]
  omega

theorem heightOneBoundary_horizontal_values (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (i j : ZMod L) :
    cellSetEdgeCoefficient L (heightOneCells L m γ) (edgeOfRow L false i j) ∈
      ({-1, 0, 1} : Finset ℤ) := by
  rw [cellSetEdgeCoefficient_horizontal,
    height_one_indicator L m γ (i, j),
    height_one_indicator L m γ (i - 1, j)]
  have hp : standardDualHeight L m γ (i, j) < 2 := by
    unfold standardDualHeight
    omega
  have hq : standardDualHeight L m γ (i - 1, j) < 2 := by
    unfold standardDualHeight
    omega
  simp only [Finset.mem_insert, Finset.mem_singleton]
  omega

theorem heightOneBoundary_vertical_support (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (i j : ZMod L) :
    cellSetEdgeCoefficient L (heightOneCells L m γ) (edgeOfRow L true i j) ≠ 0 ↔
      standardDualHeight L m γ (i, j - 1) ≠
        standardDualHeight L m γ (i, j) := by
  rw [cellSetEdgeCoefficient_vertical,
    height_one_indicator L m γ (i, j - 1),
    height_one_indicator L m γ (i, j)]
  omega

theorem heightOneBoundary_vertical_values (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (i j : ZMod L) :
    cellSetEdgeCoefficient L (heightOneCells L m γ) (edgeOfRow L true i j) ∈
      ({-1, 0, 1} : Finset ℤ) := by
  rw [cellSetEdgeCoefficient_vertical,
    height_one_indicator L m γ (i, j - 1),
    height_one_indicator L m γ (i, j)]
  have hp : standardDualHeight L m γ (i, j - 1) < 2 := by
    unfold standardDualHeight
    omega
  have hq : standardDualHeight L m γ (i, j) < 2 := by
    unfold standardDualHeight
    omega
  simp only [Finset.mem_insert, Finset.mem_singleton]
  omega

/-- An interior horizontal edge occurs in the height-one boundary precisely when the walk crosses it oddly. -/
theorem heightOneBoundary_horizontal_internal_parity (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (i j : ℕ) (hi : i + 1 < L) (hj : j < L) :
    cellSetEdgeCoefficient L (heightOneCells L m γ)
        (edgeOfRow L false ((i + 1 : ℕ) : ZMod L) (j : ZMod L)) ≠ 0 ↔
      walkBaseEdgeParity γ
        (edgeOfRow L false ((i + 1 : ℕ) : ZMod L) (j : ZMod L)) = 1 := by
  have hsupport := heightOneBoundary_horizontal_support L m γ
    ((i + 1 : ℕ) : ZMod L) (j : ZMod L)
  have hprev : (((i + 1 : ℕ) : ZMod L) - 1) = (i : ZMod L) := by simp
  rw [hprev] at hsupport
  exact hsupport.trans (standardDualHeight_horizontal_internal_changes L m γ i j hi hj)

/-- An interior vertical edge occurs in the height-one boundary precisely when a closed walk crosses it oddly. -/
theorem heightOneBoundary_vertical_internal_parity (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (i j : ℕ) (hi : i < L) (hj : j + 1 < L) :
    cellSetEdgeCoefficient L (heightOneCells L m γ)
        (edgeOfRow L true (i : ZMod L) ((j + 1 : ℕ) : ZMod L)) ≠ 0 ↔
      walkBaseEdgeParity γ
        (edgeOfRow L true (i : ZMod L) ((j + 1 : ℕ) : ZMod L)) = 1 := by
  have hsupport := heightOneBoundary_vertical_support L m γ
    (i : ZMod L) ((j + 1 : ℕ) : ZMod L)
  have hprev : (((j + 1 : ℕ) : ZMod L) - 1) = (j : ZMod L) := by simp
  rw [hprev] at hsupport
  exact hsupport.trans
    ((ne_comm).trans (closedWalk_standardDualHeight_vertical_internal_changes L m γ hγ i j hi hj))

/-- At the horizontal seam, zero horizontal winding identifies the boundary support with traversal parity. -/
theorem heightOneBoundary_horizontal_seam_parity (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (hseam : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (j : ℕ) (hL : 2 ≤ L) (hj : j < L) :
    cellSetEdgeCoefficient L (heightOneCells L m γ)
        (edgeOfRow L false 0 (j : ZMod L)) ≠ 0 ↔
      walkBaseEdgeParity γ (edgeOfRow L false 0 (j : ZMod L)) = 1 := by
  have hprev : (0 : ZMod L) - 1 = ((L - 1 : ℕ) : ZMod L) := by
    have hpositive : 1 ≤ L := by omega
    rw [Nat.cast_sub hpositive, ZMod.natCast_self]
    norm_num
  have hsupport := heightOneBoundary_horizontal_support L m γ 0 (j : ZMod L)
  rw [hprev] at hsupport
  exact hsupport.trans
    (closedWalk_standardDualHeight_horizontal_seam_changes L m γ hγ hseam j hL hj)

/-- At side length one, both sides are one cell and zero horizontal seam parity excludes the sole horizontal edge. -/
theorem heightOneBoundary_horizontal_seam_parity_singleCell (m : ℕ)
    (γ : Fin (m + 1) → OrientedEdge 1)
    (hseam : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0) :
    cellSetEdgeCoefficient 1 (heightOneCells 1 m γ)
        (edgeOfRow 1 false 0 0) ≠ 0 ↔
      walkBaseEdgeParity γ (edgeOfRow 1 false 0 0) = 1 := by
  have hleft : cellSetEdgeCoefficient 1 (heightOneCells 1 m γ)
      (edgeOfRow 1 false 0 0) = 0 := by
    rw [cellSetEdgeCoefficient_horizontal]
    have hcell : (((0 : ZMod 1) - 1), (0 : ZMod 1)) = (0, 0) :=
      Subsingleton.elim _ _
    rw [hcell]
    simp
  have hright := singleCell_horizontal_seam_edge_parity m γ hseam
  simp [hleft, hright]

/-- At the vertical seam, zero vertical winding identifies the boundary support with traversal parity. -/
theorem heightOneBoundary_vertical_seam_parity (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (hseam : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0)
    (i : ℕ) (hL : 2 ≤ L) (hi : i < L) :
    cellSetEdgeCoefficient L (heightOneCells L m γ)
        (edgeOfRow L true (i : ZMod L) 0) ≠ 0 ↔
      walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) 0) = 1 := by
  have hprev : (0 : ZMod L) - 1 = ((L - 1 : ℕ) : ZMod L) := by
    have hpositive : 1 ≤ L := by omega
    rw [Nat.cast_sub hpositive, ZMod.natCast_self]
    norm_num
  have hsupport := heightOneBoundary_vertical_support L m γ (i : ZMod L) 0
  rw [hprev] at hsupport
  exact hsupport.trans
    ((ne_comm).trans
      (closedWalk_standardDualHeight_vertical_seam_changes L m γ hγ hseam i hL hi))

/-- At side length one, both sides are one cell and zero seam parity excludes the sole vertical edge. -/
theorem heightOneBoundary_vertical_seam_parity_singleCell (m : ℕ)
    (γ : Fin (m + 1) → OrientedEdge 1)
    (hseam : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0) :
    cellSetEdgeCoefficient 1 (heightOneCells 1 m γ)
        (edgeOfRow 1 true 0 0) ≠ 0 ↔
      walkBaseEdgeParity γ (edgeOfRow 1 true 0 0) = 1 := by
  have hleft : cellSetEdgeCoefficient 1 (heightOneCells 1 m γ)
      (edgeOfRow 1 true 0 0) = 0 := by
    rw [cellSetEdgeCoefficient_vertical]
    have hcell : ((0 : ZMod 1), (0 : ZMod 1) - 1) = (0, 0) :=
      Subsingleton.elim _ _
    rw [hcell]
    simp
  have hright := singleCell_vertical_seam_edge_parity m γ hseam
  simp [hleft, hright]

end Ising2DLambda.KacWard
