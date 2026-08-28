/-
人手証明「末尾周期的で極限量を持つ正の有理点は 1 だけである」
（ラベル `claim_eventually_periodic_limit_quantity_only_at_one`）の Lean 具体版。

人手証明は、剰余類ごとの定数値が「すべて一致する」か「相異なる二つがある」かの
排他的な場合分け一本で閉じている。相異なる側は極限量の非存在へ落ちて仮定に反し、
一致する側は末尾定数性を経て、既に閉じた「末尾定数となる正の有理点は 1 に限られる」
（ラベル `claim_eventually_constant_only_at_one`）へ渡す。

その最後の一段は人手証明でも既出の主張の引用であり、Lean 側では
有限箱値の有理数表示を経由する別系統
（`EventuallyConstantOnlyAtOneBundleFreeBox` の `eq_one_of_cross_power_identity_from_free_box`）
として既に閉じている。ここで束ねるのは場合分けの一本であって引用先の再証明ではないので、
その引用を仮定 `heventuallyConstantOnlyAtOne` として明示的に受け取る形で書く
（人手証明が `claim_eventually_constant_only_at_one` を引用しているのと 1 対 1 に対応する）。

使うのは有限個の実数の等号の場合分けと、直前に閉じた三つの主張だけである。
上限・下限・積分・微分・無限和は使わない。唯一の非可算への脱出は
極限量の定義に含まれる箱の大きさの極限である。
-/
import Ising3DCut.LimitQuantity.ResidueClassValuesDifferNoLimitQuantity

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- `claim_eventually_periodic_limit_quantity_only_at_one` の具体版。 -/
theorem eventually_periodic_limit_quantity_only_at_one (q : ℚ) {L0 p : ℕ} (hp : 0 < p)
    (hperiodic : ∀ L, L0 ≤ L →
      rootSeq (isingValueSeq q) siteCountSeq L =
        rootSeq (isingValueSeq q) siteCountSeq (L + p))
    (heventuallyConstantOnlyAtOne :
      (∃ c : ℝ, ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = c) → q = 1)
    (hlimit : ∃ α : ℝ, Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (𝓝 α)) :
    q = 1 := by
  -- 有限個の剰余類の定数値について、すべてが等しいか相異なる二つがあるかで場合を分ける。
  by_cases hagree :
      ∀ r : ℕ, r < p →
        rootSeq (isingValueSeq q) siteCountSeq (L0 + r) =
          rootSeq (isingValueSeq q) siteCountSeq (L0 + 0)
  · -- 一致する場合。剰余類ごとの値の一致から列は末尾定数である。
    refine heventuallyConstantOnlyAtOne
      ⟨rootSeq (isingValueSeq q) siteCountSeq (L0 + 0), ?_⟩
    exact residue_class_values_agree_gives_eventually_constant q hp hperiodic hagree
  · -- 相異なる二つがある場合。極限量は存在しないので仮定に反する。
    push_neg at hagree
    obtain ⟨r, _, hdiffer⟩ := hagree
    exact absurd hlimit
      (residue_class_values_differ_no_limit_quantity q hp hperiodic hdiffer)

end Ising3DCut.LimitQuantity
