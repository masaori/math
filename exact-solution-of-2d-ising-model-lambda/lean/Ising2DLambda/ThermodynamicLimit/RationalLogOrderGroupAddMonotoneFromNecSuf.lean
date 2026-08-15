/- 必要十分版を具体的な Λ_ℚ・共通分母・Λ の順序へ特殊化する。
添字は `ℕ`、良さは `N ≥ 1`、`Rep` は `IsCommonDenominator`、`le` は `logOrderLE`。 -/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupAddMonotone
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupAddMonotone

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_add_right_from_necSuf {l m : RationalLogOrderGroup}
    (h : rationalLogOrderLE l m) (n : RationalLogOrderGroup) :
    rationalLogOrderLE (l + n) (m + n) :=
  NecSuf.ThermodynamicLimit.indexedLE_add_right_necSuf IsCommonDenominator (fun N : ℕ => 1 ≤ N)
    logOrderLE commonDenominator_three_exists
    (fun N N' l m lN mN lN' mN' hN hN' hl hm hl' hm' =>
      commonDenominator_order_independent N N' hN hN' l m lN mN lN' mN' hl hm hl' hm')
    (fun N l n lN nN hl hn => commonDenominator_add N l n lN nN hl hn)
    (fun _ _ c e => logOrderLE_add_right e c) h n

end Ising2DLambda.ThermodynamicLimit
