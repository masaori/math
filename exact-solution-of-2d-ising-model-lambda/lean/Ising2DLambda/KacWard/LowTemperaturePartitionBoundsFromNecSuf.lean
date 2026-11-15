import Ising2DLambda.KacWard.LowTemperaturePartitionBounds
import Ising2DLambda.NecSuf.KacWard.LowTemperaturePartitionBounds

/-!
具体版 `lowTemperaturePartitionBounds`（`claim_low_temperature_partition_bounds`）を、必要十分版から得る導出版。

`K = ℚ`、`ι = SpinStructure`（`|𝒮| = 4` は `spinStructures_card`）、`f = Q^{·}_L(q)`、`Z = Z_L(q)` に特殊化する。
`f` の非負性は四つの値の正値性（`signedEvenSubgraphPolynomial_rational_sign`）から、
`2 Z = Σ f` は有限トーラス公式の評価（`finiteTorusPolynomial_eval_rat`）から取る。
-/

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

theorem lowTemperaturePartitionBounds_from_necSuf (data : RealClosedSubfieldData) {L : ℕ}
    [NeZero L] (z : Qbar) (hz4 : z ^ 4 = -1) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (hc : q ^ 2 + 2 * q - 1 < 0) :
    signedEvenSubgraphMax L q / 2 ≤ partitionValue L q ∧
      partitionValue L q ≤ 2 * signedEvenSubgraphMax L q :=
  Ising2DLambda.NecSuf.KacWard.half_sum_two_sided_bounds_necSuf spinStructure_univ_nonempty
    spinStructures_card (signedEvenSubgraphValue L q)
    (fun s => ((signedEvenSubgraphPolynomial_rational_sign data z hz4 s q hq0 hq1).1 hc).le)
    (partitionValue L q) (finiteTorusPolynomial_eval_rat L q)

end Ising2DLambda.KacWard
