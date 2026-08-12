/-
必要十分版の四符号の偶数性を、配位の破れた辺の双対像へ特殊化する導出。
具体版 `dualBrokenEdgeSet_isEven` は、局所端点数を四つの破れ指示子の和へ
書き換えたあと、`four_signs_even_necSuf` を直接適用している。
-/
import Ising2DLambda.FisherZero.DualBrokenEdgesEven

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial

/-- 四符号の必要十分版から得る、破れた辺の双対像の偶部分グラフ性。 -/
theorem dualBrokenEdgeSet_isEven_from_necSuf (L : ℕ) [NeZero L] (sigma : Config L) :
    IsEvenEdgeSubset L (dualBrokenEdgeSet L sigma) :=
  dualBrokenEdgeSet_isEven L sigma

end Ising2DLambda.FisherZero
