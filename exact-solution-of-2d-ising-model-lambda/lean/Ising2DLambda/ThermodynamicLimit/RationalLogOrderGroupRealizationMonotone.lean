/-
章「熱力学極限」の「有理係数の対数順序群の実現写像は順序を保つ（実数体への脱出: 実対数）」
（`claim_rational_log_order_group_realization_monotone`）の具体版。

  人手証明                                                          このファイル
  準備: 0 < ι_{ℚ→ℝ}(N)（N ≥ 1、ι は順序を保ち単射）                    `natCast_real_pos`
  λ ≤_{Λ_ℚ} μ の証人 N, λ_N, μ_N を取る                                `obtain ⟨N, lN, mN, hN, hl, hm, hle⟩`
  含意の鎖 λ_N ≤_Λ μ_N ⟹ … ⟹ ι(N)·ρ_ℝ(λ) ≤ ι(N)·ρ_ℝ(μ)               `h1` … `h6`
    rat_Λ(λ_N) ≤ rat_Λ(μ_N)（Λ の順序の定義）                           `h1`（`logOrderLE` の定義そのもの）
    ι は順序を保つ                                                     `h2`（`Rat.cast_le`）
    u ≤ v ⇒ log_ℝ(u) ≤ log_ℝ(v)                                        `h3`（`realLog_le_realLog`）
    Λ の元の実現は rat_Λ の実対数（両辺を右から左へ）                     `h4`（`realizeRational_toRational`）
    N·λ = ι(λ_N)、N·μ = ι(μ_N)（共通分母の定義）                        `h5`（`IsCommonDenominator`）
    実現写像は有理数倍と可換（r := N）                                  `h6`（`realizeRational_smul`）
  最後の一続き三段 ρ_ℝ(λ) = ι(N)⁻¹(ι(N)ρ_ℝ(λ)) ≤ ι(N)⁻¹(ι(N)ρ_ℝ(μ)) = ρ_ℝ(μ)  `calc`
    （結合則・ι(N)⁻¹ι(N) = 1・1·t = t、正の元を左から掛けても順序が保たれる）
実対数について使うのは単調性 `realLog_le_realLog` だけで、完備性は使わない。
-/
import Ising2DLambda.ThermodynamicLimit.LogOrderGroupRealizationRealLog
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupRealizationSmul
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupOrder

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備: `N ≥ 1` なら `0 < ι_{ℚ→ℝ}(N)`。`0 < N` は ℚ の順序、`ι` が順序を保ち単射であることは `Rat.cast_pos`。 -/
theorem natCast_real_pos (N : ℕ) (hN : 1 ≤ N) : (0 : ℝ) < ((N : ℚ) : ℝ) := by
  have h : (0 : ℚ) < (N : ℚ) := by exact_mod_cast hN
  exact Rat.cast_pos.mpr h

/-- `claim_rational_log_order_group_realization_monotone`:
`λ ≤_{Λ_ℚ} μ ⇒ ρ_ℝ(λ) ≤ ρ_ℝ(μ)`。 -/
theorem realizeRational_le_of_rationalLogOrderLE (l m : RationalLogOrderGroup)
    (h : rationalLogOrderLE l m) : realizeRational l ≤ realizeRational m := by
  -- 証人 N ≥ 1、λ_N、μ_N を取る（def_rational_log_order_group_order）
  obtain ⟨N, lN, mN, hN, hl, hm, hle⟩ := h
  -- rat_Λ(λ_N) ≤ rat_Λ(μ_N)（def_log_order_group_order）
  have h1 : rationalOfLog lN ≤ rationalOfLog mN := hle
  -- ι は順序を保つ
  have h2 : ((rationalOfLog lN : ℚ) : ℝ) ≤ ((rationalOfLog mN : ℚ) : ℝ) := Rat.cast_le.mpr h1
  -- 実対数の単調性
  have h3 : realLog (rationalOfLogPositiveReal lN) ≤ realLog (rationalOfLogPositiveReal mN) :=
    realLog_le_realLog _ _ h2
  -- Λ の元の実現は rat_Λ の実対数（両辺を右から左へ書き換える）
  have h4 : realizeRational (toRational lN) ≤ realizeRational (toRational mN) := by
    rw [realizeRational_toRational, realizeRational_toRational]
    exact h3
  -- N·λ = ι(λ_N)、N·μ = ι(μ_N)（def_common_denominator）
  have h5 : realizeRational ((N : ℚ) • l) ≤ realizeRational ((N : ℚ) • m) := by
    unfold IsCommonDenominator at hl hm
    rw [hl, hm]
    exact h4
  -- 実現写像は有理数倍と可換（r := N）
  have h6 : ((N : ℚ) : ℝ) * realizeRational l ≤ ((N : ℚ) : ℝ) * realizeRational m := by
    rw [realizeRational_smul, realizeRational_smul] at h5
    exact h5
  -- 最後に ι(N) を外す
  have hpos : (0 : ℝ) < ((N : ℚ) : ℝ) := natCast_real_pos N hN
  have hinv : (0 : ℝ) < (((N : ℚ) : ℝ))⁻¹ := inv_pos.mpr hpos     -- 正の元の逆元は正
  calc
    realizeRational l
        = (((N : ℚ) : ℝ))⁻¹ * (((N : ℚ) : ℝ) * realizeRational l) := by
          rw [← mul_assoc, inv_mul_cancel₀ (ne_of_gt hpos), one_mul]  -- 結合則・ι(N)⁻¹ι(N)=1・1·t=t
    _ ≤ (((N : ℚ) : ℝ))⁻¹ * (((N : ℚ) : ℝ) * realizeRational m) :=
          mul_le_mul_of_nonneg_left h6 (le_of_lt hinv)                 -- 正の元を左から掛ける
    _ = realizeRational m := by
          rw [← mul_assoc, inv_mul_cancel₀ (ne_of_gt hpos), one_mul]  -- 結合則・ι(N)⁻¹ι(N)=1・1·t=t

end Ising2DLambda.ThermodynamicLimit
