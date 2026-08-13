/-
「自己双対条件は二次方程式と同値」の具体版。
人手証明と同じく `KW ξ * (1 + ξ) = 1 - ξ` を準備し、二方向を別々の鎖で示す。
住処は Qbar であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.KwDualTransformDomain

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_kw_self_dual_quadratic_equivalence` の具体版。 -/
theorem kwSelfDual_quadratic_equivalence {xi : Qbar} (hDomain : 1 + xi ≠ 0) :
    kwDualTransform xi = xi ↔ xi ^ 2 + 2 * xi - 1 = 0 := by
  have hInverse : (1 + xi) * (1 + xi)⁻¹ = 1 := mul_inv_cancel₀ hDomain
  have hProduct : kwDualTransform xi * (1 + xi) = 1 - xi := by
    calc
      kwDualTransform xi * (1 + xi)
          = ((1 - xi) * (1 + xi)⁻¹) * (1 + xi) := rfl
      _ = (1 - xi) * ((1 + xi)⁻¹ * (1 + xi)) := by rw [mul_assoc]
      _ = (1 - xi) * ((1 + xi) * (1 + xi)⁻¹) := by
        rw [mul_comm (1 + xi)⁻¹]
      _ = (1 - xi) * 1 := by rw [hInverse]
      _ = 1 - xi := by rw [mul_one]
  constructor
  · intro hSelfDual
    have hXiProduct : xi * (1 + xi) = 1 - xi := by
      calc
        xi * (1 + xi) = kwDualTransform xi * (1 + xi) := by rw [hSelfDual]
        _ = 1 - xi := hProduct
    calc
      xi ^ 2 + 2 * xi - 1 = (xi * (1 + xi) - xi) + 2 * xi - 1 := by ring
      _ = ((1 - xi) - xi) + 2 * xi - 1 := by rw [hXiProduct]
      _ = (1 - 2 * xi) + 2 * xi - 1 := by ring
      _ = 0 := by ring
  · intro hQuadratic
    have hDifferenceProduct : (1 + xi) * (kwDualTransform xi - xi) = 0 := by
      calc
        (1 + xi) * (kwDualTransform xi - xi)
            = (1 + xi) * kwDualTransform xi - (1 + xi) * xi := by rw [mul_sub]
        _ = kwDualTransform xi * (1 + xi) - xi * (1 + xi) := by ring
        _ = (1 - xi) - xi * (1 + xi) := by rw [hProduct]
        _ = (1 - xi) - (xi + xi ^ 2) := by ring
        _ = -(xi ^ 2 + 2 * xi - 1) := by ring
        _ = -0 := by rw [hQuadratic]
        _ = 0 := neg_zero
    have hDifferenceZero : kwDualTransform xi - xi = 0 :=
      AlgebraicEigenvalue.qbarNoZeroDivisors hDomain hDifferenceProduct
    exact sub_eq_zero.mp hDifferenceZero

end Ising2DLambda.FisherZero
