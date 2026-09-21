/-
「訪問頂点の内側セルと外側セルはそれぞれ一つの弧をなす」の必要十分版。

格子から切り離すと、必要なのは四つの境界辺が相異なる二本だけ選ばれることと、
隣り合うセルの内外が、その共有辺が選ばれるときに限って切り替わることだけである。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 四セルの巡回列で内外が二回だけ切り替わり、内側と外側がともに現れること。 -/
def FourCellsFormParityArcs (c0 c1 c2 c3 : ℕ) : Prop :=
  (c0 + c1) % 2 + (c1 + c2) % 2 + (c2 + c3) % 2 + (c3 + c0) % 2 = 2 ∧
    0 < c0 + c1 + c2 + c3 ∧ c0 + c1 + c2 + c3 < 4

/-- 四境界のうち相異なる二本だけで内外が切り替わるなら、両側はそれぞれ一つの弧になる。 -/
theorem four_cells_form_parity_arcs_necSuf
    (c0 c1 c2 c3 e0 e1 e2 e3 : ℕ)
    (hc0 : c0 ≤ 1) (hc1 : c1 ≤ 1) (hc2 : c2 ≤ 1) (hc3 : c3 ≤ 1)
    (hedges : e0 + e1 + e2 + e3 = 2)
    (h01 : (c0 + c1) % 2 = e0)
    (h12 : (c1 + c2) % 2 = e1)
    (h23 : (c2 + c3) % 2 = e2)
    (h30 : (c3 + c0) % 2 = e3) :
    FourCellsFormParityArcs c0 c1 c2 c3 := by
  unfold FourCellsFormParityArcs
  constructor
  · omega
  constructor <;> omega

end Ising2DLambda.NecSuf.KacWard
