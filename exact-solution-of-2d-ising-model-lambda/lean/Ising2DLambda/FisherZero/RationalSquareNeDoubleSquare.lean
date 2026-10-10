/-
「有理数の平方は二倍の平方にならない（混合符号の排除）」の具体版。
人手証明と同じく、b の逆元から r := a * b⁻¹ を置き、十七等号の鎖で r * r = 2 を導く。
-/
import Ising2DLambda.FisherZero.NoRationalSquareTwo

namespace Ising2DLambda.FisherZero

/-- `claim_rational_square_ne_double_square` の具体版。 -/
theorem rationalSquareNeDoubleSquare
    (a b : ℚ) (hb : b ≠ 0) : a * a ≠ 2 * (b * b) := by
  intro hSquare
  let r : ℚ := a * b⁻¹
  apply noRationalSquareTwo r
  calc
    r * r = (a * b⁻¹) * (a * b⁻¹) := rfl
    _ = a * (b⁻¹ * (a * b⁻¹)) := mul_assoc _ _ _
    _ = a * ((b⁻¹ * a) * b⁻¹) := congrArg (a * ·) (mul_assoc _ _ _).symm
    _ = a * ((a * b⁻¹) * b⁻¹) :=
      congrArg (fun q : ℚ => a * (q * b⁻¹)) (mul_comm b⁻¹ a)
    _ = a * (a * (b⁻¹ * b⁻¹)) := congrArg (a * ·) (mul_assoc _ _ _)
    _ = (a * a) * (b⁻¹ * b⁻¹) := (mul_assoc _ _ _).symm
    _ = (2 * (b * b)) * (b⁻¹ * b⁻¹) := congrArg (· * (b⁻¹ * b⁻¹)) hSquare
    _ = 2 * ((b * b) * (b⁻¹ * b⁻¹)) := mul_assoc _ _ _
    _ = 2 * (b * (b * (b⁻¹ * b⁻¹))) := congrArg (2 * ·) (mul_assoc _ _ _)
    _ = 2 * (b * ((b * b⁻¹) * b⁻¹)) :=
      congrArg (fun q : ℚ => 2 * (b * q)) (mul_assoc _ _ _).symm
    _ = 2 * (b * ((b⁻¹ * b) * b⁻¹)) :=
      congrArg (fun q : ℚ => 2 * (b * (q * b⁻¹))) (mul_comm b b⁻¹)
    _ = 2 * (b * (b⁻¹ * (b * b⁻¹))) :=
      congrArg (fun q : ℚ => 2 * (b * q)) (mul_assoc _ _ _)
    _ = 2 * ((b * b⁻¹) * (b * b⁻¹)) := congrArg (2 * ·) (mul_assoc _ _ _).symm
    _ = 2 * (1 * (b * b⁻¹)) :=
      congrArg (fun q : ℚ => 2 * (q * (b * b⁻¹))) (mul_inv_cancel₀ hb)
    _ = 2 * (1 * 1) := congrArg (fun q : ℚ => 2 * (1 * q)) (mul_inv_cancel₀ hb)
    _ = 2 * 1 := congrArg (2 * ·) (one_mul (1 : ℚ))
    _ = 2 := mul_one _

end Ising2DLambda.FisherZero
