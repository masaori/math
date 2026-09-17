import Ising2DLambda.KacWard.TwoSupportCoefficientFormula
import Ising2DLambda.NecSuf.KacWard.TwoSupportCoefficientFormula

namespace Ising2DLambda.KacWard

theorem twoSupportCoefficientFormula_from_necSuf
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
  exact Ising2DLambda.NecSuf.KacWard.two_support_coefficient_formula_necSuf
    first second
    (selectedRecoveredCutCandidate side rowDisplacement columnDisplacement
      rowFlags columnFlags offset option h)
    candidate hfirst hsecond

end Ising2DLambda.KacWard
