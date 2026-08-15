/- 必要十分版を具体的な Λ_ℚ・共通分母・Λ の順序へ特殊化する。
添字は `ℕ`、良さは `N ≥ 1`、`Rep` は `IsCommonDenominator`、`le` は `logOrderLE`、
共通の良い添字は `L^2`、証人は `λ, μ` 自身（`commonDenominator_scaled_toRational`）。 -/
import Ising2DLambda.ThermodynamicLimit.ScaledEmbeddingOrderTransfer
import Ising2DLambda.NecSuf.ThermodynamicLimit.ScaledEmbeddingOrderTransfer

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_scaled_toRational_iff_from_necSuf (L : ℕ) [NeZero L]
    (l m : LogOrderGroup) :
    rationalLogOrderLE (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l)
        (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational m) ↔ logOrderLE l m :=
  NecSuf.ThermodynamicLimit.indexedLE_iff_of_common_good_index_necSuf IsCommonDenominator
    (fun N : ℕ => 1 ≤ N) logOrderLE
    (fun N N' l m lN mN lN' mN' hN hN' hl hm hl' hm' =>
      commonDenominator_order_independent N N' hN hN' l m lN mN lN' mN' hl hm hl' hm')
    (Nat.one_le_iff_ne_zero.mpr (pow_ne_zero 2 (NeZero.ne L)))
    (commonDenominator_scaled_toRational L l) (commonDenominator_scaled_toRational L m)

end Ising2DLambda.ThermodynamicLimit
