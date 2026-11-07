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
import Ising2DLambda.KacWard.PlaneLiftIntegerBaseEndpoint
import Ising2DLambda.KacWard.VertexSurroundingCellsParityArcs
import Ising2DLambda.KacWard.WalkStepEdgeTraversalOne
import Ising2DLambda.KacWard.LiftedNonbacktracking
import Ising2DLambda.KacWard.RightRayCrossingCoordinateSum
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
  ∀ ⦃x⦄, x ∈ S → ∀ ⦃y⦄, y ∈ S →
    Relation.ReflTransGen
      (fun a b => a ∈ S ∧ b ∈ S ∧ CellEdgeAdjacent a b) x y

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

/-- 実際の内側帯のセルは、整数添字の内側帯にも属する。 -/
theorem walkSideInteriorBandFromWalk_subset_coordinateBand {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    walkSideInteriorBandFromWalk γ hγ hh hv ⊆
      walkSideInteriorBand (m + 1) row col := by
  dsimp only
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  have hinside : oddRayInteriorCellsOfWalk γ hγ hh hv =
      oddRayInteriorCells (m + 1) row col := by
    ext p
    simp only [oddRayInteriorCellsOfWalk, oddRayInteriorCells, Set.mem_setOf_eq]
    rw [rightRayVerticalCrossingCount_eq_coordinateSum]
  intro p hp
  obtain ⟨hpInside, k, hpCorner⟩ := hp
  have hk : Fin.ofNat (m + 2) k.val = k.castSucc := by
    apply Fin.ext
    simp [Nat.mod_eq_of_lt (by omega : k.val < m + 2)]
  refine ⟨k.val, k.isLt, ?_⟩
  change p ∈ ({q | q = (row k.val - 1, col k.val - 1) ∨
    q = (row k.val - 1, col k.val) ∨ q = (row k.val, col k.val) ∨
    q = (row k.val, col k.val - 1)} ∩ oddRayInteriorCells (m + 1) row col)
  constructor
  · dsimp at hpCorner ⊢
    simpa only [row, col, hk] using hpCorner
  · exact hinside ▸ hpInside

/-- 実際の閉歩道の内側帯は、持ち上げ座標で作った有限鎖の合併に等しい。 -/
theorem walkSideInteriorBandFromWalk_eq_coordinateBand {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    walkSideInteriorBandFromWalk γ hγ hh hv =
      walkSideInteriorBand (m + 1) row col := by
  dsimp only
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  have hinside : oddRayInteriorCellsOfWalk γ hγ hh hv =
      oddRayInteriorCells (m + 1) row col := by
    ext p
    simp only [oddRayInteriorCellsOfWalk, oddRayInteriorCells, Set.mem_setOf_eq]
    rw [rightRayVerticalCrossingCount_eq_coordinateSum]
  apply Set.Subset.antisymm
  · exact walkSideInteriorBandFromWalk_subset_coordinateBand γ hγ hh hv
  · intro p hp
    obtain ⟨k, hk, hcorner, hpInside⟩ := hp
    let i : Fin (m + 1) := ⟨k, hk⟩
    have hi : Fin.ofNat (m + 2) k = i.castSucc := by
      apply Fin.ext
      simp [i, Nat.mod_eq_of_lt (by omega : k < m + 2)]
    refine ⟨hinside ▸ hpInside, i, ?_⟩
    simpa only [row, col, i, hi, Set.mem_setOf_eq, Prod.mk.eta] using hcorner

/-- 零巻き付きの閉歩道では、整数添字の持ち上げ座標が一周期で閉じる。 -/
theorem walkSideInteriorBandFromWalk_coordinate_closed {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    row (m + 1) = row 0 ∧ col (m + 1) = col 0 := by
  dsimp only
  have h := planeLiftIntegerBase_endpoint γ hγ
  have hpoint : planeLiftIntegerBase γ (m + 1) = planeLiftIntegerBase γ 0 := by
    simpa [hh, hv, windingShift, Prod.add_def] using h
  exact ⟨congrArg Prod.fst hpoint, congrArg Prod.snd hpoint⟩

/-- 実際の閉歩道の持ち上げ座標は、各辺で単位格子歩を進む。 -/
theorem walkSideInteriorBandFromWalk_coordinate_unit {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    IsUnitGridWalk (m + 1) row col := by
  dsimp only [IsUnitGridWalk]
  intro k hk
  have hindex : Fin.ofNat (m + 2) k = (⟨k, hk⟩ : Fin (m + 1)).castSucc := by
    apply Fin.ext
    simp [Nat.mod_eq_of_lt (by omega : k < m + 2)]
  have hnext : Fin.ofNat (m + 2) (k + 1) = (⟨k, hk⟩ : Fin (m + 1)).succ := by
    apply Fin.ext
    simp [Nat.mod_eq_of_lt (by omega : k + 1 < m + 2)]
  have hstep := planeLift_succ γ ⟨k, hk⟩
  simp only [hnext, hindex] at *
  have hunit := orientedEdgeLatticeStep_unit (γ ⟨k, hk⟩)
  rcases hunit with hunit | hunit | hunit | hunit <;>
    rw [hunit] at hstep <;>
    simp only [Prod.add_def] at hstep
  all_goals
    have hr := congrArg Prod.fst hstep
    have hc := congrArg Prod.snd hstep
    dsimp only at hr hc
    omega

/-- 一周期の持ち上げ点の単射性を整数添字の行・列座標へ移す。 -/
theorem walkSideInteriorBandFromWalk_coordinate_distinct {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    ∀ k l, k < m + 1 → l < m + 1 →
      row k = row l → col k = col l → k = l := by
  dsimp only
  intro k l hk hl hr hc
  let i : Fin (m + 1) := ⟨k, hk⟩
  let j : Fin (m + 1) := ⟨l, hl⟩
  have hi : Fin.ofNat (m + 2) k = i.castSucc := by
    apply Fin.ext
    simp [i, Nat.mod_eq_of_lt (by omega : k < m + 2)]
  have hj : Fin.ofNat (m + 2) l = j.castSucc := by
    apply Fin.ext
    simp [j, Nat.mod_eq_of_lt (by omega : l < m + 2)]
  have hp : planeLift γ i.castSucc = planeLift γ j.castSucc := by
    rw [hi, hj] at hr hc
    exact Prod.ext hr hc
  have hij := hdistinct hp
  exact congrArg Fin.val hij

/-- 非後退な隣接二辺の持ち上げは、二歩後に元の格子点へ戻らない。 -/
theorem walkSideInteriorBandFromWalk_no_two_step_return {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k : Fin m) :
    planeLift γ (Fin.castSucc (Fin.castSucc k)) ≠
      planeLift γ (Fin.succ (Fin.succ k)) := by
  intro hreturn
  have hfirst := planeLift_succ γ (Fin.castSucc k)
  have hsecond := planeLift_succ γ (Fin.succ k)
  have hmid : (Fin.castSucc k).succ = (Fin.succ k).castSucc := rfl
  rw [hmid] at hfirst
  have hnot := liftedAdjacentSteps_not_opposite
    (γ (Fin.castSucc k)) (γ (Fin.succ k)) (hγ.1 k)
  apply hnot
  apply Prod.ext
  · have ha := congrArg Prod.fst hfirst
    have hb := congrArg Prod.fst hsecond
    have hc := congrArg Prod.fst hreturn
    simp only [Prod.fst_add, Prod.fst_neg] at ha hb ⊢
    omega
  · have ha := congrArg Prod.snd hfirst
    have hb := congrArg Prod.snd hsecond
    have hc := congrArg Prod.snd hreturn
    simp only [Prod.snd_add, Prod.snd_neg] at ha hb ⊢
    omega

/-- 零巻き付きの閉歩道では、周期端をまたぐ二歩も元の持ち上げ点へ戻らない。 -/
theorem walkSideInteriorBandFromWalk_no_cyclic_two_step_return {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    planeLift γ (Fin.last m).castSucc ≠ planeLift γ (Fin.succ 0) := by
  intro hreturn
  have hend : planeLift γ (Fin.last (m + 1)) = planeLift γ 0 := by
    simpa [hh, hv, Prod.add_def] using planeLift_endpoint_winding γ hγ
  have hlast := planeLift_succ γ (Fin.last m)
  have hfirst := planeLift_succ γ (0 : Fin (m + 1))
  rw [show (Fin.last m).succ = Fin.last (m + 1) by rfl, hend] at hlast
  rw [show Fin.castSucc (0 : Fin (m + 1)) = (0 : Fin (m + 2)) by rfl] at hfirst
  have hnot := liftedAdjacentSteps_not_opposite
    (γ (Fin.last m)) (γ 0) hγ.2
  apply hnot
  apply Prod.ext
  · have ha := congrArg Prod.fst hlast
    have hb := congrArg Prod.fst hfirst
    have hc := congrArg Prod.fst hreturn
    simp only [Prod.fst_add, Prod.fst_neg] at ha hb ⊢
    omega
  · have ha := congrArg Prod.snd hlast
    have hb := congrArg Prod.snd hfirst
    have hc := congrArg Prod.snd hreturn
    simp only [Prod.snd_add, Prod.snd_neg] at ha hb ⊢
    omega

/-- 非後退性により、各訪問点への入辺と出辺のもう一方の端点は異なる。 -/
theorem walkSideInteriorBandFromWalk_coordinate_neighbors_distinct {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    ∀ j < m + 1,
      row (if j = 0 then m else j - 1) ≠ row (j + 1) ∨
      col (if j = 0 then m else j - 1) ≠ col (j + 1) := by
  dsimp only
  intro j hj
  by_cases hj0 : j = 0
  · subst j
    have h := walkSideInteriorBandFromWalk_no_cyclic_two_step_return γ hγ hh hv
    have hm : Fin.ofNat (m + 2) m = (Fin.last m).castSucc := by
      apply Fin.ext
      simp [Nat.mod_eq_of_lt (by omega : m < m + 2)]
    have hfirst : Fin.ofNat (m + 2) 1 = Fin.succ (0 : Fin (m + 1)) := by
      apply Fin.ext
      simp [Nat.mod_eq_of_lt (by omega : 1 < m + 2)]
    by_contra hc
    push Not at hc
    have hpoint : planeLift γ (Fin.last m).castSucc =
        planeLift γ (Fin.succ (0 : Fin (m + 1))) := by
      apply Prod.ext
      · have hc1 := hc.1
        change (planeLift γ (Fin.ofNat (m + 2) m)).1 =
          (planeLift γ (Fin.ofNat (m + 2) 1)).1 at hc1
        rw [hm, hfirst] at hc1
        exact hc1
      · have hc2 := hc.2
        change (planeLift γ (Fin.ofNat (m + 2) m)).2 =
          (planeLift γ (Fin.ofNat (m + 2) 1)).2 at hc2
        rw [hm, hfirst] at hc2
        exact hc2
    exact h hpoint
  · have hjpos : 0 < j := Nat.pos_of_ne_zero hj0
    let k : Fin m := ⟨j - 1, by omega⟩
    have h := walkSideInteriorBandFromWalk_no_two_step_return γ hγ k
    have hprev : Fin.ofNat (m + 2) (j - 1) = Fin.castSucc (Fin.castSucc k) := by
      apply Fin.ext
      simp [k, Nat.mod_eq_of_lt (by omega : j - 1 < m + 2)]
    have hnext : Fin.ofNat (m + 2) (j + 1) = Fin.succ (Fin.succ k) := by
      apply Fin.ext
      simp [k, Nat.mod_eq_of_lt (by omega : j + 1 < m + 2)]
      omega
    simp only [if_neg hj0, hprev, hnext] at h ⊢
    by_contra hc
    push Not at hc
    exact h (Prod.ext hc.1 hc.2)

/-- 持ち上げ点の相異性から、各訪問頂点に接する四辺の総通過回数は二である。 -/
theorem walkSideInteriorBand_coordinate_incident_total_two
    (n : ℕ) (row col : ℕ → ℤ) (j : ℕ) (hj : j < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hdistinct : ∀ k l, k < n → l < n →
      row k = row l → col k = col l → k = l) :
    verticalEdgeTraversalCount n row col (row j - 1) (col j) +
      verticalEdgeTraversalCount n row col (row j) (col j) +
      horizontalEdgeTraversalCount n row col (row j) (col j - 1) +
      horizontalEdgeTraversalCount n row col (row j) (col j) = 2 := by
  rw [vertexIncidentEdgeTraversal_even n row col (row j) (col j)
    hunit hclosedRow hclosedCol]
  rw [vertexVisitCount_eq_one_of_distinct n row col j hj hdistinct]

/-- 接触四辺の総通過回数が二なら、異なる二辺の正の寄与が各辺の高々一を強制する。 -/
theorem four_incident_counts_le_one_of_distinct_positive
    (a b c d : ℕ) (hsum : a + b + c + d = 2)
    (hpositive :
      (0 < a ∧ 0 < b) ∨ (0 < a ∧ 0 < c) ∨
      (0 < a ∧ 0 < d) ∨ (0 < b ∧ 0 < c) ∨
      (0 < b ∧ 0 < d) ∨ (0 < c ∧ 0 < d)) :
    a ≤ 1 ∧ b ≤ 1 ∧ c ≤ 1 ∧ d ≤ 1 := by
  rcases hpositive with ⟨ha, hb⟩ | ⟨ha, hc⟩ | ⟨ha, hd⟩ |
    ⟨hb, hc⟩ | ⟨hb, hd⟩ | ⟨hc, hd⟩
  all_goals omega

/-- 閉じた単位歩の入辺と出辺は、非帰還なら接触四辺の異なる二項へ正に寄与する。 -/
theorem walkSideInteriorBand_coordinate_incident_distinct_positive
    (n : ℕ) (row col : ℕ → ℤ) (j : ℕ) (hj : j < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hneighbors :
      row (if j = 0 then n - 1 else j - 1) ≠ row (j + 1) ∨
      col (if j = 0 then n - 1 else j - 1) ≠ col (j + 1)) :
    let a := verticalEdgeTraversalCount n row col (row j - 1) (col j)
    let b := verticalEdgeTraversalCount n row col (row j) (col j)
    let c := horizontalEdgeTraversalCount n row col (row j) (col j - 1)
    let d := horizontalEdgeTraversalCount n row col (row j) (col j)
    (0 < a ∧ 0 < b) ∨ (0 < a ∧ 0 < c) ∨
    (0 < a ∧ 0 < d) ∨ (0 < b ∧ 0 < c) ∨
    (0 < b ∧ 0 < d) ∨ (0 < c ∧ 0 < d) := by
  dsimp only
  let p := if j = 0 then n - 1 else j - 1
  change row p ≠ row (j + 1) ∨ col p ≠ col (j + 1) at hneighbors
  have hp : p < n := by dsimp [p]; split_ifs <;> omega
  have hendRow : row (p + 1) = row j := by
    by_cases h : j = 0
    · subst j
      have hpn : p + 1 = n := by dsimp [p]; omega
      rw [hpn]
      exact hclosedRow
    · have hpj : p + 1 = j := by dsimp [p]; simp [h]; omega
      rw [hpj]
  have hendCol : col (p + 1) = col j := by
    by_cases h : j = 0
    · subst j
      have hpn : p + 1 = n := by dsimp [p]; omega
      rw [hpn]
      exact hclosedCol
    · have hpj : p + 1 = j := by dsimp [p]; simp [h]; omega
      rw [hpj]
  have hcontribution (f : ℕ → ℕ) (k : ℕ) (hk : k < n) (hf : f k = 1) :
      0 < ∑ i ∈ Finset.range n, f i := by
    have hle := Finset.single_le_sum (fun i hi => Nat.zero_le (f i))
      (Finset.mem_range.mpr hk)
    omega
  have hpositiveV (k : ℕ) (hk : k < n) (r c : ℤ)
      (hr : crossesRowLevel row r k) (hc : col k = c) :
      0 < verticalEdgeTraversalCount n row col r c := by
    unfold verticalEdgeTraversalCount
    apply hcontribution _ k hk
    simp [hr, hc]
  have hpositiveH (k : ℕ) (hk : k < n) (r c : ℤ)
      (hc : crossesColLevel col c k) (hr : row k = r) :
      0 < horizontalEdgeTraversalCount n row col r c := by
    unfold horizontalEdgeTraversalCount
    apply hcontribution _ k hk
    simp [hc, hr]
  have hprev :
      (row p = row j - 1 ∧ col p = col j ∧
        0 < verticalEdgeTraversalCount n row col (row j - 1) (col j)) ∨
      (row p = row j + 1 ∧ col p = col j ∧
        0 < verticalEdgeTraversalCount n row col (row j) (col j)) ∨
      (row p = row j ∧ col p = col j - 1 ∧
        0 < horizontalEdgeTraversalCount n row col (row j) (col j - 1)) ∨
      (row p = row j ∧ col p = col j + 1 ∧
        0 < horizontalEdgeTraversalCount n row col (row j) (col j)) := by
    rcases hunit p hp with h | h | h | h
    · left
      have hr : row p = row j - 1 := by omega
      refine ⟨hr, by omega, ?_⟩
      exact hpositiveV p hp (row j - 1) (col j) (by simp [crossesRowLevel]; omega) (by omega)
    · right; left
      have hr : row p = row j + 1 := by omega
      refine ⟨hr, by omega, ?_⟩
      exact hpositiveV p hp (row j) (col j) (by simp [crossesRowLevel]; omega) (by omega)
    · right; right; left
      have hc : col p = col j - 1 := by omega
      refine ⟨by omega, hc, ?_⟩
      exact hpositiveH p hp (row j) (col j - 1) (by simp [crossesColLevel]; omega) (by omega)
    · right; right; right
      have hc : col p = col j + 1 := by omega
      refine ⟨by omega, hc, ?_⟩
      exact hpositiveH p hp (row j) (col j) (by simp [crossesColLevel]; omega) (by omega)
  have hnext :
      (row (j + 1) = row j + 1 ∧ col (j + 1) = col j ∧
        0 < verticalEdgeTraversalCount n row col (row j) (col j)) ∨
      (row (j + 1) = row j - 1 ∧ col (j + 1) = col j ∧
        0 < verticalEdgeTraversalCount n row col (row j - 1) (col j)) ∨
      (row (j + 1) = row j ∧ col (j + 1) = col j + 1 ∧
        0 < horizontalEdgeTraversalCount n row col (row j) (col j)) ∨
      (row (j + 1) = row j ∧ col (j + 1) = col j - 1 ∧
        0 < horizontalEdgeTraversalCount n row col (row j) (col j - 1)) := by
    rcases hunit j hj with h | h | h | h
    · left
      exact ⟨h.1, h.2, hpositiveV j hj (row j) (col j)
        (by simp [crossesRowLevel]; omega) rfl⟩
    · right; left
      exact ⟨h.1, h.2, hpositiveV j hj (row j - 1) (col j)
        (by simp [crossesRowLevel]; omega) rfl⟩
    · right; right; left
      exact ⟨h.1, h.2, hpositiveH j hj (row j) (col j)
        (by simp [crossesColLevel]; omega) rfl⟩
    · right; right; right
      exact ⟨h.1, h.2, hpositiveH j hj (row j) (col j - 1)
        (by simp [crossesColLevel]; omega) rfl⟩
  rcases hprev with hprev | hprev | hprev | hprev <;>
    rcases hnext with hnext | hnext | hnext | hnext <;> omega

/-- 実際の閉歩道の前後の接辺は、接触四辺の異なる二項へ正に寄与する。 -/
theorem walkSideInteriorBandFromWalk_coordinate_incident_distinct_positive
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    ∀ j < m + 1,
      let a := verticalEdgeTraversalCount (m + 1) row col (row j - 1) (col j)
      let b := verticalEdgeTraversalCount (m + 1) row col (row j) (col j)
      let c := horizontalEdgeTraversalCount (m + 1) row col (row j) (col j - 1)
      let d := horizontalEdgeTraversalCount (m + 1) row col (row j) (col j)
      (0 < a ∧ 0 < b) ∨ (0 < a ∧ 0 < c) ∨
      (0 < a ∧ 0 < d) ∨ (0 < b ∧ 0 < c) ∨
      (0 < b ∧ 0 < d) ∨ (0 < c ∧ 0 < d) := by
  dsimp only
  intro j hj
  have hclosed := walkSideInteriorBandFromWalk_coordinate_closed γ hγ hh hv
  exact walkSideInteriorBand_coordinate_incident_distinct_positive
    (m + 1) _ _ j hj hclosed.1 hclosed.2
    (walkSideInteriorBandFromWalk_coordinate_unit γ)
    (walkSideInteriorBandFromWalk_coordinate_neighbors_distinct γ hγ hh hv j hj)

/-- 実際の閉歩道では各訪問点に接する四辺を高々一度ずつ通る。 -/
theorem walkSideInteriorBandFromWalk_coordinate_incident_counts_le_one
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
    let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
    ∀ j < m + 1,
      verticalEdgeTraversalCount (m + 1) row col (row j - 1) (col j) ≤ 1 ∧
      verticalEdgeTraversalCount (m + 1) row col (row j) (col j) ≤ 1 ∧
      horizontalEdgeTraversalCount (m + 1) row col (row j) (col j - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount (m + 1) row col (row j) (col j) ≤ 1 := by
  dsimp only
  intro j hj
  have hclosed := walkSideInteriorBandFromWalk_coordinate_closed γ hγ hh hv
  have hsum := walkSideInteriorBand_coordinate_incident_total_two
    (m + 1) _ _ j hj hclosed.1 hclosed.2
    (walkSideInteriorBandFromWalk_coordinate_unit γ)
    (walkSideInteriorBandFromWalk_coordinate_distinct γ hdistinct)
  exact four_incident_counts_le_one_of_distinct_positive _ _ _ _ hsum
    (walkSideInteriorBandFromWalk_coordinate_incident_distinct_positive γ hγ hh hv j hj)

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
  let A := surroundingInteriorCells n row col
  let band := walkSideInteriorBand n row col
  have hsubset (k : ℕ) (hk : k < n) : A k ⊆ band := by
    intro p hp
    exact ⟨k, hk, hp⟩
  obtain ⟨base, hbase⟩ := hnonempty 0 hn
  have hbaseBand : base ∈ band := hsubset 0 hn hbase
  let step := fun p q => p ∈ band ∧ q ∈ band ∧ CellEdgeAdjacent p q
  have htoBase : ∀ k < n, ∀ ⦃p⦄, p ∈ A k →
      Relation.ReflTransGen step p base := by
    intro k
    induction k with
    | zero =>
        intro hk p hp
        exact (Relation.ReflTransGen.mono
          (r := fun a b => a ∈ A 0 ∧ b ∈ A 0 ∧ CellEdgeAdjacent a b)
          (fun (a b : ℤ × ℤ) h =>
            ⟨hsubset 0 hk h.1, hsubset 0 hk h.2.1, h.2.2⟩) p base)
          (hlocal 0 hk hp hbase)
    | succ k ih =>
        intro hk p hp
        obtain ⟨z, hzPrev, hzNext⟩ := hbridge k hk
        have hlift :
            (fun a b => a ∈ A (k + 1) ∧ b ∈ A (k + 1) ∧ CellEdgeAdjacent a b) ≤
              step := by
          intro a b h
          exact ⟨hsubset (k + 1) hk h.1, hsubset (k + 1) hk h.2.1, h.2.2⟩
        have hpz := (Relation.ReflTransGen.mono
          (r := fun a b => a ∈ A (k + 1) ∧ b ∈ A (k + 1) ∧ CellEdgeAdjacent a b)
          hlift p z)
          (hlocal (k + 1) hk hp hzNext)
        exact hpz.trans (ih (Nat.lt_of_succ_lt hk) hzPrev)
  refine ⟨⟨base, hbaseBand⟩, ?_⟩
  intro p hp q hq
  obtain ⟨i, hi, hpi⟩ := hp
  obtain ⟨j, hj, hqj⟩ := hq
  have hpb := htoBase i hi hpi
  have hqb := htoBase j hj hqj
  have hbqSwap : Relation.ReflTransGen (Function.swap step) base q :=
    (Relation.ReflTransGen.swap (r := step) base q) hqb
  have hstepSwap : Function.swap step ≤ step := by
    intro a b hab
    exact ⟨hab.2.1, hab.1, cellEdgeAdjacent_symmetric hab.2.2⟩
  have hbq : Relation.ReflTransGen step base q :=
    (Relation.ReflTransGen.mono (r := Function.swap step) hstepSwap base q) hbqSwap
  exact hpb.trans hbq

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
      horizontalEdgeTraversalCount n row col (row k) (col k) ≤ 1) :
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
  have hbridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingInteriorCells n row col k ∧
      p ∈ surroundingInteriorCells n row col (k + 1) := by
    intro k hk
    exact consecutive_surroundingInteriorCells_intersect n row col k (by omega)
      hclosedRow hclosedCol hunit (hedgeSimple k (by omega))
  exact walkSideInteriorBand_nonempty_edgeConnected_local n row col hn
    hnonempty hlocal hbridge

/-- 実際の閉歩道について、歩道沿いの内側帯は空でなく辺連結である。 -/
theorem walkSideInteriorBandFromWalk_nonempty_edgeConnected {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    (walkSideInteriorBandFromWalk γ hγ hh hv).Nonempty ∧
      EdgeConnectedCellSet (walkSideInteriorBandFromWalk γ hγ hh hv) := by
  let row : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).1
  let col : ℕ → ℤ := fun j => (planeLift γ (Fin.ofNat (m + 2) j)).2
  have hclosed := walkSideInteriorBandFromWalk_coordinate_closed γ hγ hh hv
  have hband := walkSideInteriorBand_nonempty_edgeConnected (m + 1) row col
    (by omega) hclosed.1 hclosed.2
    (walkSideInteriorBandFromWalk_coordinate_unit γ)
    (walkSideInteriorBandFromWalk_coordinate_distinct γ hdistinct)
    (walkSideInteriorBandFromWalk_coordinate_incident_counts_le_one γ hγ hh hv hdistinct)
  rw [walkSideInteriorBandFromWalk_eq_coordinateBand γ hγ hh hv]
  exact hband

end Ising2DLambda.KacWard
