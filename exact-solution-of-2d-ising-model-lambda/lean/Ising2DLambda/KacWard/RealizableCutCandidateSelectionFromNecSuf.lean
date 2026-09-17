import Ising2DLambda.KacWard.RealizableCutCandidateSelection
import Ising2DLambda.KacWard.TwoCoordinateBoundaryCompletenessFromNecSuf
import Ising2DLambda.NecSuf.KacWard.RealizableCutCandidateSelection

namespace Ising2DLambda.KacWard

theorem cutCandidateRealizable_iff_mem_recoveredSet_from_necSuf
    (side : ℤ) {n : ℕ}
    (rowDisplacement columnDisplacement : Fin 2 → Fin n → ℤ)
    (rowFlags columnFlags : Fin 2 → Fin n → Bool × Bool)
    (offset : Fin 2 → ℤ × ℤ)
    (option : Fin 2 → (Bool × Bool) × (Bool × Bool))
    (candidate : Fin 2) (hside : 2 ≤ side) :
    cutCandidateRealizable side rowDisplacement columnDisplacement
        rowFlags columnFlags offset option candidate ↔
      candidate ∈ recoveredCutCandidateSet side rowDisplacement
        columnDisplacement rowFlags columnFlags offset option := by
  classical
  apply Ising2DLambda.NecSuf.KacWard.realizable_iff_mem_recoveredCandidateSet
      (cutCandidateRealizable side rowDisplacement columnDisplacement
        rowFlags columnFlags offset option)
      (cutCandidateRecovered side rowDisplacement columnDisplacement
        rowFlags columnFlags offset option)
  intro selected
  exact boundaryExtensionCandidate_iff_recovered_from_necSuf side
    (rowDisplacement selected) (columnDisplacement selected)
    (rowFlags selected) (columnFlags selected)
    (offset selected) (option selected) hside

end Ising2DLambda.KacWard
