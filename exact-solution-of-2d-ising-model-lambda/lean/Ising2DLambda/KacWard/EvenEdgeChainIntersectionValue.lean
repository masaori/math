/-
「正方形境界との交差数は零で基本周回は一度交差する」（`claim_even_edge_chain_intersection`）の具体版。
係数は本文と同じ `𝔽₂ = ZMod 2`、添字は `ZMod L` である。住処は ℕ と 𝔽₂ で、ℝ / ℂ は現れない。

人手証明との対応:
- `coefficientIntersection_squareBoundary_left`: `I_L(P_{r,s},C)` の四項と頂点 `(r,s+1)` の偶次数条件。
- `coefficientIntersection_squareBoundary_right`: `I_L(C,P_{r,s})` の四項と頂点 `(r+1,s)` の偶次数条件。
- `coefficientIntersection_row_row` ほか三つ: 基本周回の係数を交差数の定義へ代入する段。
- `coefficientIntersection_add_left` ほか: 「有限和は各引数について分配的である」の段。
- `coefficientIntersection_eq_cutParity`: 標準形を両引数へ代入し、分配律と零等式・一の等式で
  `h_C v_D + v_C h_D` へ着く最後の式変形。
-/
import Ising2DLambda.KacWard.EvenEdgeChainTorusNormalForm
import Ising2DLambda.NecSuf.KacWard.EvenEdgeChainIntersectionValue

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

/-- 係数で与えた二つの辺鎖の交差数 `I_L(C,D)`（`def_even_edge_chain_intersection` の右辺）。 -/
def coefficientIntersection {L : ℕ} [NeZero L] (HC VC HD VD : ZMod L → ZMod L → ZMod 2) : ZMod 2 :=
  ∑ i : ZMod L, ∑ j : ZMod L, (HC i j * VD (i - 1) (j + 1) + VC i j * HD i j)

/-- 辺の有限集合で与えた交差数は、その係数の交差数である。 -/
theorem evenEdgeChainIntersection_eq_coefficientIntersection (L : ℕ) [NeZero L]
    (C D : Finset (Edge L)) :
    evenEdgeChainIntersection L C D =
      coefficientIntersection (horizontalChainCoefficient L C) (verticalChainCoefficient L C)
        (horizontalChainCoefficient L D) (verticalChainCoefficient L D) := rfl

/-- 指示関数を掛けた二重和は、その一点の値である。 -/
theorem sum_sum_indicator_mul {L : ℕ} [NeZero L] (a b : ZMod L) (f : ZMod L → ZMod L → ZMod 2) :
    ∑ i : ZMod L, ∑ j : ZMod L, (if i = a ∧ j = b then (1 : ZMod 2) else 0) * f i j = f a b := by
  simp [ite_and]

/-- `I_L(P_{r,s},C)=0`。頂点 `(r,s+1)` の偶次数条件を使う。 -/
theorem coefficientIntersection_squareBoundary_left {L : ℕ} [NeZero L]
    (H V : ZMod L → ZMod L → ZMod 2)
    (heven : ∀ i j, H i j + H i (j - 1) + V i j + V (i - 1) j = 0) (r s : ZMod L) :
    coefficientIntersection (squareBoundaryHorizontal r s) (squareBoundaryVertical r s) H V = 0 := by
  -- 本文の第一の行: 交差数の定義と `P_{r,s}` の四辺で四項になる。
  have hfour : coefficientIntersection (squareBoundaryHorizontal r s) (squareBoundaryVertical r s) H V =
      V (r - 1) (s + 1) + V r (s + 1) + H r s + H r (s + 1) := by
    unfold coefficientIntersection squareBoundaryHorizontal squareBoundaryVertical
    simp only [add_mul, sum_add_distrib, sum_sum_indicator_mul (f := fun i j => V (i - 1) (j + 1)),
      sum_sum_indicator_mul (f := fun i j => H i j)]
    ring_nf
  -- 本文の第二の行: 頂点 `(r,s+1)` の偶次数条件。
  have hv := heven r (s + 1)
  rw [add_sub_cancel_right] at hv
  rw [hfour]
  linear_combination hv

/-- `I_L(C,P_{r,s})=0`。頂点 `(r+1,s)` の偶次数条件を使う。 -/
theorem coefficientIntersection_squareBoundary_right {L : ℕ} [NeZero L]
    (H V : ZMod L → ZMod L → ZMod 2)
    (heven : ∀ i j, H i j + H i (j - 1) + V i j + V (i - 1) j = 0) (r s : ZMod L) :
    coefficientIntersection H V (squareBoundaryHorizontal r s) (squareBoundaryVertical r s) = 0 := by
  -- 本文の第三の行: 交差数の定義と `P_{r,s}` の四辺で四項になる。
  have hshiftRow : ∀ i : ZMod L, (i - 1 = r) ↔ (i = r + 1) := by
    intro i; constructor
    · intro h; rw [← h]; ring
    · intro h; rw [h]; ring
  have hshiftCol : ∀ (j b : ZMod L), (j + 1 = b) ↔ (j = b - 1) := by
    intro j b; constructor
    · intro h; rw [← h]; ring
    · intro h; rw [h]; ring
  have hfour : coefficientIntersection H V (squareBoundaryHorizontal r s) (squareBoundaryVertical r s) =
      H (r + 1) (s - 1) + H (r + 1) s + V r s + V (r + 1) s := by
    unfold coefficientIntersection squareBoundaryHorizontal squareBoundaryVertical
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
def zeroCoefficient {L : ℕ} (_i _j : ZMod L) : ZMod 2 := 0

/-- `I_L(R_h,R_h)=0`。`R_h` は縦辺を持たない。 -/
theorem coefficientIntersection_row_row {L : ℕ} [NeZero L] :
    coefficientIntersection (fundamentalRowHorizontal (L := L)) zeroCoefficient
      fundamentalRowHorizontal zeroCoefficient = 0 := by
  simp [coefficientIntersection, zeroCoefficient]

/-- `I_L(R_v,R_v)=0`。`R_v` は横辺を持たない。 -/
theorem coefficientIntersection_column_column {L : ℕ} [NeZero L] :
    coefficientIntersection zeroCoefficient (fundamentalColumnVertical (L := L))
      zeroCoefficient fundamentalColumnVertical = 0 := by
  simp [coefficientIntersection, zeroCoefficient]

/-- `I_L(R_h,R_v)=1`。`(i,j)=(0,L-1)` の項だけが一になる。 -/
theorem coefficientIntersection_row_column {L : ℕ} [NeZero L] :
    coefficientIntersection (fundamentalRowHorizontal (L := L)) zeroCoefficient
      zeroCoefficient fundamentalColumnVertical = 1 := by
  have hcol : ∀ j : ZMod L, (j + 1 = 0) ↔ (j = -1) := by
    intro j; constructor
    · intro h; rw [← sub_eq_zero, ← h]; ring
    · intro h; rw [h]; ring
  simp [coefficientIntersection, zeroCoefficient, fundamentalRowHorizontal,
    fundamentalColumnVertical, hcol]

/-- `I_L(R_v,R_h)=1`。`(i,j)=(0,0)` の項だけが一になる。 -/
theorem coefficientIntersection_column_row {L : ℕ} [NeZero L] :
    coefficientIntersection zeroCoefficient (fundamentalColumnVertical (L := L))
      fundamentalRowHorizontal zeroCoefficient = 1 := by
  simp only [coefficientIntersection, zeroCoefficient, fundamentalRowHorizontal,
    fundamentalColumnVertical, zero_add, mul_ite, mul_one, mul_zero]
  simp

/-- 交差数は第一引数の和について分配的である。 -/
theorem coefficientIntersection_add_left {L : ℕ} [NeZero L]
    (H₁ V₁ H₂ V₂ HD VD : ZMod L → ZMod L → ZMod 2) :
    coefficientIntersection (fun i j => H₁ i j + H₂ i j) (fun i j => V₁ i j + V₂ i j) HD VD =
      coefficientIntersection H₁ V₁ HD VD + coefficientIntersection H₂ V₂ HD VD := by
  unfold coefficientIntersection
  rw [← sum_add_distrib]
  refine sum_congr rfl fun i _ => ?_
  rw [← sum_add_distrib]
  refine sum_congr rfl fun j _ => ?_
  ring

/-- 交差数は第二引数の和について分配的である。 -/
theorem coefficientIntersection_add_right {L : ℕ} [NeZero L]
    (HC VC H₁ V₁ H₂ V₂ : ZMod L → ZMod L → ZMod 2) :
    coefficientIntersection HC VC (fun i j => H₁ i j + H₂ i j) (fun i j => V₁ i j + V₂ i j) =
      coefficientIntersection HC VC H₁ V₁ + coefficientIntersection HC VC H₂ V₂ := by
  unfold coefficientIntersection
  rw [← sum_add_distrib]
  refine sum_congr rfl fun i _ => ?_
  rw [← sum_add_distrib]
  refine sum_congr rfl fun j _ => ?_
  ring

/-- 交差数は第一引数のスカラー倍を外へ出す。 -/
theorem coefficientIntersection_mul_left {L : ℕ} [NeZero L] (c : ZMod 2)
    (H V HD VD : ZMod L → ZMod L → ZMod 2) :
    coefficientIntersection (fun i j => c * H i j) (fun i j => c * V i j) HD VD =
      c * coefficientIntersection H V HD VD := by
  unfold coefficientIntersection
  rw [mul_sum]
  refine sum_congr rfl fun i _ => ?_
  rw [mul_sum]
  refine sum_congr rfl fun j _ => ?_
  ring

/-- 交差数は第二引数のスカラー倍を外へ出す。 -/
theorem coefficientIntersection_mul_right {L : ℕ} [NeZero L] (c : ZMod 2)
    (HC VC H V : ZMod L → ZMod L → ZMod 2) :
    coefficientIntersection HC VC (fun i j => c * H i j) (fun i j => c * V i j) =
      c * coefficientIntersection HC VC H V := by
  unfold coefficientIntersection
  rw [mul_sum]
  refine sum_congr rfl fun i _ => ?_
  rw [mul_sum]
  refine sum_congr rfl fun j _ => ?_
  ring

/-- 交差数は第一引数の有限和について分配的である。 -/
theorem coefficientIntersection_finsetSum_left {L : ℕ} [NeZero L] {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (F G : ι → ZMod L → ZMod L → ZMod 2) (HD VD : ZMod L → ZMod L → ZMod 2) :
    coefficientIntersection (fun i j => ∑ k ∈ s, F k i j) (fun i j => ∑ k ∈ s, G k i j) HD VD =
      ∑ k ∈ s, coefficientIntersection (F k) (G k) HD VD := by
  induction s using Finset.induction_on with
  | empty => simp [coefficientIntersection]
  | insert k s hk ih =>
    simp only [sum_insert hk]
    rw [coefficientIntersection_add_left (F k) (G k) (fun i j => ∑ k ∈ s, F k i j)
      (fun i j => ∑ k ∈ s, G k i j), ih]

/-- 交差数は第二引数の有限和について分配的である。 -/
theorem coefficientIntersection_finsetSum_right {L : ℕ} [NeZero L] {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (HC VC : ZMod L → ZMod L → ZMod 2) (F G : ι → ZMod L → ZMod L → ZMod 2) :
    coefficientIntersection HC VC (fun i j => ∑ k ∈ s, F k i j) (fun i j => ∑ k ∈ s, G k i j) =
      ∑ k ∈ s, coefficientIntersection HC VC (F k) (G k) := by
  induction s using Finset.induction_on with
  | empty => simp [coefficientIntersection]
  | insert k s hk ih =>
    simp only [sum_insert hk]
    rw [coefficientIntersection_add_right HC VC (F k) (G k) (fun i j => ∑ k ∈ s, F k i j)
      (fun i j => ∑ k ∈ s, G k i j), ih]

/-- 交差数は第一引数の正方形境界の係数付き二重和について分配的である。 -/
theorem coefficientIntersection_sum_left {L : ℕ} [NeZero L]
    (p : ZMod L → ZMod L → ZMod 2) (Hs Vs : ZMod L → ZMod L → ZMod L → ZMod L → ZMod 2)
    (HD VD : ZMod L → ZMod L → ZMod 2) :
    coefficientIntersection (fun i j => ∑ a, ∑ b, p a b * Hs a b i j)
        (fun i j => ∑ a, ∑ b, p a b * Vs a b i j) HD VD =
      ∑ a, ∑ b, p a b * coefficientIntersection (Hs a b) (Vs a b) HD VD := by
  rw [coefficientIntersection_finsetSum_left univ (fun a i j => ∑ b, p a b * Hs a b i j)
    (fun a i j => ∑ b, p a b * Vs a b i j)]
  refine sum_congr rfl fun a _ => ?_
  rw [coefficientIntersection_finsetSum_left univ (fun b i j => p a b * Hs a b i j)
    (fun b i j => p a b * Vs a b i j)]
  refine sum_congr rfl fun b _ => ?_
  exact coefficientIntersection_mul_left (p a b) (Hs a b) (Vs a b) HD VD

/-- 交差数は第二引数の正方形境界の係数付き二重和について分配的である。 -/
theorem coefficientIntersection_sum_right {L : ℕ} [NeZero L]
    (HC VC : ZMod L → ZMod L → ZMod 2)
    (p : ZMod L → ZMod L → ZMod 2) (Hs Vs : ZMod L → ZMod L → ZMod L → ZMod L → ZMod 2) :
    coefficientIntersection HC VC (fun i j => ∑ a, ∑ b, p a b * Hs a b i j)
        (fun i j => ∑ a, ∑ b, p a b * Vs a b i j) =
      ∑ a, ∑ b, p a b * coefficientIntersection HC VC (Hs a b) (Vs a b) := by
  rw [coefficientIntersection_finsetSum_right univ HC VC (fun a i j => ∑ b, p a b * Hs a b i j)
    (fun a i j => ∑ b, p a b * Vs a b i j)]
  refine sum_congr rfl fun a _ => ?_
  rw [coefficientIntersection_finsetSum_right univ HC VC (fun b i j => p a b * Hs a b i j)
    (fun b i j => p a b * Vs a b i j)]
  refine sum_congr rfl fun b _ => ?_
  exact coefficientIntersection_mul_right (p a b) HC VC (Hs a b) (Vs a b)

/-- 基本周回 `R_h` は頂点偶次数である（各頂点で行 `0` の横辺が二本接する）。 -/
theorem fundamentalRow_even {L : ℕ} [NeZero L] (i j : ZMod L) :
    fundamentalRowHorizontal i j + fundamentalRowHorizontal i (j - 1) +
      zeroCoefficient i j + zeroCoefficient (i - 1) j = 0 := by
  unfold fundamentalRowHorizontal zeroCoefficient
  split_ifs
  · linear_combination zmodTwo_two_eq_zero
  · ring

/-- 基本周回 `R_v` は頂点偶次数である（各頂点で列 `0` の縦辺が二本接する）。 -/
theorem fundamentalColumn_even {L : ℕ} [NeZero L] (i j : ZMod L) :
    zeroCoefficient i j + zeroCoefficient i (j - 1) +
      fundamentalColumnVertical i j + fundamentalColumnVertical (i - 1) j = 0 := by
  unfold fundamentalColumnVertical zeroCoefficient
  split_ifs
  · linear_combination zmodTwo_two_eq_zero
  · ring

/-- `claim_even_edge_chain_intersection` の最後の式変形の具体版:
偶辺鎖 `C,D` について `I_L(C,D) = h_C v_D + v_C h_D`。 -/
theorem coefficientIntersection_eq_cutParity {L : ℕ} [NeZero L]
    (HC VC HD VD : ZMod L → ZMod L → ZMod 2)
    (hevenC : ∀ i j, HC i j + HC i (j - 1) + VC i j + VC (i - 1) j = 0)
    (hevenD : ∀ i j, HD i j + HD i (j - 1) + VD i j + VD (i - 1) j = 0) :
    coefficientIntersection HC VC HD VD =
      (∑ i', HC i' (-1)) * (∑ j', VD (-1) j') + (∑ j', VC (-1) j') * (∑ i', HD i' (-1)) := by
  -- 標準形（`claim_even_edge_chain_torus_normal_form`）を両引数へ用意する。
  obtain ⟨p, hpH, hpV⟩ := evenEdgeChain_torusNormalForm HC VC hevenC
  obtain ⟨q, hqH, hqV⟩ := evenEdgeChain_torusNormalForm HD VD hevenD
  set hCut := ∑ i', HC i' (-1) with hhC
  set vCut := ∑ j', VC (-1) j' with hvC
  set hCutD := ∑ i', HD i' (-1) with hhD
  set vCutD := ∑ j', VD (-1) j' with hvD
  have eHC : HC = fun i j => (fun i j => (fun i j => hCut * fundamentalRowHorizontal i j) i j +
      (fun i j => vCut * zeroCoefficient i j) i j) i j +
      ∑ a, ∑ b, p a b * squareBoundaryHorizontal a b i j :=
    funext fun i => funext fun j => hpH i j
  have eVC : VC = fun i j => (fun i j => (fun i j => hCut * zeroCoefficient i j) i j +
      (fun i j => vCut * fundamentalColumnVertical i j) i j) i j +
      ∑ a, ∑ b, p a b * squareBoundaryVertical a b i j :=
    funext fun i => funext fun j => hpV i j
  have eHD : HD = fun i j => (fun i j => (fun i j => hCutD * fundamentalRowHorizontal i j) i j +
      (fun i j => vCutD * zeroCoefficient i j) i j) i j +
      ∑ a, ∑ b, q a b * squareBoundaryHorizontal a b i j :=
    funext fun i => funext fun j => hqH i j
  have eVD : VD = fun i j => (fun i j => (fun i j => hCutD * zeroCoefficient i j) i j +
      (fun i j => vCutD * fundamentalColumnVertical i j) i j) i j +
      ∑ a, ∑ b, q a b * squareBoundaryVertical a b i j :=
    funext fun i => funext fun j => hqV i j
  -- 右辺の正方形境界との交差数は零（`C` の偶次数）。左辺についても同じ（`D` の偶次数）。
  have hzeroD : ∀ a b, coefficientIntersection (squareBoundaryHorizontal a b)
      (squareBoundaryVertical a b) HD VD = 0 :=
    coefficientIntersection_squareBoundary_left HD VD hevenD
  -- 分配律と正方形境界の零等式で `C` を基本周回の部分だけにする。
  calc coefficientIntersection HC VC HD VD
      = coefficientIntersection
          (fun i j => (fun i j => hCut * fundamentalRowHorizontal i j) i j +
            (fun i j => vCut * zeroCoefficient i j) i j)
          (fun i j => (fun i j => hCut * zeroCoefficient i j) i j +
            (fun i j => vCut * fundamentalColumnVertical i j) i j) HD VD +
        ∑ a, ∑ b, p a b * coefficientIntersection (squareBoundaryHorizontal a b)
          (squareBoundaryVertical a b) HD VD := by
        conv_lhs => rw [eHC, eVC]
        rw [coefficientIntersection_add_left, coefficientIntersection_sum_left]
    _ = hCut * coefficientIntersection fundamentalRowHorizontal (zeroCoefficient (L := L)) HD VD +
        vCut * coefficientIntersection (zeroCoefficient (L := L)) fundamentalColumnVertical HD VD := by
        simp only [hzeroD, mul_zero, sum_const_zero, add_zero]
        rw [coefficientIntersection_add_left, coefficientIntersection_mul_left,
          coefficientIntersection_mul_left]
    -- 同じく `D` を基本周回の部分だけにする（`R_h`・`R_v` も偶辺鎖）。
    _ = hCut * (hCutD * coefficientIntersection fundamentalRowHorizontal (zeroCoefficient (L := L))
            fundamentalRowHorizontal (zeroCoefficient (L := L)) +
          vCutD * coefficientIntersection fundamentalRowHorizontal (zeroCoefficient (L := L))
            (zeroCoefficient (L := L)) fundamentalColumnVertical) +
        vCut * (hCutD * coefficientIntersection (zeroCoefficient (L := L)) fundamentalColumnVertical
            fundamentalRowHorizontal (zeroCoefficient (L := L)) +
          vCutD * coefficientIntersection (zeroCoefficient (L := L)) fundamentalColumnVertical
            (zeroCoefficient (L := L)) fundamentalColumnVertical) := by
        have hzeroRow : ∀ a b, coefficientIntersection fundamentalRowHorizontal (zeroCoefficient (L := L))
            (squareBoundaryHorizontal a b) (squareBoundaryVertical a b) = 0 :=
          coefficientIntersection_squareBoundary_right _ _ fundamentalRow_even
        have hzeroCol : ∀ a b, coefficientIntersection (zeroCoefficient (L := L)) fundamentalColumnVertical
            (squareBoundaryHorizontal a b) (squareBoundaryVertical a b) = 0 :=
          coefficientIntersection_squareBoundary_right _ _ fundamentalColumn_even
        rw [eHD, eVD, coefficientIntersection_add_right, coefficientIntersection_sum_right,
          coefficientIntersection_add_right, coefficientIntersection_mul_right,
          coefficientIntersection_mul_right, coefficientIntersection_add_right,
          coefficientIntersection_sum_right, coefficientIntersection_add_right,
          coefficientIntersection_mul_right, coefficientIntersection_mul_right]
        simp only [hzeroRow, hzeroCol, mul_zero, sum_const_zero, add_zero]
    -- 同種の基本周回の交差数は零、異種は一。
    _ = hCut * vCutD + vCut * hCutD := by
        rw [coefficientIntersection_row_row, coefficientIntersection_row_column,
          coefficientIntersection_column_row, coefficientIntersection_column_column]
        ring

/-- 本文の辺鎖（辺の有限集合）について述べた形。 -/
theorem evenEdgeChainIntersection_eq_cutParity {L : ℕ} [NeZero L] (C D : Finset (Edge L))
    (hevenC : ∀ i j, horizontalChainCoefficient L C i j +
      horizontalChainCoefficient L C i (j - 1) + verticalChainCoefficient L C i j +
      verticalChainCoefficient L C (i - 1) j = 0)
    (hevenD : ∀ i j, horizontalChainCoefficient L D i j +
      horizontalChainCoefficient L D i (j - 1) + verticalChainCoefficient L D i j +
      verticalChainCoefficient L D (i - 1) j = 0) :
    evenEdgeChainIntersection L C D =
      (∑ i', horizontalChainCoefficient L C i' (-1)) * (∑ j', verticalChainCoefficient L D (-1) j') +
        (∑ j', verticalChainCoefficient L C (-1) j') * (∑ i', horizontalChainCoefficient L D i' (-1)) :=
  coefficientIntersection_eq_cutParity _ _ _ _ hevenC hevenD


/-- 具体版の主張が必要十分版の `R = 𝔽₂` への特殊化であること。 -/
theorem coefficientIntersection_eq_cutParity_from_necSuf {L : ℕ} [NeZero L]
    (HC VC HD VD : ZMod L → ZMod L → ZMod 2)
    (hevenC : ∀ i j, HC i j + HC i (j - 1) + VC i j + VC (i - 1) j = 0)
    (hevenD : ∀ i j, HD i j + HD i (j - 1) + VD i j + VD (i - 1) j = 0) :
    coefficientIntersection HC VC HD VD =
      (∑ i', HC i' (-1)) * (∑ j', VD (-1) j') + (∑ j', VC (-1) j') * (∑ i', HD i' (-1)) :=
  Ising2DLambda.NecSuf.KacWard.ringCoefficientIntersection_eq_cutParity zmodTwo_two_eq_zero
    HC VC HD VD hevenC hevenD

end Ising2DLambda.KacWard
