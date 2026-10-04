/-
対角変換の逆行列の必要十分版。
有限和の AddCommMonoid と、結合・単位元の Monoid を独立に持つ。
零の左右吸収は零項を消すために明示して要求する。分配則と乗法可換性は使わない。
整数冪の代わりに、零を一へ、和を積へ送る写像を用いる。
格子、方向番号の範囲、ねじれの二値性、四乗根という条件は論法に不要である。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Algebra.Group.Int.Defs

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

def powerPairDiagonal {α R : Type*} [DecidableEq α] [Zero R] [Mul R]
    (φ : ℤ → R) (p q : α → ℤ) : Matrix α α R :=
  fun e f => if f = e then φ (p e) * φ (q e) else 0

def powerPairDiagonalInverse {α R : Type*} [DecidableEq α] [Zero R] [Mul R]
    (φ : ℤ → R) (p q : α → ℤ) : Matrix α α R :=
  fun e f => if f = e then φ (-q e) * φ (-p e) else 0

/-- 具体版の整数冪の準備と同じ九等号。 -/
lemma powerPair_cancel_necSuf {R : Type*} [Monoid R]
    (φ : ℤ → R) (hzero : φ 0 = 1) (hadd : ∀ a b, φ (a + b) = φ a * φ b)
    (p q : ℤ) : (φ p * φ q) * (φ (-q) * φ (-p)) = 1 := by
  calc
    (φ p * φ q) * (φ (-q) * φ (-p)) = φ p * (φ q * (φ (-q) * φ (-p))) :=
      mul_assoc _ _ _
    _ = φ p * ((φ q * φ (-q)) * φ (-p)) := by rw [← mul_assoc (φ q) (φ (-q)) (φ (-p))]
    _ = φ p * (φ (q + -q) * φ (-p)) :=
      congrArg (fun t => φ p * (t * φ (-p))) (hadd q (-q)).symm
    _ = φ p * (φ 0 * φ (-p)) := by rw [add_neg_cancel]
    _ = φ p * (1 * φ (-p)) := by rw [hzero]
    _ = φ p * φ (-p) := by rw [one_mul]
    _ = φ (p + -p) := (hadd p (-p)).symm
    _ = φ 0 := by rw [add_neg_cancel]
    _ = 1 := hzero

/-- 具体版と同じ対角成分の計算と、零項を除いた有限和の成分計算。 -/
theorem powerPairDiagonal_mul_inverse_necSuf {α R : Type*}
    [Fintype α] [DecidableEq α] [AddCommMonoid R] [Monoid R]
    (φ : ℤ → R) (hzero : φ 0 = 1) (hadd : ∀ a b, φ (a + b) = φ a * φ b)
    (p q : α → ℤ) (hzero_mul : ∀ r : R, 0 * r = 0)
    (hmul_zero : ∀ r : R, r * 0 = 0) :
    powerPairDiagonal φ p q * powerPairDiagonalInverse φ p q = 1 ∧
      powerPairDiagonalInverse φ p q * powerPairDiagonal φ p q = 1 := by
  let u : α → R := fun e => φ (p e) * φ (q e)
  let v : α → R := fun e => φ (-q e) * φ (-p e)
  have huv (e : α) : u e * v e = 1 := by
    calc
      u e * v e = (φ (p e) * φ (q e)) * v e := rfl
      _ = (φ (p e) * φ (q e)) * (φ (-q e) * φ (-p e)) := rfl
      _ = 1 := powerPair_cancel_necSuf φ hzero hadd _ _
  have hvu (e : α) : v e * u e = 1 := by
    calc
      v e * u e = (φ (-q e) * φ (-p e)) * u e := rfl
      _ = (φ (-q e) * φ (-p e)) * (φ (p e) * φ (q e)) := rfl
      _ = (φ (-q e) * φ (-p e)) * (φ (-(-p e)) * φ (q e)) := by rw [neg_neg]
      _ = (φ (-q e) * φ (-p e)) * (φ (-(-p e)) * φ (-(-q e))) := by rw [neg_neg (q e)]
      _ = 1 := powerPair_cancel_necSuf φ hzero hadd _ _
  have hmatrix (M N : Matrix α α R) (m n : α → R)
      (hM : ∀ e f, M e f = if f = e then m e else 0)
      (hN : ∀ e f, N e f = if f = e then n e else 0)
      (hmn : ∀ e, m e * n e = 1) : M * N = 1 := by
    apply Matrix.ext
    intro e f
    have hzero (g : α) (hg : g ≠ e) : M e g * N g f = 0 := by
      calc
        M e g * N g f = 0 * N g f := by rw [hM e g, if_neg hg]
        _ = 0 := hzero_mul _
    have hentry : (M * N) e f = m e * N e f := by
      calc
        (M * N) e f = ∑ g, M e g * N g f := rfl
        _ = M e e * N e f := Fintype.sum_eq_single e hzero
        _ = m e * N e f := by rw [hM e e, if_pos rfl]
    rw [hentry]
    by_cases hfe : f = e
    · subst f
      calc
        m e * N e e = m e * n e := by rw [hN e e, if_pos rfl]
        _ = 1 := hmn e
        _ = (1 : Matrix α α R) e e := by rw [Matrix.one_apply_eq]
    · calc
        m e * N e f = m e * 0 := by rw [hN e f, if_neg hfe]
        _ = 0 := hmul_zero _
        _ = (1 : Matrix α α R) e f := by rw [Matrix.one_apply_ne (Ne.symm hfe)]
  constructor
  · exact hmatrix _ _ u v (fun _ _ => rfl) (fun _ _ => rfl) huv
  · exact hmatrix _ _ v u (fun _ _ => rfl) (fun _ _ => rfl) hvu

end Ising2DLambda.NecSuf.KacWard
