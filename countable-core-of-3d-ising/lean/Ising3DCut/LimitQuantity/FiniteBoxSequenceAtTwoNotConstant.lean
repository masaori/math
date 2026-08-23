/-
人手証明「有理点 2 では有限箱の量の列は定数列でない」
（ラベル `claim_finite_box_sequence_at_two_is_not_constant`）の Lean 具体版。

`L = 1, 2` の有限箱計算から正の実数乗根を取った二項が相異なることを導く段を形式化する。
`L = 1` の有限箱計算 `Z_1(2) = 2` は
`FiniteBoxValueAtTwoForBoxOne`（`isingValueSeq_two_at_one`）で閉じてあるので、
下の `rootSeq_isingValueSeq_two_not_constant_of_box_two` はそれを外した形になる。
`L = 2` の有限箱計算 `Z_2(2) > 2^8` の Lean 化は次段に残す。
箱の大きさの極限は使わない。
-/
import Ising3DCut.LimitQuantity.FiniteBoxValueAtTwoForBoxOne
import Ising3DCut.NullModel.PartitionSupportEndpoints

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 人手証明の二つ目の有限箱計算 `Z₂(2) > 2⁸`。
各係数の非負性により有限和は最高次項以上であり、`L = 2` では辺数が `12`、
最高次係数が `2` 以上なので、その項だけで `2 * 2^12 > 2^8` である。 -/
theorem isingValueSeq_two_at_two_gt_two_pow_eight :
    (256 : ℝ) < isingValueSeq 2 2 := by
  have hEdge : Fintype.card (Edge 2) = 12 := by native_decide
  have hTop : 2 ≤ NullModel.multiplicity 2 (Fintype.card (Edge 2)) :=
    NullModel.two_le_multiplicity_full (by norm_num)
  have hLower :
      (2 : ℚ) * 2 ^ Fintype.card (Edge 2) ≤
        evalAtRational 2 (partitionPolynomial 2) := by
    rw [partitionPolynomial, evalAtRational, map_sum]
    simp only [Polynomial.coe_eval₂RingHom, Polynomial.eval₂_monomial, eq_intCast]
    apply le_trans _ (Finset.single_le_sum
      (fun m _ => mul_nonneg
        (by exact_mod_cast Nat.zero_le (NullModel.multiplicity 2 m)) (by positivity))
      (Finset.mem_range.mpr (Nat.lt_succ_self _)))
    exact mul_le_mul_of_nonneg_right (by exact_mod_cast hTop) (by positivity)
  unfold isingValueSeq
  exact_mod_cast (lt_of_lt_of_le (by norm_num [hEdge]) hLower)

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

/-- `L = 1` の有限箱計算を閉じた版。残る仮定は `L = 2` の有限箱計算だけである。 -/
theorem rootSeq_isingValueSeq_two_not_constant_of_box_two
    (hTwoValue : (256 : ℝ) < isingValueSeq 2 2) :
    ¬ ∃ c : ℝ, rootSeq (isingValueSeq 2) siteCountSeq = fun _ => c :=
  rootSeq_isingValueSeq_two_not_constant isingValueSeq_two_at_one hTwoValue

/-- `L = 1,2` の有限箱計算をともに閉じた具体版。 -/
theorem rootSeq_isingValueSeq_two_not_constant_closed :
    ¬ ∃ c : ℝ, rootSeq (isingValueSeq 2) siteCountSeq = fun _ => c :=
  rootSeq_isingValueSeq_two_not_constant_of_box_two
    isingValueSeq_two_at_two_gt_two_pow_eight

end Ising3DCut.LimitQuantity
