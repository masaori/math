/-
具体版が必要十分版の特殊化であることの導出。
人手証明の準備・二方向の各段・零因子の消去をそのまま必要十分版へ渡す。
-/
import Ising2DLambda.FisherZero.KwSelfDualQuadraticEquivalence
import Ising2DLambda.NecSuf.FisherZero.KwSelfDualQuadraticEquivalence

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_kw_self_dual_quadratic_equivalence` の具体版を必要十分版から導く。 -/
theorem kwSelfDual_quadratic_equivalence_from_necSuf {xi : Qbar} (hDomain : 1 + xi ≠ 0) :
    kwDualTransform xi = xi ↔ xi ^ 2 + 2 * xi - 1 = 0 := by
  have hInverse : (1 + xi) * (1 + xi)⁻¹ = 1 := mul_inv_cancel₀ hDomain
  apply Ising2DLambda.NecSuf.FisherZero.kw_self_dual_quadratic_equivalence_necSuf
      (start := kwDualTransform xi)
      (target := xi)
      (quadratic := xi ^ 2 + 2 * xi - 1)
      (product := kwDualTransform xi * (1 + xi))
      (productAfterDefinition := ((1 - xi) * (1 + xi)⁻¹) * (1 + xi))
      (productAfterAssociation := (1 - xi) * ((1 + xi)⁻¹ * (1 + xi)))
      (productAfterCommutation := (1 - xi) * ((1 + xi) * (1 + xi)⁻¹))
      (productAfterInverse := (1 - xi) * 1)
      (productCommon := 1 - xi)
      (forwardProduct := xi * (1 + xi))
      (forwardAfterSelf := kwDualTransform xi * (1 + xi))
      (forwardQuadratic := xi ^ 2 + 2 * xi - 1)
      (forwardAfterProduct := (xi * (1 + xi) - xi) + 2 * xi - 1)
      (forwardAfterCollect := ((1 - xi) - xi) + 2 * xi - 1)
      (differenceProduct := (1 + xi) * (kwDualTransform xi - xi))
      (differenceAfterDistribution :=
        (1 + xi) * kwDualTransform xi - (1 + xi) * xi)
      (differenceAfterCommutation :=
        kwDualTransform xi * (1 + xi) - xi * (1 + xi))
      (differenceAfterProduct := (1 - xi) - xi * (1 + xi))
      (differenceAfterExpansion := (1 - xi) - (xi + xi ^ 2))
      (differenceAfterNegation := -(xi ^ 2 + 2 * xi - 1))
      (differenceAfterAssumption := -0)
      (difference := kwDualTransform xi - xi)
  · rfl
  · rw [mul_assoc]
  · rw [mul_comm (1 + xi)⁻¹]
  · rw [hInverse]
  · rw [mul_one]
  · intro hSelf
    exact congrArg (fun z => z * (1 + xi)) hSelf.symm
  · intro hProduct
    exact hProduct
  · ring
  · intro hForward
    rw [hForward]
  · ring
  · intro hForward
    exact hForward
  · rw [mul_sub]
  · ring
  · intro hProduct
    rw [hProduct]
  · ring
  · ring
  · intro hQuadratic
    rw [hQuadratic]
  · exact neg_zero
  · intro hZero
    exact AlgebraicEigenvalue.qbarNoZeroDivisors hDomain hZero
  · intro hZero
    exact sub_eq_zero.mp hZero

end Ising2DLambda.FisherZero
