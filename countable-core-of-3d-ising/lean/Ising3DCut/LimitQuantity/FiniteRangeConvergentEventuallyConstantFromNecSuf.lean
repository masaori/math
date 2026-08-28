/-
必要十分版 `NecSuf.finiteRangeConvergent_eventuallyConstant` から、有限箱の量の列についての
具体版を導く。具体側で新たに必要な仮定は無い。
-/
import Ising3DCut.LimitQuantity.InfiniteLevelSetValueEqualsLimit
import Ising3DCut.NecSuf.FiniteRangeConvergentEventuallyConstant

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- `ising_eventually_constant_of_finite_range` を必要十分版から導いた版。 -/
theorem ising_eventually_constant_of_finite_range_fromNecSuf (q : ℚ) {α : ℝ}
    (hlimit : Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (nhds α))
    (hfin : (Set.range (rootSeq (isingValueSeq q) siteCountSeq)).Finite) :
    ∃ L0 : ℕ, ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = α :=
  Ising3DCut.NecSuf.finiteRangeConvergent_eventuallyConstant hlimit hfin

end Ising3DCut.LimitQuantity
