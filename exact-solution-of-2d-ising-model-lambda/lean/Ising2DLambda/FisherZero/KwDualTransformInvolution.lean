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
      _ = 2 * (1 + xi)⁻¹ := by ring
  have hOneMinus :
      1 - kwDualTransform xi = 2 * xi * (1 + xi)⁻¹ := by
    calc
      1 - kwDualTransform xi
          = 1 - (1 - xi) * (1 + xi)⁻¹ := rfl
      _ = (1 + xi) * (1 + xi)⁻¹ - (1 - xi) * (1 + xi)⁻¹ := by
        rw [hInverse]
      _ = ((1 + xi) - (1 - xi)) * (1 + xi)⁻¹ := by
        ring
      _ = 2 * xi * (1 + xi)⁻¹ := by ring
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
      _ = 2 * xi * (1 + xi)⁻¹ := by ring
      _ = 1 - kwDualTransform xi := hOneMinus.symm
  have hDifference :
      (1 + kwDualTransform xi) * (kwDualTransform (kwDualTransform xi) - xi) = 0 := by
    calc
      (1 + kwDualTransform xi) * (kwDualTransform (kwDualTransform xi) - xi)
          = (1 + kwDualTransform xi) * kwDualTransform (kwDualTransform xi) -
              (1 + kwDualTransform xi) * xi := by rw [mul_sub]
      _ = kwDualTransform (kwDualTransform xi) * (1 + kwDualTransform xi) -
              xi * (1 + kwDualTransform xi) := by ring
      _ = (1 - kwDualTransform xi) - (1 - kwDualTransform xi) := by
        rw [hDoubleProduct, hXiProduct]
      _ = 0 := sub_self _
  have hDifferenceZero : kwDualTransform (kwDualTransform xi) - xi = 0 :=
    AlgebraicEigenvalue.qbarNoZeroDivisors hKwDomain hDifference
  exact sub_eq_zero.mp hDifferenceZero

end Ising2DLambda.FisherZero
