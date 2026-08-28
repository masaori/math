/-
人手証明「第二の極限量候補は無限個の有限箱量を持つ」
（ラベル `claim_second_limit_quantity_candidate_has_infinite_range`）の Lean 具体版。

証明は、値域が有限であると仮定し、既出の有限値域点の分類から `q = 1` を得て
`q ≠ 1` に反するという対偶一段である。唯一の非可算への脱出は `hlimit` に含まれる
箱の大きさの極限である。
-/
import Ising3DCut.LimitQuantity.FiniteRangeLimitQuantityOnlyAtOne

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- `claim_second_limit_quantity_candidate_has_infinite_range` の具体版。 -/
theorem second_limit_quantity_candidate_has_infinite_range
    (q : ℚ) {α : ℝ} (hq_ne_one : q ≠ 1)
    (hlimit : Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (𝓝 α))
    (heventuallyConstantOnlyAtOne :
      (∃ L0 c, ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = c) → q = 1) :
    (Set.range (rootSeq (isingValueSeq q) siteCountSeq)).Infinite := by
  intro hfinite
  exact hq_ne_one
    (finite_range_limit_quantity_only_at_one q hfinite hlimit heventuallyConstantOnlyAtOne)

end Ising3DCut.LimitQuantity
