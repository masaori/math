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

end Ising2DLambda.KacWard
