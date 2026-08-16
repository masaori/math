/-
章「熱力学極限」の「有理係数の対数順序群の Archimedes 性」（`claim_rational_log_order_group_archimedean`）の
具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                                          このファイル
  準備の第一: N は 0 の共通分母で証人は 0（各素数での五段の鎖）           `commonDenominator_zero`
             N は n·ε の共通分母で証人は nε_N（五段の鎖）                 `commonDenominator_natSmul`
  準備の第二: 0 ≤_{Λ_ℚ} μ から 0 ≤_Λ μ_N、すなわち 1 ≤ rat_Λ(μ_N)       `one_le_rationalOfLog_witness_of_nonneg`
  準備の第三: ε_N ≠ 0（九段の鎖で ε = 0 を導いて矛盾）、反対称性で
             ¬(ε_N ≤_Λ 0)、全順序で 1 < rat_Λ(ε_N)                    `one_lt_rationalOfLog_witness_of_pos`
  準備の第四: r := (A−1)/h ≥ 0、n := num(r) ∈ ℕ、r ≤ n、
             A − 1 = r h = (num/den) h ≤ num·h = n h（四段）            `rat_le_num_toNat`、`archimedeanMultiplier`、
                                                                     `le_archimedeanMultiplier_mul`
  本体:      rat_Λ(μ_N) = A = 1+(A−1) ≤ 1+nh ≤ (1+h)^n
             = rat_Λ(ε_N)^n = rat_Λ(nε_N)（五段）、μ_N ≤_Λ nε_N、
             N は μ と n·ε の両方の共通分母なので μ ≤_{Λ_ℚ} n·ε         `rationalLogOrderLE_natSmul_of_pos`

住処は ℕ・ℤ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupOrder
import Ising2DLambda.ThermodynamicLimit.RationalBernoulliInequality
import Ising2DLambda.FreeEntropy.LogOrderGroupPositiveMultipleInvariant

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `rat_Λ(0) = 1`（`def_rational_of_log` の空積）。 -/
theorem rationalOfLog_zero : rationalOfLog (0 : LogOrderGroup) = 1 :=
  Finsupp.prod_zero_index

/-- 準備の第一: 任意の `N` は零写像 `0 ∈ Λ_ℚ` の共通分母で、その証人は零写像 `0 ∈ Λ`
（各素数での五段の鎖）。 -/
theorem commonDenominator_zero (N : ℕ) :
    IsCommonDenominator N (0 : RationalLogOrderGroup) 0 := by
  unfold IsCommonDenominator
  ext p
  calc
    (((N : ℚ)) • (0 : RationalLogOrderGroup)) p
        = (N : ℚ) * (0 : RationalLogOrderGroup) p := Finsupp.smul_apply _ _ _  -- 有理数倍の定義
    _ = (N : ℚ) * 0 := by rw [Finsupp.zero_apply]                              -- 零写像の値
    _ = 0 := mul_zero _                                                         -- ℚ の積。0 倍は 0
    _ = ((0 : ℤ) : ℚ) := Int.cast_zero.symm                                    -- 分母 1 の有理数
    _ = toRational (0 : LogOrderGroup) p := by
          rw [toRational_apply, Finsupp.zero_apply]                            -- ι の定義と零写像の値

/-- 準備の第一: `N` が `ε` の共通分母（証人 `ε_N`）なら、`N` は `n·ε` の共通分母で証人は `nε_N`
（五段の鎖）。 -/
theorem commonDenominator_natSmul (N n : ℕ) (ε : RationalLogOrderGroup) (εN : LogOrderGroup)
    (h : IsCommonDenominator N ε εN) :
    IsCommonDenominator N (((n : ℚ)) • ε) (((n : ℤ)) • εN) := by
  unfold IsCommonDenominator at h ⊢
  have hι : ((n : ℚ)) • toRational εN = toRational (((n : ℤ)) • εN) := by
    have := toRational_intSmul (n : ℤ) εN
    rwa [Int.cast_natCast] at this
  calc
    ((N : ℚ)) • (((n : ℚ)) • ε)
        = (((N : ℚ)) * (n : ℚ)) • ε := smul_smul _ _ _                 -- 有理数倍の結合則
    _ = (((n : ℚ)) * (N : ℚ)) • ε := by rw [mul_comm]                  -- ℚ の積の可換性
    _ = ((n : ℚ)) • (((N : ℚ)) • ε) := (smul_smul _ _ _).symm          -- 有理数倍の結合則
    _ = ((n : ℚ)) • toRational εN := by rw [h]                          -- N は ε の共通分母
    _ = toRational (((n : ℤ)) • εN) := hι                               -- ι は整数倍と交換する

/-- 準備の第二: `0 ≤_{Λ_ℚ} μ` を共通分母 `N` で読み `0 ≤_Λ μ_N`、すなわち `1 ≤ rat_Λ(μ_N)`。 -/
theorem one_le_rationalOfLog_witness_of_nonneg (N : ℕ) (hN : 1 ≤ N)
    (μ : RationalLogOrderGroup) (μN : LogOrderGroup)
    (hμ : IsCommonDenominator N μ μN) (h0 : rationalLogOrderLE 0 μ) :
    1 ≤ rationalOfLog μN := by
  -- 「すべての共通分母」形で N において読む（0 の証人は 0）
  have h : logOrderLE 0 μN :=
    (rationalLogOrderLE_iff_forall 0 μ).mp h0 N 0 μN hN (commonDenominator_zero N) hμ
  unfold logOrderLE at h
  rwa [rationalOfLog_zero] at h

/-- 準備の第三: `0 ≤_{Λ_ℚ} ε`、`ε ≠ 0` から `1 < rat_Λ(ε_N)`。 -/
theorem one_lt_rationalOfLog_witness_of_pos (N : ℕ) (hN : 1 ≤ N)
    (ε : RationalLogOrderGroup) (εN : LogOrderGroup)
    (hε : IsCommonDenominator N ε εN) (h0 : rationalLogOrderLE 0 ε) (hne : ε ≠ 0) :
    1 < rationalOfLog εN := by
  -- ε_N ≠ 0: ε_N = 0 と仮定すると九段の鎖で ε = 0
  have hεN : εN ≠ 0 := by
    intro hz
    apply hne
    have hN0 : (N : ℚ) ≠ 0 := by exact_mod_cast (Nat.one_le_iff_ne_zero.mp hN)
    have hε' : ((N : ℚ)) • ε = toRational εN := hε
    have h00 : ((N : ℚ)) • (0 : RationalLogOrderGroup) = toRational (0 : LogOrderGroup) :=
      commonDenominator_zero N
    calc
      ε = (1 : ℚ) • ε := (one_smul _ _).symm                              -- 1·λ = λ
      _ = ((1 / (N : ℚ)) * (N : ℚ)) • ε := by rw [one_div_mul_cancel hN0]  -- N ≠ 0、ℚ の約分
      _ = (1 / (N : ℚ)) • (((N : ℚ)) • ε) := (smul_smul _ _ _).symm         -- 有理数倍の結合則
      _ = (1 / (N : ℚ)) • toRational εN := by rw [hε']                      -- N は ε の共通分母
      _ = (1 / (N : ℚ)) • toRational (0 : LogOrderGroup) := by rw [hz]      -- 仮定 ε_N = 0
      _ = (1 / (N : ℚ)) • (((N : ℚ)) • (0 : RationalLogOrderGroup)) := by
            rw [h00]                                                       -- 準備の第一 N·0 = ι(0)
      _ = ((1 / (N : ℚ)) * (N : ℚ)) • (0 : RationalLogOrderGroup) :=
            smul_smul _ _ _                                                -- 有理数倍の結合則
      _ = (1 : ℚ) • (0 : RationalLogOrderGroup) := by rw [one_div_mul_cancel hN0]  -- ℚ の約分
      _ = 0 := one_smul _ _                                                -- 1·λ = λ
  -- 0 ≤_Λ ε_N（準備の第二と同じ読み方）
  have hle : logOrderLE 0 εN :=
    (rationalLogOrderLE_iff_forall 0 ε).mp h0 N 0 εN hN (commonDenominator_zero N) hε
  -- ¬(ε_N ≤_Λ 0)（反対称性）
  have hnot : ¬ logOrderLE εN 0 := fun hle' => hεN (logOrderLE_antisymm hle' hle)
  unfold logOrderLE at hnot
  rw [rationalOfLog_zero] at hnot
  -- ℚ の順序は全順序
  exact not_le.mp hnot

/-- 準備の第四: `0 ≤ r` なる有理数は自分の分子（自然数として読む）以下である。
`r = num(r)/den(r)`、`0 ≤ num(r)`、`1 ≤ den(r)`。 -/
theorem rat_le_num_toNat (r : ℚ) (hr : 0 ≤ r) : r ≤ ((r.num.toNat : ℕ) : ℚ) := by
  have hnum : 0 ≤ r.num := Rat.num_nonneg.mpr hr
  have hden : (1 : ℚ) ≤ (r.den : ℚ) := by exact_mod_cast r.den_pos
  have hcast : ((r.num.toNat : ℕ) : ℚ) = (r.num : ℚ) := by
    rw [← Int.cast_natCast, Int.toNat_of_nonneg hnum]
  calc
    r = (r.num : ℚ) / (r.den : ℚ) := (Rat.num_div_den r).symm      -- 既約分数表示
    _ ≤ (r.num : ℚ) := div_le_self (by exact_mod_cast hnum) hden   -- 非負元を 1 以上で割ると小さくなる
    _ = ((r.num.toNat : ℕ) : ℚ) := hcast.symm                      -- 非負の整数を自然数として読む

/-- 準備の第四: `n := num((A−1)/h)`。 -/
noncomputable def archimedeanMultiplier (A h : ℚ) : ℕ := ((A - 1) / h).num.toNat

/-- 準備の第四: `A − 1 = r h ≤ n h`（`r := (A−1)/h`）。 -/
theorem le_archimedeanMultiplier_mul (A h : ℚ) (hA : 1 ≤ A) (hh : 0 < h) :
    A - 1 ≤ ((archimedeanMultiplier A h : ℕ) : ℚ) * h := by
  have hr : 0 ≤ (A - 1) / h := div_nonneg (by linarith) hh.le
  calc
    A - 1 = ((A - 1) / h) * h := (div_mul_cancel₀ (A - 1) hh.ne').symm    -- r h = A − 1（ℚ の四則）
    _ ≤ ((archimedeanMultiplier A h : ℕ) : ℚ) * h :=
          mul_le_mul_of_nonneg_right (rat_le_num_toNat _ hr) hh.le           -- r ≤ n に 0 < h を掛ける

/-- `claim_rational_log_order_group_archimedean`。`0 ≤_{Λ_ℚ} μ`、`0 ≤_{Λ_ℚ} ε`、`ε ≠ 0` なら
`μ ≤_{Λ_ℚ} n·ε` となる `n ∈ ℕ` がある（`n` は `archimedeanMultiplier` で明示）。 -/
theorem rationalLogOrderLE_natSmul_of_pos (μ ε : RationalLogOrderGroup)
    (hμ : rationalLogOrderLE 0 μ) (hε : rationalLogOrderLE 0 ε) (hne : ε ≠ 0) :
    ∃ n : ℕ, rationalLogOrderLE μ (((n : ℚ)) • ε) := by
  -- 準備の第一: N := N_μ N_ε、証人 μ_N, ε_N
  obtain ⟨hμN, hεN⟩ := commonCommonDenominator_exists μ ε
  have hN : 1 ≤ denominatorProduct μ * denominatorProduct ε :=
    Nat.one_le_iff_ne_zero.mpr
      (Nat.mul_ne_zero (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos μ))
        (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos ε)))
  generalize hμw : ((denominatorProduct ε : ℤ)) • commonDenominatorWitness μ = μN at hμN
  generalize hεw : ((denominatorProduct μ : ℤ)) • commonDenominatorWitness ε = εN at hεN
  generalize hNw : denominatorProduct μ * denominatorProduct ε = N at hμN hεN hN
  -- 準備の第二・第三
  have hA : 1 ≤ rationalOfLog μN := one_le_rationalOfLog_witness_of_nonneg N hN μ μN hμN hμ
  have hB : 1 < rationalOfLog εN := one_lt_rationalOfLog_witness_of_pos N hN ε εN hεN hε hne
  have hh : 0 < rationalOfLog εN - 1 := by linarith
  -- 準備の第四: n := num((A−1)/h)
  refine ⟨archimedeanMultiplier (rationalOfLog μN) (rationalOfLog εN - 1), ?_⟩
  generalize hnw : archimedeanMultiplier (rationalOfLog μN) (rationalOfLog εN - 1) = n
  have hn : rationalOfLog μN - 1 ≤ (n : ℚ) * (rationalOfLog εN - 1) := by
    rw [← hnw]; exact le_archimedeanMultiplier_mul _ _ hA hh
  -- 本体: Λ の証人の値の比較（五段の鎖）
  have hchain : logOrderLE μN (((n : ℤ)) • εN) := by
    unfold logOrderLE
    calc
      rationalOfLog μN
          = 1 + (rationalOfLog μN - 1) := by ring                                  -- ℚ の四則
      _ ≤ 1 + (n : ℚ) * (rationalOfLog εN - 1) := by linarith [hn]               -- 準備の第四。加法単調性
      _ ≤ (1 + (rationalOfLog εN - 1)) ^ n :=
            one_add_nsmul_le_one_add_pow_rat _ hh.le n                             -- Bernoulli 不等式
      _ = (rationalOfLog εN) ^ n := by rw [add_sub_cancel]                         -- 1 + h = rat_Λ(ε_N)
      _ = rationalOfLog (((n : ℤ)) • εN) := by
            rw [natCast_zsmul, rationalOfLog_natSmul]                              -- 正整数倍は冪へ
  -- N は μ と n·ε の両方の共通分母（証人 μ_N, nε_N）で証人が ≤_Λ を満たす
  exact ⟨N, μN, ((n : ℤ)) • εN, hN, hμN, commonDenominator_natSmul N n ε εN hεN, hchain⟩

end Ising2DLambda.ThermodynamicLimit
