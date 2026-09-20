/- 具体版が必要十分版の整数格子上の反復階段と周期並進への特殊化であることの導出。 -/
import Ising2DLambda.KacWard.PeriodTranslatesOfIteratedStaircase

namespace Ising2DLambda.KacWard

/-- `claim_period_translates_of_iterated_staircase_disjoint` を必要十分版から導いたもの。 -/
theorem iteratedTransverseStaircase_ne_period_translate_from_necSuf
    (L : ℕ) (hL : 0 < L) (wv wh : ℤ) (hwind : (wh, wv) ≠ (0, 0))
    (base : ℤ × ℤ) (t s s' : ℕ) (ht : 1 ≤ t)
    (hs : s ≤ t * (wh.natAbs + wv.natAbs))
    (hs' : s' ≤ t * (wh.natAbs + wv.natAbs))
    (z : ℤ) (hz : z ≠ 0) :
    iteratedTransverseStaircase wh wv base s ≠
      iteratedTransverseStaircase wh wv base s' + z • windingShift L wv wh :=
  iteratedTransverseStaircase_ne_period_translate L hL wv wh hwind base t s s' ht hs hs' z hz

end Ising2DLambda.KacWard
