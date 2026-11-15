import Ising2DLambda.RealEscape.PeriodicDensityModeMaxLimit
import Ising2DLambda.NecSuf.RealEscape.PeriodicDensityModeMaxLimit

/-!
具体版 `tendsto_scaledLogAbsMax_of_modeLimits`（`theorem_periodic_density_onsager_integral` の、四つのモード和の
最大値を `w_L` と同定し、各成分の共通極限から `w_L → I` を得る段）を、必要十分版から得る導出版。

`A = 𝒮`、`α = ℚ`、`β = ℝ`、`a_{L,s} = |Q^{s}_L(q)|`（`L = 0` では `1`）、`P_L = ℚ_{>0}`、
`φ_L(x) = L^{-2} log_ℝ ι(x)`、`w = (w_L)_L` に特殊化する。`hP` は `signedEvenSubgraphValue_ne_zero`、
`hmono` は実対数の単調性と `L^{-2} ≥ 0`、`hmode` は `modeLogDensity_eq`（`claim_cut_realization_agrees_on_rationals`）で
具体版の仮定から移す。
-/

namespace Ising2DLambda.RealEscape

open Ising2DLambda.KacWard Ising2DLambda.FisherZero Ising2DLambda.AlgebraicEigenvalue
open Filter Topology

/-- `a_{L,s} = |Q^{s}_L(q)|`（`L = 0` では `1`）。 -/
noncomputable def absModeValue (q : ℚ) (L : ℕ) (s : SpinStructure) : ℚ :=
  if h : L = 0 then 1 else
    haveI : NeZero L := ⟨h⟩
    |signedEvenSubgraphValue L q s|

theorem absModeValue_of_ne_zero (q : ℚ) (L : ℕ) [hL : NeZero L] (s : SpinStructure) :
    absModeValue q L s = |signedEvenSubgraphValue L q s| := by
  unfold absModeValue
  rw [dif_neg hL.out]

theorem tendsto_scaledLogAbsMax_of_modeLimits_from_necSuf (data : RealClosedSubfieldData)
    (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (I : ℝ)
    (hmode : ∀ s : SpinStructure, Tendsto (modeLogDensity data q s) atTop (𝓝 I)) :
    Tendsto (scaledLogAbsMax q) atTop (𝓝 I) := by
  refine Ising2DLambda.NecSuf.RealEscape.tendsto_of_componentLimits_necSuf
    (Finset.univ : Finset SpinStructure) spinStructure_univ_nonempty (absModeValue q)
    (fun _ => {x : ℚ | 0 < x}) (fun L x => (1 / ((L : ℝ) ^ 2)) * Real.log ((x : ℚ) : ℝ))
    (scaledLogAbsMax q) I ?_ ?_ ?_ ?_
  · -- 被対数は正
    intro L hL s _
    haveI : NeZero L := ⟨by omega⟩
    show 0 < absModeValue q L s
    rw [absModeValue_of_ne_zero]
    exact abs_pos.mpr (signedEvenSubgraphValue_ne_zero data z hz4 q hq0 hq1 s)
  · -- 実対数の単調性と L^{-2} ≥ 0
    intro L _ x hx y hy hxy
    have hc : (0 : ℝ) ≤ 1 / ((L : ℝ) ^ 2) := by positivity
    exact mul_le_mul_of_nonneg_left
      (Real.log_le_log (Rat.cast_pos.mpr hx) (Rat.cast_le.mpr hxy)) hc
  · -- w_L = φ_L(max a_L)
    intro L hL
    haveI : NeZero L := ⟨by omega⟩
    unfold scaledLogAbsMax
    rw [absMaxSequence_of_ne_zero]
    congr 3
    unfold signedEvenSubgraphAbsMax
    exact Finset.sup'_congr _ rfl (fun s _ => (absModeValue_of_ne_zero q L s).symm)
  · -- 各成分: L ≥ 1 で u_{L,s} = φ_L(a_{L,s})
    intro s _
    refine (hmode s).congr' (eventually_atTop.2 ⟨1, fun L hL => ?_⟩)
    haveI : NeZero L := ⟨by omega⟩
    show _ = 1 / ((L : ℝ) ^ 2) * Real.log ((absModeValue q L s : ℚ) : ℝ)
    rw [modeLogDensity_eq, absModeValue_of_ne_zero]

end Ising2DLambda.RealEscape
