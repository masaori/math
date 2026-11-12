import Ising2DLambda.NecSuf.KacWard.CyclicTotalTurning
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A cyclic turn is the sum of the turn at each departure edge. -/
theorem cyclicTotalTurning_eq_step_sum {E : Type*} {m : ℕ}
    (turn : E → E → ℤ) (γ : Fin (m + 1) → E) :
    cyclicTotalTurning turn γ =
      ∑ j : Fin (m + 1),
        if hj : j.val < m then
          turn (γ j) (γ ⟨j.val + 1, by omega⟩)
        else turn (γ j) (γ 0) := by
  rw [Fin.sum_univ_castSucc]
  simp only [cyclicTotalTurning, edgeSequenceTotalTurning]
  have hfirst :
      (∑ j : Fin m,
        if hj : (Fin.castSucc j).val < m then
          turn (γ (Fin.castSucc j))
            (γ ⟨(Fin.castSucc j).val + 1, by omega⟩)
        else turn (γ (Fin.castSucc j)) (γ 0)) =
      ∑ j : Fin m, turn (γ (Fin.castSucc j)) (γ (Fin.succ j)) := by
    apply Finset.sum_congr rfl
    intro j _
    simp [Fin.succ]
  rw [hfirst]
  simp

end Ising2DLambda.NecSuf.KacWard
