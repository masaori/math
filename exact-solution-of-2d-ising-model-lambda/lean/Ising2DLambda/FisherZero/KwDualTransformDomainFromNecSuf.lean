/-
具体版が必要十分版の特殊化であることの導出。
人手証明の各行の計算、零因子の消去、逆元による矛盾をそのまま必要十分版へ渡す。
-/
import Ising2DLambda.FisherZero.KwDualTransformDomain
import Ising2DLambda.NecSuf.FisherZero.KwDualTransformDomain

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_kw_dual_transform_domain` の具体版を必要十分版から導く。 -/
theorem kwDualTransform_domain_from_necSuf {xi : Qbar} (hDomain : 1 + xi ≠ 0) :
    1 + kwDualTransform xi ≠ 0 := by
  have hInverse : (1 + xi) * (1 + xi)⁻¹ = 1 := mul_inv_cancel₀ hDomain
  have hTwo : (2 : Qbar) ≠ 0 := by norm_num
  apply Ising2DLambda.NecSuf.FisherZero.kw_dual_transform_domain_necSuf
      (afterDefinition := 1 + (1 - xi) * (1 + xi)⁻¹)
      (afterIdentity := (1 + xi) * (1 + xi)⁻¹ + (1 - xi) * (1 + xi)⁻¹)
      (final := 2 * (1 + xi)⁻¹)
      (inverse := (1 + xi)⁻¹)
      (one := (1 : Qbar))
  · rfl
  · rw [hInverse]
  · calc
      (1 + xi) * (1 + xi)⁻¹ + (1 - xi) * (1 + xi)⁻¹
          = ((1 + xi) + (1 - xi)) * (1 + xi)⁻¹ := by rw [← add_mul]
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
  · intro hZero
    exact AlgebraicEigenvalue.qbarNoZeroDivisors hTwo hZero
  · intro hInverseZero
    calc
      (1 : Qbar) = (1 + xi) * (1 + xi)⁻¹ := hInverse.symm
      _ = (1 + xi) * 0 := by rw [hInverseZero]
      _ = 0 := mul_zero _
  · exact one_ne_zero

end Ising2DLambda.FisherZero
