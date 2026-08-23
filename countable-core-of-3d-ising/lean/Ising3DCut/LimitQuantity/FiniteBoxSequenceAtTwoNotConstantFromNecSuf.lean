/-
必要十分版 `NecSuf.not_constant_of_pow_ne` から、具体版と同じ主張
「有理点 2 では有限箱の量の列は定数列でない」を導く。

具体版が担うのは、必要十分版の三つの仮定を用意するところだけである。
すなわち `L = 1` の有限箱計算から `a₁(2) = 2`、`L = 2` の有限箱計算から
`a₂(2) ^ 8 = Z₂(2)` と `2 ^ 8 ≠ Z₂(2)` を与える。
-/
import Ising3DCut.LimitQuantity.FiniteBoxSequenceAtTwoNotConstant
import Ising3DCut.NecSuf.FiniteBoxSequenceAtTwoNotConstant

namespace Ising3DCut.LimitQuantity

open NullModel

/-- `rootSeq_isingValueSeq_two_not_constant_closed` を必要十分版から導いた版。 -/
theorem rootSeq_isingValueSeq_two_not_constant_viaNecSuf :
    ¬ ∃ c : ℝ, rootSeq (isingValueSeq 2) siteCountSeq = fun _ => c := by
  have hTwoValue : (256 : ℝ) < isingValueSeq 2 2 :=
    isingValueSeq_two_at_two_gt_two_pow_eight
  have hPositive : (0 : ℝ) < isingValueSeq 2 2 := lt_trans (by norm_num) hTwoValue
  have hCount : siteCountSeq 2 = 8 := by
    unfold siteCountSeq
    rw [card_site]
    norm_num
  have hPow : rootSeq (isingValueSeq 2) siteCountSeq 2 ^ 8 = isingValueSeq 2 2 := by
    unfold rootSeq
    rw [hCount]
    exact posRoot_pow (isingValueSeq 2 2) hPositive 8 (by norm_num)
  refine NecSuf.not_constant_of_pow_ne _ 1 2 8 2 (isingValueSeq 2 2)
    (rootSeq_isingValueSeq_two_at_one isingValueSeq_two_at_one) hPow ?_
  intro hEq
  exact (ne_of_gt hTwoValue) (by rw [← hEq]; norm_num)

end Ising3DCut.LimitQuantity
