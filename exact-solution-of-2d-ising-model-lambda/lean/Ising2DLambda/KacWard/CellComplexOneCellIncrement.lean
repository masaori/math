/-
章「Onsager 閉形式への接続」の「一セルを追加したときの Euler 数の増分」
(`claim_cell_complex_one_cell_increment`) の具体版。

人手証明と同じく、単位正方形の四頂点と四辺、セル集合の合併に対する
頂点集合と辺集合の分配、有限集合の包除から増分等式を得る。
-/
import Ising2DLambda.NecSuf.KacWard.CellComplexOneCellIncrement
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

abbrev GridCell := ℤ × ℤ
abbrev GridVertex := ℤ × ℤ
/- `false` is a horizontal edge and `true` a vertical edge; the vertex is its
left or lower endpoint.  This is the injective coordinate encoding of the
two-point edge sets used by the human proof. -/
abbrev GridEdge := Bool × GridVertex

/-- 一つの整数格子セルの四頂点。 -/
def verticesOfCell (x : GridCell) : Finset GridVertex :=
  {(x.1, x.2), (x.1, x.2 + 1), (x.1 + 1, x.2), (x.1 + 1, x.2 + 1)}

/-- 一つの整数格子セルの四辺。 -/
def edgesOfCell (x : GridCell) : Finset GridEdge :=
  { (false, (x.1, x.2)), (false, (x.1 + 1, x.2)),
    (true, (x.1, x.2)), (true, (x.1, x.2 + 1)) }

/-- 有限セル集合の全頂点。 -/
def cellVertices (cells : Finset GridCell) : Finset GridVertex :=
  cells.biUnion verticesOfCell

/-- 有限セル集合の全辺。 -/
def cellEdges (cells : Finset GridCell) : Finset GridEdge :=
  cells.biUnion edgesOfCell

/-- 有限セル集合の Euler 数。 -/
def cellEulerNumber (cells : Finset GridCell) : ℤ :=
  ((cellVertices cells).card : ℤ) - ((cellEdges cells).card : ℤ) + (cells.card : ℤ)

private theorem verticesOfCell_card (x : GridCell) : (verticesOfCell x).card = 4 := by
  rcases x with ⟨r, c⟩
  simp [verticesOfCell]

private theorem edgesOfCell_card (x : GridCell) : (edgesOfCell x).card = 4 := by
  rcases x with ⟨r, c⟩
  simp [edgesOfCell]

/-- `claim_cell_complex_one_cell_increment` の具体版。 -/
theorem cellEulerNumber_insert
    (cells : Finset GridCell) (x : GridCell) (hx : x ∉ cells) :
    cellEulerNumber (insert x cells) =
      cellEulerNumber cells + 1 + (cellEdges cells ∩ cellEdges {x}).card -
        (cellVertices cells ∩ cellVertices {x}).card := by
  unfold cellEulerNumber
  exact cellComplex_oneCellIncrement_necSuf
    cells x cellVertices cellEdges hx
    (by simp [cellVertices, Finset.union_comm])
    (by simp [cellEdges, Finset.union_comm])
    (by simpa [cellVertices] using verticesOfCell_card x)
    (by simpa [cellEdges] using edgesOfCell_card x)

end Ising2DLambda.KacWard
