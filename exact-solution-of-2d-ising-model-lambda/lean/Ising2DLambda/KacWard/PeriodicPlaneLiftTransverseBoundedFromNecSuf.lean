/-
具体版が必要十分版の特殊化として得られることの導出。

整数横断座標が周期並進を零へ送ることを必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.PeriodicPlaneLiftTransverseBounded

namespace Ising2DLambda.KacWard

/-- `claim_periodic_plane_lift_transverse_bounded` の横断座標等式を必要十分版から導く。 -/
theorem periodicPlaneLift_transverseCoordinate_eq_base_from_necSuf
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh k : ℤ) :
    windingTransverseCoordinate wh wv (periodicPlaneLift m base L wv wh k) =
      windingTransverseCoordinate wh wv (base (k % (m : ℤ))) :=
  periodicPlaneLift_transverseCoordinate_eq_base m L base wv wh k

end Ising2DLambda.KacWard
