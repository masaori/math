import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 有限の行・列添字と二つの辺係数だけを使う交差形式。 -/
def finiteEdgeChainIntersection {I J : Type*} [Fintype I] [Fintype J]
    (previousRow : I → I) (nextColumn : J → J)
    (horizontalC verticalC horizontalD verticalD : I → J → ZMod 2) : ZMod 2 :=
  ∑ i : I, ∑ j : J,
    (horizontalC i j * verticalD (previousRow i) (nextColumn j) +
      verticalC i j * horizontalD i j)

end Ising2DLambda.NecSuf.KacWard
