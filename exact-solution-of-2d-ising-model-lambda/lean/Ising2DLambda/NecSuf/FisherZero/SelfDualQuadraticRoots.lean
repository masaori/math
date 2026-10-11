/-
「自己双対方程式の因数分解と根の全体」の必要十分版。

加法可換群、左右の乗法単位元、左右の分配則を使い、本文の七十一等号を保つ。
減法への分配と零との積は、加法への分配と加法群の消去から導く。
乗法の可換則は `(xi + 1)` と `s` の一組だけで使う。
零因子の不在は第一因子が非零の場合に第二因子を消去する箇所で必要である。
乗法の結合則、全域の逆数、標数零、代数的閉性は使わない。
二乗は積、二は `1 + 1` の略記にとどめる。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Algebra.Group.Basic

namespace Ising2DLambda.NecSuf.FisherZero

universe u

/-- 本文の因数分解、二根の代入、零積からの二根の導出を同じ演算列で示す。 -/
theorem self_dual_quadratic_roots_necSuf
    {A : Type u} [AddCommGroup A] [MulOneClass A]
    [LeftDistribClass A] [RightDistribClass A]
    {s xi : A} (hs : s * s = 1 + 1)
    (hCommute : (xi + 1) * s = s * (xi + 1))
    (hNoZeroDivisors : ∀ {a b : A}, a ≠ 0 → a * b = 0 → b = 0) :
    xi * xi + (1 + 1) * xi - 1 = 0 ↔ xi = -1 + s ∨ xi = -1 - s := by
  let two : A := 1 + 1
  let square : A := xi * xi
  change square + two * xi - 1 = 0 ↔ xi = -1 + s ∨ xi = -1 - s
  have hSubMul (a b c : A) : (a - b) * c = a * c - b * c := by
    apply (eq_sub_iff_add_eq).2
    calc
      (a - b) * c + b * c = ((a - b) + b) * c := (add_mul _ _ _).symm
      _ = a * c := by rw [sub_add_cancel]
  have hZeroMul (a : A) : 0 * a = 0 := by
    apply add_left_cancel (a := 0 * a)
    calc
      0 * a + 0 * a = (0 + 0) * a := (add_mul _ _ _).symm
      _ = 0 * a := by rw [add_zero]
      _ = 0 * a + 0 := (add_zero _).symm
  have hMulZero (a : A) : a * 0 = 0 := by
    apply add_left_cancel (a := a * 0)
    calc
      a * 0 + a * 0 = a * (0 + 0) := (mul_add _ _ _).symm
      _ = a * 0 := by rw [add_zero]
      _ = a * 0 + 0 := (add_zero _).symm
  -- 準備: 因数分解の三十二等号。
  have hFactor : ((xi + 1) - s) * ((xi + 1) + s) = square + two * xi - 1 := by
    calc
      ((xi + 1) - s) * ((xi + 1) + s)
          = ((xi + 1) - s) * (xi + 1) + ((xi + 1) - s) * s := mul_add _ _ _
      _ = ((xi + 1) * (xi + 1) - s * (xi + 1)) + ((xi + 1) - s) * s := by
        rw [hSubMul]
      _ = ((xi + 1) * (xi + 1) - s * (xi + 1)) + ((xi + 1) * s - s * s) := by
        rw [hSubMul]
      _ = ((xi + 1) * (xi + 1) - s * (xi + 1)) + (s * (xi + 1) - s * s) := by
        rw [hCommute]
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
      _ = (xi + 1) * (xi + 1) - two := by rw [hs]
      _ = ((xi + 1) * xi + (xi + 1) * 1) - two := by rw [mul_add]
      _ = ((xi * xi + 1 * xi) + (xi + 1) * 1) - two := by rw [add_mul]
      _ = ((xi * xi + 1 * xi) + (xi + 1)) - two := by rw [mul_one]
      _ = ((square + 1 * xi) + (xi + 1)) - two := rfl
      _ = ((square + xi) + (xi + 1)) - two := by rw [one_mul]
      _ = (square + (xi + (xi + 1))) - two := by rw [add_assoc (square)]
      _ = (square + ((xi + xi) + 1)) - two := by rw [← add_assoc xi xi]
      _ = ((square + (xi + xi)) + 1) - two := by rw [← add_assoc (square)]
      _ = ((square + (1 * xi + xi)) + 1) - two :=
        congrArg (fun u : A => ((square + (u + xi)) + 1) - two) (one_mul xi).symm
      _ = ((square + (1 * xi + 1 * xi)) + 1) - two :=
        congrArg (fun u : A => ((square + (1 * xi + u)) + 1) - two) (one_mul xi).symm
      _ = ((square + (1 + 1) * xi) + 1) - two := by rw [add_mul]
      _ = ((square + two * xi) + 1) - two := rfl
      _ = ((square + two * xi) + 1) + -two := sub_eq_add_neg _ _
      _ = (square + two * xi) + (1 + -two) := add_assoc _ _ _
      _ = (square + two * xi) + (1 + -(1 + 1)) := rfl
      _ = (square + two * xi) + (1 + (-1 + -1)) := by rw [neg_add]
      _ = (square + two * xi) + ((1 + -1) + -1) := by rw [← add_assoc 1 (-1 : A)]
      _ = (square + two * xi) + (0 + -1) := by rw [add_neg_cancel]
      _ = (square + two * xi) + -1 := by rw [zero_add]
      _ = square + two * xi - 1 := (sub_eq_add_neg _ _).symm
  -- 第二の方向の第一因子から根を取り出す十等号。
  have hFirstRoot (hFirst : (xi + 1) - s = 0) : xi = -1 + s := by
    calc
      xi = xi + 0 := (add_zero xi).symm
      _ = xi + (1 + -1) := by rw [add_neg_cancel]
      _ = (xi + 1) + -1 := (add_assoc _ _ _).symm
      _ = ((xi + 1) + 0) + -1 := by rw [add_zero]
      _ = ((xi + 1) + (-s + s)) + -1 := by rw [neg_add_cancel]
      _ = (((xi + 1) + -s) + s) + -1 :=
        congrArg (fun u : A => u + -1) (add_assoc (xi + 1) (-s) s).symm
      _ = (((xi + 1) - s) + s) + -1 := by rw [sub_eq_add_neg]
      _ = (0 + s) + -1 := by rw [hFirst]
      _ = s + -1 := by rw [zero_add]
      _ = -1 + s := add_comm _ _
  -- 第二の方向の第二因子から根を取り出す十等号。
  have hSecondRoot (hSecond : (xi + 1) + s = 0) : xi = -1 - s := by
    calc
      xi = xi + 0 := (add_zero xi).symm
      _ = xi + (1 + -1) := by rw [add_neg_cancel]
      _ = (xi + 1) + -1 := (add_assoc _ _ _).symm
      _ = ((xi + 1) + 0) + -1 := by rw [add_zero]
      _ = ((xi + 1) + (s + -s)) + -1 := by rw [add_neg_cancel]
      _ = (((xi + 1) + s) + -s) + -1 :=
        congrArg (fun u : A => u + -1) (add_assoc (xi + 1) s (-s)).symm
      _ = (0 + -s) + -1 := by rw [hSecond]
      _ = -s + -1 := by rw [zero_add]
      _ = -1 + -s := add_comm _ _
      _ = -1 - s := (sub_eq_add_neg _ _).symm
  constructor
  -- 第二の方向: 零積の二等号と第一因子が零か否かの場合分け。
  · intro hQuadratic
    have hProduct : ((xi + 1) - s) * ((xi + 1) + s) = 0 := by
      calc
        ((xi + 1) - s) * ((xi + 1) + s) = square + two * xi - 1 := hFactor
        _ = 0 := hQuadratic
    by_cases hFirst : (xi + 1) - s = 0
    · exact Or.inl (hFirstRoot hFirst)
    · have hSecond : (xi + 1) + s = 0 :=
        hNoZeroDivisors hFirst hProduct
      exact Or.inr (hSecondRoot hSecond)
  -- 第一の方向: 二根の代入（八等号・九等号）。
  · intro hRoot
    rcases hRoot with hPlus | hMinus
    · calc
        square + two * xi - 1 = ((xi + 1) - s) * ((xi + 1) + s) := hFactor.symm
        _ = (((-1 + s) + 1) - s) * ((xi + 1) + s) :=
          congrArg (fun u : A => ((u + 1) - s) * ((xi + 1) + s)) hPlus
        _ = (((s + -1) + 1) - s) * ((xi + 1) + s) := by rw [add_comm (-1 : A) s]
        _ = ((s + (-1 + 1)) - s) * ((xi + 1) + s) := by rw [add_assoc s]
        _ = ((s + 0) - s) * ((xi + 1) + s) := by rw [neg_add_cancel]
        _ = (s - s) * ((xi + 1) + s) := by rw [add_zero]
        _ = 0 * ((xi + 1) + s) := by rw [sub_self]
        _ = 0 := hZeroMul _
    · calc
        square + two * xi - 1 = ((xi + 1) - s) * ((xi + 1) + s) := hFactor.symm
        _ = ((xi + 1) - s) * (((-1 - s) + 1) + s) :=
          congrArg (fun u : A => ((xi + 1) - s) * ((u + 1) + s)) hMinus
        _ = ((xi + 1) - s) * (((-1 + -s) + 1) + s) := by rw [sub_eq_add_neg (-1 : A)]
        _ = ((xi + 1) - s) * (((-s + -1) + 1) + s) := by rw [add_comm (-1 : A) (-s)]
        _ = ((xi + 1) - s) * ((-s + (-1 + 1)) + s) := by rw [add_assoc (-s)]
        _ = ((xi + 1) - s) * ((-s + 0) + s) := by rw [neg_add_cancel (1 : A)]
        _ = ((xi + 1) - s) * (-s + s) := by rw [add_zero]
        _ = ((xi + 1) - s) * 0 := by rw [neg_add_cancel]
        _ = 0 := hMulZero _


end Ising2DLambda.NecSuf.FisherZero
