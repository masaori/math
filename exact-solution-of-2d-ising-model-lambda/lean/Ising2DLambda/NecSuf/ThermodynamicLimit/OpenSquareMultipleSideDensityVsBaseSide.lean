/-
「倍数辺の密度と基準辺の密度の差の評価（q は 1 以下）」の必要十分版。

具体版の本体が使うのは、関係 `le` の (1) 推移律、(2) 右から同じ元を足しても保たれること、だけである。
両側の挟み込み `A' + C ≤ ψ ≤ D` と、下端の第一項の比較 `A ≤ A'` から `A + C ≤ ψ ≤ D` を得る。
係数・有理数倍・`Λ_ℚ`・共通分母・符号は本体には入らない（それらは具体版の準備であり、
`A ≤ A'` の形で受け取る）。上端 `D` には何もしないので、加法の交換則・結合則も要らない
（誤差評価の必要十分版 `twoSided_bounds_enlarge_coefficients_necSuf` より仮定が一つ少ない）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [Add X]

/-- 両側の挟み込みの下端の第一項を、比較で取り替える。 -/
theorem twoSided_bounds_enlarge_lower_coefficient_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (A A' C ψ D : X)
    (hlow : le (A' + C) ψ) (hup : le ψ D) (hA : le A A') :
    le (A + C) ψ ∧ le ψ D :=
  ⟨htrans (hadd C hA) hlow, hup⟩

end Ising2DLambda.NecSuf.ThermodynamicLimit
