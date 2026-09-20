/- 具体版が必要十分版の整数格子上の反復横断階段への特殊化であることの導出。 -/
import Ising2DLambda.KacWard.IteratedStaircaseParallelWidth

namespace Ising2DLambda.KacWard

/-- `claim_iterated_staircase_parallel_width_bound` を必要十分版から導いたもの。 -/
theorem iteratedTransverseStaircase_parallel_width_bound_from_necSuf
    (wh wv : ℤ) (base : ℤ × ℤ) (hwind : (wh, wv) ≠ (0, 0)) (s : ℕ) :
    min 0 (wh * wv) ≤
        windingParallelCoordinate wv wh (iteratedTransverseStaircase wh wv base s) -
          windingParallelCoordinate wv wh base ∧
      windingParallelCoordinate wv wh (iteratedTransverseStaircase wh wv base s) -
          windingParallelCoordinate wv wh base ≤ max 0 (wh * wv) :=
  iteratedTransverseStaircase_parallel_width_bound wh wv base hwind s

end Ising2DLambda.KacWard
