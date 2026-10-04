/-
反転置換行列の二乗の必要十分版。
有限和には AddCommMonoid、成分の積には Mul、非零項には One を使う。
乗法から必要なのは零と一の左乗法だけであり、分配則・結合則・
右乗法の法則は要求しない。添字の写像には対合性だけを使い、
固定点がないことや正方格子の形は使わない。
-/
import Mathlib.Data.Matrix.Mul

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

def involutionMatrix {α R : Type*} [DecidableEq α] [Zero R] [One R]
    (reverse : α → α) : Matrix α α R :=
  fun e f => if f = reverse e then 1 else 0

theorem involutionMatrix_mul_self_necSuf
    {α R : Type*} [Fintype α] [DecidableEq α] [AddCommMonoid R] [Mul R] [One R]
    (reverse : α → α) (hinvolutive : Function.Involutive reverse)
    (hzero_mul : ∀ r : R, 0 * r = 0) (hone_mul : ∀ r : R, 1 * r = r) :
    involutionMatrix (R := R) reverse * involutionMatrix reverse = 1 := by
  apply Matrix.ext
  intro e f
  -- 具体版と同じ準備: reverse e 以外の項を零の左乗法で消す。
  have hzero (g : α) (hg : g ≠ reverse e) :
      involutionMatrix (R := R) reverse e g * involutionMatrix reverse g f = 0 := by
    calc
      involutionMatrix (R := R) reverse e g * involutionMatrix reverse g f =
          0 * involutionMatrix reverse g f := by
        rw [show involutionMatrix (R := R) reverse e g = 0 from if_neg hg]
      _ = 0 := hzero_mul _
  calc
    (involutionMatrix (R := R) reverse * involutionMatrix reverse : Matrix α α R) e f =
        ∑ g, involutionMatrix reverse e g * involutionMatrix reverse g f := rfl
    _ = involutionMatrix reverse e (reverse e) * involutionMatrix reverse (reverse e) f :=
      Fintype.sum_eq_single (reverse e) hzero
    _ = 1 * involutionMatrix reverse (reverse e) f := by
      rw [show involutionMatrix (R := R) reverse e (reverse e) = 1 from if_pos rfl]
    _ = involutionMatrix reverse (reverse e) f := hone_mul _
    _ = (if f = reverse (reverse e) then 1 else 0) := rfl
    _ = (if f = e then 1 else 0) := by rw [hinvolutive e]
    _ = (if e = f then 1 else 0) := by simp only [@eq_comm _ f e]
    _ = (1 : Matrix α α R) e f := rfl

end Ising2DLambda.NecSuf.KacWard
