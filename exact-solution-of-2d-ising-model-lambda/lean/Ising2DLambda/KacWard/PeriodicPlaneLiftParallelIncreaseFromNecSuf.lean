/-
具体版が必要十分版の特殊化として得られることの導出。
-/
import Ising2DLambda.KacWard.PeriodicPlaneLiftParallelIncrease

namespace Ising2DLambda.KacWard

/-- `claim_periodic_plane_lift_parallel_period_increase` の座標等式を必要十分版から導く。 -/
theorem periodicPlaneLift_parallelCoordinate_add_period_from_necSuf
    (m L : ℕ) (hm : 0 < m) (base : ℤ → ℤ × ℤ) (wv wh k : ℤ) :
    windingParallelCoordinate wv wh (periodicPlaneLift m base L wv wh (k + m)) =
      windingParallelCoordinate wv wh (periodicPlaneLift m base L wv wh k) +
        (L : ℤ) * (wv ^ 2 + wh ^ 2) :=
  periodicPlaneLift_parallelCoordinate_add_period m L hm base wv wh k

end Ising2DLambda.KacWard
