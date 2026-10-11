/-
具体版が必要十分版の特殊化であることの導出。
Qbar の二つの逆元を与え、本文の計算と指定因子の消去は必要十分版で行う。
-/
import Ising2DLambda.FisherZero.KwDualTransformDomainFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.KwDualTransformInvolution

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_kw_dual_transform_involution` の具体版を必要十分版から導く。 -/
theorem kwDualTransform_involution_from_necSuf {xi : Qbar} (hDomain : 1 + xi ≠ 0) :
    kwDualTransform (kwDualTransform xi) = xi := by
  have hInverse : (1 + xi) * (1 + xi)⁻¹ = 1 := mul_inv_cancel₀ hDomain
  have hKwDomain : 1 + kwDualTransform xi ≠ 0 := kwDualTransform_domain_from_necSuf hDomain
  have hKwInverse :
      (1 + kwDualTransform xi) * (1 + kwDualTransform xi)⁻¹ = 1 :=
    mul_inv_cancel₀ hKwDomain
  exact Ising2DLambda.NecSuf.FisherZero.kw_dual_transform_involution_necSuf
    xi (1 + xi)⁻¹ (kwDualTransform xi) (1 + kwDualTransform xi)⁻¹
    (kwDualTransform (kwDualTransform xi)) rfl rfl hInverse hKwInverse

end Ising2DLambda.FisherZero
