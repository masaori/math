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
  have hDouble : xi + xi = 2 * xi := by
    calc
      xi + xi = 1 * xi + 1 * xi := by rw [one_mul]
      _ = (1 + 1) * xi := by rw [add_mul]
      _ = 2 * xi := by norm_num
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
      (forwardAfterCancellation := ((xi + xi ^ 2) - xi) + 2 * xi - 1)
      (forwardAfterProduct := (xi * (1 + xi) - xi) + 2 * xi - 1)
      (forwardAfterCollect := ((1 - xi) - xi) + 2 * xi - 1)
      (differenceProduct := (1 + xi) * (kwDualTransform xi - xi))
      (differenceAfterDistribution :=
        (1 + xi) * kwDualTransform xi - (1 + xi) * xi)
      (differenceAfterCommutation :=
        kwDualTransform xi * (1 + xi) - xi * (1 + xi))
      (differenceAfterProduct := (1 - xi) - xi * (1 + xi))
      (differenceAfterExpansion := (1 - xi) - (xi + xi ^ 2))
      (differenceAfterSubtraction := 1 - xi - xi - xi ^ 2)
      (differenceAfterDoubling := 1 - 2 * xi - xi ^ 2)
      (differenceAfterCommuting := -xi ^ 2 + (1 - 2 * xi))
      (differenceAfterAssociating := -xi ^ 2 - 2 * xi + 1)
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
  · calc
      xi ^ 2 + 2 * xi - 1 = ((xi ^ 2 + xi) - xi) + 2 * xi - 1 := by
        rw [add_sub_cancel_right]
      _ = ((xi + xi ^ 2) - xi) + 2 * xi - 1 := by rw [add_comm (xi ^ 2) xi]
  · calc
      ((xi + xi ^ 2) - xi) + 2 * xi - 1
          = ((xi + xi * xi) - xi) + 2 * xi - 1 := by rw [pow_two]
      _ = ((xi * 1 + xi * xi) - xi) + 2 * xi - 1 := by rw [mul_one]
      _ = (xi * (1 + xi) - xi) + 2 * xi - 1 := by rw [mul_add]
  · intro hForward
    rw [hForward]
  · calc
      ((1 - xi) - xi) + 2 * xi - 1 = (1 - (xi + xi)) + 2 * xi - 1 := by
        rw [sub_sub]
      _ = (1 - 2 * xi) + 2 * xi - 1 := by rw [hDouble]
      _ = 1 - 1 := by rw [sub_add_cancel]
      _ = 0 := sub_self 1
  · intro hForward
    exact hForward
  · rw [mul_sub]
  · rw [mul_comm (1 + xi) (kwDualTransform xi), mul_comm (1 + xi) xi]
  · intro hProduct
    rw [hProduct]
  · calc
      (1 - xi) - xi * (1 + xi) = (1 - xi) - (xi * 1 + xi * xi) := by rw [mul_add]
      _ = (1 - xi) - (xi + xi * xi) := by rw [mul_one]
      _ = (1 - xi) - (xi + xi ^ 2) := by rw [pow_two]
  · exact sub_add_eq_sub_sub _ _ _
  · calc
      1 - xi - xi - xi ^ 2 = (1 - (xi + xi)) - xi ^ 2 := by rw [sub_sub 1 xi xi]
      _ = 1 - 2 * xi - xi ^ 2 := by rw [hDouble]
  · calc
      1 - 2 * xi - xi ^ 2 = (1 - 2 * xi) + (-xi ^ 2) := sub_eq_add_neg _ _
      _ = -xi ^ 2 + (1 - 2 * xi) := add_comm _ _
  · calc
      -xi ^ 2 + (1 - 2 * xi) = (-xi ^ 2 + 1) - 2 * xi := (add_sub_assoc _ _ _).symm
      _ = (1 + (-xi ^ 2)) - 2 * xi := by rw [add_comm (-xi ^ 2) 1]
      _ = 1 + (-xi ^ 2 - 2 * xi) := add_sub_assoc _ _ _
      _ = -xi ^ 2 - 2 * xi + 1 := add_comm _ _
  · calc
      -xi ^ 2 - 2 * xi + 1 = (-xi ^ 2 + (-(2 * xi))) + 1 := by rw [sub_eq_add_neg]
      _ = -(xi ^ 2 + 2 * xi) + 1 := by rw [neg_add]
      _ = -(xi ^ 2 + 2 * xi) + (-(-1)) := by rw [neg_neg]
      _ = -((xi ^ 2 + 2 * xi) + (-1)) := (neg_add _ _).symm
      _ = -(xi ^ 2 + 2 * xi - 1) := by rw [sub_eq_add_neg]
  · intro hQuadratic
    rw [hQuadratic]
  · exact neg_zero
  · intro hZero
    exact AlgebraicEigenvalue.qbarNoZeroDivisors hDomain hZero
  · intro hZero
    calc
      kwDualTransform xi = (kwDualTransform xi - xi) + xi := by rw [sub_add_cancel]
      _ = 0 + xi := by rw [hZero]
      _ = xi := zero_add xi

end Ising2DLambda.FisherZero
