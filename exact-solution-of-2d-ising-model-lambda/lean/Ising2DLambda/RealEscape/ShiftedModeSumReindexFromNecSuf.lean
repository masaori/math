import Ising2DLambda.RealEscape.ShiftedModeSumReindex
import Ising2DLambda.NecSuf.RealEscape.ShiftedModeSumReindex

namespace Ising2DLambda.RealEscape

open Filter Topology
open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent
open Ising2DLambda.KacWard

/-- 再添字付けの具体版は、必要十分版を `A := U_a × W_b`、`M := ℝ`、`Θ := 複素実現の組`、
`e₁ k := exp(2πi(k+a/2)/L)`、`e₂ l := exp(2πi(l+b/2)/L)`、`g k l := f_q(t^{a,b}_{L,k,l})` に
特殊化して得られる。 -/
theorem modeSum_realizedDispersionLog_eq_sampleSum_from_necSuf (data : RealClosedSubfieldData)
    (L : ℕ) [NeZero L] (s : SpinStructure) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (φ : FourierModePair L s → ℝ)
    (hφ : ∀ (m : FourierModePair L s) (D : data.carrier),
      (D : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) →
        φ m = Real.log (realAlgebraicCutRealization data D)) :
    ∑ m : FourierModePair L s, φ m =
      ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
        dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l) := by
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  have hbij := twistedModeProductRealization_bijOn data L hL s
  refine Ising2DLambda.NecSuf.RealEscape.modeSum_reindex_necSuf L
    (fun m : FourierModePair L s => twistedModeProductRealization data m.1)
    (fun m m' h => Subtype.ext (hbij.injOn m.2 m'.2 h))
    (complexRootCandidate L s.1) (complexRootCandidate L s.2)
    (complexRootCandidate_injOn L hL s.1) (complexRootCandidate_injOn L hL s.2) ?_ ?_ φ
    (fun k l => dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l)) ?_
  · intro m
    obtain ⟨h1, h2⟩ := hbij.mapsTo m.2
    rw [complexRootSet_eq_candidates L hL s.1] at h1
    rw [complexRootSet_eq_candidates L hL s.2] at h2
    obtain ⟨k, hk, hk'⟩ := h1
    obtain ⟨l, hl, hl'⟩ := h2
    exact ⟨k, by simpa using hk, l, by simpa using hl, Prod.ext hk'.symm hl'.symm⟩
  · intro k l
    obtain ⟨p, hp, hpΘ⟩ := hbij.surjOn (complexRootCandidate_pair_mem L hL s k l)
    exact ⟨⟨p, hp⟩, hpΘ⟩
  · intro m k l hΘ
    obtain ⟨D, hD, -⟩ := dispersion_realized_positive data L hL s m.1.1 m.1.2 m.2.1 m.2.2 q hq0 hq1
    rw [hφ m D hD, dispersion_angle_realization data L hL s m.1.1 m.1.2 m.2.1 m.2.2 k l hΘ q D hD,
      modeAngle_eq_angleStep_mul, modeAngle_eq_angleStep_mul]
    rfl

/-- 極限の書き換えの具体版は、必要十分版を `R = M = ℝ`、`a_L := 1/(2L²)`、`b_L := h_L²`、
`c := 1/(8π²)` に特殊化して得られる。 -/
theorem halfInvSq_sampleSum_tendsto_from_necSuf (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (s : SpinStructure) :
    Tendsto (fun L : ℕ => 1 / (2 * (L : ℝ) ^ 2) * ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
        dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l)) atTop
      (𝓝 (dispersionAngleDoubleIntegral q hq0 hq1 / (8 * Real.pi ^ 2))) := by
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  have h := Ising2DLambda.NecSuf.RealEscape.scaled_tendsto_necSuf
    (fun L : ℕ => 1 / (2 * (L : ℝ) ^ 2)) (fun L => angleStep L ^ 2) (1 / (8 * Real.pi ^ 2))
    (fun L => ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
      dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l))
    (dispersionAngleDoubleIntegral q hq0 hq1)
    (by
      filter_upwards [eventually_ge_atTop 1] with L hL
      have hL0 : (L : ℝ) ≠ 0 := by positivity
      rw [angleStep]; field_simp; ring)
    (shiftedAngleRiemannSum_tendsto q hq0 hq1 s)
  simp only [smul_eq_mul] at h
  rwa [show 1 / (8 * Real.pi ^ 2) * dispersionAngleDoubleIntegral q hq0 hq1 =
      dispersionAngleDoubleIntegral q hq0 hq1 / (8 * Real.pi ^ 2) by ring] at h

end Ising2DLambda.RealEscape
