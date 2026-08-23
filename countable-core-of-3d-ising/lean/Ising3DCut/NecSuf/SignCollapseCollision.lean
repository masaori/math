/-
「符号への潰しは値の衝突を持つ」の Lean 必要十分版。

具体版が使ったのは、二つの相異なる元が付帯条件を満たすこと、一つの添字では
座標を潰した像が一致すること、残りの添字では潰す前から座標が一致することだけである。
素数・有理数・付値・符号・整数・順序はいずれも論法には要らない。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 座標ごとの写像が、一つの添字で二つの座標を同じ像へ送り、残りの添字では
座標が一致するなら、二つの元は座標ごとの像の族で衝突する。 -/
theorem coordinatewise_map_has_a_value_collision
    {ι α μ β : Type*}
    (coord : ι → α → μ) (collapse : μ → β) (Good : α → Prop)
    (d : ι) (u w : α) (hu : Good u) (hw : Good w) (hne : u ≠ w)
    (hcollapse : collapse (coord d u) = collapse (coord d w))
    (hagree : ∀ i, i ≠ d → coord i u = coord i w) :
    ∃ u' w' : α, Good u' ∧ Good w' ∧ u' ≠ w' ∧
      (fun i => collapse (coord i u')) = fun i => collapse (coord i w') := by
  refine ⟨u, w, hu, hw, hne, ?_⟩
  funext i
  by_cases hi : i = d
  · subst hi
    exact hcollapse
  · rw [hagree i hi]

end Ising3DCut.NecSuf
