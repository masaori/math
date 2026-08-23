/-
人手証明「有理点 2 では有限箱の量の列は定数列でない」
（ラベル `claim_finite_box_sequence_at_two_is_not_constant`）の Lean 具体版。

この tick では、`L = 1, 2` の有限箱計算から正の実数乗根を取った二項が
相異なることを導く段を形式化する。有限箱計算そのものの Lean 化は次段に残す。
箱の大きさの極限は使わない。
-/
import Ising3DCut.LimitQuantity.LimitQuantityAtOneEqualsTwo

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 人手証明の最初の有限箱計算 `a₁(2) = 2`。 -/
theorem rootSeq_isingValueSeq_two_at_one
    (hValue : isingValueSeq 2 1 = 2) :
    rootSeq (isingValueSeq 2) siteCountSeq 1 = 2 := by
  have hCount : siteCountSeq 1 = 1 := by
    unfold siteCountSeq
    rw [card_site]
    norm_num
  unfold rootSeq
  rw [hCount, hValue]
  exact (eq_posRoot_of_pow_eq 2 2 (by norm_num) (by norm_num) 1 one_ne_zero
    (by norm_num)).symm

/-- 人手証明の二つ目の有限箱計算 `a₂(2) ≠ 2`。 -/
theorem rootSeq_isingValueSeq_two_at_two_ne_two
    (hValue : (256 : ℝ) < isingValueSeq 2 2) :
    rootSeq (isingValueSeq 2) siteCountSeq 2 ≠ 2 := by
  have hCount : siteCountSeq 2 = 8 := by
    unfold siteCountSeq
    rw [card_site]
    norm_num
  intro hEq
  have hPositive : (0 : ℝ) < isingValueSeq 2 2 := lt_trans (by norm_num) hValue
  have hPow := posRoot_pow (isingValueSeq 2 2) hPositive 8 (by norm_num)
  unfold rootSeq at hEq
  rw [hCount] at hEq
  rw [hEq] at hPow
  norm_num at hPow
  exact (ne_of_gt hValue) hPow.symm

/-- `claim_finite_box_sequence_at_two_is_not_constant` の具体版。 -/
theorem rootSeq_isingValueSeq_two_not_constant :
    isingValueSeq 2 1 = 2 →
      (256 : ℝ) < isingValueSeq 2 2 →
      ¬ ∃ c : ℝ, rootSeq (isingValueSeq 2) siteCountSeq = fun _ => c := by
  intro hOneValue hTwoValue
  rintro ⟨c, hConstant⟩
  have hOne := congrFun hConstant 1
  have hTwo := congrFun hConstant 2
  rw [rootSeq_isingValueSeq_two_at_one hOneValue] at hOne
  apply rootSeq_isingValueSeq_two_at_two_ne_two hTwoValue
  exact hTwo.trans hOne.symm

end Ising3DCut.LimitQuantity
