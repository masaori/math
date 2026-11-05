import Ising2DLambda.KacWard.WalkTwistSign
import Ising2DLambda.KacWard.CellSetBoundaryCoefficients
import Ising2DLambda.KacWard.ClosedWalkIncidenceParity
import Ising2DLambda.FisherZero.TrivialSectorConfigurationReconstruction

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 向きを忘れた基底辺の通過を、重複を保って数えた後に二で割った余り。 -/
def walkBaseEdgeParity {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (edge : Edge L) : ℕ :=
  (∑ k : Fin (m + 1), if (γ k).1 = edge then 1 else 0) % 2

/-- A single traversal contributes one endpoint at each end of its base edge. -/
private lemma singleton_edge_incidence {L : ℕ} (e : OrientedEdge L) (v : Vertex L) :
    Ising2DLambda.FisherZero.edgeSubsetIncidenceCount L {e.1} v =
      (if orientedSource e = v then 1 else 0) +
        (if orientedTarget e = v then 1 else 0) := by
  cases e with
  | mk edge direction =>
    cases direction <;>
      simp [Ising2DLambda.FisherZero.edgeSubsetIncidenceCount,
        orientedSource, orientedTarget, add_comm]

/-- Each edge traversal contributes to precisely the four named edge positions at a vertex. -/
private lemma one_walk_edge_four_incidence {L : ℕ} [NeZero L]
    (e : OrientedEdge L) (i j : ZMod L) :
    (if e.1 = edgeOfRow L false i j then 1 else 0) +
      (if e.1 = edgeOfRow L false i (j - 1) then 1 else 0) +
      (if e.1 = edgeOfRow L true i j then 1 else 0) +
      (if e.1 = edgeOfRow L true (i - 1) j then 1 else 0) =
      (if orientedSource e = (i, j) then 1 else 0) +
        (if orientedTarget e = (i, j) then 1 else 0) := by
  have h := Ising2DLambda.FisherZero.edgeSubsetIncidenceCount_four_incident_edges
    L {e.1} i j
  simp only [Finset.mem_singleton] at h
  have h' := h.symm.trans (singleton_edge_incidence e (i, j))
  simpa only [eq_comm] using h'

/-- A closed walk has even traversal parity among the four edge positions at every vertex. -/
theorem closedWalk_four_edge_parity {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (i j : ZMod L) :
    (walkBaseEdgeParity γ (edgeOfRow L false i j) +
      walkBaseEdgeParity γ (edgeOfRow L false i (j - 1)) +
      walkBaseEdgeParity γ (edgeOfRow L true i j) +
      walkBaseEdgeParity γ (edgeOfRow L true (i - 1) j)) % 2 = 0 := by
  have hlocal := fun k : Fin (m + 1) => one_walk_edge_four_incidence (γ k) i j
  have hsum :
      (∑ k : Fin (m + 1), if (γ k).1 = edgeOfRow L false i j then 1 else 0) +
      (∑ k : Fin (m + 1), if (γ k).1 = edgeOfRow L false i (j - 1) then 1 else 0) +
      (∑ k : Fin (m + 1), if (γ k).1 = edgeOfRow L true i j then 1 else 0) +
      (∑ k : Fin (m + 1), if (γ k).1 = edgeOfRow L true (i - 1) j then 1 else 0) =
      ∑ k : Fin (m + 1),
        ((if orientedSource (γ k) = (i, j) then 1 else 0) +
          (if orientedTarget (γ k) = (i, j) then 1 else 0)) := by
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib,
      ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl (fun k _ => hlocal k)
  have heven := closedWalk_incidence_even γ hγ (i, j)
  unfold walkBaseEdgeParity
  omega

/-- 閉歩道では、横辺の全行和の偶奇が隣の列で保存される。 -/
theorem closedWalk_horizontal_column_parity_invariant {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (j : ZMod L) :
    (∑ i : ZMod L, walkBaseEdgeParity γ (edgeOfRow L false i j)) % 2 =
      (∑ i : ZMod L, walkBaseEdgeParity γ (edgeOfRow L false i (j + 1))) % 2 := by
  let e : ZMod L ≃ ZMod L := Equiv.addRight (-1)
  have hshift :
      (∑ i : ZMod L, walkBaseEdgeParity γ (edgeOfRow L true (i - 1) (j + 1))) =
        ∑ i : ZMod L, walkBaseEdgeParity γ (edgeOfRow L true i (j + 1)) := by
    exact Fintype.sum_equiv e _ _ (by intro i; simp [e, sub_eq_add_neg])
  have hsum :
      (∑ i : ZMod L,
        (walkBaseEdgeParity γ (edgeOfRow L false i j) +
          walkBaseEdgeParity γ (edgeOfRow L false i (j + 1)) +
          walkBaseEdgeParity γ (edgeOfRow L true (i - 1) (j + 1)) +
          walkBaseEdgeParity γ (edgeOfRow L true i (j + 1)))) % 2 = 0 := by
    have hlocal (i : ZMod L) :
        (walkBaseEdgeParity γ (edgeOfRow L false i j) +
          walkBaseEdgeParity γ (edgeOfRow L false i (j + 1)) +
          walkBaseEdgeParity γ (edgeOfRow L true (i - 1) (j + 1)) +
          walkBaseEdgeParity γ (edgeOfRow L true i (j + 1))) % 2 = 0 := by
      have h := closedWalk_four_edge_parity γ hγ i (j + 1)
      simp only [add_sub_cancel_right] at h
      omega
    rw [Finset.sum_nat_mod]
    simp [hlocal]
  simp only [Finset.sum_add_distrib] at hsum
  rw [hshift] at hsum
  omega

/-- 閉歩道では、縦辺の全列和の偶奇が隣の行で保存される。 -/
theorem closedWalk_vertical_row_parity_invariant {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (i : ZMod L) :
    (∑ j : ZMod L, walkBaseEdgeParity γ (edgeOfRow L true i j)) % 2 =
      (∑ j : ZMod L, walkBaseEdgeParity γ (edgeOfRow L true (i + 1) j)) % 2 := by
  let e : ZMod L ≃ ZMod L := Equiv.addRight (-1)
  have hshift :
      (∑ j : ZMod L, walkBaseEdgeParity γ (edgeOfRow L false (i + 1) (j - 1))) =
        ∑ j : ZMod L, walkBaseEdgeParity γ (edgeOfRow L false (i + 1) j) := by
    exact Fintype.sum_equiv e _ _ (by intro j; simp [e, sub_eq_add_neg])
  have hsum :
      (∑ j : ZMod L,
        (walkBaseEdgeParity γ (edgeOfRow L true i j) +
          walkBaseEdgeParity γ (edgeOfRow L true (i + 1) j) +
          walkBaseEdgeParity γ (edgeOfRow L false (i + 1) (j - 1)) +
          walkBaseEdgeParity γ (edgeOfRow L false (i + 1) j))) % 2 = 0 := by
    have hlocal (j : ZMod L) :
        (walkBaseEdgeParity γ (edgeOfRow L true i j) +
          walkBaseEdgeParity γ (edgeOfRow L true (i + 1) j) +
          walkBaseEdgeParity γ (edgeOfRow L false (i + 1) (j - 1)) +
          walkBaseEdgeParity γ (edgeOfRow L false (i + 1) j)) % 2 = 0 := by
      have h := closedWalk_four_edge_parity γ hγ (i + 1) j
      simp only [add_sub_cancel_right] at h
      omega
    rw [Finset.sum_nat_mod]
    simp [hlocal]
  simp only [Finset.sum_add_distrib] at hsum
  rw [hshift] at hsum
  omega

/-- The horizontal seam is precisely the last column of horizontal base edges. -/
theorem horizontal_seam_column_parity {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) :
    (∑ i : ZMod L, walkBaseEdgeParity γ
      (edgeOfRow L false i ((L - 1 : ℕ) : ZMod L))) % 2 =
      (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 := by
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  have hlast : L - 1 < L := by omega
  -- The edge-number partition identifies the unique row of a seam edge.
  have hsingle (e : OrientedEdge L) :
      (∑ i : ZMod L,
        if e.1 = edgeOfRow L false i ((L - 1 : ℕ) : ZMod L) then 1 else 0) =
        horizontalSeamParity e := by
    rcases e with ⟨b, d⟩
    rcases (edgeEquiv L).surjective b with ⟨w, hw⟩
    cases w with
    | inl p =>
        rcases p with ⟨r, c⟩
        simp only [edgeEquiv_inl] at hw
        rw [← hw]
        have heq (i : ZMod L) :
            (edgeOfRow L false r c =
              edgeOfRow L false i ((L - 1 : ℕ) : ZMod L)) ↔
              r = i ∧ c.val = L - 1 := by
          constructor
          · intro h
            have hr := congrArg (edgeRow L) h
            have hc := congrArg (edgeColumn L) h
            simp only [edgeRow_edgeOfRow, edgeColumn_edgeOfRow,
              ZMod.val_cast_of_lt hlast] at hr hc
            exact ⟨ZMod.val_injective L hr, hc⟩
          · rintro ⟨rfl, hc⟩
            have : c = ((L - 1 : ℕ) : ZMod L) :=
              ZMod.val_injective L (by simpa [ZMod.val_cast_of_lt hlast] using hc)
            rw [this]
        have hh : (∑ i : ZMod L,
            if edgeOfRow L false r c =
              edgeOfRow L false i ((L - 1 : ℕ) : ZMod L) then 1 else 0) =
            if c.val = L - 1 then 1 else 0 := by
          by_cases hc : c.val = L - 1 <;> simp [heq, hc]
        have hbound : (edgeOfRow L false r c).val < L ^ 2 := by
          simpa [edgeOfRow] using rowColumnIndex_lt L r c
        simpa [horizontalSeamParity, hbound, edgeColumn_edgeOfRow] using hh
    | inr p =>
        rcases p with ⟨r, c⟩
        simp only [edgeEquiv_inr] at hw
        rw [← hw]
        have hneq (i : ZMod L) :
            edgeOfRow L true r c ≠
              edgeOfRow L false i ((L - 1 : ℕ) : ZMod L) := by
          intro h
          have hv := congrArg Fin.val h
          have hi : (edgeOfRow L false i ((L - 1 : ℕ) : ZMod L)).val < L ^ 2 := by
            simpa [edgeOfRow] using rowColumnIndex_lt L i ((L - 1 : ℕ) : ZMod L)
          have ht : L ^ 2 ≤ (edgeOfRow L true r c).val := by simp [edgeOfRow]
          omega
        have ht : ¬ (edgeOfRow L true r c).val < L ^ 2 := by simp [edgeOfRow]
        simp [hneq, horizontalSeamParity, ht]
  unfold walkBaseEdgeParity
  -- Remove each edge count's remainder before exchanging the two finite sums.
  simp only [← Finset.sum_nat_mod]
  rw [Finset.sum_comm]
  -- The one-edge identity turns the exchanged sum into the seam count.
  simp only [hsingle]

/-- The vertical seam is precisely the last row of vertical base edges. -/
theorem vertical_seam_row_parity {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) :
    (∑ j : ZMod L, walkBaseEdgeParity γ
      (edgeOfRow L true ((L - 1 : ℕ) : ZMod L) j)) % 2 =
      (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 := by
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  have hlast : L - 1 < L := by omega
  have hsingle (e : OrientedEdge L) :
      (∑ j : ZMod L,
        if e.1 = edgeOfRow L true ((L - 1 : ℕ) : ZMod L) j then 1 else 0) =
        verticalSeamParity e := by
    rcases e with ⟨b, d⟩
    rcases (edgeEquiv L).surjective b with ⟨w, hw⟩
    cases w with
    | inl p =>
        rcases p with ⟨r, c⟩
        simp only [edgeEquiv_inl] at hw
        rw [← hw]
        have hneq (j : ZMod L) :
            edgeOfRow L false r c ≠
              edgeOfRow L true ((L - 1 : ℕ) : ZMod L) j := by
          intro h
          have hv := congrArg Fin.val h
          have hf : (edgeOfRow L false r c).val < L ^ 2 := by
            simpa [edgeOfRow] using rowColumnIndex_lt L r c
          have ht : L ^ 2 ≤
              (edgeOfRow L true ((L - 1 : ℕ) : ZMod L) j).val := by
            simp [edgeOfRow]
          omega
        have hf : (edgeOfRow L false r c).val < L ^ 2 := by
          simpa [edgeOfRow] using rowColumnIndex_lt L r c
        simp [hneq, verticalSeamParity, hf]
    | inr p =>
        rcases p with ⟨r, c⟩
        simp only [edgeEquiv_inr] at hw
        rw [← hw]
        have heq (j : ZMod L) :
            (edgeOfRow L true r c =
              edgeOfRow L true ((L - 1 : ℕ) : ZMod L) j) ↔
              r.val = L - 1 ∧ c = j := by
          constructor
          · intro h
            have hr := congrArg (edgeRow L) h
            have hc := congrArg (edgeColumn L) h
            simp only [edgeRow_edgeOfRow, edgeColumn_edgeOfRow,
              ZMod.val_cast_of_lt hlast] at hr hc
            exact ⟨hr, ZMod.val_injective L hc⟩
          · rintro ⟨hr, rfl⟩
            have : r = ((L - 1 : ℕ) : ZMod L) :=
              ZMod.val_injective L (by simpa [ZMod.val_cast_of_lt hlast] using hr)
            rw [this]
        have hh : (∑ j : ZMod L,
            if edgeOfRow L true r c =
              edgeOfRow L true ((L - 1 : ℕ) : ZMod L) j then 1 else 0) =
            if r.val = L - 1 then 1 else 0 := by
          by_cases hr : r.val = L - 1 <;> simp [heq, hr]
        have ht : ¬ (edgeOfRow L true r c).val < L ^ 2 := by
          simp [edgeOfRow]
        simpa [verticalSeamParity, ht, edgeRow_edgeOfRow] using hh
  unfold walkBaseEdgeParity
  simp only [← Finset.sum_nat_mod]
  rw [Finset.sum_comm]
  simp only [hsingle]

/-- 切断線の偶奇が零なら、閉歩道の横辺全行和はどの列でも偶数になる。 -/
theorem closedWalk_horizontal_column_parity_zero {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hseam : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (j : ZMod L) :
    (∑ i : ZMod L, walkBaseEdgeParity γ (edgeOfRow L false i j)) % 2 = 0 := by
  let A (c : ZMod L) :=
    (∑ i : ZMod L, walkBaseEdgeParity γ (edgeOfRow L false i c)) % 2
  have hlast : A (((L - 1 : ℕ) : ZMod L)) = 0 := by
    exact (horizontal_seam_column_parity γ).trans hseam
  have hL : 1 ≤ L := Nat.pos_of_ne_zero (NeZero.ne L)
  have hwrap : (((L - 1 : ℕ) : ZMod L) + 1) = 0 := by
    calc
      (((L - 1 : ℕ) : ZMod L) + 1) = ((L - 1 + 1 : ℕ) : ZMod L) := by
        rw [Nat.cast_add, Nat.cast_one]
      _ = (L : ZMod L) := congrArg (fun n : ℕ => (n : ZMod L))
        (Nat.sub_add_cancel hL)
      _ = 0 := ZMod.natCast_self L
  have hzero : A 0 = 0 := by
    calc
      A 0 = A (((L - 1 : ℕ) : ZMod L) + 1) := congrArg A hwrap.symm
      _ = A ((L - 1 : ℕ) : ZMod L) := by
        simpa only [A] using
          (closedWalk_horizontal_column_parity_invariant γ hγ
            ((L - 1 : ℕ) : ZMod L)).symm
      _ = 0 := hlast
  have hnat (n : ℕ) : A (n : ZMod L) = 0 := by
    induction n with
    | zero => simpa using hzero
    | succ n ih =>
        calc
          A ((n + 1 : ℕ) : ZMod L) = A ((n : ZMod L) + 1) := by simp
          _ = A (n : ZMod L) := by
            simpa only [A] using
              (closedWalk_horizontal_column_parity_invariant γ hγ (n : ZMod L)).symm
          _ = 0 := ih
  change A j = 0
  rw [← ZMod.natCast_zmod_val j]
  exact hnat j.val

/-- 縦切断線の偶奇が零なら、閉歩道の縦辺全列和はどの行でも偶数になる。 -/
theorem closedWalk_vertical_row_parity_zero {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hseam : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0)
    (i : ZMod L) :
    (∑ j : ZMod L, walkBaseEdgeParity γ (edgeOfRow L true i j)) % 2 = 0 := by
  let B (r : ZMod L) :=
    (∑ j : ZMod L, walkBaseEdgeParity γ (edgeOfRow L true r j)) % 2
  have hlast : B (((L - 1 : ℕ) : ZMod L)) = 0 := by
    exact (vertical_seam_row_parity γ).trans hseam
  have hL : 1 ≤ L := Nat.pos_of_ne_zero (NeZero.ne L)
  have hwrap : (((L - 1 : ℕ) : ZMod L) + 1) = 0 := by
    calc
      (((L - 1 : ℕ) : ZMod L) + 1) = ((L - 1 + 1 : ℕ) : ZMod L) := by
        rw [Nat.cast_add, Nat.cast_one]
      _ = (L : ZMod L) := congrArg (fun n : ℕ => (n : ZMod L))
        (Nat.sub_add_cancel hL)
      _ = 0 := ZMod.natCast_self L
  have hzero : B 0 = 0 := by
    calc
      B 0 = B (((L - 1 : ℕ) : ZMod L) + 1) := congrArg B hwrap.symm
      _ = B ((L - 1 : ℕ) : ZMod L) := by
        simpa only [B] using
          (closedWalk_vertical_row_parity_invariant γ hγ
            ((L - 1 : ℕ) : ZMod L)).symm
      _ = 0 := hlast
  have hnat (n : ℕ) : B (n : ZMod L) = 0 := by
    induction n with
    | zero => simpa using hzero
    | succ n ih =>
        calc
          B ((n + 1 : ℕ) : ZMod L) = B ((n : ZMod L) + 1) := by simp
          _ = B (n : ZMod L) := by
            simpa only [B] using
              (closedWalk_vertical_row_parity_invariant γ hγ (n : ZMod L)).symm
          _ = 0 := ih
  change B i = 0
  rw [← ZMod.natCast_zmod_val i]
  exact hnat i.val

/-- 基点セルから列方向、次に行方向へ進む標準双対路の横断偶奇。 -/
def standardDualHeight (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (cell : ZMod L × ZMod L) : ℕ :=
  ((∑ c ∈ Finset.Icc 1 cell.2.val,
      walkBaseEdgeParity γ (edgeOfRow L true 0 (c : ZMod L))) +
    (∑ r ∈ Finset.Icc 1 cell.1.val,
      walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) cell.2))) % 2

/-- 閉歩道の基底辺について、局所的な偶数次数から長方形の辺偶奇を得る。 -/
theorem rectangle_crossing_parity (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (i j : ℕ) (hi : i < L) (hj : j + 1 < L)
    (hvertex : ∀ r : ℕ, 1 ≤ r → r ≤ i →
      (walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) (j : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L false (r : ZMod L) ((j + 1 : ℕ) : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L true ((r - 1 : ℕ) : ZMod L) ((j + 1 : ℕ) : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L true (r : ZMod L) ((j + 1 : ℕ) : ZMod L))) % 2 = 0) :
    ((∑ r ∈ Finset.Icc 1 i,
        walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) (j : ZMod L))) +
      (∑ r ∈ Finset.Icc 1 i,
        walkBaseEdgeParity γ
          (edgeOfRow L false (r : ZMod L) ((j + 1 : ℕ) : ZMod L))) +
      walkBaseEdgeParity γ (edgeOfRow L true 0 ((j + 1 : ℕ) : ZMod L)) +
      walkBaseEdgeParity γ
        (edgeOfRow L true (i : ZMod L) ((j + 1 : ℕ) : ZMod L))) % 2 = 0 := by
  induction i with
  | zero => simp; omega
  | succ i ih =>
      have hi0 : i < L := by omega
      have hprev := ih hi0 (fun r hr1 hri => hvertex r hr1 (by omega))
      have hlast := hvertex (i + 1) (by omega) (by omega)
      rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ i + 1)]
      rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ i + 1)]
      have hcast : ((i + 1 - 1 : ℕ) : ZMod L) = (i : ZMod L) := by simp
      rw [hcast] at hlast
      omega

/-- 横方向の内部一歩では、横切る辺の通過偶奇だけ高さが変わる。 -/
theorem standardDualHeight_horizontal_internal (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (i j : ℕ) (hi : i + 1 < L) (hj : j < L) :
    standardDualHeight L m γ
        (((i + 1 : ℕ) : ZMod L), (j : ZMod L)) =
      (standardDualHeight L m γ
        ((i : ZMod L), (j : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L false ((i + 1 : ℕ) : ZMod L) (j : ZMod L))) % 2 := by
  have hi0 : i < L := by omega
  simp only [standardDualHeight, ZMod.val_cast_of_lt hi,
    ZMod.val_cast_of_lt hi0, ZMod.val_cast_of_lt hj]
  rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ i + 1)]
  omega

theorem standardDualHeight_horizontal_internal_changes (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (i j : ℕ) (hi : i + 1 < L) (hj : j < L) :
    (standardDualHeight L m γ
        (((i + 1 : ℕ) : ZMod L), (j : ZMod L)) ≠
      standardDualHeight L m γ ((i : ZMod L), (j : ZMod L))) ↔
    walkBaseEdgeParity γ
      (edgeOfRow L false ((i + 1 : ℕ) : ZMod L) (j : ZMod L)) = 1 := by
  rw [standardDualHeight_horizontal_internal L m γ i j hi hj]
  unfold standardDualHeight walkBaseEdgeParity
  omega

/-- 局所偶数次数を入力すると、縦方向の内部一歩は横切る縦辺だけで決まる。 -/
theorem standardDualHeight_vertical_internal (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (i j : ℕ) (hi : i < L) (hj : j + 1 < L)
    (hvertex : ∀ r : ℕ, 1 ≤ r → r ≤ i →
      (walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) (j : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L false (r : ZMod L) ((j + 1 : ℕ) : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L true ((r - 1 : ℕ) : ZMod L) ((j + 1 : ℕ) : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L true (r : ZMod L) ((j + 1 : ℕ) : ZMod L))) % 2 = 0) :
    standardDualHeight L m γ
        ((i : ZMod L), ((j + 1 : ℕ) : ZMod L)) =
      (standardDualHeight L m γ
        ((i : ZMod L), (j : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L true (i : ZMod L) ((j + 1 : ℕ) : ZMod L))) % 2 := by
  have hrect := rectangle_crossing_parity L m γ i j hi hj hvertex
  have hj0 : j < L := by omega
  simp only [standardDualHeight, ZMod.val_cast_of_lt hi,
    ZMod.val_cast_of_lt hj, ZMod.val_cast_of_lt hj0]
  rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ j + 1)]
  omega

theorem standardDualHeight_vertical_internal_changes (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (i j : ℕ) (hi : i < L) (hj : j + 1 < L)
    (hvertex : ∀ r : ℕ, 1 ≤ r → r ≤ i →
      (walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) (j : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L false (r : ZMod L) ((j + 1 : ℕ) : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L true ((r - 1 : ℕ) : ZMod L) ((j + 1 : ℕ) : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L true (r : ZMod L) ((j + 1 : ℕ) : ZMod L))) % 2 = 0) :
    (standardDualHeight L m γ
        ((i : ZMod L), ((j + 1 : ℕ) : ZMod L)) ≠
      standardDualHeight L m γ ((i : ZMod L), (j : ZMod L))) ↔
    walkBaseEdgeParity γ
      (edgeOfRow L true (i : ZMod L) ((j + 1 : ℕ) : ZMod L)) = 1 := by
  rw [standardDualHeight_vertical_internal L m γ i j hi hj hvertex]
  unfold standardDualHeight walkBaseEdgeParity
  omega

/-- 閉歩道では各頂点の局所偶奇が自動的に成り立つ。 -/
theorem closedWalk_standardDualHeight_vertical_internal (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (i j : ℕ) (hi : i < L) (hj : j + 1 < L) :
    standardDualHeight L m γ
        ((i : ZMod L), ((j + 1 : ℕ) : ZMod L)) =
      (standardDualHeight L m γ ((i : ZMod L), (j : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L true (i : ZMod L) ((j + 1 : ℕ) : ZMod L))) % 2 := by
  apply standardDualHeight_vertical_internal L m γ i j hi hj
  intro r _ _
  have h := closedWalk_four_edge_parity γ hγ
    (r : ZMod L) ((j + 1 : ℕ) : ZMod L)
  have hr : ((r : ZMod L) - 1) = ((r - 1 : ℕ) : ZMod L) := by
    have : 1 ≤ r := by omega
    rw [Nat.cast_sub this]
    norm_num
  have hjcast : (((j + 1 : ℕ) : ZMod L) - 1) = (j : ZMod L) := by
    simp
  rw [hr, hjcast] at h
  omega

theorem closedWalk_standardDualHeight_vertical_internal_changes
    (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (i j : ℕ) (hi : i < L) (hj : j + 1 < L) :
    (standardDualHeight L m γ
        ((i : ZMod L), ((j + 1 : ℕ) : ZMod L)) ≠
      standardDualHeight L m γ ((i : ZMod L), (j : ZMod L))) ↔
    walkBaseEdgeParity γ
      (edgeOfRow L true (i : ZMod L) ((j + 1 : ℕ) : ZMod L)) = 1 := by
  rw [closedWalk_standardDualHeight_vertical_internal L m γ hγ i j hi hj]
  unfold standardDualHeight walkBaseEdgeParity
  omega

/-- 横方向の全周通過偶奇が零なら、切断線でも末項の辺だけ高さが変わる。 -/
theorem standardDualHeight_horizontal_seam_of_line_parity (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (j : ℕ)
    (hL : 2 ≤ L) (hj : j < L)
    (hline :
      ((∑ r ∈ Finset.Icc 1 (L - 1),
          walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) (j : ZMod L))) +
        walkBaseEdgeParity γ (edgeOfRow L false 0 (j : ZMod L))) % 2 = 0) :
    standardDualHeight L m γ (0, (j : ZMod L)) =
      (standardDualHeight L m γ (((L - 1 : ℕ) : ZMod L), (j : ZMod L)) +
        walkBaseEdgeParity γ (edgeOfRow L false 0 (j : ZMod L))) % 2 := by
  have hlast : L - 1 < L := by omega
  simp only [standardDualHeight, ZMod.val_zero,
    ZMod.val_cast_of_lt hlast, ZMod.val_cast_of_lt hj]
  simp only [Finset.Icc_eq_empty_of_lt (by omega : 0 < 1), Finset.sum_empty, Nat.add_zero]
  omega

theorem standardDualHeight_horizontal_seam_changes_of_line_parity (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (j : ℕ)
    (hL : 2 ≤ L) (hj : j < L)
    (hline :
      ((∑ r ∈ Finset.Icc 1 (L - 1),
          walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) (j : ZMod L))) +
        walkBaseEdgeParity γ (edgeOfRow L false 0 (j : ZMod L))) % 2 = 0) :
    (standardDualHeight L m γ (0, (j : ZMod L)) ≠
      standardDualHeight L m γ (((L - 1 : ℕ) : ZMod L), (j : ZMod L))) ↔
    walkBaseEdgeParity γ (edgeOfRow L false 0 (j : ZMod L)) = 1 := by
  rw [standardDualHeight_horizontal_seam_of_line_parity L m γ j hL hj hline]
  unfold standardDualHeight walkBaseEdgeParity
  omega

/-- A zero horizontal seam parity supplies the full-line parity required at the seam. -/
theorem closedWalk_standardDualHeight_horizontal_seam (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hseam : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (j : ℕ) (hL : 2 ≤ L) (hj : j < L) :
    standardDualHeight L m γ (0, (j : ZMod L)) =
      (standardDualHeight L m γ (((L - 1 : ℕ) : ZMod L), (j : ZMod L)) +
        walkBaseEdgeParity γ (edgeOfRow L false 0 (j : ZMod L))) % 2 := by
  have hsum :
      (∑ i : ZMod L, walkBaseEdgeParity γ (edgeOfRow L false i (j : ZMod L))) =
        ∑ r ∈ Finset.Icc 0 (L - 1),
          walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) (j : ZMod L)) := by
    symm
    apply Finset.sum_bij (fun (r : ℕ) _ => (r : ZMod L))
    · intro r _; exact Finset.mem_univ _
    · intro a ha b hb hab
      have ha' : a < L := by have := (Finset.mem_Icc.mp ha).2; omega
      have hb' : b < L := by have := (Finset.mem_Icc.mp hb).2; omega
      have := congrArg ZMod.val hab
      simpa [ZMod.val_cast_of_lt ha', ZMod.val_cast_of_lt hb'] using this
    · intro i _
      refine ⟨i.val, Finset.mem_Icc.mpr ⟨Nat.zero_le _, ?_⟩, ?_⟩
      · exact Nat.le_sub_one_of_lt i.val_lt
      · exact ZMod.natCast_zmod_val i
    · intro r _; rfl
  have hline :
      ((∑ r ∈ Finset.Icc 1 (L - 1),
          walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) (j : ZMod L))) +
        walkBaseEdgeParity γ (edgeOfRow L false 0 (j : ZMod L))) % 2 = 0 := by
    have hz := closedWalk_horizontal_column_parity_zero γ hγ hseam (j : ZMod L)
    have hsplit : Finset.Icc 0 (L - 1) =
        insert 0 (Finset.Icc 1 (L - 1)) := by
      exact (Finset.insert_Icc_succ_left_eq_Icc (by omega : 0 ≤ L - 1)).symm
    rw [hsum, hsplit, Finset.sum_insert (by simp)] at hz
    simpa [add_comm] using hz
  exact standardDualHeight_horizontal_seam_of_line_parity L m γ j hL hj hline

theorem closedWalk_standardDualHeight_horizontal_seam_changes (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hseam : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (j : ℕ) (hL : 2 ≤ L) (hj : j < L) :
    (standardDualHeight L m γ (0, (j : ZMod L)) ≠
      standardDualHeight L m γ (((L - 1 : ℕ) : ZMod L), (j : ZMod L))) ↔
    walkBaseEdgeParity γ (edgeOfRow L false 0 (j : ZMod L)) = 1 := by
  rw [closedWalk_standardDualHeight_horizontal_seam L m γ hγ hseam j hL hj]
  unfold walkBaseEdgeParity standardDualHeight
  omega

/-- The closed walk supplies local parity; zero full-line parity closes the vertical seam. -/
theorem closedWalk_standardDualHeight_vertical_seam_of_line_parity (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (i : ℕ) (hL : 2 ≤ L) (hi : i < L)
    (hline :
      ((∑ c ∈ Finset.Icc 1 (L - 1),
          walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) (c : ZMod L))) +
        walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) 0)) % 2 = 0) :
    standardDualHeight L m γ ((i : ZMod L), 0) =
      (standardDualHeight L m γ ((i : ZMod L), ((L - 1 : ℕ) : ZMod L)) +
        walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) 0)) % 2 := by
  have hseq (j : ℕ) (hj : j < L) :
      standardDualHeight L m γ ((i : ZMod L), (j : ZMod L)) =
        (standardDualHeight L m γ ((i : ZMod L), 0) +
          ∑ c ∈ Finset.Icc 1 j,
            walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) (c : ZMod L))) % 2 := by
    induction j with
    | zero =>
        simp
        unfold standardDualHeight
        omega
    | succ j ih =>
        have hj0 : j < L := by omega
        have hstep := closedWalk_standardDualHeight_vertical_internal L m γ hγ
          i j hi hj
        rw [hstep, ih hj0, Finset.sum_Icc_succ_top (by omega : 1 ≤ j + 1)]
        omega
  have hlast : L - 1 < L := by omega
  have h := hseq (L - 1) hlast
  have hbound : standardDualHeight L m γ ((i : ZMod L), 0) < 2 := by
    unfold standardDualHeight
    omega
  omega

theorem closedWalk_standardDualHeight_vertical_seam_changes_of_line_parity
    (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (i : ℕ) (hL : 2 ≤ L) (hi : i < L)
    (hline :
      ((∑ c ∈ Finset.Icc 1 (L - 1),
          walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) (c : ZMod L))) +
        walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) 0)) % 2 = 0) :
    (standardDualHeight L m γ ((i : ZMod L), 0) ≠
      standardDualHeight L m γ ((i : ZMod L), ((L - 1 : ℕ) : ZMod L))) ↔
    walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) 0) = 1 := by
  rw [closedWalk_standardDualHeight_vertical_seam_of_line_parity L m γ hγ i hL hi hline]
  unfold standardDualHeight walkBaseEdgeParity
  omega

/-- The closed walk supplies the full vertical row parity at the seam. -/
theorem closedWalk_standardDualHeight_vertical_seam (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hseam : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0)
    (i : ℕ) (hL : 2 ≤ L) (hi : i < L) :
    standardDualHeight L m γ ((i : ZMod L), 0) =
      (standardDualHeight L m γ ((i : ZMod L), ((L - 1 : ℕ) : ZMod L)) +
        walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) 0)) % 2 := by
  have hsum :
      (∑ j : ZMod L, walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) j)) =
        ∑ c ∈ Finset.Icc 0 (L - 1),
          walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) (c : ZMod L)) := by
    symm
    apply Finset.sum_bij (fun (c : ℕ) _ => (c : ZMod L))
    · intro c _; exact Finset.mem_univ _
    · intro a ha b hb hab
      have ha' : a < L := by have := (Finset.mem_Icc.mp ha).2; omega
      have hb' : b < L := by have := (Finset.mem_Icc.mp hb).2; omega
      have := congrArg ZMod.val hab
      simpa [ZMod.val_cast_of_lt ha', ZMod.val_cast_of_lt hb'] using this
    · intro j _
      refine ⟨j.val, Finset.mem_Icc.mpr ⟨Nat.zero_le _, ?_⟩, ?_⟩
      · exact Nat.le_sub_one_of_lt j.val_lt
      · exact ZMod.natCast_zmod_val j
    · intro c _; rfl
  have hline :
      ((∑ c ∈ Finset.Icc 1 (L - 1),
          walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) (c : ZMod L))) +
        walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) 0)) % 2 = 0 := by
    have hz := closedWalk_vertical_row_parity_zero γ hγ hseam (i : ZMod L)
    have hsplit : Finset.Icc 0 (L - 1) =
        insert 0 (Finset.Icc 1 (L - 1)) := by
      exact (Finset.insert_Icc_succ_left_eq_Icc (by omega : 0 ≤ L - 1)).symm
    rw [hsum, hsplit, Finset.sum_insert (by simp)] at hz
    simpa [add_comm] using hz
  exact closedWalk_standardDualHeight_vertical_seam_of_line_parity L m γ hγ i hL hi hline

theorem closedWalk_standardDualHeight_vertical_seam_changes (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hseam : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0)
    (i : ℕ) (hL : 2 ≤ L) (hi : i < L) :
    (standardDualHeight L m γ ((i : ZMod L), 0) ≠
      standardDualHeight L m γ ((i : ZMod L), ((L - 1 : ℕ) : ZMod L))) ↔
    walkBaseEdgeParity γ (edgeOfRow L true (i : ZMod L) 0) = 1 := by
  rw [closedWalk_standardDualHeight_vertical_seam L m γ hγ hseam i hL hi]
  unfold walkBaseEdgeParity standardDualHeight
  omega

end Ising2DLambda.KacWard
