/- 必要十分版を実際の Ising 有限箱データの有理点 1 へ特殊化する。 -/
import Ising3DCut.LimitQuantity.LimitQuantityAtOneEqualsTwo
import Ising3DCut.NecSuf.LimitQuantityAtOneEqualsTwo

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 具体版と同じ極限の結論を必要十分版から取り出す。 -/
theorem tendsto_rootSeq_isingValueSeq_one_viaNecSuf :
    Tendsto (rootSeq (isingValueSeq 1) siteCountSeq) atTop (𝓝 2) := by
  apply Ising3DCut.NecSuf.eventually_constant_sequence_tendsto
  filter_upwards [eventually_gt_atTop 0] with L hL
  exact rootSeq_isingValueSeq_one hL

end Ising3DCut.LimitQuantity
