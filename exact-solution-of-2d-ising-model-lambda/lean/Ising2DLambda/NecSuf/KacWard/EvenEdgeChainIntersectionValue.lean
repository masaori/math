/-
「正方形境界との交差数は零で基本周回は一度交差する」（`claim_even_edge_chain_intersection`）の
必要十分版。

具体版と同じ手順（正方形境界との交差数を頂点の偶次数条件へ帰着 → 基本周回の係数の代入 →
交差数の分配律 → 標準形を両引数へ代入）を、係数を可換環 `R` に置いて書く。
正方形境界との零等式・基本周回の交差数・分配律は可換環の演算だけで通る。
仮定 `(2 : R) = 0` を使うのは二か所である。基本周回が頂点偶次数であること
（各頂点に同じ周回の辺が二本接する）と、標準形（`ringEvenEdgeChain_torusNormalForm`）である。
これを外すと最後の式変形が通らない。添字は巡回群 `ZMod L`（`L ≠ 0`）のままにする。
-/
import Ising2DLambda.NecSuf.KacWard.EvenEdgeChainTorusNormalForm

namespace Ising2DLambda.NecSuf.KacWard

open Finset

variable {R : Type*} [CommRing R]

/-- 係数で与えた二つの辺鎖の交差数 `I_L(C,D)`（`def_even_edge_chain_intersection` の右辺）。 -/
def ringCoefficientIntersection {L : ℕ} [NeZero L] (HC VC HD VD : ZMod L → ZMod L → R) : R :=
  ∑ i : ZMod L, ∑ j : ZMod L, (HC i j * VD (i - 1) (j + 1) + VC i j * HD i j)

/-- 指示関数を掛けた二重和は、その一点の値である。 -/
theorem ringSum_sum_indicator_mul {L : ℕ} [NeZero L] (a b : ZMod L) (f : ZMod L → ZMod L → R) :
    ∑ i : ZMod L, ∑ j : ZMod L, (if i = a ∧ j = b then (1 : R) else 0) * f i j = f a b := by
  simp [ite_and]

/-- `I_L(P_{r,s},C)=0`。頂点 `(r,s+1)` の偶次数条件を使う。 -/
theorem ringCoefficientIntersection_squareBoundary_left {L : ℕ} [NeZero L]
    (H V : ZMod L → ZMod L → R)
    (heven : ∀ i j, H i j + H i (j - 1) + V i j + V (i - 1) j = 0) (r s : ZMod L) :
    ringCoefficientIntersection (ringSquareBoundaryHorizontal r s) (ringSquareBoundaryVertical r s) H V = 0 := by
  -- 本文の第一の行: 交差数の定義と `P_{r,s}` の四辺で四項になる。
  have hfour : ringCoefficientIntersection (ringSquareBoundaryHorizontal r s) (ringSquareBoundaryVertical r s) H V =
      V (r - 1) (s + 1) + V r (s + 1) + H r s + H r (s + 1) := by
    unfold ringCoefficientIntersection ringSquareBoundaryHorizontal ringSquareBoundaryVertical
    simp only [add_mul, sum_add_distrib, ringSum_sum_indicator_mul (f := fun i j => V (i - 1) (j + 1)),
      ringSum_sum_indicator_mul (f := fun i j => H i j)]
    ring_nf
  -- 本文の第二の行: 頂点 `(r,s+1)` の偶次数条件。
  have hv := heven r (s + 1)
  rw [add_sub_cancel_right] at hv
  rw [hfour]
  linear_combination hv

/-- `I_L(C,P_{r,s})=0`。頂点 `(r+1,s)` の偶次数条件を使う。 -/
theorem ringCoefficientIntersection_squareBoundary_right {L : ℕ} [NeZero L]
    (H V : ZMod L → ZMod L → R)
    (heven : ∀ i j, H i j + H i (j - 1) + V i j + V (i - 1) j = 0) (r s : ZMod L) :
    ringCoefficientIntersection H V (ringSquareBoundaryHorizontal r s) (ringSquareBoundaryVertical r s) = 0 := by
  -- 本文の第三の行: 交差数の定義と `P_{r,s}` の四辺で四項になる。
  have hshiftRow : ∀ i : ZMod L, (i - 1 = r) ↔ (i = r + 1) := by
    intro i; constructor
    · intro h; rw [← h]; ring
    · intro h; rw [h]; ring
  have hshiftCol : ∀ (j b : ZMod L), (j + 1 = b) ↔ (j = b - 1) := by
    intro j b; constructor
    · intro h; rw [← h]; ring
    · intro h; rw [h]; ring
  have hfour : ringCoefficientIntersection H V (ringSquareBoundaryHorizontal r s) (ringSquareBoundaryVertical r s) =
      H (r + 1) (s - 1) + H (r + 1) s + V r s + V (r + 1) s := by
    unfold ringCoefficientIntersection ringSquareBoundaryHorizontal ringSquareBoundaryVertical
    simp only [hshiftRow, hshiftCol, add_sub_cancel_right, mul_add, sum_add_distrib, mul_ite,
      mul_one, mul_zero, ite_and]
    simp
    ring
  -- 本文の第四の行: 頂点 `(r+1,s)` の偶次数条件。
  have hv := heven (r + 1) s
  rw [add_sub_cancel_right] at hv
  rw [hfour]
  linear_combination hv

/-- 零の係数。基本周回の欠けている向きの係数として使う。 -/
def ringZeroCoefficient {L : ℕ} (_i _j : ZMod L) : R := 0

/-- `I_L(R_h,R_h)=0`。`R_h` は縦辺を持たない。 -/
theorem ringCoefficientIntersection_row_row {L : ℕ} [NeZero L] :
    ringCoefficientIntersection (ringFundamentalRowHorizontal (R := R) (L := L)) ringZeroCoefficient
      ringFundamentalRowHorizontal ringZeroCoefficient = 0 := by
  simp [ringCoefficientIntersection, ringZeroCoefficient]

/-- `I_L(R_v,R_v)=0`。`R_v` は横辺を持たない。 -/
theorem ringCoefficientIntersection_column_column {L : ℕ} [NeZero L] :
    ringCoefficientIntersection ringZeroCoefficient (ringFundamentalColumnVertical (R := R) (L := L))
      ringZeroCoefficient ringFundamentalColumnVertical = 0 := by
  simp [ringCoefficientIntersection, ringZeroCoefficient]

/-- `I_L(R_h,R_v)=1`。`(i,j)=(0,L-1)` の項だけが一になる。 -/
theorem ringCoefficientIntersection_row_column {L : ℕ} [NeZero L] :
    ringCoefficientIntersection (ringFundamentalRowHorizontal (R := R) (L := L)) ringZeroCoefficient
      ringZeroCoefficient ringFundamentalColumnVertical = 1 := by
  have hcol : ∀ j : ZMod L, (j + 1 = 0) ↔ (j = -1) := by
    intro j; constructor
    · intro h; rw [← sub_eq_zero, ← h]; ring
    · intro h; rw [h]; ring
  simp [ringCoefficientIntersection, ringZeroCoefficient, ringFundamentalRowHorizontal,
    ringFundamentalColumnVertical, hcol]

/-- `I_L(R_v,R_h)=1`。`(i,j)=(0,0)` の項だけが一になる。 -/
theorem ringCoefficientIntersection_column_row {L : ℕ} [NeZero L] :
    ringCoefficientIntersection ringZeroCoefficient (ringFundamentalColumnVertical (R := R) (L := L))
      ringFundamentalRowHorizontal ringZeroCoefficient = 1 := by
  simp only [ringCoefficientIntersection, ringZeroCoefficient, ringFundamentalRowHorizontal,
    ringFundamentalColumnVertical, zero_add, mul_ite, mul_one, mul_zero]
  simp

/-- 交差数は第一引数の和について分配的である。 -/
theorem ringCoefficientIntersection_add_left {L : ℕ} [NeZero L]
    (H₁ V₁ H₂ V₂ HD VD : ZMod L → ZMod L → R) :
    ringCoefficientIntersection (fun i j => H₁ i j + H₂ i j) (fun i j => V₁ i j + V₂ i j) HD VD =
      ringCoefficientIntersection H₁ V₁ HD VD + ringCoefficientIntersection H₂ V₂ HD VD := by
  unfold ringCoefficientIntersection
  rw [← sum_add_distrib]
  refine sum_congr rfl fun i _ => ?_
  rw [← sum_add_distrib]
  refine sum_congr rfl fun j _ => ?_
  ring

/-- 交差数は第二引数の和について分配的である。 -/
theorem ringCoefficientIntersection_add_right {L : ℕ} [NeZero L]
    (HC VC H₁ V₁ H₂ V₂ : ZMod L → ZMod L → R) :
    ringCoefficientIntersection HC VC (fun i j => H₁ i j + H₂ i j) (fun i j => V₁ i j + V₂ i j) =
      ringCoefficientIntersection HC VC H₁ V₁ + ringCoefficientIntersection HC VC H₂ V₂ := by
  unfold ringCoefficientIntersection
  rw [← sum_add_distrib]
  refine sum_congr rfl fun i _ => ?_
  rw [← sum_add_distrib]
  refine sum_congr rfl fun j _ => ?_
  ring

/-- 交差数は第一引数のスカラー倍を外へ出す。 -/
theorem ringCoefficientIntersection_mul_left {L : ℕ} [NeZero L] (c : R)
    (H V HD VD : ZMod L → ZMod L → R) :
    ringCoefficientIntersection (fun i j => c * H i j) (fun i j => c * V i j) HD VD =
      c * ringCoefficientIntersection H V HD VD := by
  unfold ringCoefficientIntersection
  rw [mul_sum]
  refine sum_congr rfl fun i _ => ?_
  rw [mul_sum]
  refine sum_congr rfl fun j _ => ?_
  ring

/-- 交差数は第二引数のスカラー倍を外へ出す。 -/
theorem ringCoefficientIntersection_mul_right {L : ℕ} [NeZero L] (c : R)
    (HC VC H V : ZMod L → ZMod L → R) :
    ringCoefficientIntersection HC VC (fun i j => c * H i j) (fun i j => c * V i j) =
      c * ringCoefficientIntersection HC VC H V := by
  unfold ringCoefficientIntersection
  rw [mul_sum]
  refine sum_congr rfl fun i _ => ?_
  rw [mul_sum]
  refine sum_congr rfl fun j _ => ?_
  ring

/-- 交差数は第一引数の有限和について分配的である。 -/
theorem ringCoefficientIntersection_finsetSum_left {L : ℕ} [NeZero L] {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (F G : ι → ZMod L → ZMod L → R) (HD VD : ZMod L → ZMod L → R) :
    ringCoefficientIntersection (fun i j => ∑ k ∈ s, F k i j) (fun i j => ∑ k ∈ s, G k i j) HD VD =
      ∑ k ∈ s, ringCoefficientIntersection (F k) (G k) HD VD := by
  induction s using Finset.induction_on with
  | empty => simp [ringCoefficientIntersection]
  | insert k s hk ih =>
    simp only [sum_insert hk]
    rw [ringCoefficientIntersection_add_left (F k) (G k) (fun i j => ∑ k ∈ s, F k i j)
      (fun i j => ∑ k ∈ s, G k i j), ih]

/-- 交差数は第二引数の有限和について分配的である。 -/
theorem ringCoefficientIntersection_finsetSum_right {L : ℕ} [NeZero L] {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (HC VC : ZMod L → ZMod L → R) (F G : ι → ZMod L → ZMod L → R) :
    ringCoefficientIntersection HC VC (fun i j => ∑ k ∈ s, F k i j) (fun i j => ∑ k ∈ s, G k i j) =
      ∑ k ∈ s, ringCoefficientIntersection HC VC (F k) (G k) := by
  induction s using Finset.induction_on with
  | empty => simp [ringCoefficientIntersection]
  | insert k s hk ih =>
    simp only [sum_insert hk]
    rw [ringCoefficientIntersection_add_right HC VC (F k) (G k) (fun i j => ∑ k ∈ s, F k i j)
      (fun i j => ∑ k ∈ s, G k i j), ih]

/-- 交差数は第一引数の正方形境界の係数付き二重和について分配的である。 -/
theorem ringCoefficientIntersection_sum_left {L : ℕ} [NeZero L]
    (p : ZMod L → ZMod L → R) (Hs Vs : ZMod L → ZMod L → ZMod L → ZMod L → R)
    (HD VD : ZMod L → ZMod L → R) :
    ringCoefficientIntersection (fun i j => ∑ a, ∑ b, p a b * Hs a b i j)
        (fun i j => ∑ a, ∑ b, p a b * Vs a b i j) HD VD =
      ∑ a, ∑ b, p a b * ringCoefficientIntersection (Hs a b) (Vs a b) HD VD := by
  rw [ringCoefficientIntersection_finsetSum_left univ (fun a i j => ∑ b, p a b * Hs a b i j)
    (fun a i j => ∑ b, p a b * Vs a b i j)]
  refine sum_congr rfl fun a _ => ?_
  rw [ringCoefficientIntersection_finsetSum_left univ (fun b i j => p a b * Hs a b i j)
    (fun b i j => p a b * Vs a b i j)]
  refine sum_congr rfl fun b _ => ?_
  exact ringCoefficientIntersection_mul_left (p a b) (Hs a b) (Vs a b) HD VD

/-- 交差数は第二引数の正方形境界の係数付き二重和について分配的である。 -/
theorem ringCoefficientIntersection_sum_right {L : ℕ} [NeZero L]
    (HC VC : ZMod L → ZMod L → R)
    (p : ZMod L → ZMod L → R) (Hs Vs : ZMod L → ZMod L → ZMod L → ZMod L → R) :
    ringCoefficientIntersection HC VC (fun i j => ∑ a, ∑ b, p a b * Hs a b i j)
        (fun i j => ∑ a, ∑ b, p a b * Vs a b i j) =
      ∑ a, ∑ b, p a b * ringCoefficientIntersection HC VC (Hs a b) (Vs a b) := by
  rw [ringCoefficientIntersection_finsetSum_right univ HC VC (fun a i j => ∑ b, p a b * Hs a b i j)
    (fun a i j => ∑ b, p a b * Vs a b i j)]
  refine sum_congr rfl fun a _ => ?_
  rw [ringCoefficientIntersection_finsetSum_right univ HC VC (fun b i j => p a b * Hs a b i j)
    (fun b i j => p a b * Vs a b i j)]
  refine sum_congr rfl fun b _ => ?_
  exact ringCoefficientIntersection_mul_right (p a b) HC VC (Hs a b) (Vs a b)

/-- 基本周回 `R_h` は頂点偶次数である（各頂点で行 `0` の横辺が二本接する）。 -/
theorem ringFundamentalRow_even {L : ℕ} [NeZero L] (htwo : (2 : R) = 0) (i j : ZMod L) :
    ringFundamentalRowHorizontal (R := R) i j + ringFundamentalRowHorizontal i (j - 1) +
      ringZeroCoefficient i j + ringZeroCoefficient (i - 1) j = 0 := by
  unfold ringFundamentalRowHorizontal ringZeroCoefficient
  split_ifs
  · linear_combination htwo
  · ring

/-- 基本周回 `R_v` は頂点偶次数である（各頂点で列 `0` の縦辺が二本接する）。 -/
theorem ringFundamentalColumn_even {L : ℕ} [NeZero L] (htwo : (2 : R) = 0) (i j : ZMod L) :
    ringZeroCoefficient (R := R) i j + ringZeroCoefficient i (j - 1) +
      ringFundamentalColumnVertical i j + ringFundamentalColumnVertical (i - 1) j = 0 := by
  unfold ringFundamentalColumnVertical ringZeroCoefficient
  split_ifs
  · linear_combination htwo
  · ring

/-- `claim_even_edge_chain_intersection` の最後の式変形の必要十分版:
偶辺鎖 `C,D` について `I_L(C,D) = h_C v_D + v_C h_D`。 -/
theorem ringCoefficientIntersection_eq_cutParity {L : ℕ} [NeZero L] (htwo : (2 : R) = 0)
    (HC VC HD VD : ZMod L → ZMod L → R)
    (hevenC : ∀ i j, HC i j + HC i (j - 1) + VC i j + VC (i - 1) j = 0)
    (hevenD : ∀ i j, HD i j + HD i (j - 1) + VD i j + VD (i - 1) j = 0) :
    ringCoefficientIntersection HC VC HD VD =
      (∑ i', HC i' (-1)) * (∑ j', VD (-1) j') + (∑ j', VC (-1) j') * (∑ i', HD i' (-1)) := by
  -- 標準形（`claim_even_edge_chain_torus_normal_form`）を両引数へ用意する。
  obtain ⟨p, hpH, hpV⟩ := ringEvenEdgeChain_torusNormalForm htwo HC VC hevenC
  obtain ⟨q, hqH, hqV⟩ := ringEvenEdgeChain_torusNormalForm htwo HD VD hevenD
  set hCut := ∑ i', HC i' (-1) with hhC
  set vCut := ∑ j', VC (-1) j' with hvC
  set hCutD := ∑ i', HD i' (-1) with hhD
  set vCutD := ∑ j', VD (-1) j' with hvD
  have eHC : HC = fun i j => (fun i j => (fun i j => hCut * ringFundamentalRowHorizontal i j) i j +
      (fun i j => vCut * ringZeroCoefficient i j) i j) i j +
      ∑ a, ∑ b, p a b * ringSquareBoundaryHorizontal a b i j :=
    funext fun i => funext fun j => hpH i j
  have eVC : VC = fun i j => (fun i j => (fun i j => hCut * ringZeroCoefficient i j) i j +
      (fun i j => vCut * ringFundamentalColumnVertical i j) i j) i j +
      ∑ a, ∑ b, p a b * ringSquareBoundaryVertical a b i j :=
    funext fun i => funext fun j => hpV i j
  have eHD : HD = fun i j => (fun i j => (fun i j => hCutD * ringFundamentalRowHorizontal i j) i j +
      (fun i j => vCutD * ringZeroCoefficient i j) i j) i j +
      ∑ a, ∑ b, q a b * ringSquareBoundaryHorizontal a b i j :=
    funext fun i => funext fun j => hqH i j
  have eVD : VD = fun i j => (fun i j => (fun i j => hCutD * ringZeroCoefficient i j) i j +
      (fun i j => vCutD * ringFundamentalColumnVertical i j) i j) i j +
      ∑ a, ∑ b, q a b * ringSquareBoundaryVertical a b i j :=
    funext fun i => funext fun j => hqV i j
  -- 右辺の正方形境界との交差数は零（`C` の偶次数）。左辺についても同じ（`D` の偶次数）。
  have hzeroD : ∀ a b, ringCoefficientIntersection (ringSquareBoundaryHorizontal a b)
      (ringSquareBoundaryVertical a b) HD VD = 0 :=
    ringCoefficientIntersection_squareBoundary_left HD VD hevenD
  -- 分配律と正方形境界の零等式で `C` を基本周回の部分だけにする。
  calc ringCoefficientIntersection HC VC HD VD
      = ringCoefficientIntersection
          (fun i j => (fun i j => hCut * ringFundamentalRowHorizontal i j) i j +
            (fun i j => vCut * ringZeroCoefficient i j) i j)
          (fun i j => (fun i j => hCut * ringZeroCoefficient i j) i j +
            (fun i j => vCut * ringFundamentalColumnVertical i j) i j) HD VD +
        ∑ a, ∑ b, p a b * ringCoefficientIntersection (ringSquareBoundaryHorizontal a b)
          (ringSquareBoundaryVertical a b) HD VD := by
        conv_lhs => rw [eHC, eVC]
        rw [ringCoefficientIntersection_add_left, ringCoefficientIntersection_sum_left]
    _ = hCut * ringCoefficientIntersection ringFundamentalRowHorizontal (ringZeroCoefficient (R := R) (L := L)) HD VD +
        vCut * ringCoefficientIntersection (ringZeroCoefficient (R := R) (L := L)) ringFundamentalColumnVertical HD VD := by
        simp only [hzeroD, mul_zero, sum_const_zero, add_zero]
        rw [ringCoefficientIntersection_add_left, ringCoefficientIntersection_mul_left,
          ringCoefficientIntersection_mul_left]
    -- 同じく `D` を基本周回の部分だけにする（`R_h`・`R_v` も偶辺鎖）。
    _ = hCut * (hCutD * ringCoefficientIntersection ringFundamentalRowHorizontal (ringZeroCoefficient (R := R) (L := L))
            ringFundamentalRowHorizontal (ringZeroCoefficient (R := R) (L := L)) +
          vCutD * ringCoefficientIntersection ringFundamentalRowHorizontal (ringZeroCoefficient (R := R) (L := L))
            (ringZeroCoefficient (R := R) (L := L)) ringFundamentalColumnVertical) +
        vCut * (hCutD * ringCoefficientIntersection (ringZeroCoefficient (R := R) (L := L)) ringFundamentalColumnVertical
            ringFundamentalRowHorizontal (ringZeroCoefficient (R := R) (L := L)) +
          vCutD * ringCoefficientIntersection (ringZeroCoefficient (R := R) (L := L)) ringFundamentalColumnVertical
            (ringZeroCoefficient (R := R) (L := L)) ringFundamentalColumnVertical) := by
        have hzeroRow : ∀ a b, ringCoefficientIntersection ringFundamentalRowHorizontal (ringZeroCoefficient (R := R) (L := L))
            (ringSquareBoundaryHorizontal a b) (ringSquareBoundaryVertical a b) = 0 :=
          ringCoefficientIntersection_squareBoundary_right _ _ (ringFundamentalRow_even htwo)
        have hzeroCol : ∀ a b, ringCoefficientIntersection (ringZeroCoefficient (R := R) (L := L)) ringFundamentalColumnVertical
            (ringSquareBoundaryHorizontal a b) (ringSquareBoundaryVertical a b) = 0 :=
          ringCoefficientIntersection_squareBoundary_right _ _ (ringFundamentalColumn_even htwo)
        rw [eHD, eVD, ringCoefficientIntersection_add_right, ringCoefficientIntersection_sum_right,
          ringCoefficientIntersection_add_right, ringCoefficientIntersection_mul_right,
          ringCoefficientIntersection_mul_right, ringCoefficientIntersection_add_right,
          ringCoefficientIntersection_sum_right, ringCoefficientIntersection_add_right,
          ringCoefficientIntersection_mul_right, ringCoefficientIntersection_mul_right]
        simp only [hzeroRow, hzeroCol, mul_zero, sum_const_zero, add_zero]
    -- 同種の基本周回の交差数は零、異種は一。
    _ = hCut * vCutD + vCut * hCutD := by
        rw [ringCoefficientIntersection_row_row, ringCoefficientIntersection_row_column,
          ringCoefficientIntersection_column_row, ringCoefficientIntersection_column_column]
        ring

end Ising2DLambda.NecSuf.KacWard
