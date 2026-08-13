/-
「有理数の平方は二倍の平方にならない（混合符号の排除）」の具体版。
人手証明と同じく、b の逆元から r := a * b⁻¹ を置き、六段の鎖で r * r = 2 を導く。
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
    _ = (a * a) * (b⁻¹ * b⁻¹) := by ring
    _ = (2 * (b * b)) * (b⁻¹ * b⁻¹) := by rw [hSquare]
    _ = 2 * ((b * b⁻¹) * (b * b⁻¹)) := by ring
    _ = 2 * (1 * 1) := by rw [mul_inv_cancel₀ hb]
    _ = 2 := by ring

end Ising2DLambda.FisherZero
