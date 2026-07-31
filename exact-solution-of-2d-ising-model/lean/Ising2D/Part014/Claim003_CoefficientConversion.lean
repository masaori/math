/-
# 具体版: `check(Z), check(Y)` についての cosh / sinh の展開係数への変換

対応する人手証明のラベル: **`cosh_sinh_coefficient_conversion_for_check`**
（`structured-latex/content/014_even_sector_T_action.ts` の
`evensectorT_003_claim_coefficient_conversion`）

**必要十分版**は既存の `Ising2D/NecSuf/ExpConjugation.lean` の
`Ising2D.NecSuf.adCLM_pow_even` / `adCLM_pow_odd_z` / `adCLM_pow_odd_y`
（`Part014/Claim002_NestedCommutator.lean` と同じもの）。

## 原文との対応

原文はこの主張を「補題 1（生成子のスカラー倍 `ad_{αX}^n = α^n ad_X^n`）＋
補題 2（`i^n` の偶奇）を `nesting_of_commutator_of_H_and_check_Z` の 4 式へ代入する」
という形で導いている。Lean では、スカラー倍した生成子

  `X_1' := (i/2) K_1 H_1^{(+)}`,  `X_2' := i K_2^* H_2`

について `ad X'` が `span{check(Z)_μ, check(Y)_μ}` を保つことを直接示し
（係数は `(α, β)` が `(i K_1 e^{-iθ~}, -i K_1 e^{iθ~})` と `(-2i K_2^*, 2i K_2^*)`、
したがって `s` は `K_1` と `2K_2^*`）、同じ必要十分版へ渡す。
**原文の補題 1・補題 2 は、この `(α, β, s)` の付け替えに吸収される。**
とくに `s` が純虚数 `2iK_1` から実の `K_1` へ変わることが、原文の
`(-1)^{n/2}(2K_1)^n → K_1^n` という符号の消滅の正体である。
-/
import Ising2D.Part014.Claim002_NestedCommutator

namespace Ising2D

variable {M : ℕ}

/-! ## `ad((i/2)K_1H_1^{(+)})` が `span{check(Z)_μ, check(Y)_μ}` を保つこと -/

/-- 原文 (A) を `(i/2)K_1` 倍したもの。 -/
theorem ad_V1halfPlus_checkZ (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1)) * checkZ M μ -
        checkZ M μ * (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1))
      = (Complex.I * K1 * checkPhase M 1 μ) • checkY M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H1Plus_checkZ hM μ,
    smul_smul]
  congr 1
  ring

/-- 原文 (B) を `(i/2)K_1` 倍したもの。 -/
theorem ad_V1halfPlus_checkY (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1)) * checkY M μ -
        checkY M μ * (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1))
      = (-Complex.I * K1 * checkPhase M (-1) μ) • checkZ M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H1Plus_checkY hM μ,
    smul_smul]
  congr 1
  ring

/-- `αβ = K_1^2`（`i·(-i) = 1` と `e^{-iθ~}e^{iθ~} = 1`）。原文の `s = K_1` の根拠。 -/
theorem sK1_sq (M : ℕ) (K1 : ℂ) (μ : ℤ) :
    K1 ^ 2 = (Complex.I * K1 * checkPhase M 1 μ) * (-Complex.I * K1 * checkPhase M (-1) μ) := by
  have hp := checkPhase_mul_neg M μ
  linear_combination
    (K1 ^ 2 * checkPhase M 1 μ * checkPhase M (-1) μ) * Complex.I_sq - (K1 ^ 2) * hp

/-! ## `ad(i K_2^* H_2)` が `span{check(Z)_μ, check(Y)_μ}` を保つこと -/

/-- 原文 (C) を `i K_2^*` 倍したもの。 -/
theorem ad_V2_checkZ (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ((Complex.I * K2star) • H2 M) * checkZ M μ -
        checkZ M μ * ((Complex.I * K2star) • H2 M)
      = (-(2 * Complex.I * K2star)) • checkY M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H2_checkZ hM μ, smul_smul]
  congr 1
  ring

/-- 原文 (D) を `i K_2^*` 倍したもの。 -/
theorem ad_V2_checkY (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ((Complex.I * K2star) • H2 M) * checkY M μ -
        checkY M μ * ((Complex.I * K2star) • H2 M)
      = (2 * Complex.I * K2star) • checkZ M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H2_checkY hM μ, smul_smul]
  congr 1
  ring

/-- `αβ = (2K_2^*)^2`。原文の `s = 2K_2^*` の根拠。 -/
theorem sK2_sq (K2star : ℂ) :
    (2 * K2star) ^ 2 = (-(2 * Complex.I * K2star)) * (2 * Complex.I * K2star) := by
  linear_combination (4 * K2star ^ 2) * Complex.I_sq

/-! ## 原文 (h1.z)(h1.y): `X_1' = (i/2)K_1H_1^{(+)}` についての `n` 重交換子 -/

open scoped Matrix.Norms.Operator in
private theorem adPow_even_aux {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) (k : ℕ) :
    adPow X (2 * k) z = (s ^ (2 * k)) • z ∧ adPow X (2 * k) y = (s ^ (2 * k)) • y := by
  simpa only [adPow_eq_adCLM] using NecSuf.adCLM_pow_even (x := X) (z := z) (y := y) hz hy hs k

open scoped Matrix.Norms.Operator in
private theorem adPow_odd_z_aux {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) (k : ℕ) :
    adPow X (2 * k + 1) z = (s ^ (2 * k) * α) • y := by
  simpa only [adPow_eq_adCLM] using
    NecSuf.adCLM_pow_odd_z (x := X) (z := z) (y := y) hz hy hs k

open scoped Matrix.Norms.Operator in
private theorem adPow_odd_y_aux {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) (k : ℕ) :
    adPow X (2 * k + 1) y = (s ^ (2 * k) * β) • z := by
  simpa only [adPow_eq_adCLM] using
    NecSuf.adCLM_pow_odd_y (x := X) (z := z) (y := y) hz hy hs k

/-- **原文 (h1.z) 偶数側**: `n = 2k` のとき `K_1^{2k} check(Z)_μ`（符号が消える）。 -/
theorem conversion_H1Plus_checkZ_even (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1)) (2 * k) (checkZ M μ)
      = (K1 ^ (2 * k)) • checkZ M μ :=
  (adPow_even_aux (ad_V1halfPlus_checkZ hM K1 μ) (ad_V1halfPlus_checkY hM K1 μ)
    (sK1_sq M K1 μ) k).1

/-- **原文 (h1.z) 奇数側**: `n = 2k+1` のとき `i K_1^{2k+1} e^{-iθ~_μ} check(Y)_μ`。 -/
theorem conversion_H1Plus_checkZ_odd (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1)) (2 * k + 1) (checkZ M μ)
      = (Complex.I * K1 ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ := by
  rw [adPow_odd_z_aux (ad_V1halfPlus_checkZ hM K1 μ) (ad_V1halfPlus_checkY hM K1 μ)
    (sK1_sq M K1 μ) k]
  congr 1
  rw [pow_succ]
  ring

/-- **原文 (h1.y) 偶数側**: `n = 2k` のとき `K_1^{2k} check(Y)_μ`。 -/
theorem conversion_H1Plus_checkY_even (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1)) (2 * k) (checkY M μ)
      = (K1 ^ (2 * k)) • checkY M μ :=
  (adPow_even_aux (ad_V1halfPlus_checkZ hM K1 μ) (ad_V1halfPlus_checkY hM K1 μ)
    (sK1_sq M K1 μ) k).2

/-- **原文 (h1.y) 奇数側**: `n = 2k+1` のとき `-i K_1^{2k+1} e^{iθ~_μ} check(Z)_μ`。 -/
theorem conversion_H1Plus_checkY_odd (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1 M (-1)) (2 * k + 1) (checkY M μ)
      = (-Complex.I * K1 ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ := by
  rw [adPow_odd_y_aux (ad_V1halfPlus_checkZ hM K1 μ) (ad_V1halfPlus_checkY hM K1 μ)
    (sK1_sq M K1 μ) k]
  congr 1
  rw [pow_succ]
  ring

/-! ## 原文 (h2.z)(h2.y): `X_2' = i K_2^* H_2` についての `n` 重交換子 -/

/-- **原文 (h2.z) 偶数側**: `n = 2k` のとき `(2K_2^*)^{2k} check(Z)_μ`。 -/
theorem conversion_H2_checkZ_even (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k) (checkZ M μ)
      = ((2 * K2star) ^ (2 * k)) • checkZ M μ :=
  (adPow_even_aux (ad_V2_checkZ hM K2star μ) (ad_V2_checkY hM K2star μ) (sK2_sq K2star) k).1

/-- **原文 (h2.z) 奇数側**: `n = 2k+1` のとき `-i (2K_2^*)^{2k+1} check(Y)_μ`。 -/
theorem conversion_H2_checkZ_odd (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k + 1) (checkZ M μ)
      = (-Complex.I * (2 * K2star) ^ (2 * k + 1)) • checkY M μ := by
  rw [adPow_odd_z_aux (ad_V2_checkZ hM K2star μ) (ad_V2_checkY hM K2star μ) (sK2_sq K2star) k]
  congr 1
  rw [pow_succ]
  ring

/-- **原文 (h2.y) 偶数側**: `n = 2k` のとき `(2K_2^*)^{2k} check(Y)_μ`。 -/
theorem conversion_H2_checkY_even (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k) (checkY M μ)
      = ((2 * K2star) ^ (2 * k)) • checkY M μ :=
  (adPow_even_aux (ad_V2_checkZ hM K2star μ) (ad_V2_checkY hM K2star μ) (sK2_sq K2star) k).2

/-- **原文 (h2.y) 奇数側**: `n = 2k+1` のとき `i (2K_2^*)^{2k+1} check(Z)_μ`。 -/
theorem conversion_H2_checkY_odd (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k + 1) (checkY M μ)
      = (Complex.I * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ := by
  rw [adPow_odd_y_aux (ad_V2_checkZ hM K2star μ) (ad_V2_checkY hM K2star μ) (sK2_sq K2star) k]
  congr 1
  rw [pow_succ]
  ring

end Ising2D
