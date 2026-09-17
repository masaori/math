import Ising2DLambda.KacWard.TwoCoordinateBoundaryCompleteness

namespace Ising2DLambda.KacWard

def cutCandidateRealizable
    (side : ℤ) {n : ℕ}
    (rowDisplacement columnDisplacement : Fin 2 → Fin n → ℤ)
    (rowFlags columnFlags : Fin 2 → Fin n → Bool × Bool)
    (offset : Fin 2 → ℤ × ℤ)
    (option : Fin 2 → (Bool × Bool) × (Bool × Bool))
    (candidate : Fin 2) : Prop :=
  boundaryExtensionCandidate side
    (rowDisplacement candidate) (columnDisplacement candidate)
    (rowFlags candidate) (columnFlags candidate)
    (offset candidate) (option candidate)

def cutCandidateRecovered
    (side : ℤ) {n : ℕ}
    (rowDisplacement columnDisplacement : Fin 2 → Fin n → ℤ)
    (rowFlags columnFlags : Fin 2 → Fin n → Bool × Bool)
    (offset : Fin 2 → ℤ × ℤ)
    (option : Fin 2 → (Bool × Bool) × (Bool × Bool))
    (candidate : Fin 2) : Prop :=
  ∃ start,
    twoCoordinateRecovered side
      (rowDisplacement candidate) (columnDisplacement candidate)
      (rowFlags candidate) (columnFlags candidate) start ∧
    option candidate = boundaryExtensionFlags side (offset candidate) start

noncomputable def recoveredCutCandidateSet
    (side : ℤ) {n : ℕ}
    (rowDisplacement columnDisplacement : Fin 2 → Fin n → ℤ)
    (rowFlags columnFlags : Fin 2 → Fin n → Bool × Bool)
    (offset : Fin 2 → ℤ × ℤ)
    (option : Fin 2 → (Bool × Bool) × (Bool × Bool)) : Finset (Fin 2) := by
  classical
  exact Finset.univ.filter fun candidate ↦
    cutCandidateRecovered side rowDisplacement columnDisplacement
      rowFlags columnFlags offset option candidate

/-- `claim_cut_flag_realizable_candidate_selection` の具体版。 -/
theorem cutCandidateRealizable_iff_mem_recoveredSet
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
  rw [cutCandidateRealizable, recoveredCutCandidateSet, Finset.mem_filter]
  simp only [Finset.mem_univ, true_and, cutCandidateRecovered]
  exact boundaryExtensionCandidate_iff_recovered side
    (rowDisplacement candidate) (columnDisplacement candidate)
    (rowFlags candidate) (columnFlags candidate)
    (offset candidate) (option candidate) hside

noncomputable def selectedRecoveredCutCandidate
    (side : ℤ) {n : ℕ}
    (rowDisplacement columnDisplacement : Fin 2 → Fin n → ℤ)
    (rowFlags columnFlags : Fin 2 → Fin n → Bool × Bool)
    (offset : Fin 2 → ℤ × ℤ)
    (option : Fin 2 → (Bool × Bool) × (Bool × Bool))
    (h : (recoveredCutCandidateSet side rowDisplacement columnDisplacement
      rowFlags columnFlags offset option).Nonempty) : Fin 2 :=
  (recoveredCutCandidateSet side rowDisplacement columnDisplacement
    rowFlags columnFlags offset option).min' h

theorem selectedRecoveredCutCandidate_realizable
    (side : ℤ) {n : ℕ}
    (rowDisplacement columnDisplacement : Fin 2 → Fin n → ℤ)
    (rowFlags columnFlags : Fin 2 → Fin n → Bool × Bool)
    (offset : Fin 2 → ℤ × ℤ)
    (option : Fin 2 → (Bool × Bool) × (Bool × Bool))
    (hside : 2 ≤ side)
    (h : (recoveredCutCandidateSet side rowDisplacement columnDisplacement
      rowFlags columnFlags offset option).Nonempty) :
    cutCandidateRealizable side rowDisplacement columnDisplacement
      rowFlags columnFlags offset option
      (selectedRecoveredCutCandidate side rowDisplacement columnDisplacement
        rowFlags columnFlags offset option h) := by
  classical
  apply (cutCandidateRealizable_iff_mem_recoveredSet side
    rowDisplacement columnDisplacement rowFlags columnFlags offset option
    (selectedRecoveredCutCandidate side rowDisplacement columnDisplacement
      rowFlags columnFlags offset option h) hside).mpr
  exact Finset.min'_mem _ _

end Ising2DLambda.KacWard
