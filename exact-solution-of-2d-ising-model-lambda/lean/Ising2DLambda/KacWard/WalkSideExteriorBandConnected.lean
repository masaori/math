/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の歩道沿いの外側帯は空でなく辺連結である」
（`claim_walk_side_exterior_band_edge_connected`）の具体版。

人手証明の最後の合成と同じく、各訪問頂点に接する外側セルの弧を、
隣り合う二頂点が共有する外側セルで順につなぐ。
-/
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 持ち上げ点 `(row k, col k)` に接する四セルのうち、右半直線交差数が偶数のもの。 -/
def surroundingExteriorCells
    (n : ℕ) (row col : ℕ → ℤ) (k : ℕ) : Set (ℤ × ℤ) :=
  {p | p = (row k - 1, col k - 1) ∨
       p = (row k - 1, col k) ∨
       p = (row k, col k) ∨
       p = (row k, col k - 1)} \ oddRayInteriorCells n row col

/-- 一周期の各持ち上げ点に接する外側セルを集めた歩道沿いの外側帯。 -/
def walkSideExteriorBand
    (n : ℕ) (row col : ℕ → ℤ) : Set (ℤ × ℤ) :=
  {p | ∃ k < n, p ∈ surroundingExteriorCells n row col k}

/-- 実際の閉歩道の平面持ち上げから定める歩道沿いの外側帯。 -/
def walkSideExteriorBandFromWalk {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) : Set (ℤ × ℤ) :=
  {p | p ∉ oddRayInteriorCellsOfWalk γ hγ hh hv ∧
    ∃ k : Fin (m + 1),
      let P := planeLift γ k.castSucc
      p = (P.1 - 1, P.2 - 1) ∨ p = (P.1 - 1, P.2) ∨
      p = P ∨ p = (P.1, P.2 - 1)}

theorem walkSideExteriorBandFromWalk_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    walkSideExteriorBandFromWalk γ hγ hh hv =
      Ising2DLambda.NecSuf.KacWard.walkSideBand Finset.univ
        (oddRayInteriorCellsOfWalk γ hγ hh hv)ᶜ
        (fun (k : Fin (m + 1)) (p : ℤ × ℤ) =>
          let P := planeLift γ k.castSucc
          p = (P.1 - 1, P.2 - 1) ∨ p = (P.1 - 1, P.2) ∨
          p = P ∨ p = (P.1, P.2 - 1)) := by
  ext p
  simp only [walkSideExteriorBandFromWalk,
    Ising2DLambda.NecSuf.KacWard.walkSideBand, Finset.mem_univ,
    true_and, Set.mem_compl_iff, Set.mem_setOf_eq]

/-- 四つの接触セルに内側と外側がともに現れるなら、外側セル集合は空でない。 -/
private theorem surroundingExteriorCells_nonempty_of_parityArcs
    (n : ℕ) (row col : ℕ → ℤ) (k : ℕ)
    (hshape : FourCellsFormParityArcs
      (rightRayCrossingCount n row col (row k - 1) (col k - 1) % 2)
      (rightRayCrossingCount n row col (row k - 1) (col k) % 2)
      (rightRayCrossingCount n row col (row k) (col k) % 2)
      (rightRayCrossingCount n row col (row k) (col k - 1) % 2)) :
    (surroundingExteriorCells n row col k).Nonempty := by
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
  by_cases h0 : c0 = 0
  · refine ⟨(row k - 1, col k - 1), ?_⟩
    simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, c0, h0]
  by_cases h1 : c1 = 0
  · refine ⟨(row k - 1, col k), ?_⟩
    simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, c1, h1]
  by_cases h2 : c2 = 0
  · refine ⟨(row k, col k), ?_⟩
    simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, c2, h2]
  have h3 : c3 = 0 := by omega
  refine ⟨(row k, col k - 1), ?_⟩
  simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, c3, h3]

/-- 四つの接触セルの外側弧は、弧上の辺をたどって連結である。 -/
theorem surroundingExteriorCells_edgeConnected_of_parityArcs
    (n : ℕ) (row col : ℕ → ℤ) (k : ℕ)
    (hshape : FourCellsFormParityArcs
      (rightRayCrossingCount n row col (row k - 1) (col k - 1) % 2)
      (rightRayCrossingCount n row col (row k - 1) (col k) % 2)
      (rightRayCrossingCount n row col (row k) (col k) % 2)
      (rightRayCrossingCount n row col (row k) (col k - 1) % 2)) :
    EdgeConnectedCellSet (surroundingExteriorCells n row col k) := by
  let a := (row k - 1, col k - 1)
  let b := (row k - 1, col k)
  let c := (row k, col k)
  let d := (row k, col k - 1)
  let S := surroundingExteriorCells n row col k
  let c0 := rightRayCrossingCount n row col a.1 a.2 % 2
  let c1 := rightRayCrossingCount n row col b.1 b.2 % 2
  let c2 := rightRayCrossingCount n row col c.1 c.2 % 2
  let c3 := rightRayCrossingCount n row col d.1 d.2 % 2
  have hc0 : c0 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc1 : c1 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc2 : c2 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc3 : c3 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have h02 : c0 = 0 → c2 = 0 → c1 = 0 ∨ c3 = 0 := by
    intro h0 h2
    change FourCellsFormParityArcs c0 c1 c2 c3 at hshape
    unfold FourCellsFormParityArcs at hshape
    omega
  have h13 : c1 = 0 → c3 = 0 → c0 = 0 ∨ c2 = 0 := by
    intro h1 h3
    change FourCellsFormParityArcs c0 c1 c2 c3 at hshape
    unfold FourCellsFormParityArcs at hshape
    omega
  have hmem0 : c0 = 0 → a ∈ S := by
    intro h
    simp [S, surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, a, c0, h]
  have hmem1 : c1 = 0 → b ∈ S := by
    intro h
    simp [S, surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, b, c1, h]
  have hmem2 : c2 = 0 → c ∈ S := by
    intro h
    simp [S, surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, c, c2, h]
  have hmem3 : c3 = 0 → d ∈ S := by
    intro h
    simp [S, surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, d, c3, h]
  have hedge01 : CellEdgeAdjacent a b := by simp [CellEdgeAdjacent, a, b]
  have hedge12 : CellEdgeAdjacent b c := by simp [CellEdgeAdjacent, b, c]
  have hedge23 : CellEdgeAdjacent c d := by simp [CellEdgeAdjacent, c, d]
  have hedge30 : CellEdgeAdjacent d a := by simp [CellEdgeAdjacent, d, a]
  let step := fun x y => x ∈ S ∧ y ∈ S ∧ CellEdgeAdjacent x y
  have hstep (x y : ℤ × ℤ) (hx : x ∈ S) (hy : y ∈ S)
      (hxy : CellEdgeAdjacent x y) : Relation.ReflTransGen step x y :=
    Relation.ReflTransGen.single ⟨hx, hy, hxy⟩
  intro x hx y hy
  have hx0 : x = a → c0 = 0 := by
    intro h; subst x
    have h : ¬ c0 = 1 := by simpa [oddRayInteriorCells, c0, a, Nat.odd_iff] using hx.2
    omega
  have hx1 : x = b → c1 = 0 := by
    intro h; subst x
    have h : ¬ c1 = 1 := by simpa [oddRayInteriorCells, c1, b, Nat.odd_iff] using hx.2
    omega
  have hx2 : x = c → c2 = 0 := by
    intro h; subst x
    have h : ¬ c2 = 1 := by simpa [oddRayInteriorCells, c2, c, Nat.odd_iff] using hx.2
    omega
  have hx3 : x = d → c3 = 0 := by
    intro h; subst x
    have h : ¬ c3 = 1 := by simpa [oddRayInteriorCells, c3, d, Nat.odd_iff] using hx.2
    omega
  have hy0 : y = a → c0 = 0 := by
    intro h; subst y
    have h : ¬ c0 = 1 := by simpa [oddRayInteriorCells, c0, a, Nat.odd_iff] using hy.2
    omega
  have hy1 : y = b → c1 = 0 := by
    intro h; subst y
    have h : ¬ c1 = 1 := by simpa [oddRayInteriorCells, c1, b, Nat.odd_iff] using hy.2
    omega
  have hy2 : y = c → c2 = 0 := by
    intro h; subst y
    have h : ¬ c2 = 1 := by simpa [oddRayInteriorCells, c2, c, Nat.odd_iff] using hy.2
    omega
  have hy3 : y = d → c3 = 0 := by
    intro h; subst y
    have h : ¬ c3 = 1 := by simpa [oddRayInteriorCells, c3, d, Nat.odd_iff] using hy.2
    omega
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

/-- 相異なる持ち上げ点に接する外側セルは辺連結である。 -/
theorem surroundingExteriorCells_edgeConnected
    (n : ℕ) (row col : ℕ → ℤ) (k : ℕ) (hk : k < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hdistinct : ∀ i j, i < n → j < n →
      row i = row j → col i = col j → i = j)
    (hedgeSimple :
      verticalEdgeTraversalCount n row col (row k - 1) (col k) ≤ 1 ∧
      verticalEdgeTraversalCount n row col (row k) (col k) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k) ≤ 1) :
    EdgeConnectedCellSet (surroundingExteriorCells n row col k) := by
  have hshape := vertexSurroundingCells_formParityArcs n row col k hk
    hclosedRow hclosedCol hunit hdistinct
    hedgeSimple.1 hedgeSimple.2.1 hedgeSimple.2.2.1 hedgeSimple.2.2.2
  exact surroundingExteriorCells_edgeConnected_of_parityArcs n row col k hshape

/-- 一歩の両端に接する外側弧は、歩が通る辺の外側セルを共有する。 -/
theorem consecutive_surroundingExteriorCells_intersect
    (n : ℕ) (row col : ℕ → ℤ) (k : ℕ) (hk : k < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hlocal :
      verticalEdgeTraversalCount n row col (row k - 1) (col k) ≤ 1 ∧
      verticalEdgeTraversalCount n row col (row k) (col k) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k) ≤ 1) :
    ∃ p, p ∈ surroundingExteriorCells n row col k ∧
      p ∈ surroundingExteriorCells n row col (k + 1) := by
  have heven (a b : ℕ) (h : (a + b) % 2 = 1) :
      a % 2 = 0 ∨ b % 2 = 0 := by omega
  rcases walkStep_edgeTraversal_one n row col k hk hunit hlocal with
    ⟨hr, hc, ht⟩ | ⟨hr, hc, ht⟩ | ⟨hr, hc, ht⟩ | ⟨hr, hc, ht⟩
  · have hp : rightRayCrossingCount n row col (row k) (col k - 1) =
        rightRayCrossingCount n row col (row k) (col k) + 1 := by
        simpa only [show col k - 1 + 1 = col k by omega, ht] using
          rightRayCrossingCount_adjacent n row col (row k) (col k - 1)
    have hparity : (rightRayCrossingCount n row col (row k) (col k - 1) +
        rightRayCrossingCount n row col (row k) (col k)) % 2 = 1 := by
      rw [hp]; omega
    rcases heven _ _ hparity with h | h
    · refine ⟨(row k, col k - 1), ?_, ?_⟩ <;>
        simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, hr, hc, h]
    · refine ⟨(row k, col k), ?_, ?_⟩ <;>
        simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, hr, hc, h]
  · have hp : rightRayCrossingCount n row col (row k - 1) (col k - 1) =
        rightRayCrossingCount n row col (row k - 1) (col k) + 1 := by
        simpa only [show col k - 1 + 1 = col k by omega, ht] using
          rightRayCrossingCount_adjacent n row col (row k - 1) (col k - 1)
    have hparity : (rightRayCrossingCount n row col (row k - 1) (col k - 1) +
        rightRayCrossingCount n row col (row k - 1) (col k)) % 2 = 1 := by
      rw [hp]; omega
    rcases heven _ _ hparity with h | h
    · refine ⟨(row k - 1, col k - 1), ?_, ?_⟩ <;>
        simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, hr, hc, h]
    · refine ⟨(row k - 1, col k), ?_, ?_⟩ <;>
        simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, hr, hc, h]
  · have hp := verticallyAdjacentCells_boundaryParity n row col
        (row k - 1) (col k) hclosedRow hclosedCol hunit
    have hparity : (rightRayCrossingCount n row col (row k - 1) (col k) +
        rightRayCrossingCount n row col (row k) (col k)) % 2 = 1 := by
      simpa only [show row k - 1 + 1 = row k by omega, ht] using hp
    rcases heven _ _ hparity with h | h
    · refine ⟨(row k - 1, col k), ?_, ?_⟩ <;>
        simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, hr, hc, h]
    · refine ⟨(row k, col k), ?_, ?_⟩ <;>
        simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, hr, hc, h]
  · have hp := verticallyAdjacentCells_boundaryParity n row col
        (row k - 1) (col k - 1) hclosedRow hclosedCol hunit
    have hparity : (rightRayCrossingCount n row col (row k - 1) (col k - 1) +
        rightRayCrossingCount n row col (row k) (col k - 1)) % 2 = 1 := by
      simpa only [show row k - 1 + 1 = row k by omega, ht] using hp
    rcases heven _ _ hparity with h | h
    · refine ⟨(row k - 1, col k - 1), ?_, ?_⟩ <;>
        simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, hr, hc, h]
    · refine ⟨(row k, col k - 1), ?_, ?_⟩ <;>
        simp [surroundingExteriorCells, oddRayInteriorCells, Nat.odd_iff, hr, hc, h]

/-- 各訪問頂点の外側弧を有限鎖としてつなぐ局所合成。 -/
theorem walkSideExteriorBand_nonempty_edgeConnected_local
    (n : ℕ) (row col : ℕ → ℤ) (hn : 0 < n)
    (hnonempty : ∀ k < n, (surroundingExteriorCells n row col k).Nonempty)
    (hlocal : ∀ k < n, EdgeConnectedCellSet (surroundingExteriorCells n row col k))
    (hbridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingExteriorCells n row col k ∧
      p ∈ surroundingExteriorCells n row col (k + 1)) :
    (walkSideExteriorBand n row col).Nonempty ∧
      EdgeConnectedCellSet (walkSideExteriorBand n row col) := by
  exact finite_chain_union_connected_necSuf CellEdgeAdjacent cellEdgeAdjacent_symmetric
    n (surroundingExteriorCells n row col) hn hnonempty hlocal hbridge

/-- `claim_walk_side_exterior_band_edge_connected` の具体版。 -/
theorem walkSideExteriorBand_nonempty_edgeConnected
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
    (hlocal : ∀ k < n, EdgeConnectedCellSet (surroundingExteriorCells n row col k))
    (hbridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingExteriorCells n row col k ∧
      p ∈ surroundingExteriorCells n row col (k + 1)) :
    (walkSideExteriorBand n row col).Nonempty ∧
      EdgeConnectedCellSet (walkSideExteriorBand n row col) := by
  have hnonempty : ∀ k, k < n →
      (surroundingExteriorCells n row col k).Nonempty := by
    intro k hk
    have hshape := vertexSurroundingCells_formParityArcs n row col k hk
      hclosedRow hclosedCol hunit hdistinct
      (hedgeSimple k hk).1 (hedgeSimple k hk).2.1
      (hedgeSimple k hk).2.2.1 (hedgeSimple k hk).2.2.2
    exact surroundingExteriorCells_nonempty_of_parityArcs n row col k hshape
  exact walkSideExteriorBand_nonempty_edgeConnected_local n row col hn
    hnonempty hlocal hbridge

end Ising2DLambda.KacWard
