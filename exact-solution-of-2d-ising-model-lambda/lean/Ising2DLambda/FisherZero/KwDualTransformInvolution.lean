/-
「双対変換の対合性」の具体版。
人手証明と同じく、`1 + KW ξ` と `1 - KW ξ` の二つの鎖を準備し、
`KW (KW ξ)` と `ξ` に同じ非零因子を掛けた値を一致させてから零因子を消去する。
住処は Qbar であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.KwDualTransformDomain

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_kw_dual_transform_involution` の具体版。 -/
theorem kwDualTransform_involution {xi : Qbar} (hDomain : 1 + xi ≠ 0) :
    kwDualTransform (kwDualTransform xi) = xi := by
  -- 準備。本文と同じ二つの逆元の等式を置く。
  have hInverse : (1 + xi) * (1 + xi)⁻¹ = 1 := mul_inv_cancel₀ hDomain
  have hKwDomain : 1 + kwDualTransform xi ≠ 0 := kwDualTransform_domain hDomain
  have hKwInverse :
      (1 + kwDualTransform xi) * (1 + kwDualTransform xi)⁻¹ = 1 :=
    mul_inv_cancel₀ hKwDomain
  have hOnePlus :
      1 + kwDualTransform xi = 2 * (1 + xi)⁻¹ := by
    calc
      1 + kwDualTransform xi
          = 1 + (1 - xi) * (1 + xi)⁻¹ := rfl
      _ = (1 + xi) * (1 + xi)⁻¹ + (1 - xi) * (1 + xi)⁻¹ := by
        rw [hInverse]
      _ = ((1 + xi) + (1 - xi)) * (1 + xi)⁻¹ := by
        rw [← add_mul]
      _ = ((1 + xi) + (1 + (-xi))) * (1 + xi)⁻¹ := by
        rw [sub_eq_add_neg]
      _ = (1 + (xi + (1 + (-xi)))) * (1 + xi)⁻¹ := by
        rw [add_assoc 1 xi (1 + (-xi))]
      _ = (1 + ((xi + 1) + (-xi))) * (1 + xi)⁻¹ := by
        rw [← add_assoc xi 1 (-xi)]
      _ = (1 + ((1 + xi) + (-xi))) * (1 + xi)⁻¹ := by
        rw [add_comm xi 1]
      _ = (1 + (1 + (xi + (-xi)))) * (1 + xi)⁻¹ := by
        rw [add_assoc 1 xi (-xi)]
      _ = (1 + (1 + 0)) * (1 + xi)⁻¹ := by
        rw [add_neg_cancel]
      _ = (1 + 1) * (1 + xi)⁻¹ := by rw [add_zero]
      _ = 2 * (1 + xi)⁻¹ := by rw [one_add_one_eq_two]
  have hOneMinus :
      1 - kwDualTransform xi = 2 * xi * (1 + xi)⁻¹ := by
    calc
      1 - kwDualTransform xi
          = 1 - (1 - xi) * (1 + xi)⁻¹ := rfl
      _ = (1 + xi) * (1 + xi)⁻¹ - (1 - xi) * (1 + xi)⁻¹ := by
        rw [hInverse]
      _ = ((1 + xi) - (1 - xi)) * (1 + xi)⁻¹ := by
        rw [← sub_mul]
      _ = ((1 + xi) + (-(1 - xi))) * (1 + xi)⁻¹ := by
        rw [sub_eq_add_neg (1 + xi) (1 - xi)]
      _ = ((1 + xi) + (xi - 1)) * (1 + xi)⁻¹ := by rw [neg_sub]
      _ = ((1 + xi) + (xi + (-1))) * (1 + xi)⁻¹ := by
        rw [sub_eq_add_neg xi 1]
      _ = (((1 + xi) + xi) + (-1)) * (1 + xi)⁻¹ := by
        rw [← add_assoc (1 + xi) xi (-1)]
      _ = ((1 + (xi + xi)) + (-1)) * (1 + xi)⁻¹ := by
        rw [add_assoc 1 xi xi]
      _ = (((xi + xi) + 1) + (-1)) * (1 + xi)⁻¹ := by
        rw [add_comm 1 (xi + xi)]
      _ = ((xi + xi) + (1 + (-1))) * (1 + xi)⁻¹ := by
        rw [add_assoc (xi + xi) 1 (-1)]
      _ = ((xi + xi) + 0) * (1 + xi)⁻¹ := by rw [add_neg_cancel]
      _ = (xi + xi) * (1 + xi)⁻¹ := by rw [add_zero]
      _ = (1 * xi + xi) * (1 + xi)⁻¹ :=
        congrArg (fun t : Qbar => (t + xi) * (1 + xi)⁻¹) (one_mul xi).symm
      _ = (1 * xi + 1 * xi) * (1 + xi)⁻¹ :=
        congrArg (fun t : Qbar => (1 * xi + t) * (1 + xi)⁻¹) (one_mul xi).symm
      _ = ((1 + 1) * xi) * (1 + xi)⁻¹ := by rw [← add_mul]
      _ = 2 * xi * (1 + xi)⁻¹ := by rw [one_add_one_eq_two]
  have hDoubleProduct :
      kwDualTransform (kwDualTransform xi) * (1 + kwDualTransform xi) =
        1 - kwDualTransform xi := by
    calc
      kwDualTransform (kwDualTransform xi) * (1 + kwDualTransform xi)
          = (((1 - kwDualTransform xi) * (1 + kwDualTransform xi)⁻¹) *
              (1 + kwDualTransform xi)) := rfl
      _ = (1 - kwDualTransform xi) *
            ((1 + kwDualTransform xi)⁻¹ * (1 + kwDualTransform xi)) := by
        rw [mul_assoc]
      _ = (1 - kwDualTransform xi) *
            ((1 + kwDualTransform xi) * (1 + kwDualTransform xi)⁻¹) := by
        rw [mul_comm (1 + kwDualTransform xi)⁻¹]
      _ = (1 - kwDualTransform xi) * 1 := by rw [hKwInverse]
      _ = 1 - kwDualTransform xi := by rw [mul_one]
  have hXiProduct :
      xi * (1 + kwDualTransform xi) = 1 - kwDualTransform xi := by
    calc
      xi * (1 + kwDualTransform xi)
          = xi * (2 * (1 + xi)⁻¹) := by rw [hOnePlus]
      _ = (xi * 2) * (1 + xi)⁻¹ := by rw [← mul_assoc]
      _ = (2 * xi) * (1 + xi)⁻¹ := by rw [mul_comm xi 2]
      _ = 1 - kwDualTransform xi := hOneMinus.symm
  have hDifference :
      (1 + kwDualTransform xi) * (kwDualTransform (kwDualTransform xi) - xi) = 0 := by
    calc
      (1 + kwDualTransform xi) * (kwDualTransform (kwDualTransform xi) - xi)
          = (1 + kwDualTransform xi) * kwDualTransform (kwDualTransform xi) -
              (1 + kwDualTransform xi) * xi := by rw [mul_sub]
      _ = kwDualTransform (kwDualTransform xi) * (1 + kwDualTransform xi) -
              (1 + kwDualTransform xi) * xi := by
        rw [mul_comm (1 + kwDualTransform xi) (kwDualTransform (kwDualTransform xi))]
      _ = kwDualTransform (kwDualTransform xi) * (1 + kwDualTransform xi) -
              xi * (1 + kwDualTransform xi) := by
        rw [mul_comm (1 + kwDualTransform xi) xi]
      _ = (1 - kwDualTransform xi) - xi * (1 + kwDualTransform xi) := by
        rw [hDoubleProduct]
      _ = (1 - kwDualTransform xi) - (1 - kwDualTransform xi) := by rw [hXiProduct]
      _ = 0 := sub_self _
  have hDifferenceZero : kwDualTransform (kwDualTransform xi) - xi = 0 :=
    AlgebraicEigenvalue.qbarNoZeroDivisors hKwDomain hDifference
  calc
    kwDualTransform (kwDualTransform xi)
        = (kwDualTransform (kwDualTransform xi) - xi) + xi :=
      (sub_add_cancel _ _).symm
    _ = 0 + xi := by rw [hDifferenceZero]
    _ = xi := zero_add _

end Ising2DLambda.FisherZero
