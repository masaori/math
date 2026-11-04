import Ising2DLambda.KacWard.DirectedWindingNumbers
import Ising2DLambda.TransferMatrix.Basic

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- The four oriented edges of the cell with upper-left vertex `(i,j)`. -/
def cellBoundaryEdges (L : ℕ) [NeZero L] (i j : ZMod L) :
    List (OrientedEdge L) :=
  [(edgeOfRow L false i j, false),
   (edgeOfRow L true i (j + 1), false),
   (edgeOfRow L false (i + 1) j, true),
   (edgeOfRow L true i j, true)]

theorem cellBoundaryEdges_connected (L : ℕ) [NeZero L] (i j : ZMod L) :
    orientedTarget (edgeOfRow L false i j, false) =
      orientedSource (edgeOfRow L true i (j + 1), false) ∧
    orientedTarget (edgeOfRow L true i (j + 1), false) =
      orientedSource (edgeOfRow L false (i + 1) j, true) ∧
    orientedTarget (edgeOfRow L false (i + 1) j, true) =
      orientedSource (edgeOfRow L true i j, true) ∧
    orientedTarget (edgeOfRow L true i j, true) =
      orientedSource (edgeOfRow L false i j, false) := by
  simp [orientedTarget, orientedSource, edgeOfRow_boundary0,
    edgeOfRow_boundary1_horizontal, edgeOfRow_boundary1_vertical]

def horizontalSeamContribution {L : ℕ} (e : OrientedEdge L) : ℤ :=
  (horizontalSeamParity e : ℤ) * (1 - 2 * (e.2.toNat : ℤ))

def verticalSeamContribution {L : ℕ} (e : OrientedEdge L) : ℤ :=
  (verticalSeamParity e : ℤ) * (1 - 2 * (e.2.toNat : ℤ))

theorem cellBoundary_horizontalSeam_sum_zero (L : ℕ) [NeZero L]
    (i j : ZMod L) :
    ((cellBoundaryEdges L i j).map horizontalSeamContribution).sum = 0 := by
  have hh (r : ZMod L) :
      horizontalSeamParity (edgeOfRow L false r j, false) =
        if j.val = L - 1 then 1 else 0 := by
    simp only [horizontalSeamParity, edgeColumn_edgeOfRow]
    simp [edgeOfRow, rowColumnIndex_lt]
  have hv (r c : ZMod L) :
      horizontalSeamParity (edgeOfRow L true r c, false) = 0 := by
    simp [horizontalSeamParity, edgeOfRow]
  have hh' (r : ZMod L) :
      horizontalSeamParity (edgeOfRow L false r j, true) =
        if j.val = L - 1 then 1 else 0 := hh r
  have hv' (r c : ZMod L) :
      horizontalSeamParity (edgeOfRow L true r c, true) = 0 := hv r c
  simp [cellBoundaryEdges, horizontalSeamContribution, hh, hh', hv, hv']

theorem cellBoundary_verticalSeam_sum_zero (L : ℕ) [NeZero L]
    (i j : ZMod L) :
    ((cellBoundaryEdges L i j).map verticalSeamContribution).sum = 0 := by
  have hv (r c : ZMod L) :
      verticalSeamParity (edgeOfRow L true r c, false) =
        if r.val = L - 1 then 1 else 0 := by
    simp only [verticalSeamParity, edgeRow_edgeOfRow]
    simp [edgeOfRow]
  have hh (r c : ZMod L) :
      verticalSeamParity (edgeOfRow L false r c, false) = 0 := by
    simp [verticalSeamParity, edgeOfRow, rowColumnIndex_lt]
  have hv' (r c : ZMod L) :
      verticalSeamParity (edgeOfRow L true r c, true) =
        if r.val = L - 1 then 1 else 0 := hv r c
  have hh' (r c : ZMod L) :
      verticalSeamParity (edgeOfRow L false r c, true) = 0 := hh r c
  simp [cellBoundaryEdges, verticalSeamContribution, hh, hh', hv, hv']

end Ising2DLambda.KacWard
