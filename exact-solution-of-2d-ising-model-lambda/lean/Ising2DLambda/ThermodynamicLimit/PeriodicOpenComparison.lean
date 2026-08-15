/-
章「熱力学極限」の「周期境界と開境界の境界評価」の証明のうち、
頂点の対応と配位の全単射の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_periodic_open_boundary_comparison` の証明の前半である。

  人手証明の段                                このファイル
  頂点の対応 v_L(i,j) := (s(i), s(j))          periodicVertexToOpen
  逆写像 (p,q) ↦ (π(p), π(q))                  openVertexToPeriodic
  s(π(p)) = p（除法の原理の一意性）            periodicVertexToOpen_openVertexToPeriodic
  π(s(y)) = y                                  openVertexToPeriodic_periodicVertexToOpen
  v_L は全単射                                 periodicOpenVertexEquiv
  配位の読み替え r_L(τ) := τ ∘ v_L             openConfigToPeriodic
  逆写像 σ ↦ σ ∘ (v_L の逆写像)                periodicConfigToOpen
  往復して戻ること（τ 側）                     periodicConfigToOpen_openConfigToPeriodic
  往復して戻ること（σ 側）                     openConfigToPeriodic_periodicConfigToOpen
  r_L は全単射                                 periodicOpenConfigEquiv

住処: 頂点・配位はいずれも有限集合の元であり、可算側で閉じる。ℝ / ℂ は現れない。
境界横断辺の破れ本数と破れボンド数の分解、実数評価の上下は後続のセクションで扱う。

人手証明との対応の注意:
- 人手証明の代表を取る写像 s は `ZMod.val`、自然な射影 π は `Nat.cast : ℕ → ZMod L` である。
- 「除法の原理の一意性から s(π(p)) = p」は `ZMod.val_cast_of_lt`、
  「π(s(y)) = y」は `ZMod.natCast_rightInverse` で、どちらも代表の一意性そのものであり、
  人手証明が使っていない性質は使わない。
-/
import Ising2DLambda.PartitionPolynomial.Basic
import Ising2DLambda.ThermodynamicLimit.OpenRectangle
import Mathlib.Logic.Equiv.Fin.Basic

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 人手証明の頂点の対応 `v_L(i,j) := (s(i), s(j))`。
代表を取る写像 `s` は `ZMod.val` であり、`0 ≤ s(i), s(j) ≤ L-1` が
`ZMod.val_lt`（値が `L` 未満であること）として付いてくる。 -/
def periodicVertexToOpen (u : Vertex L) : OpenVertex L L :=
  (⟨u.1.val, ZMod.val_lt u.1⟩, ⟨u.2.val, ZMod.val_lt u.2⟩)

/-- 人手証明の逆写像 `(p,q) ↦ (π(p), π(q))`。自然な射影 `π` は `Nat.cast` である。 -/
def openVertexToPeriodic (v : OpenVertex L L) : Vertex L :=
  ((v.1.val : ZMod L), (v.2.val : ZMod L))

/-- 人手証明の「`0 ≤ p ≤ L-1` の整数 `p` について `s(π(p)) = p`（除法の原理の一意性）」。
成分ごとに `ZMod.val_cast_of_lt` を適用する。 -/
lemma periodicVertexToOpen_openVertexToPeriodic (v : OpenVertex L L) :
    periodicVertexToOpen L (openVertexToPeriodic L v) = v := by
  refine Prod.ext (Fin.ext ?_) (Fin.ext ?_)
  · exact ZMod.val_cast_of_lt v.1.isLt
  · exact ZMod.val_cast_of_lt v.2.isLt

/-- 人手証明の「任意の `y ∈ ℤ/Lℤ` について `π(s(y)) = y`」。
成分ごとに `ZMod.natCast_rightInverse` を適用する。 -/
lemma openVertexToPeriodic_periodicVertexToOpen (u : Vertex L) :
    openVertexToPeriodic L (periodicVertexToOpen L u) = u :=
  Prod.ext (ZMod.natCast_rightInverse u.1) (ZMod.natCast_rightInverse u.2)

/-- 人手証明の「ゆえに `v_L` は全単射である」。 -/
def periodicOpenVertexEquiv : Vertex L ≃ OpenVertex L L where
  toFun := periodicVertexToOpen L
  invFun := openVertexToPeriodic L
  left_inv := openVertexToPeriodic_periodicVertexToOpen L
  right_inv := periodicVertexToOpen_openVertexToPeriodic L

/-- 人手証明の配位を読み替える写像 `r_L(τ) := τ ∘ v_L`。 -/
def openConfigToPeriodic (τ : OpenConfig L L) : Config L :=
  fun u => τ (periodicVertexToOpen L u)

/-- 人手証明の逆写像 `τ' ↦ τ' ∘ (v_L の逆写像)`。 -/
def periodicConfigToOpen (σ : Config L) : OpenConfig L L :=
  fun v => σ (openVertexToPeriodic L v)

/-- 往復して戻ること（開境界側）。各頂点で
`τ(v_L((v_L の逆写像)(v))) = τ(v)` を頂点の往復の等式から得る。 -/
lemma periodicConfigToOpen_openConfigToPeriodic (τ : OpenConfig L L) :
    periodicConfigToOpen L (openConfigToPeriodic L τ) = τ :=
  funext fun v => congrArg τ (periodicVertexToOpen_openVertexToPeriodic L v)

/-- 往復して戻ること（周期境界側）。各頂点で
`σ((v_L の逆写像)(v_L(u))) = σ(u)` を頂点の往復の等式から得る。 -/
lemma openConfigToPeriodic_periodicConfigToOpen (σ : Config L) :
    openConfigToPeriodic L (periodicConfigToOpen L σ) = σ :=
  funext fun u => congrArg σ (openVertexToPeriodic_periodicVertexToOpen L u)

/-- 人手証明の「`r_L` も全単射である」。 -/
def periodicOpenConfigEquiv : OpenConfig L L ≃ Config L where
  toFun := openConfigToPeriodic L
  invFun := periodicConfigToOpen L
  left_inv := periodicConfigToOpen_openConfigToPeriodic L
  right_inv := openConfigToPeriodic_periodicConfigToOpen L

/-! ## 破れボンド数の分解 -/

private def finTwoProdEquivSum (A : Type) : Fin 2 × A ≃ A ⊕ A where
  toFun p := if p.1.val = 0 then Sum.inl p.2 else Sum.inr p.2
  invFun
    | Sum.inl a => (⟨0, by omega⟩, a)
    | Sum.inr a => (⟨1, by omega⟩, a)
  left_inv := by
    rintro ⟨i, a⟩
    fin_cases i <;> rfl
  right_inv := by
    intro a
    rcases a with a | a <;> rfl

/-- 周期境界の辺を、横向きの「行・列」または縦向きの
「行・列」に分ける。`Edge L = Fin (2 * L^2)` の前半は横向き、
後半は縦向きであるという人手証明の辺の向きの分割そのもの。 -/
def periodicEdgeOrientedEquiv : Edge L ≃ (Fin L × Fin L) ⊕ (Fin L × Fin L) :=
  (finCongr (by simp [Edge, pow_two])).trans
    (finProdFinEquiv.symm.trans
      ((Equiv.prodCongr (Equiv.refl (Fin 2)) finProdFinEquiv.symm).trans
        (finTwoProdEquivSum (Fin L × Fin L))))

@[simp] lemma periodicEdgeOrientedEquiv_symm_horizontal (q : Fin L × Fin L) :
    (periodicEdgeOrientedEquiv L).symm (Sum.inl q) =
      ⟨q.2.val + L * q.1.val, by
        have hInner : q.2.val + L * q.1.val < L * L := by
          calc
            q.2.val + L * q.1.val < L + L * q.1.val :=
              Nat.add_lt_add_right q.2.isLt (L * q.1.val)
            _ = L * (q.1.val + 1) := by simp [Nat.mul_succ, Nat.add_comm]
            _ ≤ L * L := Nat.mul_le_mul_left L (Nat.succ_le_iff.mpr q.1.isLt)
        exact lt_of_lt_of_le hInner (by
          simpa [pow_two] using Nat.mul_le_mul_right (L * L) (show 1 ≤ 2 by omega))⟩ := by
  apply Fin.ext
  rfl

@[simp] lemma periodicEdgeOrientedEquiv_symm_vertical (q : Fin L × Fin L) :
    (periodicEdgeOrientedEquiv L).symm (Sum.inr q) =
      Fin.cast (by simp [pow_two])
        (finProdFinEquiv (m := 2) (n := L * L)
          (⟨1, by omega⟩, finProdFinEquiv (m := L) (n := L) q)) := by
  rfl

private lemma periodicEdgeIndex_lt (q : Fin L × Fin L) :
    q.2.val + L * q.1.val < L * L := by
  calc
    q.2.val + L * q.1.val < L + L * q.1.val :=
      Nat.add_lt_add_right q.2.isLt (L * q.1.val)
    _ = L * (q.1.val + 1) := by simp [Nat.mul_succ, Nat.add_comm]
    _ ≤ L * L := Nat.mul_le_mul_left L (Nat.succ_le_iff.mpr q.1.isLt)

private lemma periodicEdgeIndex_div (q : Fin L × Fin L) :
    (q.2.val + L * q.1.val) / L = q.1.val := by
  rw [Nat.add_mul_div_left _ _ (Nat.pos_of_ne_zero (NeZero.ne L)), Nat.div_eq_of_lt q.2.isLt]
  omega

private lemma periodicEdgeIndex_mod (q : Fin L × Fin L) :
    (q.2.val + L * q.1.val) % L = q.2.val := by
  rw [Nat.add_mul_mod_self_left, Nat.mod_eq_of_lt q.2.isLt]

private lemma last_add_zmod_one_mod :
    (L - 1 + (1 : ZMod L).val) % L = 0 := by
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  by_cases h : L = 1
  · subst L
    simp only [ZMod.val_one_eq_one_mod]
  · have hTwo : 1 < L := by omega
    rw [ZMod.val_one_eq_one_mod, Nat.mod_eq_of_lt hTwo]
    have hLast : L - 1 + 1 = L := by omega
    rw [hLast, Nat.mod_self]

/-- 開境界の辺と、横・縦の境界横断辺を周期境界の向き付き辺へ送る。 -/
def periodicEdgePartsJoin :
    OpenEdge L L ⊕ (Fin L ⊕ Fin L) → (Fin L × Fin L) ⊕ (Fin L × Fin L)
  | Sum.inl (Sum.inl e) => Sum.inl e.val
  | Sum.inl (Sum.inr e) => Sum.inr e.val
  | Sum.inr (Sum.inl i) => Sum.inl (i, ⟨L - 1, by
      have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
      omega⟩)
  | Sum.inr (Sum.inr j) => Sum.inr (⟨L - 1, by
      have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
      omega⟩, j)

/-- 周期境界の向き付き辺を、開境界の辺または境界横断辺へ戻す。 -/
def periodicEdgePartsSplit :
    (Fin L × Fin L) ⊕ (Fin L × Fin L) → OpenEdge L L ⊕ (Fin L ⊕ Fin L)
  | Sum.inl q =>
      if h : q.2.val + 1 < L then Sum.inl (Sum.inl ⟨q, h⟩)
      else Sum.inr (Sum.inl q.1)
  | Sum.inr q =>
      if h : q.1.val + 1 < L then Sum.inl (Sum.inr ⟨q, h⟩)
      else Sum.inr (Sum.inr q.2)

/-- 周期境界の辺集合は、開境界正方形の辺集合と、
横・縦に `L` 本ずつの境界横断辺との互いに交わらない和である。 -/
def periodicEdgePartsEquiv :
    OpenEdge L L ⊕ (Fin L ⊕ Fin L) ≃ (Fin L × Fin L) ⊕ (Fin L × Fin L) where
  toFun := periodicEdgePartsJoin L
  invFun := periodicEdgePartsSplit L
  left_inv := by
    intro e
    rcases e with e | e
    · rcases e with e | e
      · simp [periodicEdgePartsJoin, periodicEdgePartsSplit, e.property]
      · simp [periodicEdgePartsJoin, periodicEdgePartsSplit, e.property]
    · rcases e with i | j
      · have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
        simp [periodicEdgePartsJoin, periodicEdgePartsSplit, show ¬L - 1 + 1 < L by omega]
      · have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
        simp [periodicEdgePartsJoin, periodicEdgePartsSplit, show ¬L - 1 + 1 < L by omega]
  right_inv := by
    intro e
    rcases e with q | q
    · by_cases h : q.2.val + 1 < L
      · simp [periodicEdgePartsSplit, periodicEdgePartsJoin, h]
      · have hq := q.2.isLt
        have hEq : L - 1 = q.2.val := by omega
        simp [periodicEdgePartsSplit, periodicEdgePartsJoin, h, hEq]
    · by_cases h : q.1.val + 1 < L
      · simp [periodicEdgePartsSplit, periodicEdgePartsJoin, h]
      · have hq := q.1.isLt
        have hEq : L - 1 = q.1.val := by omega
        simp [periodicEdgePartsSplit, periodicEdgePartsJoin, h, hEq]

/-- 人手証明で用いる「開境界辺と境界横断辺の直和」から
周期境界辺への全単射。 -/
def periodicOpenEdgeEquiv : OpenEdge L L ⊕ (Fin L ⊕ Fin L) ≃ Edge L :=
  (periodicEdgePartsEquiv L).trans (periodicEdgeOrientedEquiv L).symm

/-- 境界横断辺のうち、開境界配位 `τ` のもとで破れている本数。 -/
def periodicBoundaryBrokenCount (τ : OpenConfig L L) : ℕ :=
  (Finset.univ.filter fun i : Fin L =>
      τ (i, ⟨L - 1, by
        have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
        omega⟩) ≠ τ (i, ⟨0, Nat.pos_of_ne_zero (NeZero.ne L)⟩)).card +
    (Finset.univ.filter fun j : Fin L =>
      τ (⟨L - 1, by
        have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
        omega⟩, j) ≠ τ (⟨0, Nat.pos_of_ne_zero (NeZero.ne L)⟩, j)).card

lemma periodicBoundaryBrokenCount_le (τ : OpenConfig L L) :
    periodicBoundaryBrokenCount L τ ≤ 2 * L := by
  unfold periodicBoundaryBrokenCount
  have hFirst : (Finset.univ.filter fun i : Fin L =>
      τ (i, ⟨L - 1, by
        have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
        omega⟩) ≠ τ (i, ⟨0, Nat.pos_of_ne_zero (NeZero.ne L)⟩)).card ≤ L :=
    le_trans (Finset.card_filter_le _ _) (by simp)
  have hSecond : (Finset.univ.filter fun j : Fin L =>
      τ (⟨L - 1, by
        have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
        omega⟩, j) ≠ τ (⟨0, Nat.pos_of_ne_zero (NeZero.ne L)⟩, j)).card ≤ L :=
    le_trans (Finset.card_filter_le _ _) (by simp)
  omega

private lemma periodicOpenEdge_broken_open (τ : OpenConfig L L) (e : OpenEdge L L) :
    (openConfigToPeriodic L τ
        (boundary0 L (periodicOpenEdgeEquiv L (Sum.inl e))) ≠
      openConfigToPeriodic L τ
        (boundary1 L (periodicOpenEdgeEquiv L (Sum.inl e)))) ↔
      τ (openBoundary0 L L e) ≠ τ (openBoundary1 L L e) := by
  rcases e with e | e
  · have hIndex := periodicEdgeIndex_lt (L := L) e.val
    have hDiv := periodicEdgeIndex_div (L := L) e.val
    have hMod := periodicEdgeIndex_mod (L := L) e.val
    have hRowMod : e.val.1.val % L = e.val.1.val := Nat.mod_eq_of_lt e.val.1.isLt
    have hColMod : e.val.2.val % L = e.val.2.val := Nat.mod_eq_of_lt e.val.2.isLt
    have hNextMod : (e.val.2.val + 1) % L = e.val.2.val + 1 :=
      Nat.mod_eq_of_lt e.property
    have hTwo : 1 < L := lt_of_le_of_lt (Nat.succ_le_succ (Nat.zero_le _)) e.property
    letI : Fact (1 < L) := ⟨hTwo⟩
    have hOne : (1 : ZMod L).val = 1 := ZMod.val_one L
    simp [periodicOpenEdgeEquiv, periodicEdgePartsEquiv, periodicEdgePartsJoin,
      openConfigToPeriodic,
      periodicVertexToOpen, boundary0, boundary1, edgeRow, edgeColumn, edgeIndex,
      openBoundary0, openBoundary1, pow_two, e.property, hIndex, hDiv, hMod,
      hRowMod, hColMod, hNextMod, hOne, ZMod.val_add]
  · have hIndex := periodicEdgeIndex_lt (L := L) e.val
    have hDiv := periodicEdgeIndex_div (L := L) e.val
    have hMod := periodicEdgeIndex_mod (L := L) e.val
    have hNot : ¬(e.val.2.val + (L * L + L * e.val.1.val) < L * L) := by omega
    have hSub : e.val.2.val + (L * L + L * e.val.1.val) - L * L =
        e.val.2.val + L * e.val.1.val := by omega
    have hRowMod : e.val.1.val % L = e.val.1.val := Nat.mod_eq_of_lt e.val.1.isLt
    have hColMod : e.val.2.val % L = e.val.2.val := Nat.mod_eq_of_lt e.val.2.isLt
    have hNextMod : (e.val.1.val + 1) % L = e.val.1.val + 1 :=
      Nat.mod_eq_of_lt e.property
    have hTwo : 1 < L := lt_of_le_of_lt (Nat.succ_le_succ (Nat.zero_le _)) e.property
    letI : Fact (1 < L) := ⟨hTwo⟩
    have hOne : (1 : ZMod L).val = 1 := ZMod.val_one L
    simp [periodicOpenEdgeEquiv, periodicEdgePartsEquiv, periodicEdgePartsJoin,
      openConfigToPeriodic,
      periodicVertexToOpen, boundary0, boundary1, edgeRow, edgeColumn, edgeIndex,
      openBoundary0, openBoundary1, pow_two, e.property, hIndex, hDiv, hMod, hNot,
      hSub, hRowMod, hColMod, hNextMod, hOne, ZMod.val_add,
      Nat.add_comm, Nat.add_left_comm, Nat.add_assoc]

private lemma periodicOpenEdge_broken_horizontalBoundary (τ : OpenConfig L L) (i : Fin L) :
    (openConfigToPeriodic L τ
        (boundary0 L (periodicOpenEdgeEquiv L (Sum.inr (Sum.inl i)))) ≠
      openConfigToPeriodic L τ
        (boundary1 L (periodicOpenEdgeEquiv L (Sum.inr (Sum.inl i))))) ↔
      τ (i, ⟨L - 1, by
        have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
        omega⟩) ≠ τ (i, ⟨0, Nat.pos_of_ne_zero (NeZero.ne L)⟩) := by
  let q : Fin L × Fin L := (i, ⟨L - 1, by
    have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
    omega⟩)
  have hIndex := periodicEdgeIndex_lt (L := L) q
  have hDiv := periodicEdgeIndex_div (L := L) q
  have hMod := periodicEdgeIndex_mod (L := L) q
  have hRowMod : i.val % L = i.val := Nat.mod_eq_of_lt i.isLt
  have hLast : L - 1 + 1 = L := by
    have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
    omega
  simp [periodicOpenEdgeEquiv, periodicEdgePartsEquiv, periodicEdgePartsJoin,
    openConfigToPeriodic,
    periodicVertexToOpen, boundary0, boundary1, edgeRow, edgeColumn, edgeIndex, pow_two,
    q, hIndex, hDiv, hMod, hRowMod, hLast, last_add_zmod_one_mod (L := L), ZMod.val_add]

private lemma periodicOpenEdge_broken_verticalBoundary (τ : OpenConfig L L) (j : Fin L) :
    (openConfigToPeriodic L τ
        (boundary0 L (periodicOpenEdgeEquiv L (Sum.inr (Sum.inr j)))) ≠
      openConfigToPeriodic L τ
        (boundary1 L (periodicOpenEdgeEquiv L (Sum.inr (Sum.inr j))))) ↔
      τ (⟨L - 1, by
        have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
        omega⟩, j) ≠ τ (⟨0, Nat.pos_of_ne_zero (NeZero.ne L)⟩, j) := by
  let q : Fin L × Fin L := (⟨L - 1, by
    have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
    omega⟩, j)
  have hIndex := periodicEdgeIndex_lt (L := L) q
  have hDiv := periodicEdgeIndex_div (L := L) q
  have hMod := periodicEdgeIndex_mod (L := L) q
  have hNot : ¬(j.val + (L * L + L * (L - 1)) < L * L) := by omega
  have hSub : j.val + (L * L + L * (L - 1)) - L * L = j.val + L * (L - 1) := by omega
  have hColMod : j.val % L = j.val := Nat.mod_eq_of_lt j.isLt
  have hLast : L - 1 + 1 = L := by
    have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
    omega
  simp [periodicOpenEdgeEquiv, periodicEdgePartsEquiv, periodicEdgePartsJoin,
    openConfigToPeriodic,
    periodicVertexToOpen, boundary0, boundary1, edgeRow, edgeColumn, edgeIndex, pow_two,
    q, hIndex, hDiv, hMod, hNot, hSub, hColMod, hLast,
    last_add_zmod_one_mod (L := L), ZMod.val_add,
    Nat.add_comm, Nat.add_left_comm, Nat.add_assoc]

private lemma card_filter_univ_eq_sum_indicator {A : Type} [Fintype A] [DecidableEq A]
    (p : A → Prop) [DecidablePred p] :
    (Finset.univ.filter p).card = ∑ x : A, if p x then 1 else 0 := by
  rw [Finset.card_filter]

/-- 周期境界の破れボンド集合を、開境界正方形の破れ辺と
横・縦の境界横断辺へ分けると、個数は三つの和になる。 -/
theorem brokenBondCount_openConfigToPeriodic (τ : OpenConfig L L) :
    brokenBondCount L (openConfigToPeriodic L τ) =
      openBrokenBondCount L L τ + periodicBoundaryBrokenCount L τ := by
  rw [brokenBondCount, card_filter_univ_eq_sum_indicator]
  rw [← Fintype.sum_equiv (periodicOpenEdgeEquiv L)
    (fun e => if openConfigToPeriodic L τ
        (boundary0 L (periodicOpenEdgeEquiv L e)) ≠
      openConfigToPeriodic L τ
        (boundary1 L (periodicOpenEdgeEquiv L e)) then 1 else 0)
    (fun e => if openConfigToPeriodic L τ (boundary0 L e) ≠
      openConfigToPeriodic L τ (boundary1 L e) then 1 else 0)
    (fun _ => rfl)]
  rw [Fintype.sum_sum_type, Fintype.sum_sum_type]
  rw [openBrokenBondCount, openBrokenBondSet, card_filter_univ_eq_sum_indicator,
    periodicBoundaryBrokenCount, card_filter_univ_eq_sum_indicator,
    card_filter_univ_eq_sum_indicator]
  simp_rw [periodicOpenEdge_broken_open, periodicOpenEdge_broken_horizontalBoundary,
    periodicOpenEdge_broken_verticalBoundary]

end Ising2DLambda.ThermodynamicLimit
