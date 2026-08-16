/-
章「熱力学極限」の「整数冪の実対数は整数倍である（実数体への脱出: 実対数）」
（`claim_real_logarithm_int_power`）の具体版。

  人手証明                                                       このファイル
  準備: log_ℝ(1) = 0
    log_ℝ(1) = log_ℝ(1·1) = log_ℝ(1) + log_ℝ(1)、ℝ の加法群で移項          `realLog_one`
  n ∈ ℕ の帰納法: log_ℝ(u^n) = n·log_ℝ(u)
    n = 0: u^0 = 1、準備。  n → n+1: u^{n+1} = u^n·u、乗法を加法へ、帰納法の仮定  `realLog_pow`
  逆数: 0 = log_ℝ(1) = log_ℝ(v·v^{-1}) = log_ℝ(v) + log_ℝ(v^{-1})、移項          `realLog_inv`
  k = -(n+1): log_ℝ(u^k) = log_ℝ((u^{n+1})^{-1}) = -log_ℝ(u^{n+1}) = -(n+1)·log_ℝ(u) = k·log_ℝ(u)
                                                                    `realLog_zpow`
実対数について使うのは `realLog_mul`（乗法を加法へ移す）だけである。
`Real.log_pow`・`Real.log_zpow`・`Real.log_inv`・`Real.log_one` は使わない（人手証明の手順と 1 対 1 にするため）。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupRealization

namespace Ising2DLambda.ThermodynamicLimit

/-- 「乗法を加法へ移す」を、値の側の等式として読み直したもの（`realLog ⟨t, h⟩ = Real.log t` は定義そのもの）。 -/
theorem realLog_val_mul (a b : ℝ) (ha : 0 < a) (hb : 0 < b) :
    Real.log (a * b) = Real.log a + Real.log b :=
  realLog_mul ⟨a, ha⟩ ⟨b, hb⟩

/-- 準備: `log_ℝ(1) = 0`。 -/
theorem realLog_one : realLog ⟨1, one_pos⟩ = 0 := by
  have h : Real.log 1 = Real.log 1 + Real.log 1 := by
    have := realLog_val_mul 1 1 one_pos one_pos                        -- 乗法を加法へ
    rwa [one_mul] at this                                              -- 1·1 = 1
  change Real.log 1 = 0
  linarith                                                             -- ℝ の加法群で移項

/-- 自然数冪: `log_ℝ(u^n) = n·log_ℝ(u)`（`n` の帰納法）。 -/
theorem realLog_pow (u : PositiveReal) (n : ℕ) :
    realLog ⟨u.1 ^ n, pow_pos u.2 n⟩ = (n : ℝ) * realLog u := by
  induction n with
  | zero =>
      change Real.log (u.1 ^ 0) = ((0 : ℕ) : ℝ) * Real.log u.1
      rw [pow_zero, Nat.cast_zero, zero_mul]                           -- u^0 = 1
      exact realLog_one                                                -- 準備
  | succ n ih =>
      change Real.log (u.1 ^ (n + 1)) = ((n + 1 : ℕ) : ℝ) * Real.log u.1
      change Real.log (u.1 ^ n) = (n : ℝ) * Real.log u.1 at ih
      rw [pow_succ]                                                    -- u^{n+1} = u^n · u
      rw [realLog_val_mul _ _ (pow_pos u.2 n) u.2]                     -- 乗法を加法へ
      rw [ih]                                                          -- 帰納法の仮定
      push_cast
      ring                                                             -- (n+1)·x = n·x + x

/-- 逆数: `log_ℝ(v^{-1}) = -log_ℝ(v)`。 -/
theorem realLog_inv (v : PositiveReal) :
    realLog ⟨v.1⁻¹, inv_pos.mpr v.2⟩ = -realLog v := by
  have h1 : Real.log 1 = 0 := realLog_one
  have h : Real.log (v.1 * v.1⁻¹) = Real.log v.1 + Real.log v.1⁻¹ :=
    realLog_val_mul _ _ v.2 (inv_pos.mpr v.2)                          -- 乗法を加法へ
  rw [mul_inv_cancel₀ (ne_of_gt v.2), h1] at h                         -- v·v^{-1} = 1、log_ℝ(1) = 0
  change Real.log v.1⁻¹ = -Real.log v.1
  linarith                                                             -- ℝ の加法群で移項

/-- `claim_real_logarithm_int_power`: `log_ℝ(u^k) = ι_{ℚ→ℝ}(k)·log_ℝ(u)`（`k ∈ ℤ`）。 -/
theorem realLog_zpow (u : PositiveReal) (k : ℤ) :
    realLog ⟨u.1 ^ k, zpow_pos u.2 k⟩ = ((k : ℚ) : ℝ) * realLog u := by
  rw [Rat.cast_intCast]
  cases k with
  | ofNat n =>
      change Real.log (u.1 ^ (Int.ofNat n)) = ((Int.ofNat n : ℤ) : ℝ) * Real.log u.1
      rw [Int.ofNat_eq_natCast, zpow_natCast, Int.cast_natCast]            -- k = n ≥ 0 は自然数冪
      exact realLog_pow u n
  | negSucc n =>
      change Real.log (u.1 ^ (Int.negSucc n)) = ((Int.negSucc n : ℤ) : ℝ) * Real.log u.1
      rw [zpow_negSucc]                                                -- u^{-(n+1)} = (u^{n+1})^{-1}
      have hinv := realLog_inv ⟨u.1 ^ (n + 1), pow_pos u.2 (n + 1)⟩    -- 逆数
      change Real.log (u.1 ^ (n + 1))⁻¹ = -Real.log (u.1 ^ (n + 1)) at hinv
      have hpow := realLog_pow u (n + 1)                               -- 自然数冪
      change Real.log (u.1 ^ (n + 1)) = ((n + 1 : ℕ) : ℝ) * Real.log u.1 at hpow
      rw [hinv, hpow, Int.cast_negSucc]
      push_cast
      ring                                                             -- -(n+1)·x = (-(n+1))·x

end Ising2DLambda.ThermodynamicLimit
