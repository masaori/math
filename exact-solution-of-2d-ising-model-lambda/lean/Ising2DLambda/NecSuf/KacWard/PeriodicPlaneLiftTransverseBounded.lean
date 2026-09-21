/-
「周期延長した持ち上げは有限幅の整数帯に入る」の必要十分版。

格子から切り離すと、必要なのは横断座標が加法を保ち、周期並進方向を零へ送ることだけである。
そのとき周期延長した点の横断座標は、一周期内の基本点の横断座標に等しい。
-/
import Ising2DLambda.NecSuf.KacWard.PeriodicPlaneLiftDistinct

namespace Ising2DLambda.NecSuf.KacWard

/-- 周期方向を消す加法準同型は、周期延長した点を一周期内の基本点と同じ値へ送る。 -/
theorem periodic_lift_coordinate_eq_base_necSuf
    {I R G A : Type*} [AddCommGroup G] [AddCommGroup A]
    (base : R → G) (shift : G) (quotient : I → ℤ) (remainder : I → R)
    (coordinate : G →+ A) (hshift : coordinate shift = 0) (k : I) :
    coordinate (periodicLiftCore base shift quotient remainder k) =
      coordinate (base (remainder k)) := by
  calc
    coordinate (periodicLiftCore base shift quotient remainder k) =
        coordinate (base (remainder k)) + coordinate (quotient k • shift) := by
      simp [periodicLiftCore]
    _ = coordinate (base (remainder k)) + quotient k • coordinate shift := by
      rw [map_zsmul]
    _ = coordinate (base (remainder k)) := by simp [hshift]

end Ising2DLambda.NecSuf.KacWard
