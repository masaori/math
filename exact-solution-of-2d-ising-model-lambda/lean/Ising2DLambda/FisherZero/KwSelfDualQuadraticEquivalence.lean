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
  have hDouble : xi + xi = 2 * xi := by
    calc
      xi + xi = 1 * xi + 1 * xi := by rw [one_mul]
      _ = (1 + 1) * xi := by rw [add_mul]
      _ = 2 * xi := by norm_num
  constructor
  · intro hSelfDual
    have hXiProduct : xi * (1 + xi) = 1 - xi := by
      calc
        xi * (1 + xi) = kwDualTransform xi * (1 + xi) := by rw [hSelfDual]
        _ = 1 - xi := hProduct
    calc
      xi ^ 2 + 2 * xi - 1 = ((xi ^ 2 + xi) - xi) + 2 * xi - 1 := by
        rw [add_sub_cancel_right]
      _ = ((xi + xi ^ 2) - xi) + 2 * xi - 1 := by rw [add_comm (xi ^ 2) xi]
      _ = ((xi + xi * xi) - xi) + 2 * xi - 1 := by rw [pow_two]
      _ = ((xi * 1 + xi * xi) - xi) + 2 * xi - 1 := by rw [mul_one]
      _ = (xi * (1 + xi) - xi) + 2 * xi - 1 := by rw [mul_add]
      _ = ((1 - xi) - xi) + 2 * xi - 1 := by rw [hXiProduct]
      _ = (1 - (xi + xi)) + 2 * xi - 1 := by rw [sub_sub]
      _ = (1 - 2 * xi) + 2 * xi - 1 := by rw [hDouble]
      _ = 1 - 1 := by rw [sub_add_cancel]
      _ = 0 := sub_self 1
  · intro hQuadratic
    have hDifferenceProduct : (1 + xi) * (kwDualTransform xi - xi) = 0 := by
      calc
        (1 + xi) * (kwDualTransform xi - xi)
            = (1 + xi) * kwDualTransform xi - (1 + xi) * xi := by rw [mul_sub]
        _ = kwDualTransform xi * (1 + xi) - xi * (1 + xi) := by
          rw [mul_comm (1 + xi) (kwDualTransform xi), mul_comm (1 + xi) xi]
        _ = (1 - xi) - xi * (1 + xi) := by rw [hProduct]
        _ = (1 - xi) - (xi * 1 + xi * xi) := by rw [mul_add]
        _ = (1 - xi) - (xi + xi * xi) := by rw [mul_one]
        _ = (1 - xi) - (xi + xi ^ 2) := by rw [pow_two]
        _ = 1 - xi - xi - xi ^ 2 := sub_add_eq_sub_sub _ _ _
        _ = (1 - (xi + xi)) - xi ^ 2 := by rw [sub_sub 1 xi xi]
        _ = 1 - 2 * xi - xi ^ 2 := by rw [hDouble]
        _ = (1 - 2 * xi) + (-xi ^ 2) := sub_eq_add_neg _ _
        _ = -xi ^ 2 + (1 - 2 * xi) := add_comm _ _
        _ = (-xi ^ 2 + 1) - 2 * xi := (add_sub_assoc _ _ _).symm
        _ = (1 + (-xi ^ 2)) - 2 * xi := by rw [add_comm (-xi ^ 2) 1]
        _ = 1 + (-xi ^ 2 - 2 * xi) := add_sub_assoc _ _ _
        _ = -xi ^ 2 - 2 * xi + 1 := add_comm _ _
        _ = (-xi ^ 2 + (-(2 * xi))) + 1 := by rw [sub_eq_add_neg]
        _ = -(xi ^ 2 + 2 * xi) + 1 := by rw [neg_add]
        _ = -(xi ^ 2 + 2 * xi) + (-(-1)) := by rw [neg_neg]
        _ = -((xi ^ 2 + 2 * xi) + (-1)) := (neg_add _ _).symm
        _ = -(xi ^ 2 + 2 * xi - 1) := by rw [sub_eq_add_neg]
        _ = -0 := by rw [hQuadratic]
        _ = 0 := neg_zero
    have hDifferenceZero : kwDualTransform xi - xi = 0 :=
      AlgebraicEigenvalue.qbarNoZeroDivisors hDomain hDifferenceProduct
    calc
      kwDualTransform xi = (kwDualTransform xi - xi) + xi := by rw [sub_add_cancel]
      _ = 0 + xi := by rw [hDifferenceZero]
      _ = xi := zero_add xi

end Ising2DLambda.FisherZero
