import Ising2DLambda.KacWard.SelectedSupportCoefficientReconstruction

namespace Ising2DLambda.KacWard

/-- `claim_two_support_coefficient_formula` の具体版。 -/
theorem twoSupportCoefficientFormula
    (side : ℤ) {n : ℕ}
    (rowDisplacement columnDisplacement : Fin 2 → Fin n → ℤ)
    (rowFlags columnFlags : Fin 2 → Fin n → Bool × Bool)
    (offset : Fin 2 → ℤ × ℤ)
    (option : Fin 2 → (Bool × Bool) × (Bool × Bool))
    (first second : Fin 2 → ZMod 2)
    (h : (recoveredCutCandidateSet side rowDisplacement columnDisplacement
      rowFlags columnFlags offset option).Nonempty)
    (hfirst : ∀ candidate,
      candidate ≠ selectedRecoveredCutCandidate side rowDisplacement
        columnDisplacement rowFlags columnFlags offset option h →
      first candidate = 0)
    (hsecond : ∀ candidate,
      candidate ≠ selectedRecoveredCutCandidate side rowDisplacement
        columnDisplacement rowFlags columnFlags offset option h →
      second candidate = 0)
    (candidate : Fin 2) :
    first candidate + second candidate =
      if candidate = selectedRecoveredCutCandidate side rowDisplacement
          columnDisplacement rowFlags columnFlags offset option h then
        (∑ other, first other) + ∑ other, second other
      else 0 := by
  by_cases hcandidate : candidate = selectedRecoveredCutCandidate side
      rowDisplacement columnDisplacement rowFlags columnFlags offset option h
  · subst candidate
    rw [if_pos rfl]
    have hone := supportCoefficient_eq_reconstructed side rowDisplacement
      columnDisplacement rowFlags columnFlags offset option first h hfirst
      (selectedRecoveredCutCandidate side rowDisplacement columnDisplacement
        rowFlags columnFlags offset option h)
    have htwo := supportCoefficient_eq_reconstructed side rowDisplacement
      columnDisplacement rowFlags columnFlags offset option second h hsecond
      (selectedRecoveredCutCandidate side rowDisplacement columnDisplacement
        rowFlags columnFlags offset option h)
    simpa [reconstructedCutCoefficient] using congrArg₂ (fun a b ↦ a + b) hone htwo
  · rw [if_neg hcandidate, hfirst candidate hcandidate,
      hsecond candidate hcandidate, zero_add]

end Ising2DLambda.KacWard
