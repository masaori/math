/-
「周期境界の自由エネルギー密度は分散因子の積分に等しい」（`theorem_periodic_density_onsager_integral`）のうち、
四つのモード和 `u_{L,a,b}` の最大値 `v_L` を `w_L := L^{-2} log_ℝ ι(M^abs_L(q))` と同定し、
四つの列の共通極限から `w_L → I` と `f^per(q) = I` を得る段の具体版。

  人手証明                                                         このファイル
  `u_{L,a,b} := L^{-2} log_ℝ |ρ_{R→ℝ}(Q^{a,b}_L(q))|`              `modeLogDensity`
  `v_L := max_{(a,b)∈𝒮} u_{L,a,b}`                                 `modeLogMax`
  被対数は正: `q² + 2q − 1 ≠ 0`（`claim_no_rational_square_two`）と
    四つの符号（`claim_signed_even_subgraph_rational_sign`）から `Q^{a,b}_L(q) ≠ 0`
                                                                    `signedEvenSubgraphValue_ne_zero`
    `M^abs_L(q) ≥ |Q^{0,0}_L(q)| > 0`                                `signedEvenSubgraphAbsMax_pos`
  `ρ_{R→ℝ}(Q^{a,b}_L(q)) = ι(Q^{a,b}_L(q))`（`claim_cut_realization_agrees_on_rationals`）
                                                                    `modeLogDensity_eq`
  `v_L = L^{-2} log_ℝ max |ρ(Q^{a,b}_L(q))|`（`L^{-2} > 0`、実対数の単調性）
    `= L^{-2} log_ℝ M^abs_L(q)`（`claim_partition_log_order_bounds` の最大値の定義）
                                                                    `modeLogMax_eq_scaledLogAbsMax`
  有限集合上の最大値は各成分の共通極限へ収束する                       `tendsto_modeLogMax`
  `w_L = v_L → I`                                                   `tendsto_scaledLogAbsMax_of_modeLimits`
  前の段（鎖と `w_L → I` から `f^per(q) = I`）を当てる                `periodicFreeEnergyDensity_eq_of_modeLimits`

人手証明の残り（四つの列 `u_{L,a,b}` が `I_q` に収束すること＝`claim_shifted_mode_riemann_sums`、
鎖を `claim_partition_log_order_bounds` から取ること）は、この段の仮定 `hmode`・`hchain` として受け、合成の段で与える。
必要十分版の定理は使わない（`NecSuf.` を参照しない）。
実数体への脱出: 実現写像 `ρ_{R→ℝ}`（下切断の上限）、実対数（`log_ℝ`）、実数列の極限。
-/
import Ising2DLambda.RealEscape.PeriodicDensityLimitFromLogOrderChain
import Ising2DLambda.RealEscape.CutRealizationAgreesOnRationals
import Ising2DLambda.KacWard.SignedEvenSubgraphRationalSign
import Ising2DLambda.FisherZero.NoRationalSquareTwo

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit Ising2DLambda.FreeEntropy Ising2DLambda.KacWard
open Ising2DLambda.FisherZero Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.CriticalExponent
open Filter Topology

/-- `u_{L,a,b} := L^{-2} log_ℝ |ρ_{R→ℝ}(Q^{a,b}_L(q))|`（`L = 0` では `0`。極限は `L ≥ 1` しか見ない）。 -/
noncomputable def modeLogDensity (data : RealClosedSubfieldData) (q : ℚ) (s : SpinStructure)
    (L : ℕ) : ℝ :=
  if h : L = 0 then 0 else
    haveI : NeZero L := ⟨h⟩
    (1 / ((L : ℝ) ^ 2)) *
      Real.log |realAlgebraicCutRealization data (realClosedRat data (signedEvenSubgraphValue L q s))|

/-- `v_L := max_{(a,b)∈𝒮} u_{L,a,b}`。 -/
noncomputable def modeLogMax (data : RealClosedSubfieldData) (q : ℚ) (L : ℕ) : ℝ :=
  Finset.univ.sup' spinStructure_univ_nonempty (fun s => modeLogDensity data q s L)

/-- `0 < q < 1` なら四つの `Q^{a,b}_L(q)` はどれも零でない
（`claim_no_rational_square_two` による `q² + 2q − 1 ≠ 0` と `claim_signed_even_subgraph_rational_sign`）。 -/
theorem signedEvenSubgraphValue_ne_zero (data : RealClosedSubfieldData) {L : ℕ} [NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (s : SpinStructure) :
    signedEvenSubgraphValue L q s ≠ 0 := by
  have hsign := signedEvenSubgraphPolynomial_rational_sign (L := L) data z hz4 s q hq0 hq1
  -- `claim_no_rational_square_two` を `q + 1` に当てて `q² + 2q − 1 ≠ 0`
  have hp : q ^ 2 + 2 * q - 1 ≠ 0 := by
    intro hp
    apply noRationalSquareTwo (q + 1)
    calc (q + 1) * (q + 1) = q ^ 2 + 2 * q + 1 := by ring
      _ = (q ^ 2 + 2 * q - 1) + 2 := by ring
      _ = 2 := by rw [hp]; ring
  rcases lt_or_gt_of_ne hp with hc | hc
  · -- `q² + 2q − 1 < 0`: 四つとも正
    exact ne_of_gt (hsign.1 hc)
  · -- `q² + 2q − 1 > 0`: `(0,0)` だけ負、残りは正
    by_cases hs : s = (false, false)
    · exact ne_of_lt ((hsign.2 hc).1 hs)
    · exact ne_of_gt ((hsign.2 hc).2 hs)

/-- `M^abs_L(q) > 0`（`M^abs_L(q) ≥ |Q^{0,0}_L(q)| > 0`）。 -/
theorem signedEvenSubgraphAbsMax_pos (data : RealClosedSubfieldData) {L : ℕ} [NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    0 < signedEvenSubgraphAbsMax L q := by
  have h00 : 0 < |signedEvenSubgraphValue L q (false, false)| :=
    abs_pos.mpr (signedEvenSubgraphValue_ne_zero data z hz4 q hq0 hq1 _)
  exact lt_of_lt_of_le h00
    (Finset.le_sup' (fun s => |signedEvenSubgraphValue L q s|) (Finset.mem_univ _))

/-- `u_{L,a,b} = L^{-2} log_ℝ ι(|Q^{a,b}_L(q)|)`（`claim_cut_realization_agrees_on_rationals`）。 -/
theorem modeLogDensity_eq (data : RealClosedSubfieldData) (q : ℚ) (s : SpinStructure) (L : ℕ)
    [hL : NeZero L] :
    modeLogDensity data q s L
      = (1 / ((L : ℝ) ^ 2)) * Real.log ((|signedEvenSubgraphValue L q s| : ℚ) : ℝ) := by
  unfold modeLogDensity
  rw [dif_neg hL.out]
  -- ρ_{R→ℝ}(Q(q)) = ι(Q(q))、|ι(x)| = ι(|x|)
  rw [cutRealization_agrees_on_rationals data, Rat.cast_abs]

/-- `v_L = w_L`: 最大値と実対数の入れ替え（`L^{-2} > 0`、実対数の単調性、被対数は正）。 -/
theorem modeLogMax_eq_scaledLogAbsMax (data : RealClosedSubfieldData) {L : ℕ} [hL : NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    modeLogMax data q L = scaledLogAbsMax q L := by
  have hw : scaledLogAbsMax q L
      = (1 / ((L : ℝ) ^ 2)) * Real.log ((signedEvenSubgraphAbsMax L q : ℚ) : ℝ) := by
    unfold scaledLogAbsMax
    rw [absMaxSequence_of_ne_zero]
  have hc : (0 : ℝ) ≤ 1 / ((L : ℝ) ^ 2) := by positivity
  apply le_antisymm
  · -- 各 u_{L,a,b} ≤ w_L: |Q^{a,b}_L(q)| ≤ M^abs_L(q) と実対数の単調性
    refine Finset.sup'_le _ _ (fun s _ => ?_)
    rw [modeLogDensity_eq, hw]
    have hpos : (0 : ℝ) < ((|signedEvenSubgraphValue L q s| : ℚ) : ℝ) :=
      Rat.cast_pos.mpr (abs_pos.mpr (signedEvenSubgraphValue_ne_zero data z hz4 q hq0 hq1 s))
    have hle : ((|signedEvenSubgraphValue L q s| : ℚ) : ℝ) ≤ ((signedEvenSubgraphAbsMax L q : ℚ) : ℝ) :=
      Rat.cast_le.mpr
        (Finset.le_sup' (fun s => |signedEvenSubgraphValue L q s|) (Finset.mem_univ s))
    exact mul_le_mul_of_nonneg_left (Real.log_le_log hpos hle) hc
  · -- M^abs_L(q) は四つのうち一つの値 |Q^{s₀}_L(q)| なので w_L = u_{L,s₀} ≤ v_L
    obtain ⟨s₀, -, hs₀⟩ := Finset.exists_mem_eq_sup' spinStructure_univ_nonempty
      (fun s => |signedEvenSubgraphValue L q s|)
    have hM : signedEvenSubgraphAbsMax L q = |signedEvenSubgraphValue L q s₀| := hs₀
    calc scaledLogAbsMax q L
        = (1 / ((L : ℝ) ^ 2)) * Real.log ((|signedEvenSubgraphValue L q s₀| : ℚ) : ℝ) := by
          rw [hw, hM]
      _ = modeLogDensity data q s₀ L := (modeLogDensity_eq data q s₀ L).symm
      _ ≤ modeLogMax data q L :=
          Finset.le_sup' (fun s => modeLogDensity data q s L) (Finset.mem_univ s₀)

/-- 有限集合上の最大値は各成分の共通極限へ収束する: 四つの `u_{L,a,b} → I` なら `v_L → I`。 -/
theorem tendsto_modeLogMax (data : RealClosedSubfieldData) (q : ℚ) (I : ℝ)
    (hmode : ∀ s : SpinStructure, Tendsto (modeLogDensity data q s) atTop (𝓝 I)) :
    Tendsto (modeLogMax data q) atTop (𝓝 I) := by
  have h := Tendsto.finset_sup'_nhds_apply (s := (Finset.univ : Finset SpinStructure))
    (f := fun s L => modeLogDensity data q s L) (g := fun _ => I)
    spinStructure_univ_nonempty (fun s _ => hmode s)
  rwa [Finset.sup'_const] at h

/-- `w_L → I`（`L ≥ 1` で `w_L = v_L`）。 -/
theorem tendsto_scaledLogAbsMax_of_modeLimits (data : RealClosedSubfieldData) (z : Qbar)
    (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (I : ℝ)
    (hmode : ∀ s : SpinStructure, Tendsto (modeLogDensity data q s) atTop (𝓝 I)) :
    Tendsto (scaledLogAbsMax q) atTop (𝓝 I) := by
  refine (tendsto_modeLogMax data q I hmode).congr' ?_
  refine eventually_atTop.2 ⟨1, fun L hL => ?_⟩
  haveI : NeZero L := ⟨by omega⟩
  exact modeLogMax_eq_scaledLogAbsMax data z hz4 q hq0 hq1

/-- この段の主張: 鎖と四つの `u_{L,a,b} → I` から `f^per(q) = I`。 -/
theorem periodicFreeEnergyDensity_eq_of_modeLimits (data : RealClosedSubfieldData) (z : Qbar)
    (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (I : ℝ)
    (hchain : ∀ (L : ℕ) [NeZero L],
      logOrderLE (logRat (signedEvenSubgraphAbsMax L q) - 2 • logRat 2) (freeEntropy L q) ∧
        logOrderLE (freeEntropy L q) (logRat (signedEvenSubgraphAbsMax L q) + logRat 2))
    (hmode : ∀ s : SpinStructure, Tendsto (modeLogDensity data q s) atTop (𝓝 I)) :
    periodicFreeEnergyDensity q = I :=
  periodicFreeEnergyDensity_eq_of_logOrderChain q I
    (fun _ _ => signedEvenSubgraphAbsMax_pos data z hz4 q hq0 hq1) hchain
    (tendsto_scaledLogAbsMax_of_modeLimits data z hz4 q hq0 hq1 I hmode)

end Ising2DLambda.RealEscape
