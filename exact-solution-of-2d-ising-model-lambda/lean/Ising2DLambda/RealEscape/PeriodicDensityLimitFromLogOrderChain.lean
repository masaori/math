/-
「周期境界の自由エネルギー密度は分散因子の積分に等しい」（`theorem_periodic_density_onsager_integral`）のうち、
対数順序群の鎖と実数列 `w_L := L^{-2} log_ℝ ι(M^abs_L(q))` の極限 `I` から `f^per(q) = I` を得る段の具体版。

  人手証明                                                         このファイル
  鎖 `log M − 2ℓ₂ ≤_Λ Φ_L(q) ≤_Λ log M + ℓ₂` を `L^{-2}` 倍した埋め込みへ移す
    （`claim_scaled_embedding_order_transfer`）                     `rationalLogOrderLE_scaled_toRational_iff`
  左辺の実現値
    `ρ(L^{-2}·ι(λ)) = L^{-2}·ρ(ι(λ))`（`claim_rational_log_order_group_realization_smul`）
    `= L^{-2}·log_ℝ ι(rat_Λ(λ))`（`claim_log_order_group_realization_real_log`）
                                                                    `realizeRational_scaled_toRational`
    `rat_Λ(log M − 2ℓ₂) = M/4`（`claim_log_additive`、`claim_log_power`）
                                                                    `rationalOfLog_logRat_sub_two_log_two`
    `L^{-2} log_ℝ(M/4) = w_L − 2L^{-2} log_ℝ 2`（実対数の積法則）     `realizeRational_scaled_lower`
  右辺の実現値 `= w_L + L^{-2} log_ℝ 2`（同じ計算）                    `realizeRational_scaled_upper`
  実数の両側評価（`claim_rational_log_order_group_realization_monotone`）
                                                                    `realizeRational_periodicDensitySequence_bounds`
  挟み込み: `w_L → I` と `L^{-2} log_ℝ 2 → 0` から `ρ(Ψ_L(q)) → I`  `tendsto_realizeRational_periodicDensitySequence`
  `f^per(q) = sup ρ(A^per(q)) = I`
    （`def_periodic_free_energy_density_le_one`、`def_periodic_density_lower_set`、
      `claim_sequence_lower_set_sup_eq_real_limit`）                `periodicFreeEnergyDensity_eq_of_logOrderChain`

人手証明の残り（`w_L` を四つのモード和の最大値 `v_L` と同定し、`claim_shifted_mode_riemann_sums` で `v_L → I_q` を得ること、
鎖を `claim_partition_log_order_bounds` から取ること）は、この段の仮定 `hchain`・`hlim` として受け、合成の段で与える。
必要十分版の定理は使わない（`NecSuf.` を参照しない）。
実数体への脱出: 実対数（`log_ℝ`）、実数列の極限（挟み込み）、上限（完備性。`def_periodic_free_energy_density_le_one` で既に宣言済み）。
-/
import Ising2DLambda.KacWard.PartitionLogOrderTransfer
import Ising2DLambda.RealEscape.SequenceLowerSetSupRealLimit
import Ising2DLambda.ThermodynamicLimit.PeriodicFreeEnergyDensity
import Ising2DLambda.ThermodynamicLimit.ScaledEmbeddingOrderTransfer
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupRealizationSmul

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit Ising2DLambda.FreeEntropy Ising2DLambda.KacWard Filter Topology

/-- 列 `L ↦ M^abs_L(q)`（`L = 0` では `1`。極限と下組は `L ≥ 1` しか見ない）。 -/
noncomputable def absMaxSequence (q : ℚ) : ℕ → ℚ :=
  fun L => if h : L = 0 then 1 else
    haveI : NeZero L := ⟨h⟩
    signedEvenSubgraphAbsMax L q

/-- `L ≠ 0` では列の値は `M^abs_L(q)` そのものである。 -/
theorem absMaxSequence_of_ne_zero (q : ℚ) (L : ℕ) [hL : NeZero L] :
    absMaxSequence q L = signedEvenSubgraphAbsMax L q := by
  unfold absMaxSequence
  rw [dif_neg hL.out]

/-- 実数列 `w_L := L^{-2} log_ℝ ι(M^abs_L(q))`。 -/
noncomputable def scaledLogAbsMax (q : ℚ) (L : ℕ) : ℝ :=
  (1 / ((L : ℝ) ^ 2)) * Real.log ((absMaxSequence q L : ℚ) : ℝ)

/-- 実現の二段: `ρ(L^{-2}·ι(λ)) = L^{-2}·ρ(ι(λ)) = L^{-2}·log_ℝ ι(rat_Λ(λ))`。 -/
theorem realizeRational_scaled_toRational (L : ℕ) [NeZero L] (l : LogOrderGroup) :
    realizeRational (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l)
      = (1 / ((L : ℝ) ^ 2)) * Real.log ((rationalOfLog l : ℚ) : ℝ) := by
  calc
    realizeRational (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l)
        = (((1 : ℚ) / ((L : ℚ) ^ 2) : ℚ) : ℝ) * realizeRational (toRational l) :=
          realizeRational_smul _ _                       -- claim_rational_log_order_group_realization_smul
    _ = (((1 : ℚ) / ((L : ℚ) ^ 2) : ℚ) : ℝ) * realLog (rationalOfLogPositiveReal l) := by
          rw [realizeRational_toRational]                 -- claim_log_order_group_realization_real_log
    _ = (1 / ((L : ℝ) ^ 2)) * Real.log ((rationalOfLog l : ℚ) : ℝ) := by
          push_cast; rfl                                  -- ι は四則を保つ、log_ℝ の定義

/-- `rat_Λ(log M − 2ℓ₂) = M/4`（`claim_log_additive`、`claim_log_power`）。 -/
theorem rationalOfLog_logRat_sub_two_log_two {M : ℚ} (hM : 0 < M) :
    rationalOfLog (logRat M - 2 • logRat 2) = M / 4 := by
  have hM4 : 0 < M / 4 := by positivity
  have h : logRat M - 2 • logRat 2 = logRat (M / 4) := by
    calc
      logRat M - 2 • logRat 2 = logRat (M / 4 * 4) - 2 • logRat 2 := by
            rw [div_mul_cancel₀ M (by norm_num : (4 : ℚ) ≠ 0)]   -- ℚ の四則
      _ = logRat (M / 4) + logRat 4 - 2 • logRat 2 := by
            rw [logRat_mul hM4 (by norm_num)]                    -- claim_log_additive
      _ = logRat (M / 4) + 2 • logRat 2 - 2 • logRat 2 := by
            rw [logRat_four]                                     -- claim_log_power
      _ = logRat (M / 4) := add_sub_cancel_right _ _              -- Λ の加法
  rw [h, rationalOfLog_logRat hM4]

/-- `rat_Λ(log M + ℓ₂) = 2M`（`claim_log_additive`）。 -/
theorem rationalOfLog_logRat_add_log_two {M : ℚ} (hM : 0 < M) :
    rationalOfLog (logRat M + logRat 2) = 2 * M := by
  rw [add_comm, ← logRat_mul (by norm_num) hM, rationalOfLog_logRat (by positivity)]

/-- 左辺の実現値: `ρ(L^{-2}·ι(log M − 2ℓ₂)) = w_L − 2L^{-2} log_ℝ 2`。 -/
theorem realizeRational_scaled_lower (L : ℕ) [NeZero L] {M : ℚ} (hM : 0 < M) :
    realizeRational (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat M - 2 • logRat 2))
      = (1 / ((L : ℝ) ^ 2)) * Real.log ((M : ℚ) : ℝ) - 2 * ((1 / ((L : ℝ) ^ 2)) * Real.log 2) := by
  have hMr : (0 : ℝ) < ((M : ℚ) : ℝ) := Rat.cast_pos.mpr hM
  calc
    realizeRational (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat M - 2 • logRat 2))
        = (1 / ((L : ℝ) ^ 2)) * Real.log ((rationalOfLog (logRat M - 2 • logRat 2) : ℚ) : ℝ) :=
          realizeRational_scaled_toRational L _           -- 実現の二段
    _ = (1 / ((L : ℝ) ^ 2)) * Real.log (((M / 4 : ℚ)) : ℝ) := by
          rw [rationalOfLog_logRat_sub_two_log_two hM]    -- rat_Λ(log M − 2ℓ₂) = M/4
    _ = (1 / ((L : ℝ) ^ 2)) * (Real.log ((M : ℚ) : ℝ) - 2 * Real.log 2) := by
          -- 実対数の積法則: log_ℝ(M/4) = log_ℝ M − log_ℝ 4 = log_ℝ M − 2 log_ℝ 2
          rw [Rat.cast_div, Real.log_div (ne_of_gt hMr) (by norm_num)]
          have h4 : ((4 : ℚ) : ℝ) = (2 : ℝ) ^ 2 := by norm_num
          rw [h4, Real.log_pow]
          push_cast; ring
    _ = (1 / ((L : ℝ) ^ 2)) * Real.log ((M : ℚ) : ℝ) - 2 * ((1 / ((L : ℝ) ^ 2)) * Real.log 2) := by
          ring                                            -- ℝ の四則

/-- 右辺の実現値: `ρ(L^{-2}·ι(log M + ℓ₂)) = w_L + L^{-2} log_ℝ 2`。 -/
theorem realizeRational_scaled_upper (L : ℕ) [NeZero L] {M : ℚ} (hM : 0 < M) :
    realizeRational (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat M + logRat 2))
      = (1 / ((L : ℝ) ^ 2)) * Real.log ((M : ℚ) : ℝ) + (1 / ((L : ℝ) ^ 2)) * Real.log 2 := by
  have hMr : (0 : ℝ) < ((M : ℚ) : ℝ) := Rat.cast_pos.mpr hM
  calc
    realizeRational (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat M + logRat 2))
        = (1 / ((L : ℝ) ^ 2)) * Real.log ((rationalOfLog (logRat M + logRat 2) : ℚ) : ℝ) :=
          realizeRational_scaled_toRational L _           -- 実現の二段
    _ = (1 / ((L : ℝ) ^ 2)) * Real.log (((2 * M : ℚ)) : ℝ) := by
          rw [rationalOfLog_logRat_add_log_two hM]        -- rat_Λ(log M + ℓ₂) = 2M
    _ = (1 / ((L : ℝ) ^ 2)) * (Real.log 2 + Real.log ((M : ℚ) : ℝ)) := by
          -- 実対数の積法則
          rw [Rat.cast_mul, Real.log_mul (by norm_num) (ne_of_gt hMr)]
          push_cast; ring
    _ = (1 / ((L : ℝ) ^ 2)) * Real.log ((M : ℚ) : ℝ) + (1 / ((L : ℝ) ^ 2)) * Real.log 2 := by
          ring                                            -- ℝ の四則

/-- 実数の両側評価: `w_L − 2L^{-2} log_ℝ 2 ≤ ρ(Ψ_L(q)) ≤ w_L + L^{-2} log_ℝ 2`。 -/
theorem realizeRational_periodicDensitySequence_bounds (q : ℚ) (L : ℕ) [NeZero L]
    (hM : 0 < signedEvenSubgraphAbsMax L q)
    (hchain : logOrderLE (logRat (signedEvenSubgraphAbsMax L q) - 2 • logRat 2) (freeEntropy L q) ∧
      logOrderLE (freeEntropy L q) (logRat (signedEvenSubgraphAbsMax L q) + logRat 2)) :
    scaledLogAbsMax q L - 2 * ((1 / ((L : ℝ) ^ 2)) * Real.log 2)
        ≤ realizeRational (periodicDensitySequence q L) ∧
      realizeRational (periodicDensitySequence q L)
        ≤ scaledLogAbsMax q L + (1 / ((L : ℝ) ^ 2)) * Real.log 2 := by
  -- 鎖を L^{-2} 倍した埋め込みへ移す（claim_scaled_embedding_order_transfer）
  have hlow := (rationalLogOrderLE_scaled_toRational_iff L _ _).2 hchain.1
  have hup := (rationalLogOrderLE_scaled_toRational_iff L _ _).2 hchain.2
  -- 列の値は Ψ_L(q)（def_finite_free_entropy_density）、w_L の M は M^abs_L(q)
  rw [periodicDensitySequence_of_ne_zero]
  unfold scaledLogAbsMax
  rw [absMaxSequence_of_ne_zero]
  constructor
  · -- 実現写像の単調性（claim_rational_log_order_group_realization_monotone）と左辺の実現値
    rw [← realizeRational_scaled_lower L hM]
    exact realizeRational_le_of_rationalLogOrderLE _ _ hlow
  · -- 同じく右辺の実現値
    rw [← realizeRational_scaled_upper L hM]
    exact realizeRational_le_of_rationalLogOrderLE _ _ hup

/-- `L^{-2} log_ℝ 2 → 0`（実数体への脱出: 連続極限）。 -/
theorem tendsto_inv_sq_mul_log_two :
    Tendsto (fun L : ℕ => (1 / ((L : ℝ) ^ 2)) * Real.log 2) atTop (𝓝 0) := by
  have h0 : Tendsto (fun L : ℕ => 1 / (L : ℝ)) atTop (𝓝 (0 : ℝ)) :=
    tendsto_one_div_atTop_nhds_zero_nat
  have h1 : Tendsto (fun L : ℕ => (1 / (L : ℝ)) ^ 2) atTop (𝓝 (0 : ℝ)) := by
    have h := h0.pow 2
    rwa [zero_pow two_ne_zero] at h
  have h2 : Tendsto (fun L : ℕ => (1 / (L : ℝ)) ^ 2 * Real.log 2) atTop (𝓝 (0 : ℝ)) := by
    have h := h1.mul_const (Real.log 2)
    rwa [zero_mul] at h
  refine h2.congr fun L => ?_
  rw [one_div_pow]

/-- 挟み込み: `w_L → I` なら `ρ(Ψ_L(q)) → I`。 -/
theorem tendsto_realizeRational_periodicDensitySequence (q : ℚ) (I : ℝ)
    (hM : ∀ (L : ℕ) [NeZero L], 0 < signedEvenSubgraphAbsMax L q)
    (hchain : ∀ (L : ℕ) [NeZero L],
      logOrderLE (logRat (signedEvenSubgraphAbsMax L q) - 2 • logRat 2) (freeEntropy L q) ∧
        logOrderLE (freeEntropy L q) (logRat (signedEvenSubgraphAbsMax L q) + logRat 2))
    (hlim : Tendsto (scaledLogAbsMax q) atTop (𝓝 I)) :
    Tendsto (fun L => realizeRational (periodicDensitySequence q L)) atTop (𝓝 I) := by
  have he := tendsto_inv_sq_mul_log_two
  -- 下の列 w_L − 2·(L^{-2} log_ℝ 2) → I − 2·0 = I
  have hlower : Tendsto (fun L => scaledLogAbsMax q L - 2 * ((1 / ((L : ℝ) ^ 2)) * Real.log 2))
      atTop (𝓝 I) := by
    simpa using hlim.sub (he.const_mul 2)
  -- 上の列 w_L + L^{-2} log_ℝ 2 → I + 0 = I
  have hupper : Tendsto (fun L => scaledLogAbsMax q L + (1 / ((L : ℝ) ^ 2)) * Real.log 2)
      atTop (𝓝 I) := by
    simpa using hlim.add he
  -- L ≥ 1 で両側評価が成り立つ
  have hb : ∀ᶠ L : ℕ in atTop,
      (scaledLogAbsMax q L - 2 * ((1 / ((L : ℝ) ^ 2)) * Real.log 2)
          ≤ realizeRational (periodicDensitySequence q L)) ∧
        (realizeRational (periodicDensitySequence q L)
          ≤ scaledLogAbsMax q L + (1 / ((L : ℝ) ^ 2)) * Real.log 2) := by
    refine eventually_atTop.2 ⟨1, fun L hL => ?_⟩
    haveI : NeZero L := ⟨by omega⟩
    exact realizeRational_periodicDensitySequence_bounds q L (hM L) (hchain L)
  exact tendsto_of_tendsto_of_tendsto_of_le_of_le' hlower hupper
    (hb.mono fun _ h => h.1) (hb.mono fun _ h => h.2)

/-- この段の主張: 鎖と `w_L → I` から `f^per(q) = I`。 -/
theorem periodicFreeEnergyDensity_eq_of_logOrderChain (q : ℚ) (I : ℝ)
    (hM : ∀ (L : ℕ) [NeZero L], 0 < signedEvenSubgraphAbsMax L q)
    (hchain : ∀ (L : ℕ) [NeZero L],
      logOrderLE (logRat (signedEvenSubgraphAbsMax L q) - 2 • logRat 2) (freeEntropy L q) ∧
        logOrderLE (freeEntropy L q) (logRat (signedEvenSubgraphAbsMax L q) + logRat 2))
    (hlim : Tendsto (scaledLogAbsMax q) atTop (𝓝 I)) :
    periodicFreeEnergyDensity q = I := by
  -- f^per(q) = sup ρ(A^per(q))（def_periodic_free_energy_density_le_one）、
  -- A^per(q) = A((Ψ_L(q))_L)（def_periodic_density_lower_set）
  show sSup (realizeRational '' rationalLogOrderSequenceLowerSet (periodicDensitySequence q)) = I
  -- claim_sequence_lower_set_sup_eq_real_limit
  exact (sequence_lowerSet_sup_eq_realLimit _ I
    (tendsto_realizeRational_periodicDensitySequence q I hM hchain hlim)).2.2

end Ising2DLambda.RealEscape
