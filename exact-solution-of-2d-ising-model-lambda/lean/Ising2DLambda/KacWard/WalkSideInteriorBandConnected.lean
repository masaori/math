/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の歩道沿いの内側帯は空でなく辺連結である」
（`claim_walk_side_interior_band_edge_connected`）の具体版。

人手証明の最後の合成と同じく、各訪問頂点に接する内側セルの弧を、
隣り合う二頂点が共有する内側セルで順につなぐ。
-/
import Ising2DLambda.KacWard.OddRayInteriorCellsBounded
import Ising2DLambda.NecSuf.KacWard.WalkSideInteriorBandConnected
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 二つの整数格子セルが一辺を共有すること。 -/
def CellEdgeAdjacent (p q : ℤ × ℤ) : Prop :=
  (q.1 = p.1 ∧ (q.2 = p.2 - 1 ∨ q.2 = p.2 + 1)) ∨
  (q.2 = p.2 ∧ (q.1 = p.1 - 1 ∨ q.1 = p.1 + 1))

/-- 整数格子セルの集合が辺隣接の有限列で連結であること。 -/
def EdgeConnectedCellSet (S : Set (ℤ × ℤ)) : Prop :=
  ConnectedBy CellEdgeAdjacent S

/-- 持ち上げ点 `(row k, col k)` に接する四セルのうち、右半直線交差数が奇数のもの。 -/
def surroundingInteriorCells
    (n : ℕ) (row col : ℕ → ℤ) (k : ℕ) : Set (ℤ × ℤ) :=
  {p | p = (row k - 1, col k - 1) ∨
       p = (row k - 1, col k) ∨
       p = (row k, col k) ∨
       p = (row k, col k - 1)} ∩
    oddRayInteriorCells n row col

/-- 一周期の各持ち上げ点に接する内側セルを集めた歩道沿いの内側帯。 -/
def walkSideInteriorBand
    (n : ℕ) (row col : ℕ → ℤ) : Set (ℤ × ℤ) :=
  {p | ∃ k < n, p ∈ surroundingInteriorCells n row col k}

theorem cellEdgeAdjacent_symmetric :
    ∀ ⦃p q⦄, CellEdgeAdjacent p q → CellEdgeAdjacent q p := by
  rintro ⟨pr, pc⟩ ⟨qr, qc⟩ h
  rcases h with ⟨hrow, hcol⟩ | ⟨hcol, hrow⟩
  · left
    constructor
    · exact hrow.symm
    · rcases hcol with hcol | hcol <;> omega
  · right
    constructor
    · exact hcol.symm
    · rcases hrow with hrow | hrow <;> omega

/-- `claim_walk_side_interior_band_edge_connected` の具体版。 -/
theorem walkSideInteriorBand_nonempty_edgeConnected
    (n : ℕ) (row col : ℕ → ℤ) (hn : 0 < n)
    (hnonempty : ∀ k < n, (surroundingInteriorCells n row col k).Nonempty)
    (hlocal : ∀ k < n, EdgeConnectedCellSet (surroundingInteriorCells n row col k))
    (hbridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingInteriorCells n row col k ∧
      p ∈ surroundingInteriorCells n row col (k + 1)) :
    (walkSideInteriorBand n row col).Nonempty ∧
      EdgeConnectedCellSet (walkSideInteriorBand n row col) := by
  exact finite_chain_union_connected_necSuf CellEdgeAdjacent cellEdgeAdjacent_symmetric
    n (surroundingInteriorCells n row col) hn hnonempty hlocal hbridge

end Ising2DLambda.KacWard
