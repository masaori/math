/-
「自己双対条件は二次方程式と同値」の必要十分版。

加法可換群・乗法可換モノイド・分配則のもとで、本文の六つの鎖、45等号を保つ。
`inverse` は指定元 `1 + xi` の逆元であり、全域の除法は要らない。
同じ逆元から指定因子の零の消去も導くため、零因子の不在は要求しない。
標数零・代数的閉性も不要で、`two` は `1 + 1` の略記である。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Algebra.Group.Basic

namespace Ising2DLambda.NecSuf.FisherZero

universe u

/-- `claim_kw_self_dual_quadratic_equivalence` の同じ計算を必要な演算と指定逆元だけで行う。 -/
theorem kw_self_dual_quadratic_equivalence_necSuf
    {A : Type u} [AddCommGroup A] [CommMonoid A]
    [LeftDistribClass A] [RightDistribClass A]
    (xi inverse dualValue : A)
    (hDefinition : dualValue = (1 - xi) * inverse)
    (hInverse : (1 + xi) * inverse = 1) :
    dualValue = xi ↔ xi ^ 2 + (1 + 1) * xi - 1 = 0 := by
  let two : A := 1 + 1
  change dualValue = xi ↔ xi ^ 2 + two * xi - 1 = 0
  -- 減法への分配と零との積は、加法への分配と加法群の消去から導く。
  have hMulSub (a b c : A) : a * (b - c) = a * b - a * c := by
    apply (eq_sub_iff_add_eq).2
    calc
      a * (b - c) + a * c = a * ((b - c) + c) := (mul_add _ _ _).symm
      _ = a * b := by rw [sub_add_cancel]
  have hMulZero (a : A) : a * 0 = 0 := by
    apply add_left_cancel (a := a * 0)
    calc
      a * 0 + a * 0 = a * (0 + 0) := (mul_add _ _ _).symm
      _ = a * 0 + 0 := by rw [add_zero, add_zero]
  have hCancel (b : A) (hZero : (1 + xi) * b = 0) : b = 0 := by
    calc
      b = 1 * b := (one_mul b).symm
      _ = ((1 + xi) * inverse) * b := by rw [hInverse]
      _ = (inverse * (1 + xi)) * b := by rw [mul_comm (1 + xi) inverse]
      _ = inverse * ((1 + xi) * b) := mul_assoc _ _ _
      _ = inverse * 0 := by rw [hZero]
      _ = 0 := hMulZero inverse
  have hProduct : dualValue * (1 + xi) = 1 - xi := by
    calc
      dualValue * (1 + xi)
          = ((1 - xi) * inverse) * (1 + xi) := by rw [hDefinition]
      _ = (1 - xi) * (inverse * (1 + xi)) := by rw [mul_assoc]
      _ = (1 - xi) * ((1 + xi) * inverse) := by
        rw [mul_comm inverse]
      _ = (1 - xi) * 1 := by rw [hInverse]
      _ = 1 - xi := by rw [mul_one]
  have hDouble : xi + xi = two * xi := by
    calc
      xi + xi = 1 * xi + 1 * xi := by rw [one_mul]
      _ = (1 + 1) * xi := by rw [add_mul]
      _ = two * xi := rfl
  constructor
  · intro hSelfDual
    have hXiProduct : xi * (1 + xi) = 1 - xi := by
      calc
        xi * (1 + xi) = dualValue * (1 + xi) := by rw [hSelfDual]
        _ = 1 - xi := hProduct
    calc
      xi ^ 2 + two * xi - 1 = ((xi ^ 2 + xi) - xi) + two * xi - 1 := by
        rw [add_sub_cancel_right]
      _ = ((xi + xi ^ 2) - xi) + two * xi - 1 := by rw [add_comm (xi ^ 2) xi]
      _ = ((xi + xi * xi) - xi) + two * xi - 1 := by rw [pow_two]
      _ = ((xi * 1 + xi * xi) - xi) + two * xi - 1 := by rw [mul_one]
      _ = (xi * (1 + xi) - xi) + two * xi - 1 := by rw [mul_add]
      _ = ((1 - xi) - xi) + two * xi - 1 := by rw [hXiProduct]
      _ = (1 - (xi + xi)) + two * xi - 1 := by rw [sub_sub]
      _ = (1 - two * xi) + two * xi - 1 := by rw [hDouble]
      _ = 1 - 1 := by rw [sub_add_cancel]
      _ = 0 := sub_self 1
  · intro hQuadratic
    have hDifferenceProduct : (1 + xi) * (dualValue - xi) = 0 := by
      calc
        (1 + xi) * (dualValue - xi)
            = (1 + xi) * dualValue - (1 + xi) * xi := by rw [hMulSub]
        _ = dualValue * (1 + xi) - xi * (1 + xi) := by
          rw [mul_comm (1 + xi) (dualValue), mul_comm (1 + xi) xi]
        _ = (1 - xi) - xi * (1 + xi) := by rw [hProduct]
        _ = (1 - xi) - (xi * 1 + xi * xi) := by rw [mul_add]
        _ = (1 - xi) - (xi + xi * xi) := by rw [mul_one]
        _ = (1 - xi) - (xi + xi ^ 2) := by rw [pow_two]
        _ = 1 - xi - xi - xi ^ 2 := sub_add_eq_sub_sub _ _ _
        _ = (1 - (xi + xi)) - xi ^ 2 := by rw [sub_sub 1 xi xi]
        _ = 1 - two * xi - xi ^ 2 := by rw [hDouble]
        _ = (1 - two * xi) + (-xi ^ 2) := sub_eq_add_neg _ _
        _ = -xi ^ 2 + (1 - two * xi) := add_comm _ _
        _ = (-xi ^ 2 + 1) - two * xi := (add_sub_assoc _ _ _).symm
        _ = (1 + (-xi ^ 2)) - two * xi := by rw [add_comm (-xi ^ 2) 1]
        _ = 1 + (-xi ^ 2 - two * xi) := add_sub_assoc _ _ _
        _ = -xi ^ 2 - two * xi + 1 := add_comm _ _
        _ = (-xi ^ 2 + (-(two * xi))) + 1 := by rw [sub_eq_add_neg]
        _ = -(xi ^ 2 + two * xi) + 1 := by rw [neg_add]
        _ = -(xi ^ 2 + two * xi) + (-(-1)) := by rw [neg_neg]
        _ = -((xi ^ 2 + two * xi) + (-1)) := (neg_add _ _).symm
        _ = -(xi ^ 2 + two * xi - 1) := by rw [sub_eq_add_neg]
        _ = -0 := by rw [hQuadratic]
        _ = 0 := neg_zero
    have hDifferenceZero : dualValue - xi = 0 :=
      hCancel (dualValue - xi) hDifferenceProduct
    calc
      dualValue = (dualValue - xi) + xi := by rw [sub_add_cancel]
      _ = 0 + xi := by rw [hDifferenceZero]
      _ = xi := zero_add xi

end Ising2DLambda.NecSuf.FisherZero
