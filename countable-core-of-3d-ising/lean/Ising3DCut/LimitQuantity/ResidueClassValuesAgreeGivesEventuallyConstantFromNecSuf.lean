/-
必要十分版 `NecSuf.residueClassValuesAgree_givesEventuallyConstant` から、
具体版と同じ主張を導く。具体側で新たに必要な仮定は無い。
-/
import Ising3DCut.LimitQuantity.ResidueClassValuesAgreeGivesEventuallyConstant
import Ising3DCut.NecSuf.ResidueClassValuesAgreeGivesEventuallyConstant

namespace Ising3DCut.LimitQuantity

/-- `residue_class_values_agree_gives_eventually_constant` を必要十分版から導いた版。 -/
theorem residue_class_values_agree_gives_eventually_constant_fromNecSuf
    (q : ℚ) {L0 p : ℕ}
    (hp : 0 < p)
    (hperiodic : ∀ L, L0 ≤ L →
      rootSeq (isingValueSeq q) siteCountSeq L =
        rootSeq (isingValueSeq q) siteCountSeq (L + p))
    {c : ℝ}
    (hagree : ∀ r : ℕ, r < p → rootSeq (isingValueSeq q) siteCountSeq (L0 + r) = c) :
    ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = c := by
  apply Ising3DCut.NecSuf.residueClassValuesAgree_givesEventuallyConstant
    (rootSeq (isingValueSeq q) siteCountSeq) hp
  · exact eventually_periodic_residue_class_constant q hperiodic
  · exact hagree

end Ising3DCut.LimitQuantity
