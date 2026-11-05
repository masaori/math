import Ising2DLambda.KacWard.OneSidedClosurePeriodDifferenceTurning
import Ising2DLambda.KacWard.PlaneLiftIntegerBaseEndpoint
import Ising2DLambda.KacWard.ClosedNonbacktrackingWalk

namespace Ising2DLambda.KacWard

/-- 実際の閉歩道から作る一側閉包の周期数差は、元の辺列の循環回転和である。 -/
theorem oneSidedClosureFromWalk_periodDifferenceTurning {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ) (t c : ℕ) (ht : 0 < t) (hc : 0 < c) :
    oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ)
        k₀ t (c + 1) -
      oneSidedClosureProjectedTurning (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ)
        k₀ t c =
      ∑ j : ZMod (m + 1),
        directionPairTurning
          (directionNumber (γ ⟨j.val, ZMod.val_lt j⟩))
          (directionNumber (γ ⟨(j + 1).val, ZMod.val_lt (j + 1)⟩)) := by
  let γz : ZMod (m + 1) → OrientedEdge L :=
    fun j => γ ⟨j.val, ZMod.val_lt j⟩
  have hstep (j : ℕ) (hj : j < m + 1) :
      planeLiftIntegerBase γ ((j : ℤ) + 1) =
        planeLiftIntegerBase γ j + orientedEdgeLatticeStep (γz (j : ZMod (m + 1))) := by
    simpa [γz, ZMod.val_natCast, Nat.mod_eq_of_lt hj] using
      planeLiftIntegerBase_step γ j hj
  have hend := planeLiftIntegerBase_endpoint γ hγ
  have hsum : 0 < (horizontalDirectedWindingNumber γ).natAbs +
      (verticalDirectedWindingNumber γ).natAbs := by
    by_contra h
    have hh : horizontalDirectedWindingNumber γ = 0 :=
      Int.natAbs_eq_zero.mp (by omega)
    have hv : verticalDirectedWindingNumber γ = 0 :=
      Int.natAbs_eq_zero.mp (by omega)
    exact hwind (Prod.ext hh hv)
  have hn : 0 < L * (horizontalDirectedWindingNumber γ).natAbs +
      L * (verticalDirectedWindingNumber γ).natAbs := by
    rw [← Nat.mul_add]
    exact Nat.mul_pos (NeZero.pos L) hsum
  have hb : 0 < t * ((horizontalDirectedWindingNumber γ).natAbs +
      (verticalDirectedWindingNumber γ).natAbs) := Nat.mul_pos ht hsum
  exact oneSidedClosure_periodDifferenceTurning (m + 1) L (planeLiftIntegerBase γ)
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ)
    k₀ t c γz hstep hend hn hb hc

end Ising2DLambda.KacWard
