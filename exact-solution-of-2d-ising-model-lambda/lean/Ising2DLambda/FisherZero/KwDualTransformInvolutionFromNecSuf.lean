/-
具体版が必要十分版の特殊化であることの導出。
人手証明の二本の積の鎖・差の鎖・零因子の消去を、そのまま必要十分版へ渡す。
-/
import Ising2DLambda.FisherZero.KwDualTransformInvolution
import Ising2DLambda.NecSuf.FisherZero.KwDualTransformInvolution

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_kw_dual_transform_involution` の具体版を必要十分版から導く。 -/
theorem kwDualTransform_involution_from_necSuf {xi : Qbar} (hDomain : 1 + xi ≠ 0) :
    kwDualTransform (kwDualTransform xi) = xi := by
  have hInverse : (1 + xi) * (1 + xi)⁻¹ = 1 := mul_inv_cancel₀ hDomain
  have hKwDomain : 1 + kwDualTransform xi ≠ 0 := kwDualTransform_domain hDomain
  have hKwInverse :
      (1 + kwDualTransform xi) * (1 + kwDualTransform xi)⁻¹ = 1 :=
    mul_inv_cancel₀ hKwDomain
  have hOnePlus : 1 + kwDualTransform xi = 2 * (1 + xi)⁻¹ := by
    calc
      1 + kwDualTransform xi = 1 + (1 - xi) * (1 + xi)⁻¹ := rfl
      _ = (1 + xi) * (1 + xi)⁻¹ + (1 - xi) * (1 + xi)⁻¹ := by rw [hInverse]
      _ = ((1 + xi) + (1 - xi)) * (1 + xi)⁻¹ := by rw [← add_mul]
      _ = 2 * (1 + xi)⁻¹ := by ring
  have hOneMinus : 1 - kwDualTransform xi = 2 * xi * (1 + xi)⁻¹ := by
    calc
      1 - kwDualTransform xi = 1 - (1 - xi) * (1 + xi)⁻¹ := rfl
      _ = (1 + xi) * (1 + xi)⁻¹ - (1 - xi) * (1 + xi)⁻¹ := by rw [hInverse]
      _ = ((1 + xi) - (1 - xi)) * (1 + xi)⁻¹ := by ring
      _ = 2 * xi * (1 + xi)⁻¹ := by ring
  apply Ising2DLambda.NecSuf.FisherZero.kw_dual_transform_involution_necSuf
      (start := kwDualTransform (kwDualTransform xi))
      (target := xi)
      (doubleAfterDefinition :=
        ((1 - kwDualTransform xi) * (1 + kwDualTransform xi)⁻¹) *
          (1 + kwDualTransform xi))
      (doubleAfterAssociation :=
        (1 - kwDualTransform xi) *
          ((1 + kwDualTransform xi)⁻¹ * (1 + kwDualTransform xi)))
      (doubleAfterCommutation :=
        (1 - kwDualTransform xi) *
          ((1 + kwDualTransform xi) * (1 + kwDualTransform xi)⁻¹))
      (doubleAfterInverse := (1 - kwDualTransform xi) * 1)
      (common := 1 - kwDualTransform xi)
      (xiProduct := xi * (1 + kwDualTransform xi))
      (xiAfterSubstitution := xi * (2 * (1 + xi)⁻¹))
      (xiAfterReassociation := 2 * xi * (1 + xi)⁻¹)
      (differenceProduct :=
        (1 + kwDualTransform xi) * (kwDualTransform (kwDualTransform xi) - xi))
      (differenceAfterDistribution :=
        (1 + kwDualTransform xi) * kwDualTransform (kwDualTransform xi) -
          (1 + kwDualTransform xi) * xi)
      (differenceAfterCommutation :=
        kwDualTransform (kwDualTransform xi) * (1 + kwDualTransform xi) -
          xi * (1 + kwDualTransform xi))
      (differenceAfterSubstitution :=
        (1 - kwDualTransform xi) - (1 - kwDualTransform xi))
      (difference := kwDualTransform (kwDualTransform xi) - xi)
  · rfl
  · rw [mul_assoc]
  · rw [mul_comm (1 + kwDualTransform xi)⁻¹]
  · rw [hKwInverse]
  · rw [mul_one]
  · rw [hOnePlus]
  · ring
  · exact hOneMinus.symm
  · rw [mul_sub]
  · ring
  · intro hDoubleProduct hXiProduct
    have hDoubleProduct' :
        kwDualTransform (kwDualTransform xi) * (1 + kwDualTransform xi) =
          1 - kwDualTransform xi := by
      change (((1 - kwDualTransform xi) * (1 + kwDualTransform xi)⁻¹) *
        (1 + kwDualTransform xi)) = 1 - kwDualTransform xi
      exact hDoubleProduct
    rw [hDoubleProduct', hXiProduct]
  · exact sub_self _
  · intro hZero
    exact AlgebraicEigenvalue.qbarNoZeroDivisors hKwDomain hZero
  · intro hZero
    exact sub_eq_zero.mp hZero

end Ising2DLambda.FisherZero
