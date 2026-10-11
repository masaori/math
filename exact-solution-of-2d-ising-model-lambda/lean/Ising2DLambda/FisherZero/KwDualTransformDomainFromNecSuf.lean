/-
具体版が必要十分版の特殊化であることの導出。
双対変換の定義・一つの逆元・因子 2 の消去を必要十分版へ渡す。
十一等号と背理法の三等号は必要十分版自身が証明する。
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
      (xi := xi)
      (inverse := (1 + xi)⁻¹)
      (dualValue := kwDualTransform xi)
  · rfl
  · exact hInverse
  · intro b hZero
    rw [one_add_one_eq_two] at hZero
    exact AlgebraicEigenvalue.qbarNoZeroDivisors hTwo hZero
  · exact mul_zero
  · exact one_ne_zero

end Ising2DLambda.FisherZero
