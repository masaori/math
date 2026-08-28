/-
必要十分版 `Ising3DCut.NecSuf.cofinalPairFailure_and_noLimit` からの導出。

添字の二つの列を偶数幅 `2k+2` と奇数幅 `2k+3` に取り、二項関係を交差冪等式、
値の列を乗根列として特殊化する。ここに残る模型固有の内容は、
偶数幅と奇数幅での有限箱量の値と、`1 ≠ 2 ^ n`（`n ≠ 0`）という有限算術だけである。

具体版の定理はここで呼び直していない。
-/
import Ising3DCut.LimitQuantity.TailCrossPowerFailureNotSufficientForLimitQuantity
import Ising3DCut.NecSuf.CofinalPairFailureNotSufficientForLimit

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 偶数幅の次の奇数幅との対では交差冪等式が破れる（有限算術の段）。 -/
theorem alternating_crossPower_fails_on_adjacent_pair (k : ℕ) :
    ¬ alternatingValueSeq (2 * k + 2) ^ ((2 * k + 3) ^ 3)
        = alternatingValueSeq (2 * k + 3) ^ ((2 * k + 2) ^ 3) := by
  have hEven : (2 * k + 2) % 2 = 0 := by omega
  have hOdd : (2 * k + 3) % 2 ≠ 0 := by omega
  have hexponent : 0 < (2 * k + 3) ^ 3 * (2 * k + 2) ^ 3 := by positivity
  have hpow : 1 < 2 ^ ((2 * k + 3) ^ 3 * (2 * k + 2) ^ 3) :=
    (Nat.one_lt_pow_iff (Nat.ne_of_gt hexponent)).2 (by norm_num)
  simpa [alternatingValueSeq, hEven, hOdd, pow_mul] using Nat.ne_of_lt hpow

/-- `claim_tail_cross_power_failure_not_sufficient_for_limit_quantity` を必要十分版から取り出す。 -/
theorem tail_cross_power_failure_not_sufficient_for_limit_quantity_viaNecSuf :
    (∀ K : ℕ, ∃ L M : ℕ,
      max K 1 ≤ L ∧ max K 1 ≤ M ∧
        alternatingValueSeq L ^ (M ^ 3) ≠ alternatingValueSeq M ^ (L ^ 3)) ∧
    ¬ ∃ α : ℝ, Tendsto alternatingRootSeq atTop (𝓝 α) := by
  have hbase :=
    Ising3DCut.NecSuf.cofinalPairFailure_and_noLimit
      (fun L M => alternatingValueSeq L ^ (M ^ 3) = alternatingValueSeq M ^ (L ^ 3))
      alternatingRootSeq (fun k => 2 * k + 2) (fun k => 2 * k + 3)
      (tendsto_atTop_atTop.2 (fun b => ⟨b, fun k hk => by omega⟩))
      (tendsto_atTop_atTop.2 (fun b => ⟨b, fun k hk => by omega⟩))
      alternating_crossPower_fails_on_adjacent_pair
      (c₁ := 1) (c₂ := 2)
      (fun k => by
        have hEven : (2 * k + 2) % 2 = 0 := by omega
        simp [alternatingRootSeq, hEven])
      (fun k => by simp [alternatingRootSeq])
      (by norm_num)
  exact ⟨fun K => hbase.1 (max K 1), hbase.2⟩

end Ising3DCut.LimitQuantity
