import Ising2DLambda.KacWard.StepTurning
import Ising2DLambda.KacWard.PlaneProjectionCyclicTurning

namespace Ising2DLambda.KacWard

/-- The turn of an actual nonbacktracking pair is the turn of its two directions. -/
theorem stepTurning_eq_directionPairTurning {L : ℕ} [NeZero L]
    (e f : OrientedEdge L) (hf : f ∈ nonbacktrackingSuccessors e) :
    stepTurning e f = directionPairTurning (directionNumber e) (directionNumber f) := by
  have hreverse : directionNumber f ≠ directionNumber e + 2 := by
    intro h
    have hs : orientedSource f = orientedTarget e := (Finset.mem_filter.mp hf).2.1.symm
    have hr : orientedSource (reversal e) = orientedTarget e := by
      rcases e with ⟨edge, false | true⟩ <;> rfl
    have heq : f = reversal e := sourceDirection_bijective.1
      (Prod.ext (hs.trans hr.symm) (h.trans (directionNumber_reversal e).symm))
    exact (Finset.mem_filter.mp hf).2.2 heq
  simp only [stepTurning, if_pos hf]
  generalize ha : directionNumber e = a at *
  generalize hb : directionNumber f = b at *
  fin_cases a <;> fin_cases b <;>
    simp_all [directionPairTurning] <;> decide

end Ising2DLambda.KacWard
