/-
人手証明「剰余類ごとの定数値が二つ相異なるなら極限量は存在しない」
（ラベル `claim_residue_class_values_differ_no_limit_quantity`）の Lean 具体版。

極限量が存在すると仮定し、各剰余類 `t` について添字 `k ↦ L0 + t + k * p` の
部分列を取る。この添字列は `atTop` へ飛ぶので部分列も同じ極限へ収束し、
一方で剰余類ごとの末尾定数性からこの部分列は定数 `a_{L0+t}` である。
定数列の極限はその定数なので、ℝ の極限の一意性から `a_{L0+t}` が極限量に等しい。
これが全ての剰余類で成り立つので、相異なると仮定した二つの定数値が一致してしまう。

使うのは ℝ の極限の一意性と、部分列・定数列の極限だけであり、
上限・下限・積分・微分・無限和は使わない。唯一の非可算への脱出は
極限量の定義に含まれる箱の大きさの極限である。
-/
import Ising3DCut.LimitQuantity.ResidueClassValuesAgreeGivesEventuallyConstant
import Ising3DCut.LimitQuantity.LimitQuantityDeterminedBySequence

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 剰余類の添字列 `k ↦ L0 + t + k * p` は、周期が正なら `atTop` へ飛ぶ。 -/
theorem tendsto_residue_class_index_atTop {L0 t p : ℕ} (hp : 0 < p) :
    Tendsto (fun k : ℕ => L0 + t + k * p) atTop atTop := by
  refine tendsto_atTop_atTop.2 (fun b => ⟨b, fun k hk => ?_⟩)
  have hkp : k ≤ k * p := Nat.le_mul_of_pos_right k hp
  omega

/-- 末尾周期的なら、各剰余類の定数値は極限量に等しい。 -/
theorem residue_class_value_eq_limitQuantity (q : ℚ) {L0 p : ℕ} (hp : 0 < p)
    (hperiodic : ∀ L, L0 ≤ L →
      rootSeq (isingValueSeq q) siteCountSeq L =
        rootSeq (isingValueSeq q) siteCountSeq (L + p))
    {α : ℝ} (hlimit : Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (𝓝 α))
    (t : ℕ) :
    rootSeq (isingValueSeq q) siteCountSeq (L0 + t) = α := by
  -- 部分列は同じ極限へ収束する。
  have hsub :
      Tendsto (fun k : ℕ => rootSeq (isingValueSeq q) siteCountSeq (L0 + t + k * p))
        atTop (𝓝 α) :=
    hlimit.comp (tendsto_residue_class_index_atTop hp)
  -- その部分列は剰余類ごとの末尾定数性により定数列である。
  have hconst :
      (fun k : ℕ => rootSeq (isingValueSeq q) siteCountSeq (L0 + t + k * p)) =
        fun _ : ℕ => rootSeq (isingValueSeq q) siteCountSeq (L0 + t) :=
    funext (eventually_periodic_residue_class_constant q hperiodic t)
  rw [hconst] at hsub
  -- 定数列の極限はその定数であり、ℝ の極限は一意である。
  exact tendsto_nhds_unique tendsto_const_nhds hsub

/-- `claim_residue_class_values_differ_no_limit_quantity` の具体版。 -/
theorem residue_class_values_differ_no_limit_quantity (q : ℚ) {L0 p : ℕ} (hp : 0 < p)
    (hperiodic : ∀ L, L0 ≤ L →
      rootSeq (isingValueSeq q) siteCountSeq L =
        rootSeq (isingValueSeq q) siteCountSeq (L + p))
    {r s : ℕ}
    (hdiffer : rootSeq (isingValueSeq q) siteCountSeq (L0 + r) ≠
      rootSeq (isingValueSeq q) siteCountSeq (L0 + s)) :
    ¬ ∃ α : ℝ, Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (𝓝 α) := by
  rintro ⟨α, hlimit⟩
  have hr := residue_class_value_eq_limitQuantity q hp hperiodic hlimit r
  have hs := residue_class_value_eq_limitQuantity q hp hperiodic hlimit s
  exact hdiffer (hr.trans hs.symm)

end Ising3DCut.LimitQuantity
