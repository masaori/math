/-
# 半整数運動量の指数和（**具体版**）

対応する人手証明のラベル: `antiperiodic_exp_sum`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_002_claim_antiperiodic_exp_sum`）

**必要十分版**は `Ising2D/NecSuf/AntiperiodicFourier.lean`（名前空間 `Ising2D.NecSuf`、
同じラベル `antiperiodic_exp_sum`）の `Ising2D.NecSuf.sum_zpow_antiperiodic`。
必要十分版からの導出は `Ising2D/Part013/Claim002_AntiperiodicExpSumFromNecSuf.lean`。

## 原文の主張（`M ∈ ℤ_{≥2}`、`μ ∈ ℤ`）

  `θ~_μ := 2π(μ - 1/2)/M ∈ ℝ`
  `∑_{μ=1}^{M} e^{i k θ~_μ} = M(-1)^l  (k = lM),  0  (k ≢ 0 mod M)`

## 形式化の方針

* 位相因子は既存の `Ising2D.expPhase`（`expPhase N k = exp(-2π√-1 k/N)`、
  `Part004/Claim008_ExpSum.lean`）を `N = 2M` で使う:

    `e^{-i j θ~_μ} = exp(-π√-1 j(2μ-1)/M) = expPhase (2M) (j(2μ-1))`

  これを `Ising2D.checkPhase M j μ` と名づける。**`e^{-iθ~}` は 1 の `2M` 乗根であり、
  半整数運動量とはその奇数周波数のことである**、というのがこの書き方の中身である
  （必要十分版の冒頭コメント参照）。
* 実数の `θ~_μ` は `Ising2D.thetaTilde` として定義し、
  `checkPhase_eq_exp` で `checkPhase` と一致することを示す（原文の記号との橋渡し）。
* 和の添字は `Fin M`（`0,…,M-1`）で、原文の `μ` は `(μ : ℕ) + 1`。
* 原文は `M ≥ 2` を仮定しているが、本ファイルの主張に必要なのは `M ≠ 0` だけである。
-/
import Ising2D.Part004.Claim008_ExpSum
import Mathlib.Analysis.SpecialFunctions.Complex.Circle

namespace Ising2D

variable {M : ℕ}

/-! ## 位相因子の補助（`expPhase` を `2M` で使う） -/

/-- `expPhase N (l a) = (expPhase N a)^l`（`l : ℤ`）。 -/
theorem expPhase_zpow (N : ℕ) (l a : ℤ) : expPhase N (l * a) = (expPhase N a) ^ l := by
  rw [expPhase, expPhase, ← Complex.exp_int_mul]
  congr 1
  push_cast
  ring

/-- `2M` 乗根の偶数周波数は `M` 乗根そのもの: `expPhase (2M) (2n) = expPhase M n`。 -/
theorem expPhase_two_mul (hM : M ≠ 0) (n : ℤ) : expPhase (2 * M) (2 * n) = expPhase M n := by
  have hMC : ((M : ℕ) : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  rw [expPhase, expPhase]
  congr 1
  push_cast
  field_simp

/-- **反周期性の正体**: `expPhase (2M) M = -1`（`= e^{-iπ}`）。 -/
theorem expPhase_two_mul_half (hM : M ≠ 0) : expPhase (2 * M) (M : ℤ) = -1 := by
  have hMC : ((M : ℕ) : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have harg : -(2 * (Real.pi : ℂ) * Complex.I * (((M : ℤ) : ℂ))) / ((2 * M : ℕ) : ℂ)
      = -((Real.pi : ℂ) * Complex.I) := by
    push_cast
    field_simp
  rw [expPhase, harg, Complex.exp_neg, Complex.exp_pi_mul_I]
  norm_num

/-- `expPhase (2M) (-M) = -1`。 -/
theorem expPhase_two_mul_neg_half (hM : M ≠ 0) : expPhase (2 * M) (-(M : ℤ)) = -1 := by
  rw [show (-(M : ℤ)) = (-1 : ℤ) * (M : ℤ) by ring, expPhase_zpow, expPhase_two_mul_half hM]
  norm_num

/-! ## 半整数運動量 `θ~_μ` と位相因子 `check` -/

/-- **原文の `θ~_μ := 2π(μ - 1/2)/M ∈ ℝ`**。 -/
noncomputable def thetaTilde (M : ℕ) (μ : ℤ) : ℝ := 2 * Real.pi * ((μ : ℝ) - 1 / 2) / M

/-- **原文の位相因子 `e^{-i k θ~_μ}`**。`2M` 乗根の**奇数**周波数 `k(2μ-1)` である。 -/
noncomputable def checkPhase (M : ℕ) (k μ : ℤ) : ℂ := expPhase (2 * M) (k * (2 * μ - 1))

/-- `checkPhase` が原文の `e^{-i k θ~_μ}` そのものであること。 -/
theorem checkPhase_eq_exp (hM : M ≠ 0) (k μ : ℤ) :
    checkPhase M k μ = Complex.exp (-(Complex.I * (k : ℂ) * (thetaTilde M μ : ℂ))) := by
  have hMC : ((M : ℕ) : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  rw [checkPhase, expPhase, thetaTilde]
  congr 1
  push_cast
  field_simp

@[simp]
theorem checkPhase_zero_left (M : ℕ) (μ : ℤ) : checkPhase M 0 μ = 1 := by
  simp [checkPhase]

/-- 位相因子は掛けると周波数が足される。 -/
theorem checkPhase_add_left (M : ℕ) (k l μ : ℤ) :
    checkPhase M (k + l) μ = checkPhase M k μ * checkPhase M l μ := by
  rw [checkPhase, checkPhase, checkPhase, ← expPhase_add]
  congr 1
  ring

/-- **原文 `def_half_integer_modes` (1)（反周期性）**: `e^{-iM θ~_μ} = -1`。

`M(2μ-1) = 2M·μ - M` と分けて、前半は `2M` 乗根の周期（`= 1`）、
後半が `expPhase (2M) (-M) = -1` になる。 -/
theorem checkPhase_M (hM : M ≠ 0) (μ : ℤ) : checkPhase M (M : ℤ) μ = -1 := by
  have hsplit : ((M : ℤ) * (2 * μ - 1)) = (μ * (2 * (M : ℤ))) + (-(M : ℤ)) := by ring
  have hfull : expPhase (2 * M) (μ * (2 * (M : ℤ))) = 1 := by
    rw [expPhase_zpow]
    have : expPhase (2 * M) (2 * (M : ℤ)) = 1 := by
      have h2M : ((2 * M : ℕ) : ℤ) = 2 * (M : ℤ) := by push_cast; ring
      exact (expPhase_eq_one_iff (by omega) _).2 (by rw [h2M])
    rw [this, one_zpow]
  rw [checkPhase, hsplit, expPhase_add, hfull, one_mul, expPhase_two_mul_neg_half hM]

/-- 添字 `μ` について `M` 周期（`def_half_integer_modes` (2) の位相因子の部分）。 -/
theorem checkPhase_period (hM : M ≠ 0) (k μ : ℤ) :
    checkPhase M k (μ + (M : ℤ)) = checkPhase M k μ := by
  have hsplit : (k * (2 * (μ + (M : ℤ)) - 1)) = k * (2 * μ - 1) + (k * (2 * (M : ℤ))) := by ring
  have hone : expPhase (2 * M) (k * (2 * (M : ℤ))) = 1 := by
    rw [expPhase_zpow]
    have : expPhase (2 * M) (2 * (M : ℤ)) = 1 := by
      have h2M : ((2 * M : ℕ) : ℤ) = 2 * (M : ℤ) := by push_cast; ring
      exact (expPhase_eq_one_iff (by omega) _).2 (by rw [h2M])
    rw [this, one_zpow]
  rw [checkPhase, checkPhase, hsplit, expPhase_add, hone, mul_one]

/-! ## `0` 始まりの指数和（`exp_sum` の言い換え） -/

/-- `∑_{μ=0}^{M-1} exp(-2π√-1 μ k/M) = M δ^M_{(k,0)}`。

既存の `expPhase_sum`（`∑_{μ=1}^{M}`）と値が等しいこと（`μ=0` の項と `μ=M` の項が
どちらも `1`）を、位相因子を 1 つずらして示す。 -/
theorem expPhase_sum_zero_based (hM : M ≠ 0) (k : ℤ) :
    ∑ μ : Fin M, expPhase M (((μ : ℕ) : ℤ) * k) = (M : ℂ) * deltaMod M k 0 := by
  have hterm : ∀ μ : Fin M,
      expPhase M (((μ : ℕ) : ℤ) * k)
        = expPhase M ((((μ : ℕ) : ℤ) + 1) * k) * expPhase M (-k) := by
    intro μ
    rw [← expPhase_add]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, ← Finset.sum_mul, expPhase_sum hM]
  by_cases hd : (M : ℤ) ∣ k
  · rw [deltaMod, sub_zero, if_pos hd, mul_one,
      (expPhase_eq_one_iff hM (-k)).2 ((dvd_neg).2 hd), mul_one]
  · rw [deltaMod, sub_zero, if_neg hd, mul_zero, zero_mul]

/-! ## `antiperiodic_exp_sum` 本体 -/

/-- **`antiperiodic_exp_sum` の形式化**:

  `∑_{μ=1}^{M} e^{i k θ~_μ} = e^{-iπk/M} · M δ^M_{(k,0)}`

（左辺の `e^{ikθ~_μ}` は `checkPhase M (-k) μ`。）

原文は右辺を「`k = lM` なら `M(-1)^l`、そうでなければ `0`」と場合分けして書いているが、
`M ∤ k` のときは `δ^M_{(k,0)} = 0` で両者は一致し、`k = lM` のときの前因子
`expPhase (2M) (-k) = (-1)^l` は下の `antiperiodic_exp_sum_dvd` で評価する。

証明は原文どおり「定数位相 `e^{-iπk/M}` を括り出して整数運動量の指数和に帰着させる」。 -/
theorem antiperiodic_exp_sum (hM : M ≠ 0) (k : ℤ) :
    ∑ μ : Fin M, checkPhase M (-k) (((μ : ℕ) : ℤ) + 1)
      = expPhase (2 * M) (-k) * ((M : ℂ) * deltaMod M k 0) := by
  have hterm : ∀ μ : Fin M,
      checkPhase M (-k) (((μ : ℕ) : ℤ) + 1)
        = expPhase (2 * M) (-k) * expPhase M (((μ : ℕ) : ℤ) * (-k)) := by
    intro μ
    rw [checkPhase, ← expPhase_two_mul hM (((μ : ℕ) : ℤ) * (-k)), ← expPhase_add]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, ← Finset.mul_sum,
    expPhase_sum_zero_based hM (-k)]
  congr 2
  rw [deltaMod, deltaMod, sub_zero, sub_zero]
  simp only [dvd_neg]

/-- `antiperiodic_exp_sum` を、周波数をそのまま（符号を反転せずに）書いた形。
以降の計算ではこちらの形で使う。 -/
theorem sum_checkPhase (hM : M ≠ 0) (n : ℤ) :
    ∑ μ : Fin M, checkPhase M n (((μ : ℕ) : ℤ) + 1)
      = expPhase (2 * M) n * ((M : ℂ) * deltaMod M n 0) := by
  have h := antiperiodic_exp_sum hM (-n)
  rw [neg_neg] at h
  rw [h]
  congr 2
  rw [deltaMod, deltaMod, sub_zero, sub_zero]
  simp only [dvd_neg]

/-- **`antiperiodic_exp_sum` の `k = lM` の場合**: `∑_{μ=1}^{M} e^{i l M θ~_μ} = M(-1)^l`。 -/
theorem antiperiodic_exp_sum_dvd (hM : M ≠ 0) (l : ℤ) :
    ∑ μ : Fin M, checkPhase M (-(l * (M : ℤ))) (((μ : ℕ) : ℤ) + 1)
      = (M : ℂ) * (-1 : ℂ) ^ l := by
  have hdelta : deltaMod M (l * (M : ℤ)) 0 = 1 := by
    rw [deltaMod, sub_zero, if_pos ⟨l, by ring⟩]
  have hphase : expPhase (2 * M) (-(l * (M : ℤ))) = (-1 : ℂ) ^ l := by
    rw [show (-(l * (M : ℤ))) = (-l) * (M : ℤ) by ring, expPhase_zpow,
      expPhase_two_mul_half hM, zpow_neg]
    have hsq : ((-1 : ℂ) ^ l) * ((-1 : ℂ) ^ l) = 1 := by
      rw [← zpow_add₀ (by norm_num : (-1 : ℂ) ≠ 0), show l + l = 2 * l by ring, zpow_mul]
      norm_num
    exact inv_eq_of_mul_eq_one_left hsq
  rw [antiperiodic_exp_sum hM (l * (M : ℤ)), hphase, hdelta, mul_one]
  ring

/-- **`antiperiodic_exp_sum` の `M ∤ k` の場合**: 和は `0`。 -/
theorem antiperiodic_exp_sum_not_dvd (hM : M ≠ 0) {k : ℤ} (hk : ¬ (M : ℤ) ∣ k) :
    ∑ μ : Fin M, checkPhase M (-k) (((μ : ℕ) : ℤ) + 1) = 0 := by
  rw [antiperiodic_exp_sum hM k, deltaMod, sub_zero, if_neg hk, mul_zero, mul_zero]

/-- **`|k| < M` かつ `k ≠ 0` なら和は `0`、`k = 0` なら `M`**（原文の「とくに」）。 -/
theorem antiperiodic_exp_sum_zero (_hM : M ≠ 0) :
    ∑ μ : Fin M, checkPhase M 0 (((μ : ℕ) : ℤ) + 1) = (M : ℂ) := by
  simp

end Ising2D
