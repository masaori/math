/-
「横断幅を超えて離した周期持ち上げは交わらない」の必要十分版。

格子から切り離すと、必要なのは加法群の点族、整数平行移動の方向、整数値加法準同型、
元の点族の座標の上下界、および二つの移動量の間隔がその幅を超えることだけである。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 点族を一つの方向へ整数回だけ平行移動する。 -/
def translatedFamily {I G : Type*} [AddCommGroup G]
    (base : I → G) (shift : G) (u : ℤ) (i : I) : G :=
  base i + u • shift

/-- 平行移動後の座標は、元の座標と移動回数倍の座標増分との和である。 -/
theorem translatedFamily_coordinate_necSuf
    {I G : Type*} [AddCommGroup G]
    (base : I → G) (shift : G) (coordinate : G →+ ℤ) (u : ℤ) (i : I) :
    coordinate (translatedFamily base shift u i) =
      coordinate (base i) + u * coordinate shift := by
  simp [translatedFamily]

/-- 元の点族が整数区間に入り、二つの移動量の座標差が区間幅を超えれば、
    二つの平行移動像は交わらない。 -/
theorem translatedFamilies_disjoint_necSuf
    {I G : Type*} [AddCommGroup G]
    (base : I → G) (shift : G) (coordinate : G →+ ℤ)
    (lower upper u v : ℤ)
    (hlower : ∀ i, lower ≤ coordinate (base i))
    (hupper : ∀ i, coordinate (base i) ≤ upper)
    (hgap : (v - u) * coordinate shift > upper - lower) :
    ∀ i j, translatedFamily base shift u i ≠ translatedFamily base shift v j := by
  intro i j heq
  have hcoordinate := congrArg coordinate heq
  rw [translatedFamily_coordinate_necSuf, translatedFamily_coordinate_necSuf] at hcoordinate
  have hi := hupper i
  have hj := hlower j
  ring_nf at hgap hcoordinate
  omega

end Ising2DLambda.NecSuf.KacWard
