import Ising2DLambda.RealEscape.ShiftedModeRiemannSumsOfRealLogSum
import Ising2DLambda.RealEscape.ShiftedModeSumReindexFromNecSuf
import Ising2DLambda.RealEscape.PeriodicDensityOnsagerOfModeLimitsFromNecSuf
import Ising2DLambda.NecSuf.RealEscape.ShiftedModeRiemannSumsOfRealLogSum
/-!
具体版 `modeLogDensity_tendsto_of_realLogSum`（`claim_shifted_mode_riemann_sums` の合成の段）と、それを
周期境界の密度・Onsager 表示へつなぐ二つの合成を、必要十分版から得る導出版。
`R = M = ℝ`、`u = u_{·,a,b}`、`S_L := Σ_{(ϖ,ς)} φ_L(ϖ,ς)`（`φ_L` は `hsum` が与える項。`L = 0` では `0`）、
`T_L := Σ_{k,l<L} f_q(t^{a,b}_{L,k,l})`、`a_L := 1/(2L²)`、`b_L := h_L²`、`c := 1/(8π²)`、`I := ∫∫ f_q` に特殊化する。
`hST` は再添字付けの導出版 `modeSum_realizedDispersionLog_eq_sampleSum_from_necSuf`、`hlim` は小区画の誤差評価
`shiftedAngleRiemannSum_tendsto` から取る。二つの合成は、合成の段の導出版の `hmode` にこの極限を当てて得る。
-/

namespace Ising2DLambda.RealEscape

open Filter Topology
open Ising2DLambda.ThermodynamicLimit
open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.KacWard

/-- 合成の段の具体版は、必要十分版を上の値に特殊化して得られる。 -/
theorem modeLogDensity_tendsto_of_realLogSum_from_necSuf (data : RealClosedSubfieldData)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (s : SpinStructure)
    (hsum : ∀ (L : ℕ) [NeZero L], ∃ φ : FourierModePair L s → ℝ,
      (∀ (m : FourierModePair L s) (D : data.carrier),
        (D : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) →
          φ m = Real.log (realAlgebraicCutRealization data D)) ∧
      modeLogDensity data q s L = 1 / (2 * (L : ℝ) ^ 2) * ∑ m : FourierModePair L s, φ m) :
    Tendsto (modeLogDensity data q s) atTop (𝓝 (dispersionIntegral q hq0 hq1)) := by
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  -- S_L := Σ φ_L（L = 0 では 0）
  let S : ℕ → ℝ := fun L =>
    if h : L = 0 then 0 else
      haveI : NeZero L := ⟨h⟩
      ∑ m : FourierModePair L s, Classical.choose (hsum L) m
  have hS : ∀ L : ℕ, ∀ h : L ≠ 0,
      S L = (haveI : NeZero L := ⟨h⟩; ∑ m : FourierModePair L s, Classical.choose (hsum L) m) := by
    intro L h
    simp only [S, dif_neg h]
  have h := Ising2DLambda.NecSuf.RealEscape.tendsto_of_finiteSumEq_necSuf
    (modeLogDensity data q s) S
    (fun L => ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
      dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l))
    (fun L : ℕ => 1 / (2 * (L : ℝ) ^ 2)) (fun L => angleStep L ^ 2) (1 / (8 * Real.pi ^ 2))
    (dispersionAngleDoubleIntegral q hq0 hq1)
    (fun L hL => by
      haveI : NeZero L := ⟨by omega⟩
      rw [hS L (NeZero.ne L), smul_eq_mul]
      exact (Classical.choose_spec (hsum L)).2)
    (fun L hL => by
      haveI : NeZero L := ⟨by omega⟩
      rw [hS L (NeZero.ne L)]
      exact modeSum_realizedDispersionLog_eq_sampleSum_from_necSuf data L s q hq0 hq1 _
        (Classical.choose_spec (hsum L)).1)
    (by
      filter_upwards [eventually_ge_atTop 1] with L hL
      have hL0 : (L : ℝ) ≠ 0 := by positivity
      rw [angleStep]; field_simp; ring)
    (shiftedAngleRiemannSum_tendsto q hq0 hq1 s)
  rwa [smul_eq_mul, show 1 / (8 * Real.pi ^ 2) * dispersionAngleDoubleIntegral q hq0 hq1 =
      dispersionIntegral q hq0 hq1 by rw [dispersionAngleDoubleIntegral, dispersionIntegral]] at h

/-- `theorem_periodic_density_onsager_integral` の合成は、合成の段の導出版の `hmode` に上の極限を当てて得る。 -/
theorem periodicFreeEnergyDensity_eq_dispersionIntegral_of_realLogSum_from_necSuf
    (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hsum : ∀ (s : SpinStructure) (L : ℕ) [NeZero L], ∃ φ : FourierModePair L s → ℝ,
      (∀ (m : FourierModePair L s) (D : data.carrier),
        (D : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) →
          φ m = Real.log (realAlgebraicCutRealization data D)) ∧
      modeLogDensity data q s L = 1 / (2 * (L : ℝ) ^ 2) * ∑ m : FourierModePair L s, φ m) :
    periodicFreeEnergyDensity q = dispersionIntegral q hq0 hq1 :=
  periodicFreeEnergyDensity_eq_dispersionIntegral_of_modeLimits_from_necSuf data z hz4 q hq0 hq1
    (fun s => modeLogDensity_tendsto_of_realLogSum_from_necSuf data q hq0 hq1 s (hsum s))

/-- `claim_onsager_hyperbolic_integral_form` の合成も同じく導出版から得る。 -/
theorem periodicFreeEnergyDensity_onsagerForm_of_realLogSum_from_necSuf
    (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hsum : ∀ (s : SpinStructure) (L : ℕ) [NeZero L], ∃ φ : FourierModePair L s → ℝ,
      (∀ (m : FourierModePair L s) (D : data.carrier),
        (D : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) →
          φ m = Real.log (realAlgebraicCutRealization data D)) ∧
      modeLogDensity data q s L = 1 / (2 * (L : ℝ) ^ 2) * ∑ m : FourierModePair L s, φ m) :
    paperCosh (2 * onsagerCoupling q hq0) = onsagerCoshValue q ∧
      paperSinh (2 * onsagerCoupling q hq0) = onsagerSinhValue q ∧
      (∀ θ₁ θ₂ : ℝ, 0 < onsagerHyperbolicArgument q θ₁ θ₂) ∧
      periodicFreeEnergyDensity q =
        realLog ⟨2, two_pos⟩ + realLog (onsagerRadius q hq0) +
          1 / (8 * Real.pi ^ 2) *
            (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
              onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) :=
  periodicFreeEnergyDensity_onsagerForm_of_modeLimits_from_necSuf data z hz4 q hq0 hq1
    (fun s => modeLogDensity_tendsto_of_realLogSum_from_necSuf data q hq0 hq1 s (hsum s))

end Ising2DLambda.RealEscape
