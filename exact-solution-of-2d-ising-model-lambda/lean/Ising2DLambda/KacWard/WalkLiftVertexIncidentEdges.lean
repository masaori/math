/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の各訪問頂点で内側セルと外側セルはそれぞれ一つの弧をなす」
（`claim_vertex_surrounding_cells_form_parity_arcs`）が引く
「持ち上げ点が相異なる閉路の各訪問頂点に接する四辺はそれぞれ高々一度通過される」
（`claim_lifted_walk_vertex_incident_edges_traversed_at_most_once`）の具体版と、それが使う持ち上げ座標の補題。

人手証明と同じく、持ち上げ点の相異性から訪問頂点に接する四辺の総通過回数を二とし、
訪問へ入る辺と出る辺が非後退性（持ち上げた隣接二歩が逆ベクトルにならないこと）で相異なることから、
四辺の各々の通過回数が高々一であることを導く。
-/
import Ising2DLambda.KacWard.PlaneLift
import Ising2DLambda.KacWard.PlaneLiftIntegerBaseEndpoint
import Ising2DLambda.KacWard.LiftedNonbacktracking
import Ising2DLambda.KacWard.VertexIncidentEdgeTraversalEven
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 零巻き付きの閉歩道では、整数添字の持ち上げ座標が一周期で閉じる。 -/
theorem liftedWalkCoordinates_closed {L m : ℕ} [NeZero L]
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
theorem liftedWalkCoordinates_unit {L m : ℕ}
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
theorem liftedWalkCoordinates_distinct {L m : ℕ}
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
theorem liftedWalk_no_two_step_return {L m : ℕ} [NeZero L]
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
theorem liftedWalk_no_cyclic_two_step_return {L m : ℕ} [NeZero L]
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
theorem liftedWalkCoordinates_neighbors_distinct {L m : ℕ} [NeZero L]
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
    have h := liftedWalk_no_cyclic_two_step_return γ hγ hh hv
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
    have h := liftedWalk_no_two_step_return γ hγ k
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
theorem unitGridWalk_incident_total_two
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
theorem unitGridWalk_incident_distinct_positive
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
theorem liftedWalkCoordinates_incident_distinct_positive
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
  have hclosed := liftedWalkCoordinates_closed γ hγ hh hv
  exact unitGridWalk_incident_distinct_positive
    (m + 1) _ _ j hj hclosed.1 hclosed.2
    (liftedWalkCoordinates_unit γ)
    (liftedWalkCoordinates_neighbors_distinct γ hγ hh hv j hj)

/-- 実際の閉歩道では各訪問点に接する四辺を高々一度ずつ通る。 -/
theorem liftedWalkCoordinates_incident_counts_le_one
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
  have hclosed := liftedWalkCoordinates_closed γ hγ hh hv
  have hsum := unitGridWalk_incident_total_two
    (m + 1) _ _ j hj hclosed.1 hclosed.2
    (liftedWalkCoordinates_unit γ)
    (liftedWalkCoordinates_distinct γ hdistinct)
  exact four_incident_counts_le_one_of_distinct_positive _ _ _ _ hsum
    (liftedWalkCoordinates_incident_distinct_positive γ hγ hh hv j hj)

end Ising2DLambda.KacWard
