/-
「境界頂点で内側セルが対角の二セルだけになることは無い」の必要十分版。

格子から切り離すと、必要なのは四つの 0--1 値が二回だけ切り替わるか、
四値がすべて等しいことだけである。前者は訪問頂点、後者は非訪問頂点に対応する。
-/
import Ising2DLambda.NecSuf.KacWard.VertexSurroundingCellsParityArcs
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 対角の二セルだけが選ばれる二配置を排除し、二セルが選ばれるなら巡回順で隣接する。 -/
def DiagonalCellPairsExcluded (c0 c1 c2 c3 : ℕ) : Prop :=
  ¬ (c0 = 1 ∧ c1 = 0 ∧ c2 = 1 ∧ c3 = 0) ∧
    ¬ (c0 = 0 ∧ c1 = 1 ∧ c2 = 0 ∧ c3 = 1) ∧
    (c0 + c1 + c2 + c3 = 2 →
      (c0 = 1 ∧ c1 = 1 ∧ c2 = 0 ∧ c3 = 0) ∨
      (c0 = 0 ∧ c1 = 1 ∧ c2 = 1 ∧ c3 = 0) ∨
      (c0 = 0 ∧ c1 = 0 ∧ c2 = 1 ∧ c3 = 1) ∨
      (c0 = 1 ∧ c1 = 0 ∧ c2 = 0 ∧ c3 = 1))

/-- 四つの 0--1 値が二つの巡回弧を作るか全て等しいなら、対角二セル配置は生じない。 -/
theorem diagonal_cell_pairs_excluded_necSuf
    (c0 c1 c2 c3 : ℕ)
    (hc0 : c0 ≤ 1) (hc1 : c1 ≤ 1) (hc2 : c2 ≤ 1) (hc3 : c3 ≤ 1)
    (hshape : FourCellsFormParityArcs c0 c1 c2 c3 ∨
      (c0 = c1 ∧ c1 = c2 ∧ c2 = c3)) :
    DiagonalCellPairsExcluded c0 c1 c2 c3 := by
  unfold FourCellsFormParityArcs DiagonalCellPairsExcluded at *
  rcases hshape with harcs | hall
  · rcases harcs with ⟨htransitions, hnonzero, hnotall⟩
    constructor
    · intro hdiag
      rcases hdiag with ⟨rfl, rfl, rfl, rfl⟩
      norm_num at htransitions
    constructor
    · intro hdiag
      rcases hdiag with ⟨rfl, rfl, rfl, rfl⟩
      norm_num at htransitions
    intro htwo
    omega
  · rcases hall with ⟨h01, h12, h23⟩
    constructor
    · intro hdiag
      omega
    constructor
    · intro hdiag
      omega
    intro htwo
    omega

end Ising2DLambda.NecSuf.KacWard
