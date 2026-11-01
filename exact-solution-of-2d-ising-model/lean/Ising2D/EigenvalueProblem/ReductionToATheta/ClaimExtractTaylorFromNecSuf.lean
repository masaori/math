/-
# 必要十分版からの導出: `check(Z), check(Y)` についてのテイラー係数の抽出

対応する人手証明のラベル: **`extract_taylor_coefficient_of_check_Z_Y`**。
人手証明と 1 対 1 の具体版は `EigenvalueProblem/ReductionToATheta/ClaimExtractTaylor.lean` にある。

**必要十分版**は `Ising2D/NecSuf/ExpConjugation.lean` の `Ising2D.NecSuf.hasSum_two_dim_series`
（位相 ℂ 加群で、偶数項が `s^{2k} z`、奇数項が `s^{2k} α y` の級数の和が `cosh(s) z + α sinhc(s) y` であること）。
具体版の 4 式の `HasSum` 版は、その特殊化として次のとおり得られる。

- `f n` は `ad_{X'}^n(check(Z)_μ)` または `ad_{X'}^n(check(Y)_μ)`、偶数側・奇数側の仮定は
  `cosh_sinh_coefficient_conversion_for_check` の具体版 `conversion_*_even` / `conversion_*_odd` である。
- `(α, s)` は (h1.z) で `(i K_1 e^{-iθ~}, K_1)`、(h1.y) で `(-i K_1 e^{iθ~}, K_1)`、
  (h2.z) で `(-2i K_2^*, 2K_2^*)`、(h2.y) で `(2i K_2^*, 2K_2^*)` である。
- 必要十分版は `sinhc` を使い `α` を外へ出すので、`s · sinhc(s) = sinh(s)`（`NecSuf.mul_sinhc`）で
  人手の `sinh(K_1)`, `sinh(2K_2^*)` の係数へ戻す。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExtractTaylor

namespace Ising2D

open Nat

variable {M : ℕ}

/-- **人手 (h1.z)** を必要十分版の特殊化として得たもの。 -/
theorem hasSum_extract_taylor_H1Plus_checkZ_of_necSuf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    HasSum (fun n : ℕ => ((n ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) n (checkZ M μ))
      (Complex.cosh K1 • checkZ M μ
        + (Complex.I * checkPhase M 1 μ * Complex.sinh K1) • checkY M μ) := by
  have h := NecSuf.hasSum_two_dim_series
    (f := fun n => adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) n (checkZ M μ))
    (s := K1) (α := Complex.I * K1 * checkPhase M 1 μ)
    (conversion_H1Plus_checkZ_even hM K1 μ)
    (fun k => by rw [conversion_H1Plus_checkZ_odd hM K1 μ k]; congr 1; ring)
  have hcoef : (Complex.I * K1 * checkPhase M 1 μ) * NecSuf.sinhc K1
      = Complex.I * checkPhase M 1 μ * Complex.sinh K1 := by
    linear_combination (Complex.I * checkPhase M 1 μ) * NecSuf.mul_sinhc K1
  rwa [hcoef] at h

/-- **人手 (h1.y)** を必要十分版の特殊化として得たもの。 -/
theorem hasSum_extract_taylor_H1Plus_checkY_of_necSuf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    HasSum (fun n : ℕ => ((n ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) n (checkY M μ))
      ((-Complex.I * checkPhase M (-1) μ * Complex.sinh K1) • checkZ M μ
        + Complex.cosh K1 • checkY M μ) := by
  have h := NecSuf.hasSum_two_dim_series
    (f := fun n => adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) n (checkY M μ))
    (s := K1) (α := -Complex.I * K1 * checkPhase M (-1) μ)
    (conversion_H1Plus_checkY_even hM K1 μ)
    (fun k => by rw [conversion_H1Plus_checkY_odd hM K1 μ k]; congr 1; ring)
  have hcoef : (-Complex.I * K1 * checkPhase M (-1) μ) * NecSuf.sinhc K1
      = -Complex.I * checkPhase M (-1) μ * Complex.sinh K1 := by
    linear_combination (-Complex.I * checkPhase M (-1) μ) * NecSuf.mul_sinhc K1
  rwa [hcoef, add_comm] at h

/-- **人手 (h2.z)** を必要十分版の特殊化として得たもの。 -/
theorem hasSum_extract_taylor_H2_checkZ_of_necSuf (K2star : ℂ) (μ : ℤ) :
    HasSum (fun n : ℕ => ((n ! : ℂ))⁻¹ • adPow ((Complex.I * K2star) • H2 M) n (checkZ M μ))
      (Complex.cosh (2 * K2star) • checkZ M μ
        + (-Complex.I * Complex.sinh (2 * K2star)) • checkY M μ) := by
  have h := NecSuf.hasSum_two_dim_series
    (f := fun n => adPow ((Complex.I * K2star) • H2 M) n (checkZ M μ))
    (s := 2 * K2star) (α := -(2 * Complex.I * K2star))
    (conversion_H2_checkZ_even K2star μ)
    (fun k => by rw [conversion_H2_checkZ_odd K2star μ k]; congr 1; ring)
  have hcoef : (-(2 * Complex.I * K2star)) * NecSuf.sinhc (2 * K2star)
      = -Complex.I * Complex.sinh (2 * K2star) := by
    linear_combination (-Complex.I) * NecSuf.mul_sinhc (2 * K2star)
  rwa [hcoef] at h

/-- **人手 (h2.y)** を必要十分版の特殊化として得たもの。 -/
theorem hasSum_extract_taylor_H2_checkY_of_necSuf (K2star : ℂ) (μ : ℤ) :
    HasSum (fun n : ℕ => ((n ! : ℂ))⁻¹ • adPow ((Complex.I * K2star) • H2 M) n (checkY M μ))
      ((Complex.I * Complex.sinh (2 * K2star)) • checkZ M μ
        + Complex.cosh (2 * K2star) • checkY M μ) := by
  have h := NecSuf.hasSum_two_dim_series
    (f := fun n => adPow ((Complex.I * K2star) • H2 M) n (checkY M μ))
    (s := 2 * K2star) (α := 2 * Complex.I * K2star)
    (conversion_H2_checkY_even K2star μ)
    (fun k => by rw [conversion_H2_checkY_odd K2star μ k]; congr 1; ring)
  have hcoef : (2 * Complex.I * K2star) * NecSuf.sinhc (2 * K2star)
      = Complex.I * Complex.sinh (2 * K2star) := by
    linear_combination Complex.I * NecSuf.mul_sinhc (2 * K2star)
  rwa [hcoef, add_comm] at h

end Ising2D
