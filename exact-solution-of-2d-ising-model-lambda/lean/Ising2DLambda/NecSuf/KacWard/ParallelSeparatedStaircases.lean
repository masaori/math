/-
「基点の平行座標が幅を超えて離れた二つの反復横断階段は交わらない」の必要十分版。

具体的な格子・階段から切り離すと、二つの点族の座標がそれぞれの基点から同じ整数区間に
収まり、二基点の座標差がその区間の幅を真に超えることだけが必要である。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 同じ幅の整数区間に収まる二点族は、基点がその幅を超えて離れていれば交わらない。 -/
theorem separated_bases_bounded_families_disjoint_necSuf
    {I J X : Type*} (left : I → X) (right : J → X) (coordinate : X → ℤ)
    (leftBase rightBase : X) (lower upper : ℤ)
    (hleft : ∀ i, lower ≤ coordinate (left i) - coordinate leftBase ∧
      coordinate (left i) - coordinate leftBase ≤ upper)
    (hright : ∀ j, lower ≤ coordinate (right j) - coordinate rightBase ∧
      coordinate (right j) - coordinate rightBase ≤ upper)
    (hseparated : upper - lower < |coordinate leftBase - coordinate rightBase|)
    (i : I) (j : J) : left i ≠ right j := by
  intro heq
  have hcoordinate : coordinate (left i) = coordinate (right j) := congrArg coordinate heq
  have hi := hleft i
  have hj := hright j
  have hbound : |coordinate leftBase - coordinate rightBase| ≤ upper - lower := by
    rw [abs_le]
    constructor <;> omega
  omega

end Ising2DLambda.NecSuf.KacWard
