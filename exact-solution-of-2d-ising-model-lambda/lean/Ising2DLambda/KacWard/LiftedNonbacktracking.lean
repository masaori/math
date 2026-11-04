import Ising2DLambda.KacWard.PeriodicPlaneLiftPeriodTurning
import Ising2DLambda.KacWard.SuccessorDirectionSelection
import Ising2DLambda.NecSuf.KacWard.LiftedNonbacktracking

namespace Ising2DLambda.KacWard

private theorem directionUnitVector_shift_two (d : ZMod 4) :
    directionUnitVector (d + 2) = -directionUnitVector d := by
  fin_cases d <;> decide

private theorem directionUnitVector_injective : Function.Injective directionUnitVector := by
  decide

private theorem successor_direction_not_reverse {L : ℕ} [NeZero L]
    (e f : OrientedEdge L) (hf : f ∈ nonbacktrackingSuccessors e) :
    directionNumber f ≠ directionNumber e + 2 := by
  intro hdir
  have hsource : orientedSource f = orientedTarget e :=
    (Finset.mem_filter.mp hf).2.1.symm
  have hreverseSource : orientedSource (reversal e) = orientedTarget e := by
    rcases e with ⟨edge, false | true⟩ <;> rfl
  have heq : f = reversal e := sourceDirection_bijective.1
    (Prod.ext (hsource.trans hreverseSource.symm)
      (hdir.trans (directionNumber_reversal e).symm))
  exact (Finset.mem_filter.mp hf).2.2 heq

theorem liftedAdjacentSteps_not_opposite {L : ℕ} [NeZero L]
    (e f : OrientedEdge L) (hf : f ∈ nonbacktrackingSuccessors e) :
    orientedEdgeLatticeStep f ≠ -orientedEdgeLatticeStep e := by
  rw [orientedEdgeLatticeStep_eq_directionUnitVector,
    orientedEdgeLatticeStep_eq_directionUnitVector]
  intro hopposite
  have heq : directionUnitVector (directionNumber f) =
      directionUnitVector (directionNumber e + 2) :=
    hopposite.trans (directionUnitVector_shift_two (directionNumber e)).symm
  exact successor_direction_not_reverse e f hf (directionUnitVector_injective heq)

end Ising2DLambda.KacWard
