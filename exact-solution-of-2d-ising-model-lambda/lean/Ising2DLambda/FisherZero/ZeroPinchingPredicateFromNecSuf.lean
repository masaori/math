/- 必要十分版を詰め寄りの述語の具体的なデータへ特殊化する導出。住処: Q と Qbar。 -/
import Ising2DLambda.FisherZero.ZeroPinchingPredicate
import Ising2DLambda.NecSuf.FisherZero.ZeroPinchingPredicate

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 距離の二乗の非零性を、集合所属だけを使う必要十分版から導く。 -/
theorem distanceSquaredToPositiveRational_ne_zero_from_necSuf
    (data : RealClosedSubfieldData) {L : ℕ} [NeZero L]
    {xi : Qbar} (hxi : xi ∈ FisherZeroSet L) (q : PositiveRational) :
    distanceSquaredToRational data xi q.1 ≠ 0 := by
  exact Ising2DLambda.NecSuf.FisherZero.distance_ne_zero_of_zero_implies_equal_necSuf
    (distanceSquaredToRational data xi q.1)
    xi
    (q.1 : Qbar)
    (FisherZeroSet L)
    hxi
    (fun hzero => (distanceSquaredToRational_eq_zero_iff data xi q.1).mp hzero)
    (positiveRational_not_mem_fisherZero L q.2)

end Ising2DLambda.FisherZero
