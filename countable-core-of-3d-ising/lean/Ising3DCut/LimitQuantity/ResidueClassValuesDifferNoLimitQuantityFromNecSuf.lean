/-
必要十分版 `NecSuf.differingConstantCofinalSubsequences_noLimit` から、
具体版と同じ主張を導く。具体側で新たに必要な仮定は無い。
-/
import Ising3DCut.LimitQuantity.ResidueClassValuesDifferNoLimitQuantity
import Ising3DCut.NecSuf.ResidueClassValuesDifferNoLimitQuantity

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- `residue_class_values_differ_no_limit_quantity` を必要十分版から導いた版。 -/
theorem residue_class_values_differ_no_limit_quantity_fromNecSuf
    (q : ℚ) {L0 p : ℕ} (hp : 0 < p)
    (hperiodic : ∀ L, L0 ≤ L →
      rootSeq (isingValueSeq q) siteCountSeq L =
        rootSeq (isingValueSeq q) siteCountSeq (L + p))
    {r s : ℕ}
    (hdiffer : rootSeq (isingValueSeq q) siteCountSeq (L0 + r) ≠
      rootSeq (isingValueSeq q) siteCountSeq (L0 + s)) :
    ¬ ∃ α : ℝ, Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (nhds α) := by
  apply Ising3DCut.NecSuf.differingConstantCofinalSubsequences_noLimit
    (rootSeq (isingValueSeq q) siteCountSeq)
    (fun k : ℕ => L0 + r + k * p)
    (fun k : ℕ => L0 + s + k * p)
    (tendsto_residue_class_index_atTop hp)
    (tendsto_residue_class_index_atTop hp)
    (eventually_periodic_residue_class_constant q hperiodic r)
    (eventually_periodic_residue_class_constant q hperiodic s)
    hdiffer

end Ising3DCut.LimitQuantity
