import Ising2DLambda.KacWard.RepresentativeIncrement
import Ising2DLambda.KacWard.PeriodicPlaneLiftPeriodTurning
import Ising2DLambda.KacWard.TerminalMatrix
import Ising2DLambda.TransferMatrix.Basic
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
    minus the seam crossing, in both coordinates.
    本文の証明どおり、辺番号の全単射（`claim_edge_row_partition` の `edgeEquiv`）で辺を
    `n_h(i₀,j₀)` か `n_v(i₀,j₀)` のちょうど一方に分解し、端点写像の値
    （`edgeOfRow_boundary0`・`edgeOfRow_boundary1_horizontal`・`edgeOfRow_boundary1_vertical`）から
    座標ごとの差を計算する。 -/
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
  obtain ⟨w, rfl⟩ := (Ising2DLambda.TransferMatrix.edgeEquiv L).surjective edge
  have hrepNat : ∀ y : ZMod L, residueRepresentative L y = (y.val : ℤ) := fun _ => rfl
  rcases w with ⟨i₀, j₀⟩ | ⟨i₀, j₀⟩
  · -- 横向き `e = n_h(i₀,j₀)`。
    have hval : (Ising2DLambda.TransferMatrix.edgeOfRow L false i₀ j₀).val < L ^ 2 := by
      simpa [Ising2DLambda.TransferMatrix.edgeOfRow] using
        Ising2DLambda.TransferMatrix.rowColumnIndex_lt L i₀ j₀
    have h0 := Ising2DLambda.TransferMatrix.edgeOfRow_boundary0 L false i₀ j₀
    have h1 := Ising2DLambda.TransferMatrix.edgeOfRow_boundary1_horizontal L i₀ j₀
    have hcol := Ising2DLambda.TransferMatrix.edgeColumn_edgeOfRow L false i₀ j₀
    have hseam :
        edgeColumn L (Ising2DLambda.TransferMatrix.edgeOfRow L false i₀ j₀) = L - 1 ↔
        residueRepresentative L j₀ = (L : ℤ) - 1 := by
      rw [hcol, hrepNat]
      have := ZMod.val_lt j₀
      omega
    apply Prod.ext
    · cases reverse <;> simp [orientedSource, orientedTarget, h0, h1,
        orientedEdgeLatticeStep, verticalSeamParity, hval]
    · cases reverse with
      | false =>
        simpa [orientedSource, orientedTarget, h0, h1,
          orientedEdgeLatticeStep, horizontalSeamParity, hval, hseam] using
          coordinate_step L j₀ false
      | true =>
        simpa [orientedSource, orientedTarget, h0, h1,
          orientedEdgeLatticeStep, horizontalSeamParity, hval, hseam] using
          coordinate_step L j₀ true
  · -- 縦向き `e = n_v(i₀,j₀)`。行と列を入れ替えた同じ計算。
    have hval : ¬ (Ising2DLambda.TransferMatrix.edgeOfRow L true i₀ j₀).val < L ^ 2 := by
      simp [Ising2DLambda.TransferMatrix.edgeOfRow]
    have h0 := Ising2DLambda.TransferMatrix.edgeOfRow_boundary0 L true i₀ j₀
    have h1 := Ising2DLambda.TransferMatrix.edgeOfRow_boundary1_vertical L i₀ j₀
    have hrow := Ising2DLambda.TransferMatrix.edgeRow_edgeOfRow L true i₀ j₀
    have hseam :
        edgeRow L (Ising2DLambda.TransferMatrix.edgeOfRow L true i₀ j₀) = L - 1 ↔
        residueRepresentative L i₀ = (L : ℤ) - 1 := by
      rw [hrow, hrepNat]
      have := ZMod.val_lt i₀
      omega
    apply Prod.ext
    · cases reverse with
      | false =>
        simpa [orientedSource, orientedTarget, h0, h1,
          orientedEdgeLatticeStep, verticalSeamParity, hval, hseam] using
          coordinate_step L i₀ false
      | true =>
        simpa [orientedSource, orientedTarget, h0, h1,
          orientedEdgeLatticeStep, verticalSeamParity, hval, hseam] using
          coordinate_step L i₀ true
    · cases reverse <;> simp [orientedSource, orientedTarget, h0, h1,
        orientedEdgeLatticeStep, horizontalSeamParity, hval]

end Ising2DLambda.KacWard
