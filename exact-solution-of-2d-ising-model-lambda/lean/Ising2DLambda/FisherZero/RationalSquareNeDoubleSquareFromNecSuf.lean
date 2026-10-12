import Ising2DLambda.FisherZero.NoRationalSquareTwoFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.RationalSquareNeDoubleSquare

namespace Ising2DLambda.FisherZero

/-- 有理数の結合則・可換則・右逆元・単位元則を供給し、十七等号の必要十分版へ特殊化する。 -/
theorem rationalSquareNeDoubleSquare_from_necSuf
    (a b : ℚ) (hb : b ≠ 0) : a * a ≠ 2 * (b * b) := by
  apply Ising2DLambda.NecSuf.FisherZero.rational_square_ne_double_square_necSuf
      (two := (2 : ℚ)) (a := a) (b := b) (binv := b⁻¹) (r := a * b⁻¹)
      noRationalSquareTwo_from_necSuf
  · rfl
  · exact mul_assoc
  · exact mul_comm b⁻¹ a
  · exact mul_comm b b⁻¹
  · exact mul_inv_cancel₀ hb
  · exact one_mul 1
  · exact mul_one 2

end Ising2DLambda.FisherZero
