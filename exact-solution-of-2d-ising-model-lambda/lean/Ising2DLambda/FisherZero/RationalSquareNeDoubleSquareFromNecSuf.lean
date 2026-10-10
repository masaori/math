import Ising2DLambda.FisherZero.NoRationalSquareTwo
import Ising2DLambda.NecSuf.FisherZero.RationalSquareNeDoubleSquare

namespace Ising2DLambda.FisherZero

/-- 本文の十七等号で、必要十分版の並べ替え・逆元・単位元の仮定を供給する。 -/
theorem rationalSquareNeDoubleSquare_from_necSuf
    (a b : ℚ) (hb : b ≠ 0) : a * a ≠ 2 * (b * b) := by
  apply Ising2DLambda.NecSuf.FisherZero.rational_square_ne_double_square_necSuf
      (two := (2 : ℚ)) (a := a) (b := b) (binv := b⁻¹) (r := a * b⁻¹)
      noRationalSquareTwo
  · rfl
  · calc
      (a * b⁻¹) * (a * b⁻¹) = a * (b⁻¹ * (a * b⁻¹)) := mul_assoc _ _ _
      _ = a * ((b⁻¹ * a) * b⁻¹) := congrArg (a * ·) (mul_assoc _ _ _).symm
      _ = a * ((a * b⁻¹) * b⁻¹) :=
        congrArg (fun q : ℚ => a * (q * b⁻¹)) (mul_comm b⁻¹ a)
      _ = a * (a * (b⁻¹ * b⁻¹)) := congrArg (a * ·) (mul_assoc _ _ _)
      _ = (a * a) * (b⁻¹ * b⁻¹) := (mul_assoc _ _ _).symm
  · calc
      (2 * (b * b)) * (b⁻¹ * b⁻¹) = 2 * ((b * b) * (b⁻¹ * b⁻¹)) := mul_assoc _ _ _
      _ = 2 * (b * (b * (b⁻¹ * b⁻¹))) := congrArg (2 * ·) (mul_assoc _ _ _)
      _ = 2 * (b * ((b * b⁻¹) * b⁻¹)) :=
        congrArg (fun q : ℚ => 2 * (b * q)) (mul_assoc _ _ _).symm
      _ = 2 * (b * ((b⁻¹ * b) * b⁻¹)) :=
        congrArg (fun q : ℚ => 2 * (b * (q * b⁻¹))) (mul_comm b b⁻¹)
      _ = 2 * (b * (b⁻¹ * (b * b⁻¹))) :=
        congrArg (fun q : ℚ => 2 * (b * q)) (mul_assoc _ _ _)
      _ = 2 * ((b * b⁻¹) * (b * b⁻¹)) := congrArg (2 * ·) (mul_assoc _ _ _).symm
  · exact mul_inv_cancel₀ hb
  · calc
      (2 : ℚ) * (1 * 1) = 2 * 1 := congrArg (2 * ·) (one_mul (1 : ℚ))
      _ = 2 := mul_one _

end Ising2DLambda.FisherZero
