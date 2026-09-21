/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の歩道沿いの内側帯は空でなく辺連結である」
（`claim_walk_side_interior_band_edge_connected`）の具体版。

人手証明の最後の合成と同じく、各訪問頂点に接する内側セルの弧を、
隣り合う二頂点が共有する内側セルで順につなぐ。
-/
import Ising2DLambda.KacWard.OddRayInteriorCellsBounded
import Ising2DLambda.KacWard.VertexSurroundingCellsParityArcs
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

/-- 四つの接触セルに内側と外側がともに現れるなら、内側セル集合は空でない。 -/
private theorem surroundingInteriorCells_nonempty_of_parityArcs
    (n : ℕ) (row col : ℕ → ℤ) (k : ℕ)
    (hshape : FourCellsFormParityArcs
      (rightRayCrossingCount n row col (row k - 1) (col k - 1) % 2)
      (rightRayCrossingCount n row col (row k - 1) (col k) % 2)
      (rightRayCrossingCount n row col (row k) (col k) % 2)
      (rightRayCrossingCount n row col (row k) (col k - 1) % 2)) :
    (surroundingInteriorCells n row col k).Nonempty := by
  let c0 := rightRayCrossingCount n row col (row k - 1) (col k - 1) % 2
  let c1 := rightRayCrossingCount n row col (row k - 1) (col k) % 2
  let c2 := rightRayCrossingCount n row col (row k) (col k) % 2
  let c3 := rightRayCrossingCount n row col (row k) (col k - 1) % 2
  have hc0 : c0 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc1 : c1 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc2 : c2 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc3 : c3 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  change FourCellsFormParityArcs c0 c1 c2 c3 at hshape
  unfold FourCellsFormParityArcs at hshape
  by_cases h0 : c0 = 1
  · refine ⟨(row k - 1, col k - 1), ?_⟩
    simp [surroundingInteriorCells, oddRayInteriorCells, Nat.odd_iff, c0, h0]
  by_cases h1 : c1 = 1
  · refine ⟨(row k - 1, col k), ?_⟩
    simp [surroundingInteriorCells, oddRayInteriorCells, Nat.odd_iff, c1, h1]
  by_cases h2 : c2 = 1
  · refine ⟨(row k, col k), ?_⟩
    simp [surroundingInteriorCells, oddRayInteriorCells, Nat.odd_iff, c2, h2]
  have h3 : c3 = 1 := by omega
  refine ⟨(row k, col k - 1), ?_⟩
  simp [surroundingInteriorCells, oddRayInteriorCells, Nat.odd_iff, c3, h3]

/-- 各訪問頂点の内側弧を有限鎖としてつなぐ局所合成。 -/
theorem walkSideInteriorBand_nonempty_edgeConnected_local
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

/-- `claim_walk_side_interior_band_edge_connected` の具体版。 -/
theorem walkSideInteriorBand_nonempty_edgeConnected
    (n : ℕ) (row col : ℕ → ℤ) (hn : 0 < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hdistinct : ∀ k l, k < n → l < n →
      row k = row l → col k = col l → k = l)
    (hedgeSimple : ∀ k, k < n →
      verticalEdgeTraversalCount n row col (row k - 1) (col k) ≤ 1 ∧
      verticalEdgeTraversalCount n row col (row k) (col k) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k) ≤ 1)
    (hlocal : ∀ k < n, EdgeConnectedCellSet (surroundingInteriorCells n row col k))
    (hbridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingInteriorCells n row col k ∧
      p ∈ surroundingInteriorCells n row col (k + 1)) :
    (walkSideInteriorBand n row col).Nonempty ∧
      EdgeConnectedCellSet (walkSideInteriorBand n row col) := by
  have hnonempty : ∀ k, k < n →
      (surroundingInteriorCells n row col k).Nonempty := by
    intro k hk
    have hshape := vertexSurroundingCells_formParityArcs n row col k hk
      hclosedRow hclosedCol hunit hdistinct
      (hedgeSimple k hk).1 (hedgeSimple k hk).2.1
      (hedgeSimple k hk).2.2.1 (hedgeSimple k hk).2.2.2
    exact surroundingInteriorCells_nonempty_of_parityArcs n row col k hshape
  exact walkSideInteriorBand_nonempty_edgeConnected_local n row col hn
    hnonempty hlocal hbridge

end Ising2DLambda.KacWard
