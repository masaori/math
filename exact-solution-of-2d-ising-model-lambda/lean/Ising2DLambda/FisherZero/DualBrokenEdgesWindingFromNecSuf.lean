/-
有限置換上の二値変化の必要十分版を、破れた辺の双対像へ特殊化する導出。
具体版は同じ必要十分版を二つの周期方向へ直接適用している。
-/
import Ising2DLambda.FisherZero.DualBrokenEdgesWinding

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial

/-- 必要十分版から得る、破れた辺の双対像の巻き付き偶奇の消滅。 -/
theorem dualBrokenEdgeSet_winding_zero_from_necSuf (L : ℕ) [NeZero L]
    (sigma : Config L) :
    torusHomologySector L (dualBrokenEdgeSet L sigma) = (0, 0) :=
  dualBrokenEdgeSet_winding_zero L sigma

end Ising2DLambda.FisherZero
