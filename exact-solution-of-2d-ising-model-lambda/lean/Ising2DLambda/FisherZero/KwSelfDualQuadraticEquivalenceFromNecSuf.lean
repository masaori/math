/-
具体版が必要十分版の特殊化であることの導出。
Qbar の指定分母の逆元を与え、二方向の計算と指定因子の消去は必要十分版で行う。
-/
import Ising2DLambda.FisherZero.KwDualTransformDomain
import Ising2DLambda.NecSuf.FisherZero.KwSelfDualQuadraticEquivalence

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_kw_self_dual_quadratic_equivalence` の具体版を必要十分版から導く。 -/
theorem kwSelfDual_quadratic_equivalence_from_necSuf {xi : Qbar} (hDomain : 1 + xi ≠ 0) :
    kwDualTransform xi = xi ↔ xi ^ 2 + 2 * xi - 1 = 0 := by
  have hInverse : (1 + xi) * (1 + xi)⁻¹ = 1 := mul_inv_cancel₀ hDomain
  simpa only [one_add_one_eq_two] using
    Ising2DLambda.NecSuf.FisherZero.kw_self_dual_quadratic_equivalence_necSuf
      xi (1 + xi)⁻¹ (kwDualTransform xi) rfl hInverse

end Ising2DLambda.FisherZero
