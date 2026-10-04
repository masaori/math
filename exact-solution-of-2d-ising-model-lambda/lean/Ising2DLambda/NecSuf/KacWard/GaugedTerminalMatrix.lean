/-
対角相似の成分計算の必要十分版。同じ二つの有限和と二十七等号を保つ。
源は零と積だけ、先は加法可換モノイドと乗法半群だけを持つ。
左右吸収は加法の零に対して明示するので、二つの零構造の同一視は仮定しない。
単位元、分配則、源の乗法結合則、逆元、体、格子、先の乗法の全体的可換性は使わない。
交換するのは指定成分 A e f と右の対角重みの像だけである。
-/
import Mathlib.Data.Matrix.Mul

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

/-- 対角行列を写してから左右から掛け、指定成分だけを有限和で評価する。 -/
theorem gaugedMatrix_entry_necSuf {ι S R : Type*}
    [Fintype ι] [DecidableEq ι] [Zero S] [Mul S]
    [AddCommMonoid R] [Semigroup R]
    (C : S → R) (hCzero : C 0 = 0) (hCmul : ∀ a b, C (a * b) = C a * C b)
    (hzero_mul : ∀ a : R, 0 * a = 0) (hmul_zero : ∀ a : R, a * 0 = 0)
    (U V : Matrix ι ι S) (u v : ι → S)
    (hU : ∀ i j, U i j = if j = i then u i else 0)
    (hV : ∀ i j, V i j = if j = i then v i else 0)
    (A : Matrix ι ι R) (c : S) (e f : ι)
    (hcomm : A e f * C (u f) = C (u f) * A e f)
    (entry : R) (hA : A e f = entry) :
    C c * ((V.map C * A) * U.map C) e f = C (c * (v e * u f)) * entry := by
  let B := V.map C * A
  let K : Matrix ι ι R := fun i j => C c * (B * U.map C) i j
  let w := c * (v e * u f)
  have hleftZero (g : ι) (hg : g ≠ e) : V.map C e g * A g f = 0 := by
    calc
      V.map C e g * A g f = C (V e g) * A g f := rfl
      _ = C 0 * A g f := by rw [hV e g, if_neg hg]
      _ = 0 * A g f := by rw [hCzero]
      _ = 0 := hzero_mul _
  have hleft : B e f = C (v e) * A e f := by
    calc
      B e f = ∑ g, V.map C e g * A g f := rfl
      _ = V.map C e e * A e f := Fintype.sum_eq_single e hleftZero
      _ = C (V e e) * A e f := rfl
      _ = C (v e) * A e f := by rw [hV e e, if_pos rfl]
  have hrightZero (g : ι) (hg : g ≠ f) : B e g * U.map C g f = 0 := by
    calc
      B e g * U.map C g f = B e g * C (U g f) := rfl
      _ = B e g * C 0 := by rw [hU g f, if_neg (Ne.symm hg)]
      _ = B e g * 0 := by rw [hCzero]
      _ = 0 := hmul_zero _
  have hright : (B * U.map C) e f = B e f * C (u f) := by
    calc
      (B * U.map C) e f = ∑ g, B e g * U.map C g f := rfl
      _ = B e f * U.map C f f := Fintype.sum_eq_single f hrightZero
      _ = B e f * C (U f f) := rfl
      _ = B e f * C (u f) := by rw [hU f f, if_pos rfl]
  change K e f = C w * entry
  calc
    K e f = C c * (B * U.map C) e f := rfl
    _ = C c * (B e f * C (u f)) := by rw [hright]
    _ = C c * ((C (v e) * A e f) * C (u f)) := by rw [hleft]
    _ = C c * (C (v e) * (A e f * C (u f))) :=
      congrArg (C c * ·) (mul_assoc _ _ _)
    _ = C c * (C (v e) * (C (u f) * A e f)) :=
      congrArg (fun t => C c * (C (v e) * t)) hcomm
    _ = C c * ((C (v e) * C (u f)) * A e f) :=
      congrArg (C c * ·) (mul_assoc _ _ _).symm
    _ = (C c * (C (v e) * C (u f))) * A e f := (mul_assoc _ _ _).symm
    _ = (C c * C (v e * u f)) * A e f :=
      congrArg (fun t => (C c * t) * A e f) (hCmul _ _).symm
    _ = C (c * (v e * u f)) * A e f := congrArg (· * A e f) (hCmul _ _).symm
    _ = C w * A e f := rfl
    _ = C w * entry := congrArg (C w * ·) hA

end Ising2DLambda.NecSuf.KacWard
