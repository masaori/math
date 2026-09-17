import Ising2DLambda.KacWard.TwoCoordinateBoundaryCompleteness
import Ising2DLambda.NecSuf.KacWard.TwoCoordinateBoundaryCompleteness

namespace Ising2DLambda.KacWard

theorem twoCoordinateCompatible_iff_recovered_from_necSuf
    (side : ℤ) {n : ℕ} (rowDisplacement columnDisplacement : Fin n → ℤ)
    (rowFlags columnFlags : Fin n → Bool × Bool) (start : ℤ × ℤ)
    (hside : 2 ≤ side) :
    twoCoordinateCompatible side rowDisplacement columnDisplacement
        rowFlags columnFlags start ↔
      twoCoordinateRecovered side rowDisplacement columnDisplacement
        rowFlags columnFlags start := by
  apply Ising2DLambda.NecSuf.KacWard.pairCompatible_iff_pairRecovered
      (fun r ↦ 0 ≤ r ∧ r < side ∧
        coordinateStartCompatible side rowDisplacement rowFlags r)
      (coordinateRecovered side rowDisplacement rowFlags)
      (fun c ↦ 0 ≤ c ∧ c < side ∧
        coordinateStartCompatible side columnDisplacement columnFlags c)
      (coordinateRecovered side columnDisplacement columnFlags)
  · intro r
    exact coordinateStartCompatible_iff_forcedForbidden
      side rowDisplacement rowFlags r hside
  · intro c
    exact coordinateStartCompatible_iff_forcedForbidden
      side columnDisplacement columnFlags c hside

theorem coordinateLiftCandidate_iff_recovered_from_necSuf
    (side : ℤ) {n : ℕ} (rowDisplacement columnDisplacement : Fin n → ℤ)
    (rowFlags columnFlags : Fin n → Bool × Bool)
    (candidate : Fin n → ℤ × ℤ) (hside : 2 ≤ side) :
    coordinateLiftCandidate side rowDisplacement columnDisplacement
        rowFlags columnFlags candidate ↔
      ∃ start, twoCoordinateRecovered side rowDisplacement columnDisplacement
          rowFlags columnFlags start ∧
        candidate = coordinateLift side rowDisplacement columnDisplacement start := by
  apply Ising2DLambda.NecSuf.KacWard.liftCandidate_iff_recovered
      (twoCoordinateCompatible side rowDisplacement columnDisplacement rowFlags columnFlags)
      (twoCoordinateRecovered side rowDisplacement columnDisplacement rowFlags columnFlags)
      (coordinateLift side rowDisplacement columnDisplacement)
  exact fun start ↦ twoCoordinateCompatible_iff_recovered_from_necSuf
    side rowDisplacement columnDisplacement rowFlags columnFlags start hside

theorem boundaryExtensionCandidate_iff_recovered_from_necSuf
    (side : ℤ) {n : ℕ} (rowDisplacement columnDisplacement : Fin n → ℤ)
    (rowFlags columnFlags : Fin n → Bool × Bool) (offset : ℤ × ℤ)
    (option : (Bool × Bool) × (Bool × Bool)) (hside : 2 ≤ side) :
    boundaryExtensionCandidate side rowDisplacement columnDisplacement
        rowFlags columnFlags offset option ↔
      ∃ start, twoCoordinateRecovered side rowDisplacement columnDisplacement
          rowFlags columnFlags start ∧
        option = boundaryExtensionFlags side offset start := by
  apply Ising2DLambda.NecSuf.KacWard.boundaryCandidate_iff_recovered
      (twoCoordinateCompatible side rowDisplacement columnDisplacement rowFlags columnFlags)
      (twoCoordinateRecovered side rowDisplacement columnDisplacement rowFlags columnFlags)
      (boundaryExtensionFlags side offset)
  exact fun start ↦ twoCoordinateCompatible_iff_recovered_from_necSuf
    side rowDisplacement columnDisplacement rowFlags columnFlags start hside

end Ising2DLambda.KacWard
