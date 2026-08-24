/- 人手証明「有限箱の量が定数列なら有理点は 1 である」の Lean 具体版。
箱の大きさの極限は使わず、`L = 1, 2` の二つの有限箱だけを比較する。 -/
import Ising3DCut.LimitQuantity.FiniteBoxSequenceAtTwoNotConstant
import Ising3DCut.LimitQuantity.PartitionValuePositive

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 箱 `2` の分配多項式は正の有理数上で狭義単調である。 -/
theorem partitionPolynomial_two_strictMono {q r : ℚ} (hq : 0 < q) (hqr : q < r) :
    evalAtRational q (partitionPolynomial 2) <
      evalAtRational r (partitionPolynomial 2) := by
  rw [partitionPolynomial, evalAtRational, evalAtRational, map_sum, map_sum]
  simp only [Polynomial.coe_eval₂RingHom, Polynomial.eval₂_monomial, eq_intCast]
  apply Finset.sum_lt_sum
  · intro m hm
    exact mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hq.le hqr.le m)
      (by exact_mod_cast Nat.zero_le (NullModel.multiplicity 2 m))
  · refine ⟨Fintype.card (Edge 2), Finset.mem_range.mpr (Nat.lt_succ_self _), ?_⟩
    apply mul_lt_mul_of_pos_left (pow_lt_pow_left₀ hqr hq.le (by native_decide))
    have hTop : 2 ≤ NullModel.multiplicity 2 (Fintype.card (Edge 2)) :=
      two_le_multiplicity_full (by norm_num)
    exact_mod_cast (lt_of_lt_of_le (by norm_num : 0 < 2) hTop)

/-- 人手証明の第一段。箱 `1` の有限箱量は任意の正の有理点で `2` である。 -/
theorem rootSeq_isingValueSeq_at_one (q : ℚ) :
    rootSeq (isingValueSeq q) siteCountSeq 1 = 2 := by
  have hCount : siteCountSeq 1 = 1 := by
    unfold siteCountSeq
    rw [card_site]
    norm_num
  have hValue : isingValueSeq q 1 = 2 := by
    unfold isingValueSeq
    rw [partitionPolynomial_box_one]
    simp [map_ofNat]
  unfold rootSeq
  rw [hCount, hValue]
  exact (eq_posRoot_of_pow_eq 2 2 (by norm_num) (by norm_num) 1 one_ne_zero
    (by norm_num)).symm

/-- `claim_constant_finite_box_sequence_only_at_one` の具体版。 -/
theorem constant_finite_box_sequence_only_at_one
    (q : ℚ) (hq : 0 < q)
    (hConstant : ∃ c : ℝ, rootSeq (isingValueSeq q) siteCountSeq = fun _ => c) :
    q = 1 := by
  rcases hConstant with ⟨c, hc⟩
  have hOne := congrFun hc 1
  have hTwo := congrFun hc 2
  have hRootTwo : rootSeq (isingValueSeq q) siteCountSeq 2 = 2 := by
    rw [rootSeq_isingValueSeq_at_one q] at hOne
    exact hTwo.trans hOne.symm
  have hPositive : (0 : ℝ) < isingValueSeq q 2 := by
    unfold isingValueSeq
    exact_mod_cast partitionPolynomial_evalAtRational_pos (by norm_num : 0 < 2) hq
  have hPow := posRoot_pow (isingValueSeq q 2) hPositive 8 (by norm_num)
  have hCount : siteCountSeq 2 = 8 := by
    unfold siteCountSeq
    rw [card_site]
    norm_num
  unfold rootSeq at hRootTwo
  rw [hCount] at hRootTwo
  rw [hRootTwo] at hPow
  norm_num at hPow
  have hValue : evalAtRational q (partitionPolynomial 2) =
      evalAtRational 1 (partitionPolynomial 2) := by
    have hOneValue := isingValueSeq_one 2
    unfold isingValueSeq at hPow hOneValue
    norm_num [siteCountSeq, card_site] at hOneValue
    exact_mod_cast hPow.symm.trans hOneValue.symm
  rcases lt_trichotomy q 1 with hlt | heq | hgt
  · exact absurd hValue (ne_of_lt (partitionPolynomial_two_strictMono hq hlt))
  · exact heq
  · exact absurd hValue.symm
      (ne_of_lt (partitionPolynomial_two_strictMono (by norm_num) hgt))

end Ising3DCut.LimitQuantity
