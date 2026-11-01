/-
具体版が必要十分版の特殊化として得られることの導出。

四方向の標準整数代表、一歩の回転数、二つの門横断指示子を必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.DirectionGateCrossingTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `claim_direction_gate_crossing_turning` を必要十分版から導く。 -/
theorem directionGateCrossing_turning_from_necSuf
    (n : ℕ) (direction : ℕ → ZMod 4) (turn : ℕ → Turn)
    (hadvance : ∀ k < n,
      direction (k + 1) = direction k + ((turnValue (turn k) : ℤ) : ZMod 4))
    (hclosed : direction n = direction 0) :
    (∑ k ∈ Finset.range n, turnValue (turn k)) =
      4 * ((positiveDirectionGateCrossingCount n direction : ℤ)
        - (negativeDirectionGateCrossingCount n direction : ℤ)) :=
  directionGateCrossing_turning n direction turn hadvance hclosed

end Ising2DLambda.KacWard
