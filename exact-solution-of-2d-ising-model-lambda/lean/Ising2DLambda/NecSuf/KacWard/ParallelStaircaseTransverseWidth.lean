/-
「平行階段の横断座標は両端の水準の間に収まる」の必要十分版。

具体的な整数格子から切り離すと、必要なのは加法的な整数値座標、有限路の座標の上下界、
比較する点族の座標上界だけである。階段の二段階の形や巻き付き数は使わない。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 有限路の座標の上下界は、任意の基点だけ平行移動しても差の上下界として保たれる。 -/
theorem translatedPath_coordinate_between_necSuf
    {G : Type*} [AddCommGroup G]
    (path : ℕ → G) (base : G) (coordinate : G →+ ℤ)
    (length : ℕ) (lower upper : ℤ)
    (hpath : ∀ s ≤ length, lower ≤ coordinate (path s) ∧ coordinate (path s) ≤ upper)
    (s : ℕ) (hs : s ≤ length) :
    lower ≤ coordinate (base + path s) - coordinate base ∧
      coordinate (base + path s) - coordinate base ≤ upper := by
  simpa [map_add] using hpath s hs

/-- 下端を足しても点族の上端より高い基点から始まる有限路は、その点族と交わらない。 -/
theorem translatedPath_above_upper_avoids_family_necSuf
    {I G : Type*} [AddCommGroup G]
    (path : ℕ → G) (family : I → G) (base : G) (coordinate : G →+ ℤ)
    (length : ℕ) (lower upper : ℤ)
    (hpath : ∀ s ≤ length, lower ≤ coordinate (path s))
    (hbase : upper < coordinate base + lower)
    (hfamily : ∀ i, coordinate (family i) ≤ upper)
    (s : ℕ) (hs : s ≤ length) (i : I) :
    base + path s ≠ family i := by
  intro heq
  have hlower := hpath s hs
  have htranslated : coordinate base + lower ≤ coordinate (base + path s) := by
    simpa [map_add, add_assoc, add_comm, add_left_comm] using
      add_le_add_left hlower (coordinate base)
  rw [heq] at htranslated
  exact (not_lt_of_ge (hfamily i)) (lt_of_lt_of_le hbase htranslated)

end Ising2DLambda.NecSuf.KacWard
