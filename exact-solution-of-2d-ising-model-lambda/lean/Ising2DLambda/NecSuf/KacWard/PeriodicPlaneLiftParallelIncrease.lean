/-
「周期並進は平行座標を正の定数だけ増やす」の必要十分版。

格子から切り離すと、必要なのは座標が加法を保つことだけである。
同じ基本点から周期方向を一回多く加えた点の座標差は、周期方向そのものの座標に等しい。
-/
import Ising2DLambda.NecSuf.KacWard.PeriodicPlaneLiftTransverseBounded

namespace Ising2DLambda.NecSuf.KacWard

/-- 加法準同型で読むと、周期方向を一回多く加えた点は周期方向の値だけ増える。 -/
theorem periodic_lift_coordinate_next_period_necSuf
    {G A : Type*} [AddCommGroup G] [AddCommGroup A]
    (base shift : G) (coordinate : G →+ A) (q : ℤ) :
    coordinate (base + (q + 1) • shift) =
      coordinate (base + q • shift) + coordinate shift := by
  simp [map_add, map_zsmul, add_smul, add_assoc]

end Ising2DLambda.NecSuf.KacWard
