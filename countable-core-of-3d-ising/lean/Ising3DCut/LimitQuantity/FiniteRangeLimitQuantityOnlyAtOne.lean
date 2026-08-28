/-
人手証明「有限個の値しかとらず極限量を持つ正の有理点は 1 に限られる」
（ラベル `claim_finitely_many_values_limit_quantity_only_at_one`）の Lean 具体版。

証明は、有限値域と極限量の存在から末尾定数性を得る既出の主張を適用し、
末尾定数となる正の有理点は 1 に限られる既出の分類へ渡す一段だけである。
後者は人手証明でも既出の主張を引用しているため、その引用を仮定として明示する。
唯一の非可算への脱出は `hlimit` に含まれる箱の大きさの極限である。
-/
import Ising3DCut.LimitQuantity.InfiniteLevelSetValueEqualsLimit

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- `claim_finitely_many_values_limit_quantity_only_at_one` の具体版。 -/
theorem finite_range_limit_quantity_only_at_one (q : ℚ) {α : ℝ}
    (hfin : (Set.range (rootSeq (isingValueSeq q) siteCountSeq)).Finite)
    (hlimit : Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (𝓝 α))
    (heventuallyConstantOnlyAtOne :
      (∃ L0 c, ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = c) → q = 1) :
    q = 1 := by
  obtain ⟨L0, hconstant⟩ := ising_eventually_constant_of_finite_range q hlimit hfin
  exact heventuallyConstantOnlyAtOne ⟨L0, α, hconstant⟩

end Ising3DCut.LimitQuantity
