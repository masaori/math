import Ising2DLambda.KacWard.RealizableCutCandidateSelection

namespace Ising2DLambda.KacWard

noncomputable def reconstructedCutCoefficient
    (coefficient : Fin 2 → ZMod 2) (selected candidate : Fin 2) : ZMod 2 :=
  if candidate = selected then ∑ other, coefficient other else 0

/-- `claim_selected_support_coefficient_reconstruction` の具体版。 -/
theorem supportCoefficient_eq_reconstructed
    (side : ℤ) {n : ℕ}
    (rowDisplacement columnDisplacement : Fin 2 → Fin n → ℤ)
    (rowFlags columnFlags : Fin 2 → Fin n → Bool × Bool)
    (offset : Fin 2 → ℤ × ℤ)
    (option : Fin 2 → (Bool × Bool) × (Bool × Bool))
    (coefficient : Fin 2 → ZMod 2)
    (h : (recoveredCutCandidateSet side rowDisplacement columnDisplacement
      rowFlags columnFlags offset option).Nonempty)
    (hzero : ∀ candidate,
      candidate ≠ selectedRecoveredCutCandidate side rowDisplacement
        columnDisplacement rowFlags columnFlags offset option h →
      coefficient candidate = 0)
    (candidate : Fin 2) :
    coefficient candidate = reconstructedCutCoefficient coefficient
      (selectedRecoveredCutCandidate side rowDisplacement columnDisplacement
        rowFlags columnFlags offset option h) candidate := by
  by_cases hcandidate : candidate = selectedRecoveredCutCandidate side
      rowDisplacement columnDisplacement rowFlags columnFlags offset option h
  · subst candidate
    rw [reconstructedCutCoefficient, if_pos rfl]
    symm
    exact Fintype.sum_eq_single _ (fun other hne ↦ hzero other hne)
  · rw [reconstructedCutCoefficient, if_neg hcandidate]
    exact hzero candidate hcandidate

end Ising2DLambda.KacWard
