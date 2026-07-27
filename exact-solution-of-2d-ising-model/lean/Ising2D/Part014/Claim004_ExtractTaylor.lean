/-
# 具体版: `check(Z), check(Y)` についてのテイラー係数の抽出

対応する人手証明のラベル: **`extract_taylor_coefficient_of_check_Z_Y`**
（`structured-latex/content/014_even_sector_T_action.ts` の
`evensectorT_004_claim_extract_taylor`）

**抽象版**は既存の `Ising2D/Abstract/ExpConjugation.lean` の
`Ising2D.Abstract.exp_conj_two_dim_z` / `exp_conj_two_dim_y`
（`ad x` が `span{z, y}` を保つときの閉じた形 `cosh(s) z + α sinhc(s) y`）。
本ファイルの 4 式はその特殊化（具体版 `Ising2D.matExp_conj_two_dim_z` / `..._y` 経由）である。

## 原文との対応

原文は `cosh_sinh_coefficient_conversion_for_check` の 4 式を偶数項・奇数項に分けて
`cosh`, `sinh` のテイラー展開と突き合わせている。抽象版ではこの突き合わせが
`Complex.hasSum_cosh` と `Ising2D.Abstract.hasSum_sinhc` に 1 対 1 で対応する
（`Abstract/ExpConjugation.lean` の `exp_conj_two_dim_z` の証明）。

`sinh(s)/s` は `s = 0` で 0 割りになるので、Lean では `Ising2D.Abstract.sinhc`
（`s = 0` では `1`）を経由し、最後に `s · sinhc(s) = sinh(s)`（`Abstract.mul_sinhc`）で
原文の `sinh(K_1)`, `sinh(2K_2^*)` の形へ戻す。**原文の係数と完全に一致し、誤りは無かった。**
-/
import Ising2D.Part014.Claim003_CoefficientConversion

namespace Ising2D

open Nat

variable {M : ℕ}

/-! ## (h1.z), (h1.y): `X_1' = (i/2)K_1H_1^{(+)}` -/

/-- **原文 (h1.z)**: `∑_n (1/n!) ad_{X_1'}^n(check(Z)_μ) = cosh(K_1) check(Z)_μ
+ i e^{-iθ~_μ} sinh(K_1) check(Y)_μ`。 -/
theorem extract_taylor_H1Plus_checkZ (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    ∑' n : ℕ, ((n ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1)) n (checkZ M μ)
      = Complex.cosh K1 • checkZ M μ
        + (Complex.I * checkPhase M 1 μ * Complex.sinh K1) • checkY M μ := by
  have hcoef : (Complex.I * K1 * checkPhase M 1 μ) * Abstract.sinhc K1
      = Complex.I * checkPhase M 1 μ * Complex.sinh K1 := by
    linear_combination (Complex.I * checkPhase M 1 μ) * Abstract.mul_sinhc K1
  rw [← matExp_conj_eq_tsum, matExp_conj_two_dim_z (ad_V1halfPlus_checkZ hM K1 μ)
    (ad_V1halfPlus_checkY hM K1 μ) (sK1_sq M K1 μ), hcoef]

/-- **原文 (h1.y)**: `∑_n (1/n!) ad_{X_1'}^n(check(Y)_μ) = -i e^{iθ~_μ} sinh(K_1) check(Z)_μ
+ cosh(K_1) check(Y)_μ`。 -/
theorem extract_taylor_H1Plus_checkY (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    ∑' n : ℕ, ((n ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1)) n (checkY M μ)
      = (-Complex.I * checkPhase M (-1) μ * Complex.sinh K1) • checkZ M μ
        + Complex.cosh K1 • checkY M μ := by
  have hcoef : (-Complex.I * K1 * checkPhase M (-1) μ) * Abstract.sinhc K1
      = -Complex.I * checkPhase M (-1) μ * Complex.sinh K1 := by
    linear_combination (-Complex.I * checkPhase M (-1) μ) * Abstract.mul_sinhc K1
  rw [← matExp_conj_eq_tsum, matExp_conj_two_dim_y (ad_V1halfPlus_checkZ hM K1 μ)
    (ad_V1halfPlus_checkY hM K1 μ) (sK1_sq M K1 μ), hcoef, add_comm]

/-! ## (h2.z), (h2.y): `X_2' = i K_2^* H_2` -/

/-- **原文 (h2.z)**: `∑_n (1/n!) ad_{X_2'}^n(check(Z)_μ)
= cosh(2K_2^*) check(Z)_μ - i sinh(2K_2^*) check(Y)_μ`。 -/
theorem extract_taylor_H2_checkZ (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow ((Complex.I * K2star) • H2 M) n (checkZ M μ)
      = Complex.cosh (2 * K2star) • checkZ M μ
        + (-Complex.I * Complex.sinh (2 * K2star)) • checkY M μ := by
  have hcoef : (-(2 * Complex.I * K2star)) * Abstract.sinhc (2 * K2star)
      = -Complex.I * Complex.sinh (2 * K2star) := by
    linear_combination (-Complex.I) * Abstract.mul_sinhc (2 * K2star)
  rw [← matExp_conj_eq_tsum, matExp_conj_two_dim_z (ad_V2_checkZ hM K2star μ)
    (ad_V2_checkY hM K2star μ) (sK2_sq K2star), hcoef]

/-- **原文 (h2.y)**: `∑_n (1/n!) ad_{X_2'}^n(check(Y)_μ)
= i sinh(2K_2^*) check(Z)_μ + cosh(2K_2^*) check(Y)_μ`。 -/
theorem extract_taylor_H2_checkY (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow ((Complex.I * K2star) • H2 M) n (checkY M μ)
      = (Complex.I * Complex.sinh (2 * K2star)) • checkZ M μ
        + Complex.cosh (2 * K2star) • checkY M μ := by
  have hcoef : (2 * Complex.I * K2star) * Abstract.sinhc (2 * K2star)
      = Complex.I * Complex.sinh (2 * K2star) := by
    linear_combination Complex.I * Abstract.mul_sinhc (2 * K2star)
  rw [← matExp_conj_eq_tsum, matExp_conj_two_dim_y (ad_V2_checkZ hM K2star μ)
    (ad_V2_checkY hM K2star μ) (sK2_sq K2star), hcoef, add_comm]

end Ising2D
