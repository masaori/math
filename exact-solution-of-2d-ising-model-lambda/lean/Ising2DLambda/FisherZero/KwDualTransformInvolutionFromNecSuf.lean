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
  · calc
      xi * (2 * (1 + xi)⁻¹) = (xi * 2) * (1 + xi)⁻¹ := by rw [← mul_assoc]
      _ = (2 * xi) * (1 + xi)⁻¹ := by rw [mul_comm xi 2]
  · exact hOneMinus.symm
  · rw [mul_sub]
  · calc
      (1 + kwDualTransform xi) * kwDualTransform (kwDualTransform xi) -
          (1 + kwDualTransform xi) * xi
          = kwDualTransform (kwDualTransform xi) * (1 + kwDualTransform xi) -
              (1 + kwDualTransform xi) * xi := by
        rw [mul_comm (1 + kwDualTransform xi) (kwDualTransform (kwDualTransform xi))]
      _ = kwDualTransform (kwDualTransform xi) * (1 + kwDualTransform xi) -
              xi * (1 + kwDualTransform xi) := by
        rw [mul_comm (1 + kwDualTransform xi) xi]
  · intro hDoubleProduct hXiProduct
    have hDoubleProduct' :
        kwDualTransform (kwDualTransform xi) * (1 + kwDualTransform xi) =
          1 - kwDualTransform xi := by
      change (((1 - kwDualTransform xi) * (1 + kwDualTransform xi)⁻¹) *
        (1 + kwDualTransform xi)) = 1 - kwDualTransform xi
      exact hDoubleProduct
    calc
      kwDualTransform (kwDualTransform xi) * (1 + kwDualTransform xi) -
          xi * (1 + kwDualTransform xi)
          = (1 - kwDualTransform xi) - xi * (1 + kwDualTransform xi) := by
        rw [hDoubleProduct']
      _ = (1 - kwDualTransform xi) - (1 - kwDualTransform xi) := by rw [hXiProduct]
  · exact sub_self _
  · intro hZero
    exact AlgebraicEigenvalue.qbarNoZeroDivisors hKwDomain hZero
  · intro hZero
    calc
      kwDualTransform (kwDualTransform xi)
          = (kwDualTransform (kwDualTransform xi) - xi) + xi :=
        (sub_add_cancel _ _).symm
      _ = 0 + xi := by rw [hZero]
      _ = xi := zero_add _

end Ising2DLambda.FisherZero
