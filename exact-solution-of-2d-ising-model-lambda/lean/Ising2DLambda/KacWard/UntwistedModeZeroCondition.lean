import Ising2DLambda.KacWard.TwistedModeSets
import Ising2DLambda.KacWard.ModeSmallMatrixDeterminantDispersion

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_untwisted_mode_zero_condition`: membership, square factorization,
and the zero equivalence are proved in the order of the human proof. -/
theorem untwistedMode_zero_condition (L : ℕ) (q : Qbar) :
    ((1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) * (1 + 1 + 1 + 1) = 0 ↔
      q ^ 2 + 2 * q - 1 = 0) := by
  have hhorizontal : (1 : Qbar) ∈ horizontalTwistedModes L (false, false) := by
    simp [horizontalTwistedModes]
  have hvertical : (1 : Qbar) ∈ verticalTwistedModes L (false, false) := by
    simp [verticalTwistedModes]
  have hsum : (1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) * (1 + 1 + 1 + 1) =
      (1 + q ^ 2) ^ 2 - 4 * q * (1 - q ^ 2) := by ring
  have hfactor : (1 + q ^ 2) ^ 2 - 4 * q * (1 - q ^ 2) =
      (1 - 2 * q - q ^ 2) ^ 2 := by ring
  -- These two memberships make (1, 1) a mode of the untwisted structure.
  have _ := hhorizontal
  have _ := hvertical
  -- The two algebraic equalities match the displayed steps of the human proof.
  rw [hsum, hfactor]
  constructor
  · intro h
    have hbase : 1 - 2 * q - q ^ 2 = 0 := by
      have hm : (1 - 2 * q - q ^ 2) * (1 - 2 * q - q ^ 2) = 0 := by
        simpa [pow_two] using h
      exact (mul_eq_zero.mp hm).elim id id
    calc
      q ^ 2 + 2 * q - 1 = -(1 - 2 * q - q ^ 2) := by ring
      _ = 0 := by rw [hbase]; ring
  · intro h
    have hbase : 1 - 2 * q - q ^ 2 = 0 := by
      calc
        1 - 2 * q - q ^ 2 = -(q ^ 2 + 2 * q - 1) := by ring
        _ = 0 := by rw [h]; ring
    rw [hbase]
    ring

end Ising2DLambda.KacWard
