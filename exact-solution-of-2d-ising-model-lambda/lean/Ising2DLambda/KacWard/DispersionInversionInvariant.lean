/-
「モードの逆元操作は分散因子を保つ」（`claim_dispersion_inversion_invariant`）の具体版。

本文と同じ順に次を示す。必要十分版を呼ばない。
- `ϖ ≠ 0`: `ϖ = 0` なら `(−1)^a = ϖ^L = 0^L = 0`（`L ≥ 1`）となり、`(−1)^a ≠ 0` に反する。縦も同じ。
- 逆元の冪: `(ϖ⁻¹)^L = (ϖ^L)⁻¹ = ((−1)^a)⁻¹ = (−1)^a`（`(−1)^a·(−1)^a = 1`）。縦も同じ。
- 分散因子: `Δ(x;ϖ⁻¹,ς)` の四行（定義、`ϖ·ϖ⁻¹ = 1` より `ϖ⁻¹` の逆元は `ϖ`、加法の交換律、定義）。縦も同じ。

本文の `(−1)^a` は `if s.1 then -1 else 1` で、横が `s.1`、縦が `s.2` である。
住処は Qbar と Qbar[x]。実数体・複素数体は使わない。
-/
import Ising2DLambda.KacWard.TwistedModeSets
import Ising2DLambda.KacWard.DispersionPolynomial

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

/-- 符号 `(−1)^a`（`a ∈ {0,1}`）は零でない。 -/
theorem twistSign_ne_zero (t : Bool) : (if t then (-1 : Qbar) else 1) ≠ 0 := by
  cases t <;> simp

/-- 符号 `(−1)^a` は自分自身との積が一である。 -/
theorem twistSign_mul_self (t : Bool) :
    (if t then (-1 : Qbar) else 1) * (if t then (-1 : Qbar) else 1) = 1 := by
  cases t <;> simp

/-- 本文の `ϖ ≠ 0` の三行: `(−1)^a = ϖ^L = 0^L = 0` の矛盾。 -/
theorem twistedMode_ne_zero {L : ℕ} (hL : 1 ≤ L) (t : Bool) (z : Qbar)
    (hz : z ^ L = if t then -1 else 1) : z ≠ 0 := by
  intro h0
  apply twistSign_ne_zero t
  calc (if t then (-1 : Qbar) else 1) = z ^ L := hz.symm
    _ = 0 ^ L := by rw [h0]
    _ = 0 := zero_pow (by omega)

/-- 本文の逆元の冪の三行: `(z⁻¹)^L = (z^L)⁻¹ = ((−1)^a)⁻¹ = (−1)^a`。 -/
theorem twistedMode_inv_pow {L : ℕ} (t : Bool) (z : Qbar)
    (hz : z ^ L = if t then -1 else 1) : z⁻¹ ^ L = if t then -1 else 1 := by
  calc z⁻¹ ^ L = (z ^ L)⁻¹ := inv_pow z L
    _ = (if t then (-1 : Qbar) else 1)⁻¹ := by rw [hz]
    _ = if t then (-1 : Qbar) else 1 := inv_eq_of_mul_eq_one_left (twistSign_mul_self t)

/-- `z·z⁻¹ = 1` より `z⁻¹` の逆元は `z`（`z ≠ 0`）。 -/
theorem mode_inv_inv {z : Qbar} (hz : z ≠ 0) : z⁻¹⁻¹ = z :=
  inv_eq_of_mul_eq_one_left (mul_inv_cancel₀ hz)

/-- 本文の横の逆元操作の四行。 -/
theorem dispersion_horizontal_inversion (varpi varsigma : Qbar) (hne : varpi ≠ 0) :
    dispersionPolynomial varpi⁻¹ varsigma = dispersionPolynomial varpi varsigma := by
  calc dispersionPolynomial varpi⁻¹ varsigma
      = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi⁻¹ + C varpi⁻¹⁻¹ + C varsigma + C varsigma⁻¹) := rfl
    _ = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi⁻¹ + C varpi + C varsigma + C varsigma⁻¹) := by rw [mode_inv_inv hne]
    _ = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹) := by
        rw [add_comm (C varpi⁻¹) (C varpi)]
    _ = dispersionPolynomial varpi varsigma := rfl

/-- 本文の縦の逆元操作の四行。 -/
theorem dispersion_vertical_inversion (varpi varsigma : Qbar) (hne : varsigma ≠ 0) :
    dispersionPolynomial varpi varsigma⁻¹ = dispersionPolynomial varpi varsigma := by
  calc dispersionPolynomial varpi varsigma⁻¹
      = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi + C varpi⁻¹ + C varsigma⁻¹ + C varsigma⁻¹⁻¹) := rfl
    _ = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi + C varpi⁻¹ + C varsigma⁻¹ + C varsigma) := by rw [mode_inv_inv hne]
    _ = (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹) := by
        rw [add_assoc _ (C varsigma⁻¹) (C varsigma), add_comm (C varsigma⁻¹) (C varsigma),
          ← add_assoc]
    _ = dispersionPolynomial varpi varsigma := rfl

/-- 主張: 逆元に替えた組も同じモード集合に属し、分散因子は横・縦の逆元操作で変わらない。 -/
theorem dispersion_inversion_invariant {L : ℕ} (hL : 1 ≤ L) (s : SpinStructure)
    {varpi varsigma : Qbar} (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s) :
    varpi⁻¹ ∈ horizontalTwistedModes L s ∧ varsigma⁻¹ ∈ verticalTwistedModes L s ∧
      dispersionPolynomial varpi⁻¹ varsigma = dispersionPolynomial varpi varsigma ∧
      dispersionPolynomial varpi varsigma⁻¹ = dispersionPolynomial varpi varsigma := by
  have hvarpi0 : varpi ≠ 0 := twistedMode_ne_zero hL s.1 varpi hvarpi
  have hvarsigma0 : varsigma ≠ 0 := twistedMode_ne_zero hL s.2 varsigma hvarsigma
  exact ⟨twistedMode_inv_pow s.1 varpi hvarpi, twistedMode_inv_pow s.2 varsigma hvarsigma,
    dispersion_horizontal_inversion varpi varsigma hvarpi0,
    dispersion_vertical_inversion varpi varsigma hvarsigma0⟩

end Ising2DLambda.KacWard
