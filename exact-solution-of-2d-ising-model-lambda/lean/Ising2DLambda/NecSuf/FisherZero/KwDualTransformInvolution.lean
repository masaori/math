/-
「双対変換の対合性」の必要十分版。

加法可換群・乗法可換モノイド・分配則のもとで、本文の六つの鎖、45等号を保つ。
`inverse` と `dualInverse` は二つの指定元の逆元であり、全域の除法は要らない。
指定因子 `1 + dualValue` の零の消去は `dualInverse` から導く。
零因子の不在・標数零・代数的閉性は要求しない。
`two` は `1 + 1` の略記で、自然数の埋め込みも不要である。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Algebra.Group.Basic

namespace Ising2DLambda.NecSuf.FisherZero

universe u

/-- `claim_kw_dual_transform_involution` の同じ計算を必要な演算と指定逆元だけで行う。 -/
theorem kw_dual_transform_involution_necSuf
    {A : Type u} [AddCommGroup A] [CommMonoid A]
    [LeftDistribClass A] [RightDistribClass A]
    (xi inverse dualValue dualInverse doubleValue : A)
    (hDefinition : dualValue = (1 - xi) * inverse)
    (hDoubleDefinition : doubleValue = (1 - dualValue) * dualInverse)
    (hInverse : (1 + xi) * inverse = 1)
    (hKwInverse : (1 + dualValue) * dualInverse = 1) :
    doubleValue = xi := by
  let two : A := 1 + 1
  -- 減法への分配は、加法への分配と加法群の消去から従う。
  have hSubMul (a b c : A) : (a - b) * c = a * c - b * c := by
    apply (eq_sub_iff_add_eq).2
    calc
      (a - b) * c + b * c = ((a - b) + b) * c := (add_mul _ _ _).symm
      _ = a * c := by rw [sub_add_cancel]
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
  have hCancel (b : A) (hZero : (1 + dualValue) * b = 0) : b = 0 := by
    calc
      b = 1 * b := (one_mul b).symm
      _ = ((1 + dualValue) * dualInverse) * b := by rw [hKwInverse]
      _ = (dualInverse * (1 + dualValue)) * b := by
        rw [mul_comm (1 + dualValue) dualInverse]
      _ = dualInverse * ((1 + dualValue) * b) := mul_assoc _ _ _
      _ = dualInverse * 0 := by rw [hZero]
      _ = 0 := hMulZero dualInverse
  have hOnePlus :
      1 + dualValue = two * inverse := by
    calc
      1 + dualValue
          = 1 + (1 - xi) * inverse := by rw [hDefinition]
      _ = (1 + xi) * inverse + (1 - xi) * inverse := by
        rw [hInverse]
      _ = ((1 + xi) + (1 - xi)) * inverse := by
        rw [← add_mul]
      _ = ((1 + xi) + (1 + (-xi))) * inverse := by
        rw [sub_eq_add_neg]
      _ = (1 + (xi + (1 + (-xi)))) * inverse := by
        rw [add_assoc 1 xi (1 + (-xi))]
      _ = (1 + ((xi + 1) + (-xi))) * inverse := by
        rw [← add_assoc xi 1 (-xi)]
      _ = (1 + ((1 + xi) + (-xi))) * inverse := by
        rw [add_comm xi 1]
      _ = (1 + (1 + (xi + (-xi)))) * inverse := by
        rw [add_assoc 1 xi (-xi)]
      _ = (1 + (1 + 0)) * inverse := by
        rw [add_neg_cancel]
      _ = (1 + 1) * inverse := by rw [add_zero]
      _ = two * inverse := rfl
  have hOneMinus :
      1 - dualValue = two * xi * inverse := by
    calc
      1 - dualValue
          = 1 - (1 - xi) * inverse := by rw [hDefinition]
      _ = (1 + xi) * inverse - (1 - xi) * inverse := by
        rw [hInverse]
      _ = ((1 + xi) - (1 - xi)) * inverse := by
        rw [← hSubMul]
      _ = ((1 + xi) + (-(1 - xi))) * inverse := by
        rw [sub_eq_add_neg (1 + xi) (1 - xi)]
      _ = ((1 + xi) + (xi - 1)) * inverse := by rw [neg_sub]
      _ = ((1 + xi) + (xi + (-1))) * inverse := by
        rw [sub_eq_add_neg xi 1]
      _ = (((1 + xi) + xi) + (-1)) * inverse := by
        rw [← add_assoc (1 + xi) xi (-1)]
      _ = ((1 + (xi + xi)) + (-1)) * inverse := by
        rw [add_assoc 1 xi xi]
      _ = (((xi + xi) + 1) + (-1)) * inverse := by
        rw [add_comm 1 (xi + xi)]
      _ = ((xi + xi) + (1 + (-1))) * inverse := by
        rw [add_assoc (xi + xi) 1 (-1)]
      _ = ((xi + xi) + 0) * inverse := by rw [add_neg_cancel]
      _ = (xi + xi) * inverse := by rw [add_zero]
      _ = (1 * xi + xi) * inverse :=
        congrArg (fun t : A => (t + xi) * inverse) (one_mul xi).symm
      _ = (1 * xi + 1 * xi) * inverse :=
        congrArg (fun t : A => (1 * xi + t) * inverse) (one_mul xi).symm
      _ = ((1 + 1) * xi) * inverse := by rw [← add_mul]
      _ = two * xi * inverse := rfl
  have hDoubleProduct :
      doubleValue * (1 + dualValue) =
        1 - dualValue := by
    calc
      doubleValue * (1 + dualValue)
          = (((1 - dualValue) * dualInverse) *
              (1 + dualValue)) := by rw [hDoubleDefinition]
      _ = (1 - dualValue) *
            (dualInverse * (1 + dualValue)) := by
        rw [mul_assoc]
      _ = (1 - dualValue) *
            ((1 + dualValue) * dualInverse) := by
        rw [mul_comm dualInverse]
      _ = (1 - dualValue) * 1 := by rw [hKwInverse]
      _ = 1 - dualValue := by rw [mul_one]
  have hXiProduct :
      xi * (1 + dualValue) = 1 - dualValue := by
    calc
      xi * (1 + dualValue)
          = xi * (two * inverse) := by rw [hOnePlus]
      _ = (xi * two) * inverse := by rw [← mul_assoc]
      _ = (two * xi) * inverse := by rw [mul_comm xi two]
      _ = 1 - dualValue := hOneMinus.symm
  have hDifference :
      (1 + dualValue) * (doubleValue - xi) = 0 := by
    calc
      (1 + dualValue) * (doubleValue - xi)
          = (1 + dualValue) * doubleValue -
              (1 + dualValue) * xi := by rw [hMulSub]
      _ = doubleValue * (1 + dualValue) -
              (1 + dualValue) * xi := by
        rw [mul_comm (1 + dualValue) (doubleValue)]
      _ = doubleValue * (1 + dualValue) -
              xi * (1 + dualValue) := by
        rw [mul_comm (1 + dualValue) xi]
      _ = (1 - dualValue) - xi * (1 + dualValue) := by
        rw [hDoubleProduct]
      _ = (1 - dualValue) - (1 - dualValue) := by rw [hXiProduct]
      _ = 0 := sub_self _
  have hDifferenceZero : doubleValue - xi = 0 :=
    hCancel (doubleValue - xi) hDifference
  calc
    doubleValue
        = (doubleValue - xi) + xi :=
      (sub_add_cancel _ _).symm
    _ = 0 + xi := by rw [hDifferenceZero]
    _ = xi := zero_add _

end Ising2DLambda.NecSuf.FisherZero
