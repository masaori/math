/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の歩道沿いの内側帯は空でなく辺連結である」
（`claim_walk_side_interior_band_edge_connected`）の具体版。

人手証明の最後の合成と同じく、各訪問頂点に接する内側セルの弧を、
隣り合う二頂点が共有する内側セルで順につなぐ。
-/
import Ising2DLambda.KacWard.OddRayInteriorCellsBounded
import Ising2DLambda.KacWard.OddRayInteriorCells
import Ising2DLambda.KacWard.PlaneLift
import Ising2DLambda.KacWard.VertexSurroundingCellsParityArcs
import Ising2DLambda.KacWard.WalkStepEdgeTraversalOne
import Ising2DLambda.NecSuf.KacWard.WalkSideInteriorBandConnected
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 二つの整数格子セルが一辺を共有すること。 -/
def CellEdgeAdjacent (p q : ℤ × ℤ) : Prop :=
  (q.1 = p.1 ∧ (q.2 = p.2 - 1 ∨ q.2 = p.2 + 1)) ∨
  (q.2 = p.2 ∧ (q.1 = p.1 - 1 ∨ q.1 = p.1 + 1))

theorem cellEdgeAdjacent_from_necSuf (p q : ℤ × ℤ) :
    CellEdgeAdjacent p q ↔
      Ising2DLambda.NecSuf.KacWard.cellEdgeAdjacent
        (fun p q : ℤ × ℤ =>
          q.1 = p.1 ∧ (q.2 = p.2 - 1 ∨ q.2 = p.2 + 1))
        (fun p q : ℤ × ℤ =>
          q.2 = p.2 ∧ (q.1 = p.1 - 1 ∨ q.1 = p.1 + 1)) p q :=
  Iff.rfl

/-- 整数格子セルの集合が辺隣接の有限列で連結であること。 -/
def EdgeConnectedCellSet (S : Set (ℤ × ℤ)) : Prop :=
  ConnectedBy CellEdgeAdjacent S

theorem edgeConnectedCellSet_from_necSuf (S : Set (ℤ × ℤ)) :
    EdgeConnectedCellSet S ↔
      Ising2DLambda.NecSuf.KacWard.ConnectedBy
        (Ising2DLambda.NecSuf.KacWard.cellEdgeAdjacent
          (fun p q : ℤ × ℤ =>
            q.1 = p.1 ∧ (q.2 = p.2 - 1 ∨ q.2 = p.2 + 1))
          (fun p q : ℤ × ℤ =>
            q.2 = p.2 ∧ (q.1 = p.1 - 1 ∨ q.1 = p.1 + 1))) S :=
  Iff.rfl

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

/-- 実際の閉歩道の平面持ち上げから定める歩道沿いの内側帯。 -/
def walkSideInteriorBandFromWalk {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) : Set (ℤ × ℤ) :=
  {p | p ∈ oddRayInteriorCellsOfWalk γ hγ hh hv ∧
    ∃ k : Fin (m + 1),
      let P := planeLift γ k.castSucc
      p = (P.1 - 1, P.2 - 1) ∨ p = (P.1 - 1, P.2) ∨
      p = P ∨ p = (P.1, P.2 - 1)}

theorem walkSideInteriorBandFromWalk_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    walkSideInteriorBandFromWalk γ hγ hh hv =
      Ising2DLambda.NecSuf.KacWard.walkSideBand Finset.univ
        (oddRayInteriorCellsOfWalk γ hγ hh hv)
        (fun (k : Fin (m + 1)) (p : ℤ × ℤ) =>
          let P := planeLift γ k.castSucc
          p = (P.1 - 1, P.2 - 1) ∨ p = (P.1 - 1, P.2) ∨
          p = P ∨ p = (P.1, P.2 - 1)) := by
  ext p
  simp only [walkSideInteriorBandFromWalk,
    Ising2DLambda.NecSuf.KacWard.walkSideBand, Finset.mem_univ,
    true_and, Set.mem_setOf_eq]

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

/-- 四つの接触セルの内側弧は、弧上の辺をたどって連結である。 -/
theorem surroundingInteriorCells_edgeConnected_of_parityArcs
    (n : ℕ) (row col : ℕ → ℤ) (k : ℕ)
    (hshape : FourCellsFormParityArcs
      (rightRayCrossingCount n row col (row k - 1) (col k - 1) % 2)
      (rightRayCrossingCount n row col (row k - 1) (col k) % 2)
      (rightRayCrossingCount n row col (row k) (col k) % 2)
      (rightRayCrossingCount n row col (row k) (col k - 1) % 2)) :
    EdgeConnectedCellSet (surroundingInteriorCells n row col k) := by
  let a := (row k - 1, col k - 1)
  let b := (row k - 1, col k)
  let c := (row k, col k)
  let d := (row k, col k - 1)
  let S := surroundingInteriorCells n row col k
  let c0 := rightRayCrossingCount n row col a.1 a.2 % 2
  let c1 := rightRayCrossingCount n row col b.1 b.2 % 2
  let c2 := rightRayCrossingCount n row col c.1 c.2 % 2
  let c3 := rightRayCrossingCount n row col d.1 d.2 % 2
  have hc0 : c0 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc1 : c1 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc2 : c2 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc3 : c3 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have h02 : c0 = 1 → c2 = 1 → c1 = 1 ∨ c3 = 1 := by
    intro h0 h2
    change FourCellsFormParityArcs c0 c1 c2 c3 at hshape
    unfold FourCellsFormParityArcs at hshape
    omega
  have h13 : c1 = 1 → c3 = 1 → c0 = 1 ∨ c2 = 1 := by
    intro h1 h3
    change FourCellsFormParityArcs c0 c1 c2 c3 at hshape
    unfold FourCellsFormParityArcs at hshape
    omega
  have hmem0 : c0 = 1 → a ∈ S := by
    intro h
    simp [S, surroundingInteriorCells, oddRayInteriorCells, Nat.odd_iff, a, c0, h]
  have hmem1 : c1 = 1 → b ∈ S := by
    intro h
    simp [S, surroundingInteriorCells, oddRayInteriorCells, Nat.odd_iff, b, c1, h]
  have hmem2 : c2 = 1 → c ∈ S := by
    intro h
    simp [S, surroundingInteriorCells, oddRayInteriorCells, Nat.odd_iff, c, c2, h]
  have hmem3 : c3 = 1 → d ∈ S := by
    intro h
    simp [S, surroundingInteriorCells, oddRayInteriorCells, Nat.odd_iff, d, c3, h]
  have hedge01 : CellEdgeAdjacent a b := by simp [CellEdgeAdjacent, a, b]
  have hedge12 : CellEdgeAdjacent b c := by simp [CellEdgeAdjacent, b, c]
  have hedge23 : CellEdgeAdjacent c d := by simp [CellEdgeAdjacent, c, d]
  have hedge30 : CellEdgeAdjacent d a := by simp [CellEdgeAdjacent, d, a]
  let step := fun x y => x ∈ S ∧ y ∈ S ∧ CellEdgeAdjacent x y
  have hstep (x y : ℤ × ℤ) (hx : x ∈ S) (hy : y ∈ S)
      (hxy : CellEdgeAdjacent x y) : Relation.ReflTransGen step x y :=
    Relation.ReflTransGen.single ⟨hx, hy, hxy⟩
  intro x hx y hy
  have hx0 : x = a → c0 = 1 := by
    intro h; subst x
    exact (Nat.odd_iff.mp hx.2)
  have hx1 : x = b → c1 = 1 := by
    intro h; subst x
    exact (Nat.odd_iff.mp hx.2)
  have hx2 : x = c → c2 = 1 := by
    intro h; subst x
    exact (Nat.odd_iff.mp hx.2)
  have hx3 : x = d → c3 = 1 := by
    intro h; subst x
    exact (Nat.odd_iff.mp hx.2)
  have hy0 : y = a → c0 = 1 := by
    intro h; subst y
    exact (Nat.odd_iff.mp hy.2)
  have hy1 : y = b → c1 = 1 := by
    intro h; subst y
    exact (Nat.odd_iff.mp hy.2)
  have hy2 : y = c → c2 = 1 := by
    intro h; subst y
    exact (Nat.odd_iff.mp hy.2)
  have hy3 : y = d → c3 = 1 := by
    intro h; subst y
    exact (Nat.odd_iff.mp hy.2)
  rcases hx.1 with hxa | hxb | hxc | hxd <;>
    rcases hy.1 with hya | hyb | hyc | hyd
  all_goals
    subst x; subst y
    first
    | exact Relation.ReflTransGen.refl
    | exact hstep _ _ hx hy hedge01
    | exact hstep _ _ hx hy hedge12
    | exact hstep _ _ hx hy hedge23
    | exact hstep _ _ hx hy hedge30
    | exact hstep _ _ hx hy (cellEdgeAdjacent_symmetric hedge01)
    | exact hstep _ _ hx hy (cellEdgeAdjacent_symmetric hedge12)
    | exact hstep _ _ hx hy (cellEdgeAdjacent_symmetric hedge23)
    | exact hstep _ _ hx hy (cellEdgeAdjacent_symmetric hedge30)
    | (rcases h02 (hx0 rfl) (hy2 rfl) with hm | hm
       · exact (hstep _ _ hx (hmem1 hm) hedge01).trans
           (hstep _ _ (hmem1 hm) hy hedge12)
       · exact (hstep _ _ hx (hmem3 hm) (cellEdgeAdjacent_symmetric hedge30)).trans
           (hstep _ _ (hmem3 hm) hy (cellEdgeAdjacent_symmetric hedge23)))
    | (rcases h02 (hy0 rfl) (hx2 rfl) with hm | hm
       · exact (hstep _ _ hx (hmem1 hm) (cellEdgeAdjacent_symmetric hedge12)).trans
           (hstep _ _ (hmem1 hm) hy (cellEdgeAdjacent_symmetric hedge01))
       · exact (hstep _ _ hx (hmem3 hm) hedge23).trans
           (hstep _ _ (hmem3 hm) hy hedge30))
    | (rcases h13 (hx1 rfl) (hy3 rfl) with hm | hm
       · exact (hstep _ _ hx (hmem0 hm) (cellEdgeAdjacent_symmetric hedge01)).trans
           (hstep _ _ (hmem0 hm) hy (cellEdgeAdjacent_symmetric hedge30))
       · exact (hstep _ _ hx (hmem2 hm) hedge12).trans
           (hstep _ _ (hmem2 hm) hy hedge23))
    | (rcases h13 (hy1 rfl) (hx3 rfl) with hm | hm
       · exact (hstep _ _ hx (hmem0 hm) hedge30).trans
           (hstep _ _ (hmem0 hm) hy hedge01)
       · exact (hstep _ _ hx (hmem2 hm) (cellEdgeAdjacent_symmetric hedge23)).trans
           (hstep _ _ (hmem2 hm) hy (cellEdgeAdjacent_symmetric hedge12)))

/-- 一歩の両端に接する内側弧は、歩が通る辺の内側セルを共有する。 -/
theorem consecutive_surroundingInteriorCells_intersect
    (n : ℕ) (row col : ℕ → ℤ) (k : ℕ) (hk : k < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hlocal :
      verticalEdgeTraversalCount n row col (row k - 1) (col k) ≤ 1 ∧
      verticalEdgeTraversalCount n row col (row k) (col k) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k) ≤ 1) :
    ∃ p, p ∈ surroundingInteriorCells n row col k ∧
      p ∈ surroundingInteriorCells n row col (k + 1) := by
  have hodd (a b : ℕ) (h : (a + b) % 2 = 1) : Odd a ∨ Odd b := by
    rw [Nat.odd_iff, Nat.odd_iff]
    omega
  rcases walkStep_edgeTraversal_one n row col k hk hunit hlocal with
    ⟨hr, hc, ht⟩ | ⟨hr, hc, ht⟩ | ⟨hr, hc, ht⟩ | ⟨hr, hc, ht⟩
  · have hp : rightRayCrossingCount n row col (row k) (col k - 1) =
        rightRayCrossingCount n row col (row k) (col k) + 1 := by
        simpa only [show col k - 1 + 1 = col k by omega, ht] using
          rightRayCrossingCount_adjacent n row col (row k) (col k - 1)
    have hparity : (rightRayCrossingCount n row col (row k) (col k - 1) +
        rightRayCrossingCount n row col (row k) (col k)) % 2 = 1 := by
      rw [hp]; omega
    rcases hodd _ _ hparity with h | h
    · refine ⟨(row k, col k - 1), ?_, ?_⟩ <;>
        simp [surroundingInteriorCells, oddRayInteriorCells, hr, hc, h]
    · refine ⟨(row k, col k), ?_, ?_⟩ <;>
        simp [surroundingInteriorCells, oddRayInteriorCells, hr, hc, h]
  · have hp : rightRayCrossingCount n row col (row k - 1) (col k - 1) =
        rightRayCrossingCount n row col (row k - 1) (col k) + 1 := by
        simpa only [show col k - 1 + 1 = col k by omega, ht] using
          rightRayCrossingCount_adjacent n row col (row k - 1) (col k - 1)
    have hparity : (rightRayCrossingCount n row col (row k - 1) (col k - 1) +
        rightRayCrossingCount n row col (row k - 1) (col k)) % 2 = 1 := by
      rw [hp]; omega
    rcases hodd _ _ hparity with h | h
    · refine ⟨(row k - 1, col k - 1), ?_, ?_⟩ <;>
        simp [surroundingInteriorCells, oddRayInteriorCells, hr, hc, h]
    · refine ⟨(row k - 1, col k), ?_, ?_⟩ <;>
        simp [surroundingInteriorCells, oddRayInteriorCells, hr, hc, h]
  · have hp := verticallyAdjacentCells_boundaryParity n row col
        (row k - 1) (col k) hclosedRow hclosedCol hunit
    have hparity : (rightRayCrossingCount n row col (row k - 1) (col k) +
        rightRayCrossingCount n row col (row k) (col k)) % 2 = 1 := by
      simpa only [show row k - 1 + 1 = row k by omega, ht] using hp
    rcases hodd _ _ hparity with h | h
    · refine ⟨(row k - 1, col k), ?_, ?_⟩ <;>
        simp [surroundingInteriorCells, oddRayInteriorCells, hr, hc, h]
    · refine ⟨(row k, col k), ?_, ?_⟩ <;>
        simp [surroundingInteriorCells, oddRayInteriorCells, hr, hc, h]
  · have hp := verticallyAdjacentCells_boundaryParity n row col
        (row k - 1) (col k - 1) hclosedRow hclosedCol hunit
    have hparity : (rightRayCrossingCount n row col (row k - 1) (col k - 1) +
        rightRayCrossingCount n row col (row k) (col k - 1)) % 2 = 1 := by
      simpa only [show row k - 1 + 1 = row k by omega, ht] using hp
    rcases hodd _ _ hparity with h | h
    · refine ⟨(row k - 1, col k - 1), ?_, ?_⟩ <;>
        simp [surroundingInteriorCells, oddRayInteriorCells, hr, hc, h]
    · refine ⟨(row k, col k - 1), ?_, ?_⟩ <;>
        simp [surroundingInteriorCells, oddRayInteriorCells, hr, hc, h]

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
  have hlocal : ∀ k < n,
      EdgeConnectedCellSet (surroundingInteriorCells n row col k) := by
    intro k hk
    have hshape := vertexSurroundingCells_formParityArcs n row col k hk
      hclosedRow hclosedCol hunit hdistinct
      (hedgeSimple k hk).1 (hedgeSimple k hk).2.1
      (hedgeSimple k hk).2.2.1 (hedgeSimple k hk).2.2.2
    exact surroundingInteriorCells_edgeConnected_of_parityArcs n row col k hshape
  exact walkSideInteriorBand_nonempty_edgeConnected_local n row col hn
    hnonempty hlocal hbridge

end Ising2DLambda.KacWard
