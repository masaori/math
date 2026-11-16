import Ising2DLambda.RealEscape.ShiftedModeRiemannSums
import Ising2DLambda.RealEscape.ShiftedModeRiemannSumsOfRealLogSumFromNecSuf
/-!
`claim_shifted_mode_riemann_sums`・`theorem_periodic_density_onsager_integral`・
`claim_onsager_hyperbolic_integral_form` の具体版を、合成の段の導出版から得る。
合成の段の仮定 `hsum` には、最初の式鎖の一行目 `realLogSum_of_dispersionProduct` を当てる。
-/

namespace Ising2DLambda.RealEscape

open Filter Topology
open Ising2DLambda.ThermodynamicLimit
open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.KacWard

theorem shiftedModeRiemannSums_tendsto_from_necSuf (data : RealClosedSubfieldData) (z : Qbar)
    (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (s : SpinStructure) :
    Tendsto (modeLogDensity data q s) atTop (𝓝 (dispersionIntegral q hq0 hq1)) :=
  modeLogDensity_tendsto_of_realLogSum_from_necSuf data q hq0 hq1 s
    (fun L => realLogSum_of_dispersionProduct data z hz4 q hq0 hq1 s L)

theorem periodicFreeEnergyDensity_eq_dispersionIntegral_from_necSuf
    (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    periodicFreeEnergyDensity q = dispersionIntegral q hq0 hq1 :=
  periodicFreeEnergyDensity_eq_dispersionIntegral_of_realLogSum_from_necSuf data z hz4 q hq0 hq1
    (fun s L => realLogSum_of_dispersionProduct data z hz4 q hq0 hq1 s L)

theorem periodicFreeEnergyDensity_onsagerForm_from_necSuf
    (data : RealClosedSubfieldData) (z : Qbar) (hz4 : z ^ 4 = -1)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    paperCosh (2 * onsagerCoupling q hq0) = onsagerCoshValue q ∧
      paperSinh (2 * onsagerCoupling q hq0) = onsagerSinhValue q ∧
      (∀ θ₁ θ₂ : ℝ, 0 < onsagerHyperbolicArgument q θ₁ θ₂) ∧
      periodicFreeEnergyDensity q =
        realLog ⟨2, two_pos⟩ + realLog (onsagerRadius q hq0) +
          1 / (8 * Real.pi ^ 2) *
            (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
              onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) :=
  periodicFreeEnergyDensity_onsagerForm_of_realLogSum_from_necSuf data z hz4 q hq0 hq1
    (fun s L => realLogSum_of_dispersionProduct data z hz4 q hq0 hq1 s L)

end Ising2DLambda.RealEscape
