/-
# 具体版: `check(Z), check(Y)` についての `n` 重交換子

対応する人手証明のラベル: **`nesting_of_commutator_of_H_and_check_Z`**
（`structured-latex/content/014_even_sector_T_action.ts` の
`evensectorT_002_claim_nesting_commutator`）

**抽象版**は既存の `Ising2D/Abstract/ExpConjugation.lean` の
`Ising2D.Abstract.adCLM_pow_even` / `adCLM_pow_odd_z` / `adCLM_pow_odd_y`。
本ファイルの 8 本（4 式 × 偶奇）はすべてその系として導く。

## ここで確かめたこと（章 014 の要点）

008 章の `<nesting_of_commutator_of_H_and_Z>`（整数運動量）と本章の
`<nesting_of_commutator_of_H_and_check_Z>`（半整数運動量）は、
**同じ抽象版 `adCLM_pow_even` / `adCLM_pow_odd_*` の別の特殊化**である。
違いは `ad X` が `span{z, y}` に及ぼす係数 `(α, β)` だけで、

| | `z` | `y` | `α` | `β` | `s` |
| --- | --- | --- | --- | --- | --- |
| 008 章（整数運動量） | `hat(Z)^{(-)}_μ` | `hat(Y)_μ` | `2K_1 e^{-iθ_μ}` | `-2K_1 e^{iθ_μ}` | `2iK_1` |
| 本章（半整数運動量） | `check(Z)_μ` | `check(Y)_μ` | `2K_1 e^{-iθ~_μ}` | `-2K_1 e^{iθ~_μ}` | `2iK_1` |

`αβ = -4K_1^2` は `e^{-iθ}e^{iθ} = 1` からしか使っておらず、`θ` が `2πμ/M` か
`2π(μ-1/2)/M` かは効いていない。これが原文の
「008 章の各証明は `θ_μ` に固有の性質を使っていない」という観察の Lean での裏づけである。

## 原文の主張と本ファイルの形

原文は `n ∈ ℤ_{≥0}` について右辺を `n` の偶奇で場合分けして書いている。
Lean では偶奇を `n = 2k` / `n = 2k+1` と書き分けた 2 本ずつの定理にする
（`(-1)^{n/2} = (-1)^k`、`(-1)^{(n-1)/2} = (-1)^k`、`(-1)^{(n+1)/2} = (-1)^{k+1}`）。
`n` 重の入れ子交換子は既存の `Ising2D.adPow`（`Part008/Claim006_ExpConjugation.lean`、
原文 `<ad_binomial>` の再帰そのもの）で表す。

`e^{-iθ~_μ}` は `Ising2D.checkPhase M 1 μ`、`e^{iθ~_μ}` は `Ising2D.checkPhase M (-1) μ`
（`Part013/Claim002_AntiperiodicExpSum.lean`）。
`H_1^{(+)}` は `Ising2D.H1 M (-1)`（引数 `η` が原文の `∓1`）。
-/
import Ising2D.Part008.Claim006_ExpConjugation
import Ising2D.Part013.Claim004_CommutatorHCheckZY

namespace Ising2D

variable {M : ℕ}

/-! ## 位相因子の補助 -/

/-- `e^{-iθ~_μ} e^{iθ~_μ} = 1`（原文が帰納段階で使う唯一の位相の性質）。 -/
theorem checkPhase_mul_neg (M : ℕ) (μ : ℤ) :
    checkPhase M 1 μ * checkPhase M (-1) μ = 1 := by
  rw [← checkPhase_add_left]
  norm_num

/-- `(2 i c)^{2k} = (-1)^k (2c)^{2k}`（原文の `(-1)^{n/2}(2K)^n` の正体）。 -/
private theorem two_I_pow_two_mul (c : ℂ) (k : ℕ) :
    (2 * Complex.I * c) ^ (2 * k) = (-1 : ℂ) ^ k * (2 * c) ^ (2 * k) := by
  have hsq : (2 * Complex.I * c) ^ 2 = (-1 : ℂ) * (2 * c) ^ 2 := by
    linear_combination (4 * c ^ 2) * Complex.I_sq
  rw [pow_mul, hsq, mul_pow, pow_mul]

/-! ## `adPow` の偶奇（抽象版の特殊化） -/

open scoped Matrix.Norms.Operator in
/-- 抽象版 `Abstract.adCLM_pow_even` の特殊化（偶数回）。 -/
private theorem adPow_two_dim_even {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) (k : ℕ) :
    adPow X (2 * k) z = (s ^ (2 * k)) • z ∧ adPow X (2 * k) y = (s ^ (2 * k)) • y := by
  simpa only [adPow_eq_adCLM] using Abstract.adCLM_pow_even (x := X) (z := z) (y := y) hz hy hs k

open scoped Matrix.Norms.Operator in
/-- 抽象版 `Abstract.adCLM_pow_odd_z` の特殊化（奇数回・`z` 始点）。 -/
private theorem adPow_two_dim_odd_z {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) (k : ℕ) :
    adPow X (2 * k + 1) z = (s ^ (2 * k) * α) • y := by
  simpa only [adPow_eq_adCLM] using
    Abstract.adCLM_pow_odd_z (x := X) (z := z) (y := y) hz hy hs k

open scoped Matrix.Norms.Operator in
/-- 抽象版 `Abstract.adCLM_pow_odd_y` の特殊化（奇数回・`y` 始点）。 -/
private theorem adPow_two_dim_odd_y {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) (k : ℕ) :
    adPow X (2 * k + 1) y = (s ^ (2 * k) * β) • z := by
  simpa only [adPow_eq_adCLM] using
    Abstract.adCLM_pow_odd_y (x := X) (z := z) (y := y) hz hy hs k

/-! ## `ad(K_1 H_1^{(+)})` が `span{check(Z)_μ, check(Y)_μ}` を保つこと -/

/-- 原文 (A) `[H_1^{(+)}, check(Z)_μ] = 2 e^{-iθ~_μ} check(Y)_μ` の `K_1` 倍。 -/
theorem ad_K1H1Plus_checkZ (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (K1 • H1 M (-1)) * checkZ M μ - checkZ M μ * (K1 • H1 M (-1))
      = (2 * K1 * checkPhase M 1 μ) • checkY M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H1Plus_checkZ hM μ,
    smul_smul]
  congr 1
  ring

/-- 原文 (B) `[H_1^{(+)}, check(Y)_μ] = -2 e^{iθ~_μ} check(Z)_μ` の `K_1` 倍。 -/
theorem ad_K1H1Plus_checkY (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (K1 • H1 M (-1)) * checkY M μ - checkY M μ * (K1 • H1 M (-1))
      = (-2 * K1 * checkPhase M (-1) μ) • checkZ M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H1Plus_checkY hM μ,
    smul_smul]
  congr 1
  ring

/-- `α β = (2iK_1)^2`（`e^{-iθ~}e^{iθ~} = 1` と `i^2 = -1` だけを使う）。 -/
private theorem s1_sq (M : ℕ) (K1 : ℂ) (μ : ℤ) :
    (2 * Complex.I * K1) ^ 2
      = (2 * K1 * checkPhase M 1 μ) * (-2 * K1 * checkPhase M (-1) μ) := by
  have hp := checkPhase_mul_neg M μ
  linear_combination (4 * K1 ^ 2) * Complex.I_sq + (4 * K1 ^ 2) * hp

/-! ## `ad(K_2^* H_2)` が `span{check(Z)_μ, check(Y)_μ}` を保つこと -/

/-- 原文 (C) `[H_2, check(Z)_μ] = -2 check(Y)_μ` の `K_2^*` 倍。 -/
theorem ad_K2H2_checkZ (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    (K2star • H2 M) * checkZ M μ - checkZ M μ * (K2star • H2 M)
      = (-2 * K2star) • checkY M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H2_checkZ hM μ, smul_smul]
  congr 1
  ring

/-- 原文 (D) `[H_2, check(Y)_μ] = 2 check(Z)_μ` の `K_2^*` 倍。 -/
theorem ad_K2H2_checkY (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    (K2star • H2 M) * checkY M μ - checkY M μ * (K2star • H2 M)
      = (2 * K2star) • checkZ M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H2_checkY hM μ, smul_smul]
  congr 1
  ring

private theorem s2_sq (K2star : ℂ) :
    (2 * Complex.I * K2star) ^ 2 = (-2 * K2star) * (2 * K2star) := by
  linear_combination (4 * K2star ^ 2) * Complex.I_sq

/-! ## 原文 (h1.z): `[K_1H_1^{(+)}, …, [K_1H_1^{(+)}, check(Z)_μ]…]` -/

/-- **原文 (h1.z) の偶数側**: `n = 2k` のとき `(-1)^k (2K_1)^{2k} check(Z)_μ`。 -/
theorem nesting_H1Plus_checkZ_even (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1 M (-1)) (2 * k) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkZ M μ := by
  rw [(adPow_two_dim_even (ad_K1H1Plus_checkZ hM K1 μ) (ad_K1H1Plus_checkY hM K1 μ)
    (s1_sq M K1 μ) k).1, two_I_pow_two_mul]

/-- **原文 (h1.z) の奇数側**: `n = 2k+1` のとき `(-1)^k (2K_1)^{2k+1} e^{-iθ~_μ} check(Y)_μ`。 -/
theorem nesting_H1Plus_checkZ_odd (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1 M (-1)) (2 * k + 1) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ := by
  rw [adPow_two_dim_odd_z (ad_K1H1Plus_checkZ hM K1 μ) (ad_K1H1Plus_checkY hM K1 μ)
    (s1_sq M K1 μ) k, two_I_pow_two_mul]
  congr 1
  rw [pow_succ]
  ring

/-! ## 原文 (h1.y): `[K_1H_1^{(+)}, …, [K_1H_1^{(+)}, check(Y)_μ]…]` -/

/-- **原文 (h1.y) の偶数側**: `n = 2k` のとき `(-1)^k (2K_1)^{2k} check(Y)_μ`。 -/
theorem nesting_H1Plus_checkY_even (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1 M (-1)) (2 * k) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkY M μ := by
  rw [(adPow_two_dim_even (ad_K1H1Plus_checkZ hM K1 μ) (ad_K1H1Plus_checkY hM K1 μ)
    (s1_sq M K1 μ) k).2, two_I_pow_two_mul]

/-- **原文 (h1.y) の奇数側**: `n = 2k+1` のとき `(-1)^{k+1} (2K_1)^{2k+1} e^{iθ~_μ} check(Z)_μ`。 -/
theorem nesting_H1Plus_checkY_odd (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1 M (-1)) (2 * k + 1) (checkY M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ := by
  rw [adPow_two_dim_odd_y (ad_K1H1Plus_checkZ hM K1 μ) (ad_K1H1Plus_checkY hM K1 μ)
    (s1_sq M K1 μ) k, two_I_pow_two_mul]
  congr 1
  rw [pow_succ, pow_succ]
  ring

/-! ## 原文 (h2.z): `[K_2^*H_2, …, [K_2^*H_2, check(Z)_μ]…]` -/

/-- **原文 (h2.z) の偶数側**: `n = 2k` のとき `(-1)^k (2K_2^*)^{2k} check(Z)_μ`。 -/
theorem nesting_H2_checkZ_even (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkZ M μ := by
  rw [(adPow_two_dim_even (ad_K2H2_checkZ hM K2star μ) (ad_K2H2_checkY hM K2star μ)
    (s2_sq K2star) k).1, two_I_pow_two_mul]

/-- **原文 (h2.z) の奇数側**: `n = 2k+1` のとき `(-1)^{k+1} (2K_2^*)^{2k+1} check(Y)_μ`。 -/
theorem nesting_H2_checkZ_odd (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k + 1) (checkZ M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * k + 1)) • checkY M μ := by
  rw [adPow_two_dim_odd_z (ad_K2H2_checkZ hM K2star μ) (ad_K2H2_checkY hM K2star μ)
    (s2_sq K2star) k, two_I_pow_two_mul]
  congr 1
  rw [pow_succ, pow_succ]
  ring

/-! ## 原文 (h2.y): `[K_2^*H_2, …, [K_2^*H_2, check(Y)_μ]…]` -/

/-- **原文 (h2.y) の偶数側**: `n = 2k` のとき `(-1)^k (2K_2^*)^{2k} check(Y)_μ`。 -/
theorem nesting_H2_checkY_even (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkY M μ := by
  rw [(adPow_two_dim_even (ad_K2H2_checkZ hM K2star μ) (ad_K2H2_checkY hM K2star μ)
    (s2_sq K2star) k).2, two_I_pow_two_mul]

/-- **原文 (h2.y) の奇数側**: `n = 2k+1` のとき `(-1)^k (2K_2^*)^{2k+1} check(Z)_μ`。 -/
theorem nesting_H2_checkY_odd (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k + 1) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ := by
  rw [adPow_two_dim_odd_y (ad_K2H2_checkZ hM K2star μ) (ad_K2H2_checkY hM K2star μ)
    (s2_sq K2star) k, two_I_pow_two_mul]
  congr 1
  rw [pow_succ]
  ring

end Ising2D
