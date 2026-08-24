/-
必要十分版 `NecSuf.eq_of_constant_of_strictMonoOn` から、具体版と同じ主張
「有限箱の量が定数列になる正の有理点は 1 に限る」を導く。

具体版が担うのは、必要十分版の仮定を用意するところだけである。
すなわち `L = 1` の有限箱計算から有限箱量が `2` であること、
`L = 2` の有限箱計算から有限箱量の `8` 乗が箱 `2` の分配多項式の値であること、
`2 ^ 8` が有理点 `1` での値であること、
そして箱 `2` の分配多項式の値が正の有理点上で狭義単調であることを与える。
-/
import Ising3DCut.LimitQuantity.ConstantFiniteBoxSequenceOnlyAtOne
import Ising3DCut.NecSuf.ConstantFiniteBoxSequenceOnlyAtOne

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 箱 `2` の有限箱の値は正の有理点の上で狭義単調である。 -/
theorem isingValueSeq_two_strictMonoOn :
    StrictMonoOn (fun x : ℚ => isingValueSeq x 2) (Set.Ioi (0 : ℚ)) := by
  intro a ha b _ hab
  have h := partitionPolynomial_two_strictMono (Set.mem_Ioi.mp ha) hab
  show isingValueSeq a 2 < isingValueSeq b 2
  unfold isingValueSeq
  exact_mod_cast h

/-- `constant_finite_box_sequence_only_at_one` を必要十分版から導いた版。 -/
theorem constant_finite_box_sequence_only_at_one_viaNecSuf
    (q : ℚ) (hq : 0 < q)
    (hConstant : ∃ c : ℝ, rootSeq (isingValueSeq q) siteCountSeq = fun _ => c) :
    q = 1 := by
  have hCount : siteCountSeq 2 = 8 := by
    unfold siteCountSeq
    rw [card_site]
    norm_num
  have hPositive : (0 : ℝ) < isingValueSeq q 2 := by
    unfold isingValueSeq
    exact_mod_cast partitionPolynomial_evalAtRational_pos (by norm_num : 0 < 2) hq
  have hPow : rootSeq (isingValueSeq q) siteCountSeq 2 ^ 8 = isingValueSeq q 2 := by
    unfold rootSeq
    rw [hCount]
    exact posRoot_pow (isingValueSeq q 2) hPositive 8 (by norm_num)
  have hOneValue : isingValueSeq 1 2 = (2 : ℝ) ^ 8 := by
    have h := isingValueSeq_one 2
    rw [hCount] at h
    exact h
  exact NecSuf.eq_of_constant_of_strictMonoOn
    (rootSeq (isingValueSeq q) siteCountSeq) 1 2 8 2
    (fun x : ℚ => isingValueSeq x 2) (Set.Ioi (0 : ℚ)) isingValueSeq_two_strictMonoOn
    q 1 (Set.mem_Ioi.mpr hq) (Set.mem_Ioi.mpr one_pos) hConstant
    (rootSeq_isingValueSeq_at_one q) hOneValue.symm hPow

end Ising3DCut.LimitQuantity
