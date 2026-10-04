/-
「自己双対方程式の因数分解と根の全体」の具体版。
本文の準備三十二等号、二根の代入、零因子の場合分けと各根の導出を対応させる。
-/
import Ising2DLambda.FisherZero.SqrtTwoExists
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_self_dual_quadratic_roots` の具体版。 -/
theorem selfDualQuadratic_roots {s xi : Qbar} (hs : s * s = 2) :
    xi ^ 2 + 2 * xi - 1 = 0 ↔ xi = -1 + s ∨ xi = -1 - s := by
  have hFactor : ((xi + 1) - s) * ((xi + 1) + s) = xi ^ 2 + 2 * xi - 1 := by
    calc
      ((xi + 1) - s) * ((xi + 1) + s)
          = ((xi + 1) - s) * (xi + 1) + ((xi + 1) - s) * s := mul_add _ _ _
      _ = ((xi + 1) * (xi + 1) - s * (xi + 1)) + ((xi + 1) - s) * s := by
        rw [sub_mul]
      _ = ((xi + 1) * (xi + 1) - s * (xi + 1)) + ((xi + 1) * s - s * s) := by
        rw [sub_mul]
      _ = ((xi + 1) * (xi + 1) - s * (xi + 1)) + (s * (xi + 1) - s * s) := by
        rw [mul_comm (xi + 1) s]
      _ = ((xi + 1) * (xi + 1) + -(s * (xi + 1))) + (s * (xi + 1) - s * s) := by
        rw [sub_eq_add_neg ((xi + 1) * (xi + 1))]
      _ = ((xi + 1) * (xi + 1) + -(s * (xi + 1))) + (s * (xi + 1) + -(s * s)) := by
        rw [sub_eq_add_neg (s * (xi + 1))]
      _ = (xi + 1) * (xi + 1) + (-(s * (xi + 1)) + (s * (xi + 1) + -(s * s))) :=
        add_assoc _ _ _
      _ = (xi + 1) * (xi + 1) + ((-(s * (xi + 1)) + s * (xi + 1)) + -(s * s)) := by
        rw [← add_assoc (-(s * (xi + 1))) (s * (xi + 1))]
      _ = (xi + 1) * (xi + 1) + (0 + -(s * s)) := by rw [neg_add_cancel]
      _ = (xi + 1) * (xi + 1) + -(s * s) := by rw [zero_add]
      _ = (xi + 1) * (xi + 1) - s * s := (sub_eq_add_neg _ _).symm
      _ = (xi + 1) * (xi + 1) - 2 := by rw [hs]
      _ = ((xi + 1) * xi + (xi + 1) * 1) - 2 := by rw [mul_add]
      _ = ((xi * xi + 1 * xi) + (xi + 1) * 1) - 2 := by rw [add_mul]
      _ = ((xi * xi + 1 * xi) + (xi + 1)) - 2 := by rw [mul_one]
      _ = ((xi ^ 2 + 1 * xi) + (xi + 1)) - 2 := by rw [pow_two]
      _ = ((xi ^ 2 + xi) + (xi + 1)) - 2 := by rw [one_mul]
      _ = (xi ^ 2 + (xi + (xi + 1))) - 2 := by rw [add_assoc (xi ^ 2)]
      _ = (xi ^ 2 + ((xi + xi) + 1)) - 2 := by rw [← add_assoc xi xi]
      _ = ((xi ^ 2 + (xi + xi)) + 1) - 2 := by rw [← add_assoc (xi ^ 2)]
      _ = ((xi ^ 2 + (1 * xi + xi)) + 1) - 2 :=
        congrArg (fun u : Qbar => ((xi ^ 2 + (u + xi)) + 1) - 2) (one_mul xi).symm
      _ = ((xi ^ 2 + (1 * xi + 1 * xi)) + 1) - 2 :=
        congrArg (fun u : Qbar => ((xi ^ 2 + (1 * xi + u)) + 1) - 2) (one_mul xi).symm
      _ = ((xi ^ 2 + (1 + 1) * xi) + 1) - 2 := by rw [add_mul]
      _ = ((xi ^ 2 + 2 * xi) + 1) - 2 := by rw [one_add_one_eq_two]
      _ = ((xi ^ 2 + 2 * xi) + 1) + -2 := sub_eq_add_neg _ _
      _ = (xi ^ 2 + 2 * xi) + (1 + -2) := add_assoc _ _ _
      _ = (xi ^ 2 + 2 * xi) + (1 + -(1 + 1)) := by rw [one_add_one_eq_two]
      _ = (xi ^ 2 + 2 * xi) + (1 + (-1 + -1)) := by rw [neg_add]
      _ = (xi ^ 2 + 2 * xi) + ((1 + -1) + -1) := by rw [← add_assoc 1 (-1 : Qbar)]
      _ = (xi ^ 2 + 2 * xi) + (0 + -1) := by rw [add_neg_cancel]
      _ = (xi ^ 2 + 2 * xi) + -1 := by rw [zero_add]
      _ = xi ^ 2 + 2 * xi - 1 := (sub_eq_add_neg _ _).symm
  have hFirstRoot (hFirst : (xi + 1) - s = 0) : xi = -1 + s := by
    calc
      xi = xi + 0 := (add_zero xi).symm
      _ = xi + (1 + -1) := by rw [add_neg_cancel]
      _ = (xi + 1) + -1 := (add_assoc _ _ _).symm
      _ = ((xi + 1) + 0) + -1 := by rw [add_zero]
      _ = ((xi + 1) + (-s + s)) + -1 := by rw [neg_add_cancel]
      _ = (((xi + 1) + -s) + s) + -1 :=
        congrArg (fun u : Qbar => u + -1) (add_assoc (xi + 1) (-s) s).symm
      _ = (((xi + 1) - s) + s) + -1 := by rw [sub_eq_add_neg]
      _ = (0 + s) + -1 := by rw [hFirst]
      _ = s + -1 := by rw [zero_add]
      _ = -1 + s := add_comm _ _
  have hSecondRoot (hSecond : (xi + 1) + s = 0) : xi = -1 - s := by
    calc
      xi = xi + 0 := (add_zero xi).symm
      _ = xi + (1 + -1) := by rw [add_neg_cancel]
      _ = (xi + 1) + -1 := (add_assoc _ _ _).symm
      _ = ((xi + 1) + 0) + -1 := by rw [add_zero]
      _ = ((xi + 1) + (s + -s)) + -1 := by rw [add_neg_cancel]
      _ = (((xi + 1) + s) + -s) + -1 :=
        congrArg (fun u : Qbar => u + -1) (add_assoc (xi + 1) s (-s)).symm
      _ = (0 + -s) + -1 := by rw [hSecond]
      _ = -s + -1 := by rw [zero_add]
      _ = -1 + -s := add_comm _ _
      _ = -1 - s := (sub_eq_add_neg _ _).symm
  constructor
  · intro hQuadratic
    have hProduct : ((xi + 1) - s) * ((xi + 1) + s) = 0 := by
      calc
        ((xi + 1) - s) * ((xi + 1) + s) = xi ^ 2 + 2 * xi - 1 := hFactor
        _ = 0 := hQuadratic
    by_cases hFirst : (xi + 1) - s = 0
    · exact Or.inl (hFirstRoot hFirst)
    · have hSecond : (xi + 1) + s = 0 :=
        AlgebraicEigenvalue.qbarNoZeroDivisors hFirst hProduct
      exact Or.inr (hSecondRoot hSecond)
  · intro hRoot
    rcases hRoot with hPlus | hMinus
    · calc
        xi ^ 2 + 2 * xi - 1 = ((xi + 1) - s) * ((xi + 1) + s) := hFactor.symm
        _ = (((-1 + s) + 1) - s) * ((xi + 1) + s) :=
          congrArg (fun u : Qbar => ((u + 1) - s) * ((xi + 1) + s)) hPlus
        _ = (((s + -1) + 1) - s) * ((xi + 1) + s) := by rw [add_comm (-1 : Qbar) s]
        _ = ((s + (-1 + 1)) - s) * ((xi + 1) + s) := by rw [add_assoc s]
        _ = ((s + 0) - s) * ((xi + 1) + s) := by rw [neg_add_cancel]
        _ = (s - s) * ((xi + 1) + s) := by rw [add_zero]
        _ = 0 * ((xi + 1) + s) := by rw [sub_self]
        _ = 0 := zero_mul _
    · calc
        xi ^ 2 + 2 * xi - 1 = ((xi + 1) - s) * ((xi + 1) + s) := hFactor.symm
        _ = ((xi + 1) - s) * (((-1 - s) + 1) + s) :=
          congrArg (fun u : Qbar => ((xi + 1) - s) * ((u + 1) + s)) hMinus
        _ = ((xi + 1) - s) * (((-1 + -s) + 1) + s) := by rw [sub_eq_add_neg (-1 : Qbar)]
        _ = ((xi + 1) - s) * (((-s + -1) + 1) + s) := by rw [add_comm (-1 : Qbar) (-s)]
        _ = ((xi + 1) - s) * ((-s + (-1 + 1)) + s) := by rw [add_assoc (-s)]
        _ = ((xi + 1) - s) * ((-s + 0) + s) := by rw [neg_add_cancel (1 : Qbar)]
        _ = ((xi + 1) - s) * (-s + s) := by rw [add_zero]
        _ = ((xi + 1) - s) * 0 := by rw [neg_add_cancel]
        _ = 0 := mul_zero _

end Ising2DLambda.FisherZero
