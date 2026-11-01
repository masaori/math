/-
# 具体版: `check(Z), check(Y)` についてのテイラー係数の抽出

対応する人手証明のラベル: **`extract_taylor_coefficient_of_check_Z_Y`**
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensectorT_004_claim_extract_taylor`）

## 人手証明との対応

人手は 4 式のそれぞれを、次の 4 行の式変形で示している。各定理の `HasSum` 版がこの 4 行を同じ順で持つ。

1. `cosh_sinh_coefficient_conversion_for_check` で `n` 項目を書き換える
   （`conversion_H1Plus_checkZ_even` / `_odd` ほか 8 本。`EigenvalueProblem/ReductionToATheta/ClaimCoefficientConversion.lean`）。
2. 偶数項と奇数項に分ける（`HasSum.even_add_odd`）。人手が偶数側へ吸収する `n = 0` 項は、
   `conversion_*_even` の `k = 0`（`K^0 check(Z)_μ`）が受け持つ。
3. `n` に依らない `check(Z)_μ`, `check(Y)_μ` と係数（`i e^{-iθ~}` 等）を和の外へ出す
   （`HasSum.smul_const`・`HasSum.mul_left`）。
4. `sinh_cosh_taylor_series` の `cosh x = ∑_{n 偶数} x^n/n!`, `sinh x = ∑_{n 奇数} x^n/n!` を代入する
   （`Complex.hasSum_cosh`・`Complex.hasSum_sinh`）。

人手の statement が述べる級数の収束は `HasSum` 版がそのまま与え、`∑'` 版はその和の値である。
人手は収束の根拠に `matrix_exp_conjugation` (1) を挙げるが、Lean は収束を上の 4 行の連鎖そのものから得る。
人手は左辺の級数から右辺へ進むが、Lean の `HasSum` は 4 行目の `cosh`・`sinh` の級数から出発し、
`congr_fun` で 1 行目の項へ戻す。各 `have` のコメントに、それが人手の何行目に当たるかを書いた。

必要十分版 `NecSuf.hasSum_two_dim_series`（`NecSuf/ExpConjugation.lean`）から
同じ 4 式を導く系は `EigenvalueProblem/ReductionToATheta/ClaimExtractTaylorFromNecSuf.lean` に置いた。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimCoefficientConversion

namespace Ising2D

open Nat

variable {M : ℕ}

/-! ## (h1.z), (h1.y): `X_1' = (i/2)K_1H_1^{(+)}` -/

/-- **人手 (h1.z)** の級数の収束と和: `∑_n (1/n!) ad_{X_1'}^n(check(Z)_μ) = cosh(K_1) check(Z)_μ
+ i e^{-iθ~_μ} sinh(K_1) check(Y)_μ`。 -/
theorem hasSum_extract_taylor_H1Plus_checkZ (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    HasSum (fun n : ℕ => ((n ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) n (checkZ M μ))
      (Complex.cosh K1 • checkZ M μ
        + (Complex.I * checkPhase M 1 μ * Complex.sinh K1) • checkY M μ) := by
  -- 偶数項: 4 行目の cosh のテイラー展開（`Complex.hasSum_cosh`）から、3 行目で `check(Z)_μ` を外へ出した形、
  -- 1 行目の偶数側 `K_1^{2k} check(Z)_μ`（`conversion_H1Plus_checkZ_even`）へ戻る。
  have heven : HasSum (fun k : ℕ => (((2 * k) ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k) (checkZ M μ))
      (Complex.cosh K1 • checkZ M μ) := by
    refine ((Complex.hasSum_cosh K1).smul_const (checkZ M μ)).congr_fun fun k => ?_
    rw [conversion_H1Plus_checkZ_even hM K1 μ k, smul_smul, div_eq_inv_mul]
  -- 奇数項: 4 行目の sinh のテイラー展開（`Complex.hasSum_sinh`）から、3 行目で `i e^{-iθ~}` と `check(Y)_μ` を
  -- 外へ出した形、1 行目の奇数側 `i K_1^{2k+1} e^{-iθ~} check(Y)_μ`（`conversion_H1Plus_checkZ_odd`）へ戻る。
  have hodd : HasSum (fun k : ℕ => (((2 * k + 1) ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k + 1) (checkZ M μ))
      ((Complex.I * checkPhase M 1 μ * Complex.sinh K1) • checkY M μ) := by
    refine (((Complex.hasSum_sinh K1).mul_left (Complex.I * checkPhase M 1 μ)).smul_const
      (checkY M μ)).congr_fun fun k => ?_
    rw [conversion_H1Plus_checkZ_odd hM K1 μ k, smul_smul]
    congr 1
    ring
  -- 2 行目: 偶数項と奇数項を足し直す
  exact HasSum.even_add_odd heven hodd

/-- **人手 (h1.z)**（和の値）。 -/
theorem extract_taylor_H1Plus_checkZ (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    ∑' n : ℕ, ((n ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) n (checkZ M μ)
      = Complex.cosh K1 • checkZ M μ
        + (Complex.I * checkPhase M 1 μ * Complex.sinh K1) • checkY M μ :=
  (hasSum_extract_taylor_H1Plus_checkZ hM K1 μ).tsum_eq

/-- **人手 (h1.y)** の級数の収束と和: `∑_n (1/n!) ad_{X_1'}^n(check(Y)_μ) = -i e^{iθ~_μ} sinh(K_1) check(Z)_μ
+ cosh(K_1) check(Y)_μ`。 -/
theorem hasSum_extract_taylor_H1Plus_checkY (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    HasSum (fun n : ℕ => ((n ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) n (checkY M μ))
      ((-Complex.I * checkPhase M (-1) μ * Complex.sinh K1) • checkZ M μ
        + Complex.cosh K1 • checkY M μ) := by
  -- 偶数項: 4 行目の cosh → 3 行目（`check(Y)_μ` を外へ）→ 1 行目の偶数側 `K_1^{2k} check(Y)_μ`
  have heven : HasSum (fun k : ℕ => (((2 * k) ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k) (checkY M μ))
      (Complex.cosh K1 • checkY M μ) := by
    refine ((Complex.hasSum_cosh K1).smul_const (checkY M μ)).congr_fun fun k => ?_
    rw [conversion_H1Plus_checkY_even hM K1 μ k, smul_smul, div_eq_inv_mul]
  -- 奇数項: 4 行目の sinh → 3 行目（`-i e^{iθ~}` と `check(Z)_μ` を外へ）→ 1 行目の奇数側
  -- `-i K_1^{2k+1} e^{iθ~} check(Z)_μ`
  have hodd : HasSum (fun k : ℕ => (((2 * k + 1) ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k + 1) (checkY M μ))
      ((-Complex.I * checkPhase M (-1) μ * Complex.sinh K1) • checkZ M μ) := by
    refine (((Complex.hasSum_sinh K1).mul_left (-Complex.I * checkPhase M (-1) μ)).smul_const
      (checkZ M μ)).congr_fun fun k => ?_
    rw [conversion_H1Plus_checkY_odd hM K1 μ k, smul_smul]
    congr 1
    ring
  -- 2 行目: 偶数項と奇数項を足し直す。最後の行（行列加法の可換則）で並びを statement に合わせる
  rw [add_comm]
  exact HasSum.even_add_odd heven hodd

/-- **人手 (h1.y)**（和の値）。 -/
theorem extract_taylor_H1Plus_checkY (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    ∑' n : ℕ, ((n ! : ℂ))⁻¹ •
        adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) n (checkY M μ)
      = (-Complex.I * checkPhase M (-1) μ * Complex.sinh K1) • checkZ M μ
        + Complex.cosh K1 • checkY M μ :=
  (hasSum_extract_taylor_H1Plus_checkY hM K1 μ).tsum_eq

/-! ## (h2.z), (h2.y): `X_2' = i K_2^* H_2` -/

/-- **人手 (h2.z)** の級数の収束と和: `∑_n (1/n!) ad_{X_2'}^n(check(Z)_μ)
= cosh(2K_2^*) check(Z)_μ - i sinh(2K_2^*) check(Y)_μ`。 -/
theorem hasSum_extract_taylor_H2_checkZ (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    HasSum (fun n : ℕ => ((n ! : ℂ))⁻¹ • adPow ((Complex.I * K2star) • H2 M) n (checkZ M μ))
      (Complex.cosh (2 * K2star) • checkZ M μ
        + (-Complex.I * Complex.sinh (2 * K2star)) • checkY M μ) := by
  -- 偶数項: 4 行目の cosh → 3 行目（`check(Z)_μ` を外へ）→ 1 行目の偶数側 `(2K_2^*)^{2k} check(Z)_μ`
  have heven : HasSum (fun k : ℕ => (((2 * k) ! : ℂ))⁻¹ •
        adPow ((Complex.I * K2star) • H2 M) (2 * k) (checkZ M μ))
      (Complex.cosh (2 * K2star) • checkZ M μ) := by
    refine ((Complex.hasSum_cosh (2 * K2star)).smul_const (checkZ M μ)).congr_fun fun k => ?_
    rw [conversion_H2_checkZ_even hM K2star μ k, smul_smul, div_eq_inv_mul]
  -- 奇数項: 4 行目の sinh → 3 行目（`-i` と `check(Y)_μ` を外へ）→ 1 行目の奇数側 `-i (2K_2^*)^{2k+1} check(Y)_μ`
  have hodd : HasSum (fun k : ℕ => (((2 * k + 1) ! : ℂ))⁻¹ •
        adPow ((Complex.I * K2star) • H2 M) (2 * k + 1) (checkZ M μ))
      ((-Complex.I * Complex.sinh (2 * K2star)) • checkY M μ) := by
    refine (((Complex.hasSum_sinh (2 * K2star)).mul_left (-Complex.I)).smul_const
      (checkY M μ)).congr_fun fun k => ?_
    rw [conversion_H2_checkZ_odd hM K2star μ k, smul_smul]
    congr 1
    ring
  -- 2 行目: 偶数項と奇数項を足し直す
  exact HasSum.even_add_odd heven hodd

/-- **人手 (h2.z)**（和の値）。 -/
theorem extract_taylor_H2_checkZ (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow ((Complex.I * K2star) • H2 M) n (checkZ M μ)
      = Complex.cosh (2 * K2star) • checkZ M μ
        + (-Complex.I * Complex.sinh (2 * K2star)) • checkY M μ :=
  (hasSum_extract_taylor_H2_checkZ hM K2star μ).tsum_eq

/-- **人手 (h2.y)** の級数の収束と和: `∑_n (1/n!) ad_{X_2'}^n(check(Y)_μ)
= i sinh(2K_2^*) check(Z)_μ + cosh(2K_2^*) check(Y)_μ`。 -/
theorem hasSum_extract_taylor_H2_checkY (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    HasSum (fun n : ℕ => ((n ! : ℂ))⁻¹ • adPow ((Complex.I * K2star) • H2 M) n (checkY M μ))
      ((Complex.I * Complex.sinh (2 * K2star)) • checkZ M μ
        + Complex.cosh (2 * K2star) • checkY M μ) := by
  -- 偶数項: 4 行目の cosh → 3 行目（`check(Y)_μ` を外へ）→ 1 行目の偶数側 `(2K_2^*)^{2k} check(Y)_μ`
  have heven : HasSum (fun k : ℕ => (((2 * k) ! : ℂ))⁻¹ •
        adPow ((Complex.I * K2star) • H2 M) (2 * k) (checkY M μ))
      (Complex.cosh (2 * K2star) • checkY M μ) := by
    refine ((Complex.hasSum_cosh (2 * K2star)).smul_const (checkY M μ)).congr_fun fun k => ?_
    rw [conversion_H2_checkY_even hM K2star μ k, smul_smul, div_eq_inv_mul]
  -- 奇数項: 4 行目の sinh → 3 行目（`i` と `check(Z)_μ` を外へ）→ 1 行目の奇数側 `i (2K_2^*)^{2k+1} check(Z)_μ`
  have hodd : HasSum (fun k : ℕ => (((2 * k + 1) ! : ℂ))⁻¹ •
        adPow ((Complex.I * K2star) • H2 M) (2 * k + 1) (checkY M μ))
      ((Complex.I * Complex.sinh (2 * K2star)) • checkZ M μ) := by
    refine (((Complex.hasSum_sinh (2 * K2star)).mul_left Complex.I).smul_const
      (checkZ M μ)).congr_fun fun k => ?_
    rw [conversion_H2_checkY_odd hM K2star μ k, smul_smul]
    congr 1
    ring
  -- 2 行目: 偶数項と奇数項を足し直す。最後の行（行列加法の可換則）で並びを statement に合わせる
  rw [add_comm]
  exact HasSum.even_add_odd heven hodd

/-- **人手 (h2.y)**（和の値）。 -/
theorem extract_taylor_H2_checkY (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow ((Complex.I * K2star) • H2 M) n (checkY M μ)
      = (Complex.I * Complex.sinh (2 * K2star)) • checkZ M μ
        + Complex.cosh (2 * K2star) • checkY M μ :=
  (hasSum_extract_taylor_H2_checkY hM K2star μ).tsum_eq

end Ising2D
