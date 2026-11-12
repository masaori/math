import Ising2DLambda.KacWard.CyclicTotalTurning
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The turn of the actual closed walk is summed once at each departure edge. -/
theorem cyclicTotalTurning_eq_step_sum {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    cyclicTotalTurning γ hγ =
      ∑ j : Fin (m + 1),
        if hj : j.val < m then
          stepTurning (γ j) (γ ⟨j.val + 1, by omega⟩)
        else stepTurning (γ j) (γ 0) := by
  rw [Fin.sum_univ_castSucc]
  simp only [cyclicTotalTurning, edgeSequenceTotalTurning]
  have hfirst :
      (∑ j : Fin m,
        if hj : (Fin.castSucc j).val < m then
          stepTurning (γ (Fin.castSucc j))
            (γ ⟨(Fin.castSucc j).val + 1, by omega⟩)
        else stepTurning (γ (Fin.castSucc j)) (γ 0)) =
      ∑ j : Fin m, stepTurning (γ (Fin.castSucc j)) (γ (Fin.succ j)) := by
    apply Finset.sum_congr rfl
    intro j _
    simp [Fin.succ]
  rw [hfirst]
  simp

end Ising2DLambda.KacWard
