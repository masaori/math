/- 必要十分版を具体的な正の有理数の対数と対数順序群の順序へ特殊化する。
`f` は `logRat`、`g` は `rationalOfLog`、`P` は `0 < ·`、`leX` は `ℚ` の `≤`。 -/
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.NecSuf.FreeEntropy.RationalLogOrderIff

namespace Ising2DLambda.FreeEntropy

theorem logRat_le_iff_from_necSuf {q q' : ℚ} (hq : 0 < q) (hq' : 0 < q') :
    q ≤ q' ↔ logOrderLE (logRat q) (logRat q') :=
  Ising2DLambda.NecSuf.FreeEntropy.pullback_order_iff_of_left_inverse_necSuf
    logRat rationalOfLog (fun q : ℚ => 0 < q) (· ≤ ·)
    (fun l => rationalOfLog_pos l) (fun l => logRat_rationalOfLog l)
    (fun _ _ h h' e => logRat_injective_of_pos h h' e) hq hq'

end Ising2DLambda.FreeEntropy
