import Ising2DLambda.KacWard.RepresentativeIncrement
import Ising2DLambda.KacWard.PeriodicPlaneLiftPeriodTurning
import Ising2DLambda.KacWard.TerminalMatrix
import Ising2DLambda.NecSuf.KacWard.EdgeRepresentativeDisplacement

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

private theorem coordinate_step (L : ℕ) [NeZero L] (y : ZMod L) (reverse : Bool) :
    (if reverse then residueRepresentative L y - residueRepresentative L (y + 1)
      else residueRepresentative L (y + 1) - residueRepresentative L y) =
      (if reverse then -1 else 1) -
        (L : ℤ) * (if residueRepresentative L y = (L : ℤ) - 1 then 1 else 0) *
          (if reverse then -1 else 1) := by
  have hstep := residueRepresentative_increment L y
  have hnonneg := residueRepresentative_nonneg L y
  have hlt := residueRepresentative_lt L y
  by_cases h : residueRepresentative L y ≤ (L : ℤ) - 2
  · have hn : residueRepresentative L y ≠ (L : ℤ) - 1 := by omega
    cases reverse <;> simp [hstep, h, hn]
  · have heq : residueRepresentative L y = (L : ℤ) - 1 := by omega
    cases reverse <;> simp [hstep, heq] <;> omega

/-- The actual oriented edge has representative displacement equal to its unit step
    minus the seam crossing, in both coordinates. -/
theorem edge_representative_displacement (L : ℕ) [NeZero L] (e : OrientedEdge L) :
    (residueRepresentative L (orientedTarget e).1 -
        residueRepresentative L (orientedSource e).1,
      residueRepresentative L (orientedTarget e).2 -
        residueRepresentative L (orientedSource e).2) =
      ((orientedEdgeLatticeStep e).1 -
          (L : ℤ) * (verticalSeamParity e : ℤ) * (1 - 2 * (e.2.toNat : ℤ)),
        (orientedEdgeLatticeStep e).2 -
          (L : ℤ) * (horizontalSeamParity e : ℤ) * (1 - 2 * (e.2.toNat : ℤ))) := by
  rcases e with ⟨edge, reverse⟩
  by_cases hh : edge.val < L ^ 2
  · have hcol : edgeColumn L edge < L :=
      Nat.mod_lt _ (NeZero.pos L)
    have hrep : residueRepresentative L (edgeColumn L edge : ZMod L) =
        (edgeColumn L edge : ℤ) := by
      simp [residueRepresentative, ZMod.val_natCast_of_lt hcol]
    have hseam : (edgeColumn L edge = L - 1) ↔
        residueRepresentative L (edgeColumn L edge : ZMod L) = (L : ℤ) - 1 := by
      rw [hrep]
      omega
    apply Prod.ext
    · cases reverse <;> simp [orientedSource, orientedTarget, boundary0, boundary1,
        orientedEdgeLatticeStep, verticalSeamParity, hh]
    · cases reverse with
      | false =>
        simpa [orientedSource, orientedTarget, boundary0, boundary1,
          orientedEdgeLatticeStep, horizontalSeamParity, hh, hseam] using
          coordinate_step L (edgeColumn L edge : ZMod L) false
      | true =>
        simpa [orientedSource, orientedTarget, boundary0, boundary1,
          orientedEdgeLatticeStep, horizontalSeamParity, hh, hseam] using
          coordinate_step L (edgeColumn L edge : ZMod L) true
  · have hrow : edgeRow L edge < L := by
      unfold edgeRow edgeIndex
      rw [if_neg hh]
      have hindex : edge.val - L ^ 2 < L ^ 2 := by
        have hval := edge.isLt
        omega
      exact (Nat.div_lt_iff_lt_mul (NeZero.pos L)).2 (by nlinarith)
    have hrep : residueRepresentative L (edgeRow L edge : ZMod L) =
        (edgeRow L edge : ℤ) := by
      simp [residueRepresentative, ZMod.val_natCast_of_lt hrow]
    have hseam : (edgeRow L edge = L - 1) ↔
        residueRepresentative L (edgeRow L edge : ZMod L) = (L : ℤ) - 1 := by
      rw [hrep]
      omega
    apply Prod.ext
    · cases reverse with
      | false =>
        simpa [orientedSource, orientedTarget, boundary0, boundary1,
          orientedEdgeLatticeStep, verticalSeamParity, hh, hseam] using
          coordinate_step L (edgeRow L edge : ZMod L) false
      | true =>
        simpa [orientedSource, orientedTarget, boundary0, boundary1,
          orientedEdgeLatticeStep, verticalSeamParity, hh, hseam] using
          coordinate_step L (edgeRow L edge : ZMod L) true
    · cases reverse <;> simp [orientedSource, orientedTarget, boundary0, boundary1,
        orientedEdgeLatticeStep, horizontalSeamParity, hh]

end Ising2DLambda.KacWard
