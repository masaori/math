/-
「辺の両端の座標和の偶奇は異なる」の必要十分版。

具体版の最後の段で実際に使うのは、色が二値であり、第二端点の色が第一端点の色の
否定であることだけである。`Bool` にはこの二値性と否定だけがあり、整数の加法・順序・
座標和・箱の形は無い。

  使っている性質                  なぜ削れないか
  `Bool` の二値性                 色が異なることと、一方が他方の否定であることを同値にするため。
  第二端点の色が第一端点の否定   これを外すと、両端が同じ色の辺が反例になる。

住処: 有限集合 `Bool` のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Data.Bool.Basic

namespace Ising3DCut.NecSuf.NullModel

/-- 二つの `Bool` 値について、第二の値が第一の否定であることと、値が異なることは同値。 -/
theorem endpoint_colors_differ_iff_not (c₀ c₁ : Bool) :
    c₁ = !c₀ ↔ c₀ ≠ c₁ := by
  cases c₀ <;> cases c₁ <;> decide

end Ising3DCut.NecSuf.NullModel
