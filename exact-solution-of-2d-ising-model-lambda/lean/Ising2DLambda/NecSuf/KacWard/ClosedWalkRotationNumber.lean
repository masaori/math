import Ising2DLambda.NecSuf.KacWard.CyclicTotalTurning

namespace Ising2DLambda.NecSuf.KacWard

/-- The integer quotient of a total turn by one full turn. -/
def rotationNumber (totalTurn : ℤ) : ℤ := totalTurn / 4

theorem four_mul_rotationNumber (totalTurn : ℤ) (h : (4 : ℤ) ∣ totalTurn) :
    4 * rotationNumber totalTurn = totalTurn := by
  simp [rotationNumber, Int.mul_ediv_cancel' h]

end Ising2DLambda.NecSuf.KacWard
