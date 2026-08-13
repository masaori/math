import Ising2DLambda.FisherZero.NoRationalSquareTwo
import Ising2DLambda.NecSuf.FisherZero.RationalSquareNeDoubleSquare

namespace Ising2DLambda.FisherZero

/-- `claim_rational_square_ne_double_square` の具体版を必要十分版から導く。 -/
theorem rationalSquareNeDoubleSquare_from_necSuf
    (a b : ℚ) (hb : b ≠ 0) : a * a ≠ 2 * (b * b) := by
  apply Ising2DLambda.NecSuf.FisherZero.rational_square_ne_double_square_necSuf
      (two := (2 : ℚ)) (a := a) (b := b) (binv := b⁻¹) (r := a * b⁻¹)
      noRationalSquareTwo
  · rfl
  · ring
  · ring
  · exact mul_inv_cancel₀ hb
  · ring

end Ising2DLambda.FisherZero
