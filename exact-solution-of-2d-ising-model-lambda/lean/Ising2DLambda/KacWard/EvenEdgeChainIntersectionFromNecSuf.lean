/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.EvenEdgeChainIntersection
import Ising2DLambda.NecSuf.KacWard.EvenEdgeChainIntersection

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

/-- 具体的な辺係数を必要十分な有限添字の交差形式へ代入する。 -/
theorem evenEdgeChainIntersection_from_necSuf (L : ℕ) [NeZero L]
    (C D : Finset (Edge L)) :
    evenEdgeChainIntersection L C D =
      Ising2DLambda.NecSuf.KacWard.finiteEdgeChainIntersection
        (fun i : ZMod L => i - 1) (fun j : ZMod L => j + 1)
        (horizontalChainCoefficient L C) (verticalChainCoefficient L C)
        (horizontalChainCoefficient L D) (verticalChainCoefficient L D) := rfl

end Ising2DLambda.KacWard
