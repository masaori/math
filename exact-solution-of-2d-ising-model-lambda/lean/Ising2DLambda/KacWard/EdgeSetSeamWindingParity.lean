/-
章「閉歩道の位相と Pfaffian による有限トーラス公式」の
「辺部分集合の横切断線の偶奇は横の巻き付き偶奇に等しい」
（`claim_edge_set_horizontal_seam_parity_equals_winding_parity`）と
「辺部分集合の縦切断線の偶奇は縦の巻き付き偶奇に等しい」
（`claim_edge_set_vertical_seam_parity_equals_winding_parity`）の具体版。

人手証明と同じく、代表 `s(y) = L - 1` と `y = π(-1)` の同値を先に置き、辺番号の分解で
一辺ごとの等式を示してから、有限和の交換と一点の指示子の和で巻き付き偶奇へ着く。
`horizontalWindingParity` は本文の `|A ∩ C_{L,h}| mod 2` を、単射 `i ↦ n_h(i, π(-1))` の像の
指示子の和として `Fin 2` で持つ（本文の式鎖の最後の二行）。住処は有限集合と ℕ である。
-/
import Ising2DLambda.KacWard.TaggedMatchingQuadraticCrossingWeight
import Ising2DLambda.FisherZero.TorusHomologySector

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix Ising2DLambda.FisherZero

variable {L : ℕ} [NeZero L]

/-- 証明の冒頭の同値: `y ∈ ℤ/Lℤ` について `s(y) = L - 1` と `y = π(-1)` は同値である。 -/
theorem residueVal_eq_pred_iff (y : ZMod L) : y.val = L - 1 ↔ y = -1 := by
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  have hlast : L - 1 < L := by omega
  -- `π(L - 1) = π(-1)`
  have hcast : ((L - 1 : ℕ) : ZMod L) = -1 := by
    rw [Nat.cast_sub (by omega : 1 ≤ L), ZMod.natCast_self, Nat.cast_one, zero_sub]
  constructor
  · intro h
    -- `π(s(y)) = y` から `y = π(L - 1)`
    have : y = ((L - 1 : ℕ) : ZMod L) :=
      ZMod.val_injective L (by rw [ZMod.val_cast_of_lt hlast]; exact h)
    rw [this, hcast]
  · rintro rfl
    -- 代表の一意性から `s(π(-1)) = L - 1`
    rw [← hcast, ZMod.val_cast_of_lt hlast]

/-- 一辺ごとの等式（横）: `Σ_i 1_{e = n_h(i, π(-1))} = c_h(e, 0)`。 -/
theorem horizontalSeamParity_eq_seamRowSum (e : Edge L) :
    horizontalSeamParity ((e, false) : OrientedEdge L) =
      ∑ i : ZMod L, if e = edgeOfRow L false i (-1) then 1 else 0 := by
  -- 辺番号の一意な分解（`claim_edge_row_partition`）
  rcases (edgeEquiv L).surjective e with ⟨w, rfl⟩
  cases w with
  | inl p =>
      rcases p with ⟨r, c⟩
      simp only [edgeEquiv_inl]
      have heq (i : ZMod L) :
          (edgeOfRow L false r c = edgeOfRow L false i (-1)) ↔ r = i ∧ c = -1 := by
        constructor
        · intro h
          have h' := (edgeEquiv L).injective
            (show edgeEquiv L (Sum.inl (r, c)) = edgeEquiv L (Sum.inl (i, -1)) from h)
          simp only [Sum.inl.injEq, Prod.mk.injEq] at h'
          exact h'
        · rintro ⟨rfl, rfl⟩
          rfl
      have hsum : (∑ i : ZMod L,
          if edgeOfRow L false r c = edgeOfRow L false i (-1) then 1 else 0) =
          if c = -1 then 1 else 0 := by
        rw [Finset.sum_congr rfl (fun i _ => if_congr (heq i) rfl rfl)]
        by_cases hc : c = -1
        · simp only [hc, and_true]
          rw [Finset.sum_ite_eq]
          simp
        · simp [hc]
      have hbound : (edgeOfRow L false r c).val < L ^ 2 := by
        simpa [edgeOfRow] using rowColumnIndex_lt L r c
      -- 代表の同値と `def_seam_parities`
      have hpar : horizontalSeamParity ((edgeOfRow L false r c, false) : OrientedEdge L) =
          if c = -1 then 1 else 0 := by
        simp only [horizontalSeamParity, hbound, true_and, edgeColumn_edgeOfRow,
          residueVal_eq_pred_iff]
      exact hpar.trans hsum.symm
  | inr p =>
      rcases p with ⟨r, c⟩
      simp only [edgeEquiv_inr]
      have hneq (i : ZMod L) : edgeOfRow L true r c ≠ edgeOfRow L false i (-1) := by
        intro h
        have h' := (edgeEquiv L).injective
          (show edgeEquiv L (Sum.inr (r, c)) = edgeEquiv L (Sum.inl (i, -1)) from h)
        simp at h'
      have ht : ¬ (edgeOfRow L true r c).val < L ^ 2 := by simp [edgeOfRow]
      simp [hneq, horizontalSeamParity, ht]

/-- 一辺ごとの等式（縦）: `Σ_j 1_{e = n_v(π(-1), j)} = c_v(e, 0)`。 -/
theorem verticalSeamParity_eq_seamColumnSum (e : Edge L) :
    verticalSeamParity ((e, false) : OrientedEdge L) =
      ∑ j : ZMod L, if e = edgeOfRow L true (-1) j then 1 else 0 := by
  rcases (edgeEquiv L).surjective e with ⟨w, rfl⟩
  cases w with
  | inl p =>
      rcases p with ⟨r, c⟩
      simp only [edgeEquiv_inl]
      have hneq (j : ZMod L) : edgeOfRow L false r c ≠ edgeOfRow L true (-1) j := by
        intro h
        have h' := (edgeEquiv L).injective
          (show edgeEquiv L (Sum.inl (r, c)) = edgeEquiv L (Sum.inr (-1, j)) from h)
        simp at h'
      have hf : (edgeOfRow L false r c).val < L ^ 2 := by
        simpa [edgeOfRow] using rowColumnIndex_lt L r c
      simp [hneq, verticalSeamParity, hf]
  | inr p =>
      rcases p with ⟨r, c⟩
      simp only [edgeEquiv_inr]
      have heq (j : ZMod L) :
          (edgeOfRow L true r c = edgeOfRow L true (-1) j) ↔ r = -1 ∧ c = j := by
        constructor
        · intro h
          have h' := (edgeEquiv L).injective
            (show edgeEquiv L (Sum.inr (r, c)) = edgeEquiv L (Sum.inr (-1, j)) from h)
          simp only [Sum.inr.injEq, Prod.mk.injEq] at h'
          exact h'
        · rintro ⟨rfl, rfl⟩
          rfl
      have hsum : (∑ j : ZMod L,
          if edgeOfRow L true r c = edgeOfRow L true (-1) j then 1 else 0) =
          if r = -1 then 1 else 0 := by
        rw [Finset.sum_congr rfl (fun j _ => if_congr (heq j) rfl rfl)]
        by_cases hr : r = -1
        · simp only [hr, true_and]
          rw [Finset.sum_ite_eq]
          simp
        · simp [hr]
      have ht : ¬ (edgeOfRow L true r c).val < L ^ 2 := by simp [edgeOfRow]
      have hpar : verticalSeamParity ((edgeOfRow L true r c, false) : OrientedEdge L) =
          if r = -1 then 1 else 0 := by
        simp only [verticalSeamParity, ht, not_false_eq_true, true_and, edgeRow_edgeOfRow,
          residueVal_eq_pred_iff]
      exact hpar.trans hsum.symm

/-- `Fin 2` の有限和の値は、値の ℕ での和を二で割った余り。 -/
theorem finTwo_sum_val {ι : Type*} (s : Finset ι) (f : ι → Fin 2) :
    ((∑ i ∈ s, f i : Fin 2) : ℕ) = (∑ i ∈ s, (f i : ℕ)) % 2 := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, Fin.val_add, ih, Nat.add_mod_mod]

/-- 式鎖の最後の二行: `Fin 2` に値を取る指示子の和の値は、ℕ の指示子の和を二で割った余り。 -/
theorem finTwo_indicatorSum_val {ι : Type*} [Fintype ι] (p : ι → Prop) [DecidablePred p] :
    ((∑ i : ι, if p i then (1 : Fin 2) else 0 : Fin 2) : ℕ) =
      (∑ i : ι, if p i then 1 else 0) % 2 := by
  rw [finTwo_sum_val]
  congr 1
  apply Finset.sum_congr rfl
  intro i _
  split_ifs <;> rfl

/-- `claim_edge_set_horizontal_seam_parity_equals_winding_parity` の具体版。 -/
theorem edgeSetHorizontalSeamParity_eq_windingParity (A : Finset (Edge L)) :
    (edgeSetSeamParities A).1 = (horizontalWindingParity L A : ℕ) := by
  calc (edgeSetSeamParities A).1
      = (∑ e ∈ A, horizontalSeamParity ((e, false) : OrientedEdge L)) % 2 := rfl
    _ = (∑ e ∈ A, ∑ i : ZMod L, if e = edgeOfRow L false i (-1) then 1 else 0) % 2 := by
        -- 上の一辺ごとの等式
        rw [Finset.sum_congr rfl (fun e _ => horizontalSeamParity_eq_seamRowSum e)]
    _ = (∑ i : ZMod L, ∑ e ∈ A, if e = edgeOfRow L false i (-1) then 1 else 0) % 2 := by
        -- 有限和の交換
        rw [Finset.sum_comm]
    _ = (∑ i : ZMod L, if edgeOfRow L false i (-1) ∈ A then 1 else 0) % 2 := by
        -- 一点の指示子の有限和
        simp only [Finset.sum_ite_eq']
    _ = (horizontalWindingParity L A : ℕ) := by
        -- `def_torus_winding_parities`
        rw [horizontalWindingParity, finTwo_indicatorSum_val]

/-- `claim_edge_set_vertical_seam_parity_equals_winding_parity` の具体版。 -/
theorem edgeSetVerticalSeamParity_eq_windingParity (A : Finset (Edge L)) :
    (edgeSetSeamParities A).2 = (verticalWindingParity L A : ℕ) := by
  calc (edgeSetSeamParities A).2
      = (∑ e ∈ A, verticalSeamParity ((e, false) : OrientedEdge L)) % 2 := rfl
    _ = (∑ e ∈ A, ∑ j : ZMod L, if e = edgeOfRow L true (-1) j then 1 else 0) % 2 := by
        rw [Finset.sum_congr rfl (fun e _ => verticalSeamParity_eq_seamColumnSum e)]
    _ = (∑ j : ZMod L, ∑ e ∈ A, if e = edgeOfRow L true (-1) j then 1 else 0) % 2 := by
        rw [Finset.sum_comm]
    _ = (∑ j : ZMod L, if edgeOfRow L true (-1) j ∈ A then 1 else 0) % 2 := by
        simp only [Finset.sum_ite_eq']
    _ = (verticalWindingParity L A : ℕ) := by
        rw [verticalWindingParity, finTwo_indicatorSum_val]

end Ising2DLambda.KacWard
