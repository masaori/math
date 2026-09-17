import Ising2DLambda.KacWard.CutFlagStartRecovery

namespace Ising2DLambda.KacWard

def coordinateRecovered
    (side : ℤ) {n : ℕ} (displacement : Fin n → ℤ)
    (flags : Fin n → Bool × Bool) (start : ℤ) : Prop :=
  0 ≤ start ∧ start < side ∧
    (∀ x, coordinateForcedResidue side displacement flags x → start = x) ∧
    ¬coordinateForbiddenResidue side displacement flags start

def twoCoordinateCompatible
    (side : ℤ) {n : ℕ} (rowDisplacement columnDisplacement : Fin n → ℤ)
    (rowFlags columnFlags : Fin n → Bool × Bool) (start : ℤ × ℤ) : Prop :=
  (0 ≤ start.1 ∧ start.1 < side ∧
      coordinateStartCompatible side rowDisplacement rowFlags start.1) ∧
    (0 ≤ start.2 ∧ start.2 < side ∧
      coordinateStartCompatible side columnDisplacement columnFlags start.2)

def twoCoordinateRecovered
    (side : ℤ) {n : ℕ} (rowDisplacement columnDisplacement : Fin n → ℤ)
    (rowFlags columnFlags : Fin n → Bool × Bool) (start : ℤ × ℤ) : Prop :=
  coordinateRecovered side rowDisplacement rowFlags start.1 ∧
    coordinateRecovered side columnDisplacement columnFlags start.2

def coordinateLift
    (side : ℤ) {n : ℕ} (rowDisplacement columnDisplacement : Fin n → ℤ)
    (start : ℤ × ℤ) : Fin n → ℤ × ℤ :=
  fun i ↦ ((start.1 + rowDisplacement i) % side,
    (start.2 + columnDisplacement i) % side)

def coordinateLiftCandidate
    (side : ℤ) {n : ℕ} (rowDisplacement columnDisplacement : Fin n → ℤ)
    (rowFlags columnFlags : Fin n → Bool × Bool)
    (candidate : Fin n → ℤ × ℤ) : Prop :=
  ∃ start, twoCoordinateCompatible side rowDisplacement columnDisplacement
      rowFlags columnFlags start ∧
    candidate = coordinateLift side rowDisplacement columnDisplacement start

def coordinateBoundaryFlags (side : ℤ) (vertex : ℤ × ℤ) :
    (Bool × Bool) × (Bool × Bool) :=
  ((decide (vertex.1 = 0), decide (vertex.1 = side - 1)),
    (decide (vertex.2 = 0), decide (vertex.2 = side - 1)))

def boundaryExtensionFlags
    (side : ℤ) (offset start : ℤ × ℤ) :
    (Bool × Bool) × (Bool × Bool) :=
  coordinateBoundaryFlags side
    ((start.1 + offset.1) % side, (start.2 + offset.2) % side)

def boundaryExtensionCandidate
    (side : ℤ) {n : ℕ} (rowDisplacement columnDisplacement : Fin n → ℤ)
    (rowFlags columnFlags : Fin n → Bool × Bool) (offset : ℤ × ℤ)
    (option : (Bool × Bool) × (Bool × Bool)) : Prop :=
  ∃ start, twoCoordinateCompatible side rowDisplacement columnDisplacement
      rowFlags columnFlags start ∧
    option = boundaryExtensionFlags side offset start

/-- `claim_cut_flag_two_coordinate_boundary_completeness` の具体版の始点対。 -/
theorem twoCoordinateCompatible_iff_recovered
    (side : ℤ) {n : ℕ} (rowDisplacement columnDisplacement : Fin n → ℤ)
    (rowFlags columnFlags : Fin n → Bool × Bool) (start : ℤ × ℤ)
    (hside : 2 ≤ side) :
    twoCoordinateCompatible side rowDisplacement columnDisplacement
        rowFlags columnFlags start ↔
      twoCoordinateRecovered side rowDisplacement columnDisplacement
        rowFlags columnFlags start := by
  constructor
  · rintro ⟨hr, hc⟩
    exact ⟨(coordinateStartCompatible_iff_forcedForbidden
      side rowDisplacement rowFlags start.1 hside).mp hr,
      (coordinateStartCompatible_iff_forcedForbidden
        side columnDisplacement columnFlags start.2 hside).mp hc⟩
  · rintro ⟨hr, hc⟩
    exact ⟨(coordinateStartCompatible_iff_forcedForbidden
      side rowDisplacement rowFlags start.1 hside).mpr hr,
      (coordinateStartCompatible_iff_forcedForbidden
        side columnDisplacement columnFlags start.2 hside).mpr hc⟩

/-- The recovered row and column starts give exactly all compatible coordinate lifts. -/
theorem coordinateLiftCandidate_iff_recovered
    (side : ℤ) {n : ℕ} (rowDisplacement columnDisplacement : Fin n → ℤ)
    (rowFlags columnFlags : Fin n → Bool × Bool)
    (candidate : Fin n → ℤ × ℤ) (hside : 2 ≤ side) :
    coordinateLiftCandidate side rowDisplacement columnDisplacement
        rowFlags columnFlags candidate ↔
      ∃ start, twoCoordinateRecovered side rowDisplacement columnDisplacement
          rowFlags columnFlags start ∧
        candidate = coordinateLift side rowDisplacement columnDisplacement start := by
  constructor
  · rintro ⟨start, hstart, rfl⟩
    exact ⟨start, (twoCoordinateCompatible_iff_recovered
      side rowDisplacement columnDisplacement rowFlags columnFlags start hside).mp hstart, rfl⟩
  · rintro ⟨start, hstart, rfl⟩
    exact ⟨start, (twoCoordinateCompatible_iff_recovered
      side rowDisplacement columnDisplacement rowFlags columnFlags start hside).mpr hstart, rfl⟩

/-- The recovered starts give every and only the possible one-edge boundary flags. -/
theorem boundaryExtensionCandidate_iff_recovered
    (side : ℤ) {n : ℕ} (rowDisplacement columnDisplacement : Fin n → ℤ)
    (rowFlags columnFlags : Fin n → Bool × Bool) (offset : ℤ × ℤ)
    (option : (Bool × Bool) × (Bool × Bool)) (hside : 2 ≤ side) :
    boundaryExtensionCandidate side rowDisplacement columnDisplacement
        rowFlags columnFlags offset option ↔
      ∃ start, twoCoordinateRecovered side rowDisplacement columnDisplacement
          rowFlags columnFlags start ∧
        option = boundaryExtensionFlags side offset start := by
  constructor
  · rintro ⟨start, hstart, rfl⟩
    exact ⟨start, (twoCoordinateCompatible_iff_recovered
      side rowDisplacement columnDisplacement rowFlags columnFlags start hside).mp hstart, rfl⟩
  · rintro ⟨start, hstart, rfl⟩
    exact ⟨start, (twoCoordinateCompatible_iff_recovered
      side rowDisplacement columnDisplacement rowFlags columnFlags start hside).mpr hstart, rfl⟩

end Ising2DLambda.KacWard
