import Ising2DLambda.KacWard.SelectedSupportCoefficientReconstruction
import Ising2DLambda.NecSuf.KacWard.SelectedSupportCoefficientReconstruction

namespace Ising2DLambda.KacWard

theorem supportCoefficient_eq_reconstructed_from_necSuf
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
  exact Ising2DLambda.NecSuf.KacWard.coefficient_eq_selected_sum coefficient
    (selectedRecoveredCutCandidate side rowDisplacement columnDisplacement
      rowFlags columnFlags offset option h) candidate hzero

end Ising2DLambda.KacWard
