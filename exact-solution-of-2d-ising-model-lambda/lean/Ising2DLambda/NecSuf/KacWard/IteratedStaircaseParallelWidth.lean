/-
「反復横断階段の平行座標は基点から幅以内に収まる」の必要十分版。

具体的な整数格子から切り離すと、反復の周期方向を座標が零へ送り、一周期内の有限経路の
座標が同じ上下界に収まることだけが必要である。階段であることや二段階の形は使わない。
-/
import Ising2DLambda.NecSuf.KacWard.IteratedTransverseStaircase

namespace Ising2DLambda.NecSuf.KacWard

/-- 周期方向の座標が零で、一周期内の経路が上下界に収まれば、反復後も同じ幅に収まる。 -/
theorem iteratedStaircase_coordinate_between_necSuf
    {G : Type*} [AddCommGroup G]
    (n : ℕ) (path : ℕ → G) (period base : G) (coordinate : G →+ ℤ)
    (lower upper : ℤ) (hn : 0 < n) (hperiod : coordinate period = 0)
    (hpath : ∀ r < n, lower ≤ coordinate (path r) ∧ coordinate (path r) ≤ upper)
    (s : ℕ) :
    lower ≤ coordinate (iteratedStaircase n path period base s) - coordinate base ∧
      coordinate (iteratedStaircase n path period base s) - coordinate base ≤ upper := by
  have hr := hpath (s % n) (Nat.mod_lt s hn)
  simpa [iteratedStaircase, map_add, map_nsmul, hperiod] using hr

end Ising2DLambda.NecSuf.KacWard
