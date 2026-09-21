/- 具体版が必要十分版の整数格子上の二つの反復横断階段への特殊化であることの導出。 -/
import Ising2DLambda.KacWard.ParallelSeparatedStaircases

namespace Ising2DLambda.KacWard

/-- `claim_parallel_separated_staircases_disjoint` を必要十分版から導いたもの。 -/
theorem parallelSeparatedIteratedTransverseStaircases_ne_from_necSuf
    (wh wv : ℤ) (hwind : (wh, wv) ≠ (0, 0))
    (leftBase rightBase : ℤ × ℤ) (t t' s s' : ℕ)
    (ht : 1 ≤ t) (ht' : 1 ≤ t')
    (hs : s ≤ t * (wh.natAbs + wv.natAbs))
    (hs' : s' ≤ t' * (wh.natAbs + wv.natAbs))
    (hseparated :
      |windingParallelCoordinate wv wh leftBase -
        windingParallelCoordinate wv wh rightBase| > |wh * wv|) :
    iteratedTransverseStaircase wh wv leftBase s ≠
      iteratedTransverseStaircase wh wv rightBase s' :=
  parallelSeparatedIteratedTransverseStaircases_ne
    wh wv hwind leftBase rightBase t t' s s' ht ht' hs hs' hseparated

end Ising2DLambda.KacWard
