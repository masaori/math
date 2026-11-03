import Ising2DLambda.KacWard.CyclicTotalTurning
import Ising2DLambda.NecSuf.KacWard.ClosedWalkRotationNumber

namespace Ising2DLambda.KacWard

/-- `def_closed_walk_rotation_number` for an actual closed nonbacktracking walk. -/
def closedWalkRotationNumber {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) : ℤ :=
  cyclicTotalTurning γ hγ / 4

theorem closedWalkRotationNumber_eq {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    closedWalkRotationNumber γ hγ = cyclicTotalTurning γ hγ / 4 := rfl

theorem four_mul_closedWalkRotationNumber {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hfour : (4 : ℤ) ∣ cyclicTotalTurning γ hγ) :
    4 * closedWalkRotationNumber γ hγ = cyclicTotalTurning γ hγ := by
  simp [closedWalkRotationNumber, Int.mul_ediv_cancel' hfour]

theorem closedWalkRotationNumber_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    closedWalkRotationNumber γ hγ =
      Ising2DLambda.NecSuf.KacWard.rotationNumber (cyclicTotalTurning γ hγ) := rfl

end Ising2DLambda.KacWard
