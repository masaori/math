/-
「モードの逆元操作は分散因子を保つ」の必要十分版。

具体版と同じ手順（`t = z^L = 0^L = 0` の矛盾で `z ≠ 0`、`(z⁻¹)^L = (z^L)⁻¹ = t⁻¹ = t`、
分散因子の四行ずつ）を、次の仮定だけで行う。

- `z ≠ 0` の段: 零元を持つモノイド、`L ≥ 1`、符号 `t ≠ 0`。`L = 0` を許すと `z^0 = 1 = t` で `z = 0` も条件を満たす。
- 逆元の冪の段: 除法モノイド（`(z^L)⁻¹ = (z⁻¹)^L` と `t·t = 1 ⇒ t⁻¹ = t` だけを使う）。
  符号が `±1` であることは使わず、`t·t = 1` だけを使う。
- 分散因子の段: 定義が体の上の多項式なので体。使う逆元の性質は `z·z⁻¹ = 1` だけで、
  これから `z⁻¹` の逆元が `z` であることを出す（`z ≠ 0` の段の結論はここで要る）。

住処: 一般の代数系。実数体・複素数体は現れない。
-/
import Ising2DLambda.NecSuf.KacWard.DispersionPolynomial

namespace Ising2DLambda.NecSuf.KacWard

open Polynomial

theorem twistedMode_ne_zero_necSuf {M : Type*} [MonoidWithZero M] {L : ℕ} (hL : 1 ≤ L)
    (t z : M) (ht0 : t ≠ 0) (hz : z ^ L = t) : z ≠ 0 := by
  intro h0
  apply ht0
  calc t = z ^ L := hz.symm
    _ = 0 ^ L := by rw [h0]
    _ = 0 := zero_pow (by omega)

theorem twistedMode_inv_pow_necSuf {M : Type*} [DivisionMonoid M] (L : ℕ) (t z : M)
    (ht : t * t = 1) (hz : z ^ L = t) : z⁻¹ ^ L = t := by
  calc z⁻¹ ^ L = (z ^ L)⁻¹ := inv_pow z L
    _ = t⁻¹ := by rw [hz]
    _ = t := inv_eq_of_mul_eq_one_left ht

theorem dispersion_horizontal_inversion_necSuf {R : Type*} [Field R] (varpi varsigma : R)
    (hinv : varpi * varpi⁻¹ = 1) :
    dispersionPolynomial varpi⁻¹ varsigma = dispersionPolynomial varpi varsigma := by
  calc dispersionPolynomial varpi⁻¹ varsigma
      = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi⁻¹ + C varpi⁻¹⁻¹ + C varsigma + C varsigma⁻¹) := rfl
    _ = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi⁻¹ + C varpi + C varsigma + C varsigma⁻¹) := by
        rw [inv_eq_of_mul_eq_one_left hinv]
    _ = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹) := by
        rw [add_comm (C varpi⁻¹) (C varpi)]
    _ = dispersionPolynomial varpi varsigma := rfl

theorem dispersion_vertical_inversion_necSuf {R : Type*} [Field R] (varpi varsigma : R)
    (hinv : varsigma * varsigma⁻¹ = 1) :
    dispersionPolynomial varpi varsigma⁻¹ = dispersionPolynomial varpi varsigma := by
  calc dispersionPolynomial varpi varsigma⁻¹
      = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi + C varpi⁻¹ + C varsigma⁻¹ + C varsigma⁻¹⁻¹) := rfl
    _ = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi + C varpi⁻¹ + C varsigma⁻¹ + C varsigma) := by
        rw [inv_eq_of_mul_eq_one_left hinv]
    _ = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹) := by
        rw [add_assoc _ (C varsigma⁻¹) (C varsigma), add_comm (C varsigma⁻¹) (C varsigma),
          ← add_assoc]
    _ = dispersionPolynomial varpi varsigma := rfl

/-- 体 `R`、`L ≥ 1`、`t·t = 1` かつ `t ≠ 0` の符号 `t, t'` について、具体版と同じ結論。 -/
theorem dispersion_inversion_invariant_necSuf {R : Type*} [Field R] {L : ℕ} (hL : 1 ≤ L)
    (t t' : R) (ht0 : t ≠ 0) (ht : t * t = 1) (ht'0 : t' ≠ 0) (ht' : t' * t' = 1)
    (varpi varsigma : R) (hvarpi : varpi ^ L = t) (hvarsigma : varsigma ^ L = t') :
    varpi⁻¹ ^ L = t ∧ varsigma⁻¹ ^ L = t' ∧
      dispersionPolynomial varpi⁻¹ varsigma = dispersionPolynomial varpi varsigma ∧
      dispersionPolynomial varpi varsigma⁻¹ = dispersionPolynomial varpi varsigma := by
  have hvarpi0 : varpi ≠ 0 := twistedMode_ne_zero_necSuf hL t varpi ht0 hvarpi
  have hvarsigma0 : varsigma ≠ 0 := twistedMode_ne_zero_necSuf hL t' varsigma ht'0 hvarsigma
  exact ⟨twistedMode_inv_pow_necSuf L t varpi ht hvarpi,
    twistedMode_inv_pow_necSuf L t' varsigma ht' hvarsigma,
    dispersion_horizontal_inversion_necSuf varpi varsigma (mul_inv_cancel₀ hvarpi0),
    dispersion_vertical_inversion_necSuf varpi varsigma (mul_inv_cancel₀ hvarsigma0)⟩

end Ising2DLambda.NecSuf.KacWard
