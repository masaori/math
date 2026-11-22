/-
具体版が必要十分版の特殊化として得られることの導出。

格子剰余への射影、非零巻き付きによる周期方向の無ねじれ、整数の商余り表示を
必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.PeriodicPlaneLiftDistinct
import Ising2DLambda.NecSuf.KacWard.PeriodicPlaneLiftDistinct

namespace Ising2DLambda.KacWard

/-- `claim_periodic_plane_lift_points_distinct` を必要十分版から導く。 -/
theorem periodicPlaneLift_injective_from_necSuf
    (m L : ℕ) (hm : 0 < m) (hL : 0 < L)
    (base : ℤ → ℤ × ℤ) (wv wh : ℤ) (hwind : wv ≠ 0 ∨ wh ≠ 0)
    (hbase : ∀ k k' : ℤ,
      residuePoint L (base (k % (m : ℤ))) = residuePoint L (base (k' % (m : ℤ))) →
        k % (m : ℤ) = k' % (m : ℤ)) :
    Function.Injective (periodicPlaneLift m base L wv wh) := by
  have hcore := Ising2DLambda.NecSuf.KacWard.periodic_lift_injective_necSuf
    base (windingShift L wv wh) (fun k : ℤ => k / (m : ℤ)) (fun k : ℤ => k % (m : ℤ))
    (residuePoint L)
    (fun r q => residuePoint_add_windingShift L (base r) q wv wh)
    hbase
    (windingShift_zsmul_eq_zero_imp L hL wv wh hwind)
    (edivEmodPair_injective m hm)
  intro k k' heq
  exact hcore heq

end Ising2DLambda.KacWard
