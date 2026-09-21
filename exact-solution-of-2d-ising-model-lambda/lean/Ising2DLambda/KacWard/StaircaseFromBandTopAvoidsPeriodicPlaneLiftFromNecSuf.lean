/- 具体版が必要十分版の整数格子上の反復階段と周期持ち上げへの特殊化であることの導出。 -/
import Ising2DLambda.KacWard.StaircaseFromBandTopAvoidsPeriodicPlaneLift

namespace Ising2DLambda.KacWard

/-- `claim_staircase_from_band_top_meets_lift_only_at_base` を必要十分版から導いたもの。 -/
theorem iteratedTransverseStaircase_ne_periodicPlaneLift_of_band_top_from_necSuf
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh : ℤ) (Q : ℤ × ℤ) (Kmax : ℤ)
    (hwind : (wh, wv) ≠ (0, 0))
    (hbase : Kmax ≤ windingTransverseCoordinate wh wv Q)
    (hupper : ∀ k : ℤ, windingTransverseCoordinate wh wv
      (periodicPlaneLift m base L wv wh k) ≤ Kmax)
    (t s : ℕ) (ht : 1 ≤ t) (hs : 1 ≤ s)
    (hsle : s ≤ t * (wh.natAbs + wv.natAbs)) (k : ℤ) :
    iteratedTransverseStaircase wh wv Q s ≠ periodicPlaneLift m base L wv wh k :=
  iteratedTransverseStaircase_ne_periodicPlaneLift_of_band_top
    m L base wv wh Q Kmax hwind hbase hupper t s ht hs hsle k

end Ising2DLambda.KacWard
