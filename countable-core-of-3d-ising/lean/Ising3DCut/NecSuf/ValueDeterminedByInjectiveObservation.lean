/-
「点数乗表示の底は閾値の箱の値から一意に決まる」の Lean 必要十分版。

箱・有理数・順序・冪を落とすと、二つの対象が同じ観測値を持ち、その観測が対象集合上で
単射であることだけが残る。極限も非可算な構造も使わない。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 対象集合上で単射な一つの観測値は対象を一意に決める。 -/
theorem value_determined_by_injective_observation
    {A B : Type*} {observe : A → B} {s : Set A} {x y : A}
    (hx : x ∈ s) (hy : y ∈ s) (hinj : Set.InjOn observe s)
    (hvalue : observe x = observe y) :
    x = y := by
  exact hinj hx hy hvalue

end Ising3DCut.NecSuf
