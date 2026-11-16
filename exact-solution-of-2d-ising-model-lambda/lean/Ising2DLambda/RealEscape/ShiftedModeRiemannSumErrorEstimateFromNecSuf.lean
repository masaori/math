import Ising2DLambda.RealEscape.ShiftedModeRiemannSumErrorEstimate
import Ising2DLambda.NecSuf.RealEscape.ShiftedModeRiemannSumErrorEstimate

namespace Ising2DLambda.RealEscape

open Filter Topology
open Ising2DLambda.KacWard

/-- 具体版の主張は、必要十分版を `E := ℝ`、`f := f_q`、`T := 2π`、`α := a/2`、`β := b/2` に
特殊化して得られる。 -/
theorem shiftedAngleRiemannSum_tendsto_from_necSuf (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (s : SpinStructure) :
    Tendsto (shiftedAngleRiemannSum q hq0 hq1 s) atTop
      (𝓝 (dispersionAngleDoubleIntegral q hq0 hq1)) :=
  Ising2DLambda.NecSuf.RealEscape.shiftedRiemannSum_tendsto_necSuf
    (dispersionAngleLog q hq0 hq1) (dispersion_angle_log_continuous q hq0 hq1).2
    (2 * Real.pi) (spinHalfOffset s.1) (spinHalfOffset s.2) (by positivity)
    (spinHalfOffset_mem s.1).1 (spinHalfOffset_mem s.1).2
    (spinHalfOffset_mem s.2).1 (spinHalfOffset_mem s.2).2

end Ising2DLambda.RealEscape
