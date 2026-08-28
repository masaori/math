/-
人手証明「どの閾値の先にもある交差冪等式の破れだけでは極限量の存在を保証しない」
（ラベル `claim_tail_cross_power_failure_not_sufficient_for_limit_quantity`）の Lean 具体版。

箱幅の偶奇で有限箱量を `1` と `2 ^ L ^ 3` に分ける。任意の閾値以後に偶数幅と
その次の奇数幅を取り、交差冪等式が破れることを有限算術で示す。一方、対応する
乗根列は偶数幅で `1`、奇数幅で `2` なので、二つの共終な定数部分列を持ち極限がない。
-/
import Ising3DCut.NecSuf.ResidueClassValuesDifferNoLimitQuantity

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 人手証明の正の有理有限箱値 `A_L`。 -/
def alternatingValueSeq (L : ℕ) : ℕ :=
  if L % 2 = 0 then 1 else 2 ^ (L ^ 3)

/-- 人手証明の乗根列 `c_L` を実数へ埋め込んだもの。 -/
def alternatingRootSeq (L : ℕ) : ℝ :=
  if L % 2 = 0 then 1 else 2

/-- `claim_tail_cross_power_failure_not_sufficient_for_limit_quantity` の具体版。 -/
theorem tail_cross_power_failure_not_sufficient_for_limit_quantity :
    (∀ K : ℕ, ∃ L M : ℕ,
      max K 1 ≤ L ∧ max K 1 ≤ M ∧
        alternatingValueSeq L ^ (M ^ 3) ≠ alternatingValueSeq M ^ (L ^ 3)) ∧
    ¬ ∃ α : ℝ, Tendsto alternatingRootSeq atTop (𝓝 α) := by
  constructor
  · intro K
    let T := max K 1
    refine ⟨2 * T, 2 * T + 1, ?_, ?_, ?_⟩
    · dsimp [T]
      omega
    · dsimp [T]
      omega
    · have hTpos : 0 < T := by
        dsimp [T]
        omega
      have hEven : (2 * T) % 2 = 0 := by omega
      have hOdd : (2 * T + 1) % 2 ≠ 0 := by omega
      have hexponent : 0 < (2 * T + 1) ^ 3 * (2 * T) ^ 3 := by positivity
      have hpow : 1 < 2 ^ ((2 * T + 1) ^ 3 * (2 * T) ^ 3) :=
        (Nat.one_lt_pow_iff (Nat.ne_of_gt hexponent)).2 (by norm_num)
      simpa [alternatingValueSeq, hEven, hOdd, pow_mul] using Nat.ne_of_lt hpow
  · apply Ising3DCut.NecSuf.differingConstantCofinalSubsequences_noLimit
      alternatingRootSeq (fun k => 2 * k + 2) (fun k => 2 * k + 3)
      (c₁ := 1) (c₂ := 2)
    · refine tendsto_atTop_atTop.2 (fun b => ⟨b, fun k hk => ?_⟩)
      omega
    · refine tendsto_atTop_atTop.2 (fun b => ⟨b, fun k hk => ?_⟩)
      omega
    · intro k
      have hEven : (2 * k + 2) % 2 = 0 := by omega
      simp [alternatingRootSeq, hEven]
    · intro k
      have hOdd : (2 * k + 3) % 2 ≠ 0 := by omega
      simp [alternatingRootSeq]
    · norm_num

end Ising3DCut.LimitQuantity
