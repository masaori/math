/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路で頂点まわりの内側セルが対角の二セルだけになることは無い」
（`claim_boundary_vertex_diagonal_contact_excluded`）の具体版。

人手証明と同じく、格子点が一周期の持ち上げ点かどうかで場合を分ける。
持ち上げ点である場合は四セルが二つの巡回弧を作ることを使い、そうでない場合は
四辺の通過回数が零なので四セルの内外がすべて一致することを使う。
-/
import Ising2DLambda.KacWard.VertexSurroundingCellsParityArcs
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 本文の主張の結論「頂点に接する四セル $C_0,C_1,C_2,C_3$ の内側セルが対角の二セル
（$\{C_0,C_2\}$ または $\{C_1,C_3\}$）だけになることは無く、内側セルが二つなら巡回順で隣り合う」。
`c_i` は $C_i$ の右向き半直線の交差数の偶奇（$1$ が内側）である。 -/
def DiagonalCellPairsExcluded (c0 c1 c2 c3 : ℕ) : Prop :=
  ¬ (c0 = 1 ∧ c1 = 0 ∧ c2 = 1 ∧ c3 = 0) ∧
    ¬ (c0 = 0 ∧ c1 = 1 ∧ c2 = 0 ∧ c3 = 1) ∧
    (c0 + c1 + c2 + c3 = 2 →
      (c0 = 1 ∧ c1 = 1 ∧ c2 = 0 ∧ c3 = 0) ∨
      (c0 = 0 ∧ c1 = 1 ∧ c2 = 1 ∧ c3 = 0) ∨
      (c0 = 0 ∧ c1 = 0 ∧ c2 = 1 ∧ c3 = 1) ∨
      (c0 = 1 ∧ c1 = 0 ∧ c2 = 0 ∧ c3 = 1))

set_option maxHeartbeats 1000000 in
/-- `claim_boundary_vertex_diagonal_contact_excluded` の具体版。
仮定は本文の前提だけである: 閉じた非後退辺列 `γ`、零の整数巻き付き数、一周期の持ち上げ点の相異性。
訪問する頂点では四セルの偶奇弧（`vertexSurroundingCells_formParityArcs`）を引き、
訪問しない頂点では四辺の通過回数の和が零であること（`vertexIncidentEdgeTraversal_even`）を引く。 -/
theorem boundaryVertex_diagonalContactExcluded {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (a b : ℤ) :
    let row : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).1
    let col : ℕ → ℤ := fun k => (planeLift γ (Fin.ofNat (m + 2) k)).2
    DiagonalCellPairsExcluded
      (rightRayCrossingCount (m + 1) row col (a - 1) (b - 1) % 2)
      (rightRayCrossingCount (m + 1) row col (a - 1) b % 2)
      (rightRayCrossingCount (m + 1) row col a b % 2)
      (rightRayCrossingCount (m + 1) row col a (b - 1) % 2) := by
  intro row col
  -- 持ち上げの終点の主張から P_{m+1} = P_0、持ち上げの各歩は単位格子歩。
  have hclosed := liftedWalkCoordinates_closed γ hγ hh hv
  have hunit := liftedWalkCoordinates_unit γ
  let c0 := rightRayCrossingCount (m + 1) row col (a - 1) (b - 1) % 2
  let c1 := rightRayCrossingCount (m + 1) row col (a - 1) b % 2
  let c2 := rightRayCrossingCount (m + 1) row col a b % 2
  let c3 := rightRayCrossingCount (m + 1) row col a (b - 1) % 2
  have hc0 : c0 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc1 : c1 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc2 : c2 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc3 : c3 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hshape : FourCellsFormParityArcs c0 c1 c2 c3 ∨
      (c0 = c1 ∧ c1 = c2 ∧ c2 = c3) := by
    by_cases hvisited : ∃ j, j < m + 1 ∧ row j = a ∧ col j = b
    · -- (a,b) = P_j の場合: 四セルの偶奇弧の主張。
      left
      rcases hvisited with ⟨j, hj, hrow, hcol⟩
      have harcs : FourCellsFormParityArcs
          (rightRayCrossingCount (m + 1) row col (row j - 1) (col j - 1) % 2)
          (rightRayCrossingCount (m + 1) row col (row j - 1) (col j) % 2)
          (rightRayCrossingCount (m + 1) row col (row j) (col j) % 2)
          (rightRayCrossingCount (m + 1) row col (row j) (col j - 1) % 2) :=
        vertexSurroundingCells_formParityArcs γ hγ hh hv hdistinct j hj
      rw [hrow, hcol] at harcs
      exact harcs
    · -- どの P_k も (a,b) でない場合: 四辺の通過回数の和は 2·0。
      right
      have hvisit0 : vertexVisitCount (m + 1) row col a b = 0 := by
        unfold vertexVisitCount
        apply Finset.sum_eq_zero
        intro k hk
        have hklt : k < m + 1 := Finset.mem_range.mp hk
        simp only [ite_eq_right_iff]
        intro hpoint
        exact False.elim (hvisited ⟨k, hklt, hpoint⟩)
      have hsum := vertexIncidentEdgeTraversal_even
        (m + 1) row col a b hunit hclosed.1 hclosed.2
      have hleft0 : verticalEdgeTraversalCount (m + 1) row col (a - 1) b = 0 := by omega
      have hright0 : verticalEdgeTraversalCount (m + 1) row col a b = 0 := by omega
      have hdown0 : horizontalEdgeTraversalCount (m + 1) row col a (b - 1) = 0 := by omega
      have hup0 : horizontalEdgeTraversalCount (m + 1) row col a b = 0 := by omega
      have h01 := rightRayCrossingCount_adjacent (m + 1) row col (a - 1) (b - 1)
      have h12 := verticallyAdjacentCells_boundaryParity
        (m + 1) row col (a - 1) b hclosed.1 hclosed.2 hunit
      have h23 := rightRayCrossingCount_adjacent (m + 1) row col a (b - 1)
      have h30 := verticallyAdjacentCells_boundaryParity
        (m + 1) row col (a - 1) (b - 1) hclosed.1 hclosed.2 hunit
      simp only [Int.sub_add_cancel] at h01 h12 h23 h30
      change c0 = c1 ∧ c1 = c2 ∧ c2 = c3
      simp [hleft0, hright0, hdown0, hup0] at h01 h12 h23 h30
      omega
  change DiagonalCellPairsExcluded c0 c1 c2 c3
  unfold DiagonalCellPairsExcluded
  unfold FourCellsFormParityArcs at hshape
  rcases hshape with ⟨htransitions, hnonzero, hnotall⟩ | ⟨h01, h12, h23⟩
  · constructor
    · intro hdiag
      rcases hdiag with ⟨h0, h1, h2, h3⟩
      norm_num [h0, h1, h2, h3] at htransitions
    constructor
    · intro hdiag
      rcases hdiag with ⟨h0, h1, h2, h3⟩
      norm_num [h0, h1, h2, h3] at htransitions
    intro htwo
    omega
  · constructor
    · intro hdiag
      omega
    constructor
    · intro hdiag
      omega
    intro htwo
    omega

end Ising2DLambda.KacWard
