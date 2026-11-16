import Ising2DLambda.RealEscape.PeriodicDensityOnsagerOfModeLimits
import Ising2DLambda.RealEscape.PeriodicDensityLimitFromLogOrderChainFromNecSuf
import Ising2DLambda.KacWard.LowTemperaturePartitionBounds
import Ising2DLambda.NecSuf.RealEscape.PeriodicDensityOnsagerOfModeLimits

/-!
具体版 `periodicFreeEnergyDensity_eq_dispersionIntegral_of_modeLimits`・
`periodicFreeEnergyDensity_onsagerForm_of_modeLimits`（周期境界の密度と Onsager 表示の合成の段。
四つのモード和の極限だけを仮定に残す）を、必要十分版から得る導出版。

`G = Λ`、`H = Λ_ℚ`、`ι = 𝒮`、`lg = log`、`rat = rat_Λ`、`rlog = log_ℝ ∘ ι_{ℚ→ℝ}`、
`emb_L(λ) = L^{-2}·ι(λ)`、`ρ = ρ_ℝ`、`e_L = L^{-2}`、`F(l) = sup ρ_ℝ(A(l))`、`Z_L = Z_L(q)`、
`f_{L,s} = Q^{s}_L(q)`、`Φ_L = Φ_L(q)`、`x_L = Ψ_L(q)`（`L = 0` の値は使わない）に特殊化する。
Onsager 表示ではさらに `X = ℝ × ℝ`、`r = ι_{ℚ→ℝ}(q)`、`lgR = log_ℝ`、`E = exp`、`cⱼ = cos ∘ (第 j 成分)`、
`Iint f = ∫₀^{2π}∫₀^{2π} f`、`Adm = 連続`、`area = 4π²`、`n = 1/8π²` とする。
`hsq` は `noRationalSquareTwo`、`hf` は `signedEvenSubgraphValue_ne_zero`、符号の二場合の仮定は
`signedEvenSubgraphPolynomial_rational_sign`・`lowTemperaturePartitionBounds`・`highTemperaturePartitionBounds`、
`hmode` は `modeLogDensity_eq`（`claim_cut_realization_agrees_on_rationals`）で具体版の仮定から移す。
-/

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit Ising2DLambda.FreeEntropy Ising2DLambda.KacWard
open Ising2DLambda.FisherZero Ising2DLambda.AlgebraicEigenvalue
open Filter Topology

/-- 列 `L ↦ Z_L(q)`（`L = 0` では `1`）。 -/
noncomputable def partitionValueSequence (q : ℚ) (L : ℕ) : ℚ :=
  if h : L = 0 then 1 else
    haveI : NeZero L := ⟨h⟩
    partitionValue L q

theorem partitionValueSequence_of_ne_zero (q : ℚ) (L : ℕ) [hL : NeZero L] :
    partitionValueSequence q L = partitionValue L q := by
  unfold partitionValueSequence
  rw [dif_neg hL.out]

/-- 列 `L ↦ Q^{·}_L(q)`（`L = 0` では `1`）。 -/
noncomputable def signedModeValue (q : ℚ) (L : ℕ) (s : SpinStructure) : ℚ :=
  if h : L = 0 then 1 else
    haveI : NeZero L := ⟨h⟩
    signedEvenSubgraphValue L q s

theorem signedModeValue_of_ne_zero (q : ℚ) (L : ℕ) [hL : NeZero L] :
    signedModeValue q L = signedEvenSubgraphValue L q := by
  funext s
  unfold signedModeValue
  rw [dif_neg hL.out]

theorem freeEntropySequence_of_ne_zero (q : ℚ) (L : ℕ) [hL : NeZero L] :
    freeEntropySequence q L = freeEntropy L q := by
  unfold freeEntropySequence
  rw [dif_neg hL.out]

/-- 具体版の仮定 `hmode` を必要十分版の形へ移す（`L ≥ 1` で `u_{L,s} = L^{-2} log_ℝ ι(|Q^{s}_L(q)|)`）。 -/
theorem signedModeValue_tendsto (data : RealClosedSubfieldData) (q : ℚ) (I : ℝ)
    (hmode : ∀ s : SpinStructure, Tendsto (modeLogDensity data q s) atTop (𝓝 I)) (s : SpinStructure) :
    Tendsto (fun L : ℕ => 1 / ((L : ℝ) ^ 2) * Real.log (((|signedModeValue q L s| : ℚ)) : ℝ))
      atTop (𝓝 I) := by
  refine (hmode s).congr' (eventually_atTop.2 ⟨1, fun L hL => ?_⟩)
  haveI : NeZero L := ⟨by omega⟩
  show _ = 1 / ((L : ℝ) ^ 2) * Real.log (((|signedModeValue q L s| : ℚ)) : ℝ)
  rw [modeLogDensity_eq, signedModeValue_of_ne_zero]

/-- `L^{-2} → 0`。 -/
theorem tendsto_inv_sq_nat : Tendsto (fun L : ℕ => 1 / ((L : ℝ) ^ 2)) atTop (𝓝 0) := by
  have h0 : Tendsto (fun L : ℕ => 1 / (L : ℝ)) atTop (𝓝 (0 : ℝ)) :=
    tendsto_one_div_atTop_nhds_zero_nat
  have h := h0.pow 2
  rw [zero_pow two_ne_zero] at h
  exact h.congr fun L => by rw [one_div_pow]

theorem periodicFreeEnergyDensity_eq_dispersionIntegral_of_modeLimits_from_necSuf
    (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hmode : ∀ s : SpinStructure,
      Tendsto (modeLogDensity data q s) atTop (𝓝 (dispersionIntegral q hq0 hq1))) :
    periodicFreeEnergyDensity q = dispersionIntegral q hq0 hq1 := by
  show sSup (realizeRational '' rationalLogOrderSequenceLowerSet (periodicDensitySequence q)) = _
  refine Ising2DLambda.NecSuf.RealEscape.sup_eq_of_signedBounds_modeLimits_necSuf
    spinStructure_univ_nonempty noRationalSquareTwo
    logOrderLE rationalLogOrderLE logRat rationalOfLog (fun a => Real.log ((a : ℚ) : ℝ))
    (fun L l => if L = 0 then 0 else ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l) realizeRational
    (fun L : ℕ => 1 / ((L : ℝ) ^ 2))
    (fun l => sSup (realizeRational '' rationalLogOrderSequenceLowerSet l))
    (fun ha hb h => (logRat_le_iff ha hb).1 h) (fun ha hb => logRat_mul ha hb)
    (fun h n => logOrderLE_add_right h n) (fun ha => rationalOfLog_logRat ha)
    (fun ha hb => by
      rw [Rat.cast_mul]
      exact Real.log_mul (ne_of_gt (Rat.cast_pos.mpr ha)) (ne_of_gt (Rat.cast_pos.mpr hb)))
    (fun ha hab => Real.log_le_log (Rat.cast_pos.mpr ha) (Rat.cast_le.mpr hab))
    (fun L hL x y h => by
      haveI : NeZero L := ⟨by omega⟩
      simp only [if_neg (NeZero.ne L)]
      exact (rationalLogOrderLE_scaled_toRational_iff L x y).2 h)
    (fun h => realizeRational_le_of_rationalLogOrderLE _ _ h)
    (fun L hL l => by
      haveI : NeZero L := ⟨by omega⟩
      simp only [if_neg (NeZero.ne L)]
      exact realizeRational_scaled_toRational L l)
    tendsto_inv_sq_nat (fun L _ => by positivity)
    (fun l J h => (sequence_lowerSet_sup_eq_realLimit l J h).2.2)
    q (partitionValueSequence q) (signedModeValue q) (freeEntropySequence q)
    (periodicDensitySequence q) _ ?_ ?_ ?_ ?_ ?_ ?_ ?_ ?_ (signedModeValue_tendsto data q _ hmode)
  · -- Z_L(q) > 0
    intro L hL
    haveI : NeZero L := ⟨by omega⟩
    rw [partitionValueSequence_of_ne_zero]
    exact partitionValue_pos L hq0
  · -- Φ_L(q) = log Z_L(q)
    intro L hL
    haveI : NeZero L := ⟨by omega⟩
    rw [freeEntropySequence_of_ne_zero, partitionValueSequence_of_ne_zero]
    exact freeEntropy_eq_logRat_partitionValue L q
  · -- Q^{s}_L(q) ≠ 0
    intro L hL s
    haveI : NeZero L := ⟨by omega⟩
    rw [signedModeValue_of_ne_zero]
    exact signedEvenSubgraphValue_ne_zero data z hz4 q hq0 hq1 s
  · -- 低温側: 四つの値は正
    intro L hL hc s
    haveI : NeZero L := ⟨by omega⟩
    rw [signedModeValue_of_ne_zero]
    exact (signedEvenSubgraphPolynomial_rational_sign data z hz4 s q hq0 hq1).1 hc
  · -- 低温側の下界
    intro L hL hc
    haveI : NeZero L := ⟨by omega⟩
    rw [signedModeValue_of_ne_zero, partitionValueSequence_of_ne_zero]
    exact (lowTemperaturePartitionBounds (L := L) data z hz4 q hq0 hq1 hc).1
  · -- 低温側の上界
    intro L hL hc
    haveI : NeZero L := ⟨by omega⟩
    rw [signedModeValue_of_ne_zero, partitionValueSequence_of_ne_zero]
    exact (lowTemperaturePartitionBounds (L := L) data z hz4 q hq0 hq1 hc).2
  · -- 高温側
    intro L hL hc
    haveI : NeZero L := ⟨by omega⟩
    rw [signedModeValue_of_ne_zero, partitionValueSequence_of_ne_zero]
    exact highTemperaturePartitionBounds (L := L) data z hz4 q hq0 hq1 hc
  · -- x_L = emb_L(Φ_L)
    intro L hL
    haveI : NeZero L := ⟨by omega⟩
    simp only [if_neg (NeZero.ne L), freeEntropySequence_of_ne_zero]
    rw [periodicDensitySequence_of_ne_zero]
    rfl

theorem periodicFreeEnergyDensity_onsagerForm_of_modeLimits_from_necSuf
    (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hmode : ∀ s : SpinStructure,
      Tendsto (modeLogDensity data q s) atTop (𝓝 (dispersionIntegral q hq0 hq1))) :
    paperCosh (2 * onsagerCoupling q hq0) = onsagerCoshValue q ∧
      paperSinh (2 * onsagerCoupling q hq0) = onsagerSinhValue q ∧
      (∀ θ₁ θ₂ : ℝ, 0 < onsagerHyperbolicArgument q θ₁ θ₂) ∧
      periodicFreeEnergyDensity q =
        realLog ⟨2, two_pos⟩ + realLog (onsagerRadius q hq0) +
          1 / (8 * Real.pi ^ 2) *
            (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
              onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) := by
  have hr0 : (0 : ℝ) < (q : ℝ) := by exact_mod_cast hq0
  obtain ⟨hc, hs, hH, hF⟩ :=
    Ising2DLambda.NecSuf.RealEscape.onsagerForm_of_signedBounds_modeLimits_necSuf
    (X := ℝ × ℝ) spinStructure_univ_nonempty noRationalSquareTwo
    logOrderLE rationalLogOrderLE logRat rationalOfLog (fun a => Real.log ((a : ℚ) : ℝ))
    (fun L l => if L = 0 then 0 else ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l) realizeRational
    (fun L : ℕ => 1 / ((L : ℝ) ^ 2))
    (fun l => sSup (realizeRational '' rationalLogOrderSequenceLowerSet l))
    (fun ha hb h => (logRat_le_iff ha hb).1 h) (fun ha hb => logRat_mul ha hb)
    (fun h n => logOrderLE_add_right h n) (fun ha => rationalOfLog_logRat ha)
    (fun ha hb => by
      rw [Rat.cast_mul]
      exact Real.log_mul (ne_of_gt (Rat.cast_pos.mpr ha)) (ne_of_gt (Rat.cast_pos.mpr hb)))
    (fun ha hab => Real.log_le_log (Rat.cast_pos.mpr ha) (Rat.cast_le.mpr hab))
    (fun L hL x y h => by
      haveI : NeZero L := ⟨by omega⟩
      simp only [if_neg (NeZero.ne L)]
      exact (rationalLogOrderLE_scaled_toRational_iff L x y).2 h)
    (fun h => realizeRational_le_of_rationalLogOrderLE _ _ h)
    (fun L hL l => by
      haveI : NeZero L := ⟨by omega⟩
      simp only [if_neg (NeZero.ne L)]
      exact realizeRational_scaled_toRational L l)
    tendsto_inv_sq_nat (fun L _ => by positivity)
    (fun l J h => (sequence_lowerSet_sup_eq_realLimit l J h).2.2)
    q (partitionValueSequence q) (signedModeValue q) (freeEntropySequence q)
    (periodicDensitySequence q)
    (fun L hL => by
      haveI : NeZero L := ⟨by omega⟩
      rw [partitionValueSequence_of_ne_zero]
      exact partitionValue_pos L hq0)
    (fun L hL => by
      haveI : NeZero L := ⟨by omega⟩
      rw [freeEntropySequence_of_ne_zero, partitionValueSequence_of_ne_zero]
      exact freeEntropy_eq_logRat_partitionValue L q)
    (fun L hL s => by
      haveI : NeZero L := ⟨by omega⟩
      rw [signedModeValue_of_ne_zero]
      exact signedEvenSubgraphValue_ne_zero data z hz4 q hq0 hq1 s)
    (fun L hL hc s => by
      haveI : NeZero L := ⟨by omega⟩
      rw [signedModeValue_of_ne_zero]
      exact (signedEvenSubgraphPolynomial_rational_sign data z hz4 s q hq0 hq1).1 hc)
    (fun L hL hc => by
      haveI : NeZero L := ⟨by omega⟩
      rw [signedModeValue_of_ne_zero, partitionValueSequence_of_ne_zero]
      exact (lowTemperaturePartitionBounds (L := L) data z hz4 q hq0 hq1 hc).1)
    (fun L hL hc => by
      haveI : NeZero L := ⟨by omega⟩
      rw [signedModeValue_of_ne_zero, partitionValueSequence_of_ne_zero]
      exact (lowTemperaturePartitionBounds (L := L) data z hz4 q hq0 hq1 hc).2)
    (fun L hL hc => by
      haveI : NeZero L := ⟨by omega⟩
      rw [signedModeValue_of_ne_zero, partitionValueSequence_of_ne_zero]
      exact highTemperaturePartitionBounds (L := L) data z hz4 q hq0 hq1 hc)
    (fun L hL => by
      haveI : NeZero L := ⟨by omega⟩
      simp only [if_neg (NeZero.ne L), freeEntropySequence_of_ne_zero]
      rw [periodicDensitySequence_of_ne_zero]
      rfl)
    (q : ℝ) hr0
    Real.log (fun u v hu hv => Real.log_mul (ne_of_gt hu) (ne_of_gt hv))
    Real.exp (fun u hu => Real.exp_log hu) Real.exp_neg
    (fun θ => Real.cos θ.1) (fun θ => Real.cos θ.2)
    (fun θ => (dispersionAngleArgument_pos q hq0 hq1 θ.1 θ.2).2.2)
    (fun f => ∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi, f (θ₁, θ₂))
    Continuous (4 * Real.pi ^ 2) (1 / (8 * Real.pi ^ 2))
    (fun a g hg => iteratedIntegral_const_add a g hg)
    (onsagerHyperbolicLog_continuous q hq0 hq1)
    (by field_simp [Real.pi_ne_zero]; ring)
    (signedModeValue_tendsto data q _ hmode)
  exact ⟨hc, hs, fun θ₁ θ₂ => hH (θ₁, θ₂), hF⟩

end Ising2DLambda.RealEscape
