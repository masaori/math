/-
「自明セクターの偶部分グラフから配位を復元できる」の具体版。双対辺写像の逆像として
元の辺集合を復元し、偶部分グラフ性から格子面の等式・二周期の等式・行和と列和の等式・
全行と全列の周期和の零性を導き、基点付き道和から配位を定め、その破れた辺集合が復元した
辺集合に一致することを示す。最後に全スピン反転による二つの原像だけがあると示す。
-/
import Ising2DLambda.FisherZero.DualBrokenEdgesWinding
import Ising2DLambda.FisherZero.LowTemperaturePolynomial

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 人手証明の `B = δ_L⁻¹(A)`。双対辺写像の逆写像による像として定める。 -/
noncomputable def reconstructedEdgeSet (L : ℕ) [NeZero L] (A : Finset (Edge L)) :
    Finset (Edge L) := A.image (dualEdgeEquiv L).symm

@[simp] lemma mem_reconstructedEdgeSet_iff (L : ℕ) [NeZero L] (A : Finset (Edge L))
    (e : Edge L) : e ∈ reconstructedEdgeSet L A ↔ dualEdgeEquiv L e ∈ A := by
  classical
  rw [reconstructedEdgeSet, Finset.mem_image]
  constructor
  · rintro ⟨a, ha, rfl⟩
    simpa using ha
  · intro he
    exact ⟨dualEdgeEquiv L e, he, (dualEdgeEquiv L).symm_apply_apply e⟩

/-- 人手証明の `δ_L(B) = A`（`B = δ_L⁻¹(A)` の往復）。 -/
lemma image_reconstructedEdgeSet (L : ℕ) [NeZero L] (A : Finset (Edge L)) :
    (reconstructedEdgeSet L A).image (dualEdgeEquiv L) = A := by
  classical
  ext e
  rw [Finset.mem_image]
  constructor
  · rintro ⟨a, ha, rfl⟩
    rwa [mem_reconstructedEdgeSet_iff] at ha
  · intro he
    refine ⟨(dualEdgeEquiv L).symm e, ?_, (dualEdgeEquiv L).apply_symm_apply e⟩
    rw [mem_reconstructedEdgeSet_iff, (dualEdgeEquiv L).apply_symm_apply]
    exact he

@[simp] lemma mem_image_dualEdgeEquiv_iff (L : ℕ) [NeZero L] (S : Finset (Edge L))
    (e : Edge L) : e ∈ S.image (dualEdgeEquiv L) ↔ (dualEdgeEquiv L).symm e ∈ S := by
  classical
  rw [Finset.mem_image]
  constructor
  · rintro ⟨a, ha, rfl⟩
    simpa using ha
  · intro he
    exact ⟨(dualEdgeEquiv L).symm e, he, (dualEdgeEquiv L).apply_symm_apply e⟩

/-- 本文の端点数の最初の二行。各辺の二つの端点を別々に数え、四つの位置へ展開する。
`L = 1` でも同じ辺の端点を二度数える。 -/
lemma edgeSubsetIncidenceCount_four_incident_edges (L : ℕ) [NeZero L]
    (S : Finset (Edge L)) (i j : ZMod L) :
    edgeSubsetIncidenceCount L S (i, j) =
      (if edgeOfRow L false i j ∈ S then 1 else 0) +
      (if edgeOfRow L false i (j - 1) ∈ S then 1 else 0) +
      (if edgeOfRow L true i j ∈ S then 1 else 0) +
      (if edgeOfRow L true (i - 1) j ∈ S then 1 else 0) := by
  classical
  rw [edgeSubsetIncidenceCount]
  rw [show S =
      (Finset.univ.filter fun e : Edge L => e ∈ S) by ext; simp]
  rw [Finset.sum_filter]
  change (∑ e : Edge L, if e ∈ S then
    ((if boundary0 L e = (i, j) then 1 else 0) +
      (if boundary1 L e = (i, j) then 1 else 0)) else 0) = _
  rw [← Fintype.sum_equiv (edgeEquiv L)
    (fun w => if edgeEquiv L w ∈ S then
      ((if boundary0 L (edgeEquiv L w) = (i, j) then 1 else 0) +
        (if boundary1 L (edgeEquiv L w) = (i, j) then 1 else 0)) else 0)
    (fun e => if e ∈ S then
      ((if boundary0 L e = (i, j) then 1 else 0) +
        (if boundary1 L e = (i, j) then 1 else 0)) else 0) (fun _ => rfl)]
  simp only [Fintype.sum_sum_type, edgeEquiv_inl_pair, edgeEquiv_inr_pair,
    edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal,
    edgeOfRow_boundary1_vertical]
  have hsplit (p : Prop) [Decidable p] (a b : ℕ) :
      (if p then a + b else 0) = (if p then a else 0) + (if p then b else 0) := by
    by_cases hp : p <;> simp [hp]
  have hswap (p q : Prop) [Decidable p] [Decidable q] :
      (if p then (if q then 1 else 0) else 0) =
        (if q then (if p then 1 else 0) else 0) := by
    by_cases hp : p <;> by_cases hq : q <;> simp [hp, hq]
  have hand (p q : Prop) [Decidable p] [Decidable q] (a : ℕ) :
      (if p ∧ q then a else 0) = (if p then (if q then a else 0) else 0) := by
    by_cases hp : p <;> by_cases hq : q <;> simp [hp, hq]
  have hshift (f : ZMod L → ℕ) (z : ZMod L) :
      (∑ x, if x + 1 = z then f x else 0) = f (z - 1) := by
    rw [Fintype.sum_eq_single (z - 1)]
    · simp
    · intro x hx
      by_cases h : x + 1 = z
      · exfalso
        apply hx
        calc
          x = (x + 1) - 1 := by simp
          _ = z - 1 := by rw [h]
      · simp [h]
  simp_rw [hsplit, Finset.sum_add_distrib]
  simp_rw [hswap]
  unfold Vertex
  simp only [Prod.mk.injEq]
  simp_rw [hand]
  simp [Fintype.sum_prod_type]
  rw [hshift, hshift]
  omega

/-- 本文の端点数の残り三行。指示関数を双対原像へ移し、逆写像を代入して並べ替える。 -/
lemma dualImage_incidenceCount (L : ℕ) [NeZero L] (S : Finset (Edge L))
    (i j : ZMod L) :
    edgeSubsetIncidenceCount L (S.image (dualEdgeEquiv L)) (i, j) =
      (if edgeOfRow L true (i - 1) j ∈ S then 1 else 0) +
      (if edgeOfRow L false i (j - 1) ∈ S then 1 else 0) +
      (if edgeOfRow L true (i - 1) (j - 1) ∈ S then 1 else 0) +
      (if edgeOfRow L false (i - 1) (j - 1) ∈ S then 1 else 0) := by
  classical
  rw [edgeSubsetIncidenceCount_four_incident_edges]
  simp only [mem_image_dualEdgeEquiv_iff]
  simp only [dualEdgeEquiv_symm_horizontal, dualEdgeEquiv_symm_vertical]
  omega

/-- 人手証明の格子面の等式。自明セクター以前に、偶部分グラフであることだけから従う。
`b_v(i,j) + b_h(i,j) + b_v(i,j+1) + b_h(i+1,j) = 0` in `ℤ/2ℤ`。 -/
theorem reconstructedEdgeSet_face_equation (L : ℕ) [NeZero L] (A : Finset (Edge L))
    (hEven : IsEvenEdgeSubset L A) (i j : ZMod L) :
    ((if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0) +
      (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) +
      (if edgeOfRow L true i (j + 1) ∈ reconstructedEdgeSet L A then 1 else 0) +
      (if edgeOfRow L false (i + 1) j ∈ reconstructedEdgeSet L A then 1 else 0) :
      ZMod 2) = 0 := by
  classical
  -- 本文の準備：右下の双対頂点の端点数を四辺の指示関数へ展開する。
  have hcount := hEven (i + 1, j + 1)
  rw [show A = (reconstructedEdgeSet L A).image (dualEdgeEquiv L) from
    (image_reconstructedEdgeSet L A).symm, dualImage_incidenceCount] at hcount
  simp only [add_sub_cancel_right] at hcount
  obtain ⟨k, hk⟩ := hcount
  -- 本文の面等式：各項の射影、和の射影、端点数の代入に対応する。
  have hcast :
      ((if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0) +
        (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) +
        (if edgeOfRow L true i (j + 1) ∈ reconstructedEdgeSet L A then 1 else 0) +
        (if edgeOfRow L false (i + 1) j ∈ reconstructedEdgeSet L A then 1 else 0) :
        ZMod 2) =
      (((if edgeOfRow L true i (j + 1) ∈ reconstructedEdgeSet L A then 1 else 0) +
        (if edgeOfRow L false (i + 1) j ∈ reconstructedEdgeSet L A then 1 else 0) +
        (if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0) +
        (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) : ℕ) :
        ZMod 2) := by
    push_cast
    ring
  -- 端点数は二の倍数であり、その二を法とする射影は零。
  rw [hcast, hk]
  push_cast
  rw [← two_mul, show (2 : ZMod 2) = 0 from rfl, zero_mul]

/-- 人手証明の二周期の等式。自明セクターの二つの巻き付き偶奇を、復元した辺集合の
縦向き周期閉路と横向き周期閉路へ双対辺写像の逆写像で戻す。 -/
theorem reconstructedEdgeSet_winding_equations (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hSector : IsInTorusHomologySector L A (0, 0)) :
    (∑ i : ZMod L,
      (if edgeOfRow L true i (-1) ∈ reconstructedEdgeSet L A then 1 else 0) : ZMod 2) = 0 ∧
    (∑ j : ZMod L,
      (if edgeOfRow L false (-1) j ∈ reconstructedEdgeSet L A then 1 else 0) : ZMod 2) = 0 := by
  classical
  have hHorizontal : horizontalWindingParity L A = 0 := congrArg Prod.fst hSector.2
  have hVertical : verticalWindingParity L A = 0 := congrArg Prod.snd hSector.2
  rw [← image_reconstructedEdgeSet L A] at hHorizontal hVertical
  -- 本文の自然数値の巻き付き偶奇を π₂ で写す計算。Fin 2 と ZMod 2 は定義上同じ型。
  change (∑ i : ZMod L,
    (if edgeOfRow L false i (-1) ∈ (reconstructedEdgeSet L A).image (dualEdgeEquiv L)
      then 1 else 0) : ZMod 2) = 0 at hHorizontal
  change (∑ j : ZMod L,
    (if edgeOfRow L true (-1) j ∈ (reconstructedEdgeSet L A).image (dualEdgeEquiv L)
      then 1 else 0) : ZMod 2) = 0 at hVertical
  -- 本文の境界指示子→逆像指示子→逆写像の座標式。
  simp only [mem_image_dualEdgeEquiv_iff, dualEdgeEquiv_symm_horizontal] at hHorizontal
  simp only [mem_image_dualEdgeEquiv_iff, dualEdgeEquiv_symm_vertical] at hVertical
  -- 本文の二方向の基準周期和：巡回添字を一つ戻し、上で得た零性を代入する。
  constructor
  · calc
      (∑ i : ZMod L,
          (if edgeOfRow L true i (-1) ∈ reconstructedEdgeSet L A then 1 else 0) : ZMod 2) =
        ∑ i : ZMod L,
          (if edgeOfRow L true (i - 1) (-1) ∈ reconstructedEdgeSet L A then 1 else 0) := by
            symm
            exact Fintype.sum_bijective (Equiv.addRight (-1)) (Equiv.addRight (-1)).bijective
              (fun i : ZMod L =>
                (if edgeOfRow L true (i - 1) (-1) ∈ reconstructedEdgeSet L A then 1 else 0 :
                  ZMod 2))
              (fun i : ZMod L =>
                (if edgeOfRow L true i (-1) ∈ reconstructedEdgeSet L A then 1 else 0 :
                  ZMod 2))
              (fun _ => by simp [sub_eq_add_neg])
      _ = 0 := hHorizontal
  · calc
      (∑ j : ZMod L,
          (if edgeOfRow L false (-1) j ∈ reconstructedEdgeSet L A then 1 else 0) : ZMod 2) =
        ∑ j : ZMod L,
          (if edgeOfRow L false (-1) (j - 1) ∈ reconstructedEdgeSet L A then 1 else 0) := by
            symm
            exact Fintype.sum_bijective (Equiv.addRight (-1)) (Equiv.addRight (-1)).bijective
              (fun j : ZMod L =>
                (if edgeOfRow L false (-1) (j - 1) ∈ reconstructedEdgeSet L A then 1 else 0 :
                  ZMod 2))
              (fun j : ZMod L =>
                (if edgeOfRow L false (-1) j ∈ reconstructedEdgeSet L A then 1 else 0 :
                  ZMod 2))
              (fun _ => by simp [sub_eq_add_neg])
      _ = 0 := hVertical

/-- 人手証明の行和・列和の等式。格子面の等式を一周期にわたって足し、添字を一つ
ずらした有限和を同じ有限和へ戻す。 -/
theorem reconstructedEdgeSet_row_column_sum_invariant (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hEven : IsEvenEdgeSubset L A) :
    (∀ i : ZMod L,
      (∑ j : ZMod L,
        (if edgeOfRow L false (i + 1) j ∈ reconstructedEdgeSet L A then 1 else 0) : ZMod 2) =
      ∑ j : ZMod L,
        (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0)) ∧
    (∀ j : ZMod L,
      (∑ i : ZMod L,
        (if edgeOfRow L true i (j + 1) ∈ reconstructedEdgeSet L A then 1 else 0) : ZMod 2) =
      ∑ i : ZMod L,
        (if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0)) := by
  classical
  let bh (i j : ZMod L) : ZMod 2 :=
    if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0
  let bv (i j : ZMod L) : ZMod 2 :=
    if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0
  have hdouble (z : ZMod 2) : z + z = 0 := by
    fin_cases z <;> rfl
  have hface (i j : ZMod L) : bv i j + bh i j + bv i (j + 1) + bh (i + 1) j = 0 :=
    reconstructedEdgeSet_face_equation L A hEven i j
  -- 本文の二つの局所計算鎖。α, β, γ, δ はこの面の四辺の指示関数である。
  have hrowFace (i j : ZMod L) : bh (i + 1) j = (bv i j + bh i j) + bv i (j + 1) := by
    let α := bv i j
    let β := bh i j
    let γ := bv i (j + 1)
    let δ := bh (i + 1) j
    calc
      bh (i + 1) j = δ := rfl
      _ = δ + 0 := (add_zero _).symm
      _ = δ + (((α + β) + γ) + ((α + β) + γ)) := by rw [hdouble]
      _ = (δ + ((α + β) + γ)) + ((α + β) + γ) := (add_assoc _ _ _).symm
      _ = (((α + β) + γ) + δ) + ((α + β) + γ) := by
        rw [add_comm δ ((α + β) + γ)]
      _ = 0 + ((α + β) + γ) := by
        rw [show ((α + β) + γ) + δ = 0 from hface i j]
      _ = (α + β) + γ := zero_add _
      _ = (bv i j + bh i j) + bv i (j + 1) := rfl
  have hcolumnFace (i j : ZMod L) : bv i (j + 1) = (bv i j + bh i j) + bh (i + 1) j := by
    let α := bv i j
    let β := bh i j
    let γ := bv i (j + 1)
    let δ := bh (i + 1) j
    calc
      bv i (j + 1) = γ := rfl
      _ = γ + 0 := (add_zero _).symm
      _ = γ + (((α + β) + δ) + ((α + β) + δ)) := by rw [hdouble]
      _ = (γ + ((α + β) + δ)) + ((α + β) + δ) := (add_assoc _ _ _).symm
      _ = ((γ + (α + β)) + δ) + ((α + β) + δ) := by
        rw [← add_assoc γ (α + β) δ]
      _ = (((α + β) + γ) + δ) + ((α + β) + δ) := by
        rw [add_comm γ (α + β)]
      _ = 0 + ((α + β) + δ) := by
        rw [show ((α + β) + γ) + δ = 0 from hface i j]
      _ = (α + β) + δ := zero_add _
      _ = (bv i j + bh i j) + bh (i + 1) j := rfl
  have hshift (f : ZMod L → ZMod 2) : (∑ x : ZMod L, f (x + 1)) = ∑ x : ZMod L, f x := by
    exact Fintype.sum_bijective (Equiv.addRight 1) (Equiv.addRight 1).bijective
      (fun x : ZMod L => f (x + 1)) f (fun _ => rfl)
  constructor
  · intro i
    change (∑ j : ZMod L, bh (i + 1) j) = ∑ j : ZMod L, bh i j
    -- 本文の行和の九等号。二回の有限和の分配と巡回再添字付けを区別する。
    calc
      (∑ j : ZMod L, bh (i + 1) j) =
          ∑ j : ZMod L, ((bv i j + bh i j) + bv i (j + 1)) :=
        Finset.sum_congr rfl (fun j _ => hrowFace i j)
      _ = (∑ j : ZMod L, (bv i j + bh i j)) + ∑ j : ZMod L, bv i (j + 1) :=
        Finset.sum_add_distrib
      _ = ((∑ j : ZMod L, bv i j) + ∑ j : ZMod L, bh i j) +
          ∑ j : ZMod L, bv i (j + 1) := by rw [Finset.sum_add_distrib]
      _ = ((∑ j : ZMod L, bv i j) + ∑ j : ZMod L, bh i j) +
          ∑ j : ZMod L, bv i j := by rw [hshift]
      _ = (∑ j : ZMod L, bv i j) +
          ((∑ j : ZMod L, bh i j) + ∑ j : ZMod L, bv i j) := add_assoc _ _ _
      _ = (∑ j : ZMod L, bv i j) +
          ((∑ j : ZMod L, bv i j) + ∑ j : ZMod L, bh i j) := by
        rw [add_comm (∑ j : ZMod L, bh i j) (∑ j : ZMod L, bv i j)]
      _ = ((∑ j : ZMod L, bv i j) + ∑ j : ZMod L, bv i j) +
          ∑ j : ZMod L, bh i j := (add_assoc _ _ _).symm
      _ = 0 + ∑ j : ZMod L, bh i j := by rw [hdouble]
      _ = ∑ j : ZMod L, bh i j := zero_add _
  · intro j
    change (∑ i : ZMod L, bv i (j + 1)) = ∑ i : ZMod L, bv i j
    -- 本文の列和の七等号。横辺の巡回和を戻して二つの同じ和を消す。
    calc
      (∑ i : ZMod L, bv i (j + 1)) =
          ∑ i : ZMod L, ((bv i j + bh i j) + bh (i + 1) j) :=
        Finset.sum_congr rfl (fun i _ => hcolumnFace i j)
      _ = (∑ i : ZMod L, (bv i j + bh i j)) + ∑ i : ZMod L, bh (i + 1) j :=
        Finset.sum_add_distrib
      _ = ((∑ i : ZMod L, bv i j) + ∑ i : ZMod L, bh i j) +
          ∑ i : ZMod L, bh (i + 1) j := by rw [Finset.sum_add_distrib]
      _ = ((∑ i : ZMod L, bv i j) + ∑ i : ZMod L, bh i j) +
          ∑ i : ZMod L, bh i j := by rw [hshift (fun i => bh i j)]
      _ = (∑ i : ZMod L, bv i j) +
          ((∑ i : ZMod L, bh i j) + ∑ i : ZMod L, bh i j) := by rw [add_assoc]
      _ = (∑ i : ZMod L, bv i j) + 0 := by rw [hdouble]
      _ = ∑ i : ZMod L, bv i j := add_zero _

/-- 人手証明の「全行・全列の周期和が零」。二周期の等式を出発点、
行和・列和の不変性を一歩とする帰納法で、横辺の行和と縦辺の列和がすべて零になる。 -/
theorem reconstructedEdgeSet_all_row_column_sums_zero (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hSector : IsInTorusHomologySector L A (0, 0)) :
    (∀ i : ZMod L,
      (∑ j : ZMod L,
        (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) : ZMod 2) = 0) ∧
    (∀ j : ZMod L,
      (∑ i : ZMod L,
        (if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0) : ZMod 2) = 0) := by
  classical
  obtain ⟨hwv, hwh⟩ := reconstructedEdgeSet_winding_equations L A hSector
  obtain ⟨hrow, hcol⟩ := reconstructedEdgeSet_row_column_sum_invariant L A hSector.1
  let H : ZMod L → ZMod 2 := fun i => ∑ j : ZMod L,
    if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0
  let V : ZMod L → ZMod 2 := fun j => ∑ i : ZMod L,
    if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0
  constructor
  · change ∀ i : ZMod L, H i = 0
    have haux : ∀ n : ℕ, H (-1 + (n : ZMod L)) = 0 := by
      intro n
      induction n with
      | zero =>
        calc
          H (-1 + ((0 : ℕ) : ZMod L)) = H (-1 + 0) := by rw [Nat.cast_zero]
          _ = H (-1) := congrArg H (add_zero (-1 : ZMod L))
          _ = 0 := hwh
      | succ k ih =>
        calc
          H (-1 + ((k + 1 : ℕ) : ZMod L)) =
              H (-1 + ((k : ZMod L) + ((1 : ℕ) : ZMod L))) := by rw [Nat.cast_add]
          _ = H (-1 + ((k : ZMod L) + 1)) := by rw [Nat.cast_one]
          _ = H ((-1 + (k : ZMod L)) + 1) :=
            congrArg H (add_assoc (-1 : ZMod L) (k : ZMod L) 1).symm
          _ = H (-1 + (k : ZMod L)) := hrow (-1 + (k : ZMod L))
          _ = 0 := ih
    intro i
    calc
      H i = H (0 + i) := congrArg H (zero_add i).symm
      _ = H ((-1 + 1) + i) := by rw [neg_add_cancel]
      _ = H (-1 + (1 + i)) := congrArg H (add_assoc (-1 : ZMod L) 1 i)
      _ = H (-1 + (i + 1)) := congrArg H (congrArg (-1 + ·) (add_comm 1 i))
      _ = H (-1 + (((i + 1).val : ℕ) : ZMod L)) :=
        congrArg H (congrArg (-1 + ·) (ZMod.natCast_rightInverse (i + 1)).symm)
      _ = 0 := haux (i + 1).val
  · change ∀ j : ZMod L, V j = 0
    have haux : ∀ n : ℕ, V (-1 + (n : ZMod L)) = 0 := by
      intro n
      induction n with
      | zero =>
        calc
          V (-1 + ((0 : ℕ) : ZMod L)) = V (-1 + 0) := by rw [Nat.cast_zero]
          _ = V (-1) := congrArg V (add_zero (-1 : ZMod L))
          _ = 0 := hwv
      | succ k ih =>
        calc
          V (-1 + ((k + 1 : ℕ) : ZMod L)) =
              V (-1 + ((k : ZMod L) + ((1 : ℕ) : ZMod L))) := by rw [Nat.cast_add]
          _ = V (-1 + ((k : ZMod L) + 1)) := by rw [Nat.cast_one]
          _ = V ((-1 + (k : ZMod L)) + 1) :=
            congrArg V (add_assoc (-1 : ZMod L) (k : ZMod L) 1).symm
          _ = V (-1 + (k : ZMod L)) := hcol (-1 + (k : ZMod L))
          _ = 0 := ih
    intro j
    calc
      V j = V (0 + j) := congrArg V (zero_add j).symm
      _ = V ((-1 + 1) + j) := by rw [neg_add_cancel]
      _ = V (-1 + (1 + j)) := congrArg V (add_assoc (-1 : ZMod L) 1 j)
      _ = V (-1 + (j + 1)) := congrArg V (congrArg (-1 + ·) (add_comm 1 j))
      _ = V (-1 + (((j + 1).val : ℕ) : ZMod L)) :=
        congrArg V (congrArg (-1 + ·) (ZMod.natCast_rightInverse (j + 1)).symm)
      _ = 0 := haux (j + 1).val

/-- 人手証明の「基点から縦向き、次に横向きへ進む道の偶奇」。
各座標は `ZMod.val` が与える `0, …, L - 1` の代表を使う。 -/
noncomputable def reconstructionPathParity (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (i j : ZMod L) : ZMod 2 :=
  (∑ r ∈ Finset.range i.val,
    (if edgeOfRow L true (r : ZMod L) 0 ∈ reconstructedEdgeSet L A then 1 else 0)) +
  ∑ c ∈ Finset.range j.val,
    (if edgeOfRow L false i (c : ZMod L) ∈ reconstructedEdgeSet L A then 1 else 0)

/-- 非境界の横辺では、次の座標の代表は現在の代表に一を足した値である。 -/
theorem reconstruction_horizontal_successor_val (L : ℕ) [NeZero L]
    (j : ZMod L) (hjlt : j.val + 1 < L) : (j + 1).val = j.val + 1 := by
  have hcast : ((j.val + 1 : ℕ) : ZMod L) = j + 1 := by
    calc
      ((j.val + 1 : ℕ) : ZMod L) = (j.val : ZMod L) + ((1 : ℕ) : ZMod L) :=
        Nat.cast_add j.val 1
      _ = j + ((1 : ℕ) : ZMod L) :=
        congrArg (· + ((1 : ℕ) : ZMod L)) (ZMod.natCast_zmod_val j)
      _ = j + 1 := congrArg (j + ·) Nat.cast_one
  calc
    (j + 1).val = (((j.val + 1 : ℕ) : ZMod L)).val := congrArg ZMod.val hcast.symm
    _ = j.val + 1 := by rw [ZMod.val_natCast, Nat.mod_eq_of_lt hjlt]

/-- 本文の非境界の横辺差。道和の展開、代表の代入、末尾分離、結合・交換、
標数二の取消、代表の射影の順に各等号を対応させる。偶部分グラフ性は使わない。 -/
theorem reconstructionPathParity_horizontal_interior_difference (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (i j : ZMod L) (hjlt : j.val + 1 < L) :
    reconstructionPathParity L A i (j + 1) + reconstructionPathParity L A i j =
      (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) := by
  classical
  let P : ZMod 2 := ∑ r ∈ Finset.range i.val,
    if edgeOfRow L true (r : ZMod L) 0 ∈ reconstructedEdgeSet L A then 1 else 0
  let f : ℕ → ZMod 2 := fun c =>
    if edgeOfRow L false i (c : ZMod L) ∈ reconstructedEdgeSet L A then 1 else 0
  let H : ℕ → ZMod 2 := fun m => ∑ c ∈ Finset.range m, f c
  have hdouble : (P + H j.val) + (P + H j.val) = 0 := by
    have htwo : (2 : ZMod 2) = 0 := rfl
    linear_combination (P + H j.val) * htwo
  calc
    reconstructionPathParity L A i (j + 1) + reconstructionPathParity L A i j =
        (P + H (j + 1).val) + (P + H j.val) := rfl
    _ = (P + H (j.val + 1)) + (P + H j.val) := by
      rw [reconstruction_horizontal_successor_val L j hjlt]
    _ = (P + (H j.val + f j.val)) + (P + H j.val) := by
      rw [show H (j.val + 1) = H j.val + f j.val from Finset.sum_range_succ f j.val]
    _ = ((P + H j.val) + f j.val) + (P + H j.val) := by
      rw [← add_assoc P (H j.val) (f j.val)]
    _ = (P + H j.val) + (f j.val + (P + H j.val)) :=
      add_assoc _ _ _
    _ = (P + H j.val) + ((P + H j.val) + f j.val) :=
      congrArg ((P + H j.val) + ·) (add_comm (f j.val) (P + H j.val))
    _ = ((P + H j.val) + (P + H j.val)) + f j.val :=
      (add_assoc _ _ _).symm
    _ = 0 + f j.val := congrArg (· + f j.val) hdouble
    _ = f j.val := zero_add _
    _ = (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) := by
      dsimp [f]
      rw [ZMod.natCast_zmod_val]

/-- 本文の境界の代表の七等号。末尾の次の座標は零で、その代表も零である。 -/
theorem reconstruction_horizontal_boundary_successor_val (L : ℕ) [NeZero L]
    (j : ZMod L) (hj : j.val + 1 = L) : (j + 1).val = 0 := by
  have hcast : j + 1 = (0 : ZMod L) := by
    calc
      j + 1 = (j.val : ZMod L) + 1 :=
        congrArg (· + 1) (ZMod.natCast_zmod_val j).symm
      _ = (j.val : ZMod L) + ((1 : ℕ) : ZMod L) := by rw [Nat.cast_one]
      _ = ((j.val + 1 : ℕ) : ZMod L) := (Nat.cast_add j.val 1).symm
      _ = (L : ZMod L) := congrArg (fun n : ℕ => (n : ZMod L)) hj
      _ = 0 := ZMod.natCast_self L
  calc
    (j + 1).val = (0 : ZMod L).val := congrArg ZMod.val hcast
    _ = 0 := ZMod.val_zero

/-- 本文の H_i(L)。代表の全単射で行全体の和へ再添字付けし、周期和零を使う。 -/
theorem reconstructedEdgeSet_horizontal_prefix_sum_zero (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hSector : IsInTorusHomologySector L A (0, 0))
    (i : ZMod L) :
    (∑ c ∈ Finset.range L,
      (if edgeOfRow L false i (c : ZMod L) ∈ reconstructedEdgeSet L A
        then 1 else 0) : ZMod 2) = 0 := by
  classical
  let H : ℕ → ZMod 2 := fun m => ∑ c ∈ Finset.range m,
    if edgeOfRow L false i (c : ZMod L) ∈ reconstructedEdgeSet L A then 1 else 0
  let residueEquiv : Fin L ≃ ZMod L :=
    { toFun := fun c => (c.val : ZMod L)
      invFun := fun z => ⟨z.val, z.val_lt⟩
      left_inv := fun c => Fin.ext (by
        simp only [ZMod.val_natCast, Nat.mod_eq_of_lt c.isLt])
      right_inv := fun z => ZMod.natCast_zmod_val z }
  calc
    H L = ∑ c ∈ Finset.range L,
        (if edgeOfRow L false i (c : ZMod L) ∈ reconstructedEdgeSet L A
          then 1 else 0) := rfl
    _ = ∑ k : ZMod L,
        (if edgeOfRow L false i k ∈ reconstructedEdgeSet L A then 1 else 0) := by
      rw [← Fin.sum_univ_eq_sum_range]
      exact Fintype.sum_equiv residueEquiv _ _ (fun _ => rfl)
    _ = 0 := (reconstructedEdgeSet_all_row_column_sums_zero L A hSector).1 i

/-- 本文の境界の横辺差。末尾の和を七等号で一項へ戻し、道和差を九等号で計算する。
辺長一でも空和の同じ式が成り立つ。 -/
theorem reconstructionPathParity_horizontal_boundary_difference (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hSector : IsInTorusHomologySector L A (0, 0))
    (i j : ZMod L) (hj : j.val + 1 = L) :
    reconstructionPathParity L A i (j + 1) + reconstructionPathParity L A i j =
      (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) := by
  classical
  let P : ZMod 2 := ∑ r ∈ Finset.range i.val,
    if edgeOfRow L true (r : ZMod L) 0 ∈ reconstructedEdgeSet L A then 1 else 0
  let f : ℕ → ZMod 2 := fun c =>
    if edgeOfRow L false i (c : ZMod L) ∈ reconstructedEdgeSet L A then 1 else 0
  let H : ℕ → ZMod 2 := fun m => ∑ c ∈ Finset.range m, f c
  have hperiod : H L = 0 := reconstructedEdgeSet_horizontal_prefix_sum_zero L A hSector i
  have htwo : (2 : ZMod 2) = 0 := rfl
  have hbase : P + P = 0 := by linear_combination P * htwo
  have hterm : f j.val + f j.val = 0 := by linear_combination f j.val * htwo
  have hprefix : H j.val = f j.val := by
    calc
      H j.val = H j.val + 0 := (add_zero _).symm
      _ = H j.val + (f j.val + f j.val) := congrArg (H j.val + ·) hterm.symm
      _ = (H j.val + f j.val) + f j.val := (add_assoc _ _ _).symm
      _ = H (j.val + 1) + f j.val :=
        congrArg (· + f j.val) (Finset.sum_range_succ f j.val).symm
      _ = H L + f j.val := by rw [hj]
      _ = 0 + f j.val := congrArg (· + f j.val) hperiod
      _ = f j.val := zero_add _
  calc
    reconstructionPathParity L A i (j + 1) + reconstructionPathParity L A i j =
        (P + H (j + 1).val) + (P + H j.val) := rfl
    _ = (P + H 0) + (P + H j.val) := by
      rw [reconstruction_horizontal_boundary_successor_val L j hj]
    _ = (P + 0) + (P + H j.val) := by
      rw [show H 0 = 0 from Finset.sum_range_zero f]
    _ = P + (P + H j.val) := by rw [add_zero]
    _ = (P + P) + H j.val := (add_assoc _ _ _).symm
    _ = 0 + H j.val := congrArg (· + H j.val) hbase
    _ = H j.val := zero_add _
    _ = f j.val := hprefix
    _ = (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) := by
      dsimp [f]
      rw [ZMod.natCast_zmod_val]

/-- 人手証明の横向き辺についての道和の差。非境界と周期境界の二場合を合わせる。 -/
theorem reconstructionPathParity_horizontal_difference (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hSector : IsInTorusHomologySector L A (0, 0))
    (i j : ZMod L) :
    reconstructionPathParity L A i (j + 1) + reconstructionPathParity L A i j =
      (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0) := by
  by_cases hjlt : j.val + 1 < L
  · exact reconstructionPathParity_horizontal_interior_difference L A i j hjlt
  · have hj : j.val + 1 = L := by
      have hjbound := j.val_lt
      omega
    exact reconstructionPathParity_horizontal_boundary_difference L A hSector i j hj

/-- 人手証明の「格子面の等式の望遠鏡和」の核。隣り合う二項の和を範囲にわたって足すと、
`ℤ/2ℤ` では中間の項が二度ずつ現れて消え、両端の二項だけが残る。 -/
lemma sum_range_adjacent_pairs_char_two (f : ℕ → ZMod 2) (m : ℕ) :
    (∑ c ∈ Finset.range m, (f (c + 1) + f c)) = f m + f 0 := by
  have hdouble (z : ZMod 2) : z + z = 0 := by fin_cases z <;> rfl
  induction m with
  | zero =>
      calc
        (∑ c ∈ range 0, (f (c + 1) + f c)) = 0 := Finset.sum_range_zero _
        _ = f 0 + f 0 := (hdouble (f 0)).symm
  | succ k ih =>
      calc
        (∑ c ∈ range (k + 1), (f (c + 1) + f c)) =
            (∑ c ∈ range k, (f (c + 1) + f c)) + (f (k + 1) + f k) :=
          Finset.sum_range_succ _ k
        _ = (f k + f 0) + (f (k + 1) + f k) := by rw [ih]
        _ = f k + (f 0 + (f (k + 1) + f k)) := add_assoc _ _ _
        _ = f k + ((f 0 + f (k + 1)) + f k) := by rw [← add_assoc (f 0)]
        _ = f k + (f k + (f 0 + f (k + 1))) := by
          rw [add_comm (f 0 + f (k + 1)) (f k)]
        _ = (f k + f k) + (f 0 + f (k + 1)) := (add_assoc _ _ _).symm
        _ = 0 + (f 0 + f (k + 1)) := by rw [hdouble]
        _ = f 0 + f (k + 1) := zero_add _
        _ = f (k + 1) + f 0 := add_comm _ _

/-- 本文で先に示した格子面の横辺一項の表示。縦辺差の準備へ同じ式を供給する。 -/
lemma reconstruction_horizontal_face_solve (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hEven : IsEvenEdgeSubset L A) (i j : ZMod L) :
    (if edgeOfRow L false (i + 1) j ∈ reconstructedEdgeSet L A then 1 else 0 : ZMod 2) =
      ((if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0) +
        (if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0)) +
        (if edgeOfRow L true i (j + 1) ∈ reconstructedEdgeSet L A then 1 else 0) := by
  classical
  let α : ZMod 2 := if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0
  let β : ZMod 2 := if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0
  let γ : ZMod 2 := if edgeOfRow L true i (j + 1) ∈ reconstructedEdgeSet L A then 1 else 0
  let δ : ZMod 2 := if edgeOfRow L false (i + 1) j ∈ reconstructedEdgeSet L A then 1 else 0
  have hdouble (z : ZMod 2) : z + z = 0 := by fin_cases z <;> rfl
  have hface : ((α + β) + γ) + δ = 0 := reconstructedEdgeSet_face_equation L A hEven i j
  calc
    δ = δ + 0 := (add_zero _).symm
    _ = δ + (((α + β) + γ) + ((α + β) + γ)) := by rw [hdouble]
    _ = (δ + ((α + β) + γ)) + ((α + β) + γ) := (add_assoc _ _ _).symm
    _ = (((α + β) + γ) + δ) + ((α + β) + γ) := by rw [add_comm δ]
    _ = 0 + ((α + β) + γ) := by rw [hface]
    _ = (α + β) + γ := zero_add _

/-- 本文の縦辺差の準備。横辺二項を縦辺二項へ移す十等号。 -/
theorem reconstruction_vertical_face_pair (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hEven : IsEvenEdgeSubset L A) (i : ZMod L) (c : ℕ) :
    ((if edgeOfRow L false (i + 1) (c : ZMod L) ∈ reconstructedEdgeSet L A then 1 else 0) +
      (if edgeOfRow L false i (c : ZMod L) ∈ reconstructedEdgeSet L A then 1 else 0) : ZMod 2) =
      (if edgeOfRow L true i ((c + 1 : ℕ) : ZMod L) ∈ reconstructedEdgeSet L A then 1 else 0) +
      (if edgeOfRow L true i (c : ZMod L) ∈ reconstructedEdgeSet L A then 1 else 0) := by
  classical
  let bh (i j : ZMod L) : ZMod 2 :=
    if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0
  let bv (i j : ZMod L) : ZMod 2 :=
    if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0
  let f : ℕ → ZMod 2 := fun c => bv i (c : ZMod L)
  have hdouble (z : ZMod 2) : z + z = 0 := by fin_cases z <;> rfl
  have hcast : ((c + 1 : ℕ) : ZMod L) = (c : ZMod L) + 1 := by simp only [Nat.cast_add, Nat.cast_one]
  calc
    bh (i + 1) (c : ZMod L) + bh i (c : ZMod L) =
        ((bv i (c : ZMod L) + bh i (c : ZMod L)) + bv i ((c : ZMod L) + 1)) + bh i (c : ZMod L) :=
      congrArg (· + bh i (c : ZMod L)) (reconstruction_horizontal_face_solve L A hEven i _)
    _ = (bv i (c : ZMod L) + bh i (c : ZMod L)) +
        (bv i ((c : ZMod L) + 1) + bh i (c : ZMod L)) := add_assoc _ _ _
    _ = (bv i (c : ZMod L) + bh i (c : ZMod L)) +
        (bh i (c : ZMod L) + bv i ((c : ZMod L) + 1)) := by rw [add_comm (bv i ((c : ZMod L) + 1))]
    _ = ((bv i (c : ZMod L) + bh i (c : ZMod L)) + bh i (c : ZMod L)) +
        bv i ((c : ZMod L) + 1) := (add_assoc _ _ _).symm
    _ = (bv i (c : ZMod L) + (bh i (c : ZMod L) + bh i (c : ZMod L))) +
        bv i ((c : ZMod L) + 1) := by rw [add_assoc (bv i (c : ZMod L))]
    _ = (bv i (c : ZMod L) + 0) + bv i ((c : ZMod L) + 1) := by rw [hdouble]
    _ = bv i (c : ZMod L) + bv i ((c : ZMod L) + 1) := by rw [add_zero]
    _ = bv i ((c : ZMod L) + 1) + bv i (c : ZMod L) := add_comm _ _
    _ = bv i ((c + 1 : ℕ) : ZMod L) + bv i (c : ZMod L) := by rw [hcast]
    _ = f (c + 1) + f c := rfl

/-- 本文の非境界の縦辺差。代表の増分、末尾分離、加法、面等式、望遠鏡和を各行へ対応させる。
巻き付き偶奇と周期和零はこの場合には使わず、偶部分グラフ性だけを仮定する。 -/
theorem reconstructionPathParity_vertical_interior_difference (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hEven : IsEvenEdgeSubset L A)
    (i j : ZMod L) (hilt : i.val + 1 < L) :
    reconstructionPathParity L A (i + 1) j + reconstructionPathParity L A i j =
      (if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0) := by
  classical
  let bh (i j : ZMod L) : ZMod 2 :=
    if edgeOfRow L false i j ∈ reconstructedEdgeSet L A then 1 else 0
  let bv (i j : ZMod L) : ZMod 2 :=
    if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0
  let V : ℕ → ZMod 2 := fun n => ∑ r ∈ range n, bv (r : ZMod L) 0
  let H (i : ZMod L) (m : ℕ) : ZMod 2 := ∑ c ∈ range m, bh i (c : ZMod L)
  let f : ℕ → ZMod 2 := fun c => bv i (c : ZMod L)
  have hdouble (z : ZMod 2) : z + z = 0 := by fin_cases z <;> rfl
  have hrep : (i + 1).val = i.val + 1 := reconstruction_horizontal_successor_val L i hilt
  calc
    reconstructionPathParity L A (i + 1) j + reconstructionPathParity L A i j =
        (V (i + 1).val + H (i + 1) j.val) + (V i.val + H i j.val) := rfl
    _ = (V (i.val + 1) + H (i + 1) j.val) + (V i.val + H i j.val) := by rw [hrep]
    _ = ((V i.val + bv (i.val : ZMod L) 0) + H (i + 1) j.val) + (V i.val + H i j.val) := by
      rw [show V (i.val + 1) = V i.val + bv (i.val : ZMod L) 0 from Finset.sum_range_succ _ _]
    _ = ((V i.val + bv i 0) + H (i + 1) j.val) + (V i.val + H i j.val) := by rw [ZMod.natCast_zmod_val]
    _ = (V i.val + (bv i 0 + H (i + 1) j.val)) + (V i.val + H i j.val) := by rw [add_assoc (V i.val) (bv i 0)]
    _ = V i.val + ((bv i 0 + H (i + 1) j.val) + (V i.val + H i j.val)) := add_assoc _ _ _
    _ = V i.val + (((bv i 0 + H (i + 1) j.val) + V i.val) + H i j.val) := by rw [← add_assoc (bv i 0 + H (i + 1) j.val)]
    _ = V i.val + ((V i.val + (bv i 0 + H (i + 1) j.val)) + H i j.val) := by rw [add_comm (bv i 0 + H (i + 1) j.val) (V i.val)]
    _ = V i.val + (V i.val + ((bv i 0 + H (i + 1) j.val) + H i j.val)) := by rw [add_assoc (V i.val) (bv i 0 + H (i + 1) j.val)]
    _ = (V i.val + V i.val) + ((bv i 0 + H (i + 1) j.val) + H i j.val) := (add_assoc _ _ _).symm
    _ = 0 + ((bv i 0 + H (i + 1) j.val) + H i j.val) := by rw [hdouble]
    _ = (bv i 0 + H (i + 1) j.val) + H i j.val := zero_add _
    _ = bv i 0 + (H (i + 1) j.val + H i j.val) := add_assoc _ _ _
    _ = bv i 0 + ∑ c ∈ range j.val, (bh (i + 1) (c : ZMod L) + bh i (c : ZMod L)) := by
      dsimp only [H]
      rw [← Finset.sum_add_distrib]
    _ = bv i 0 + ∑ c ∈ range j.val, (f (c + 1) + f c) := by
      congr 1
      exact Finset.sum_congr rfl (fun c _ => reconstruction_vertical_face_pair L A hEven i c)
    _ = bv i 0 + (f j.val + f 0) := congrArg (bv i 0 + ·) (sum_range_adjacent_pairs_char_two f j.val)
    _ = bv i 0 + (bv i j + f 0) := by dsimp [f]; rw [ZMod.natCast_zmod_val]
    _ = bv i 0 + (bv i j + bv i 0) := by dsimp [f]; rw [Nat.cast_zero]
    _ = bv i 0 + (bv i 0 + bv i j) := congrArg (bv i 0 + ·) (add_comm _ _)
    _ = (bv i 0 + bv i 0) + bv i j := (add_assoc _ _ _).symm
    _ = 0 + bv i j := by rw [hdouble]
    _ = bv i j := zero_add _

/-- 人手証明の縦向き辺についての道和の差。横向きの有限和の差は格子面の等式の望遠鏡和で
縦向きの両端二項へ落ち、縦向きの有限和の差は、代表が `L - 1` 未満なら有限和の末尾の一項、
`L - 1` なら列全体の和が零であることから、どちらも列 `0` の縦辺の項になる。 -/
theorem reconstructionPathParity_vertical_difference (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hSector : IsInTorusHomologySector L A (0, 0))
    (i j : ZMod L) :
    reconstructionPathParity L A (i + 1) j + reconstructionPathParity L A i j =
      (if edgeOfRow L true i j ∈ reconstructedEdgeSet L A then 1 else 0) := by
  classical
  by_cases hilt : i.val + 1 < L
  · exact reconstructionPathParity_vertical_interior_difference L A hSector.1 i j hilt
  cases L with
  | zero => exact (NeZero.ne 0 rfl).elim
  | succ n =>
      have htwo : (2 : ZMod 2) = 0 := rfl
      -- 格子面の等式を、行 i と行 i + 1 の横辺二項＝列 c と列 c + 1 の縦辺二項の形へ移す
      have hface : ∀ c : ℕ,
          ((if edgeOfRow (n + 1) false (i + 1) ((c : ZMod (n + 1))) ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0) +
            (if edgeOfRow (n + 1) false i ((c : ZMod (n + 1))) ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0) : ZMod 2) =
          (if edgeOfRow (n + 1) true i (((c + 1 : ℕ) : ZMod (n + 1))) ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0) +
            (if edgeOfRow (n + 1) true i ((c : ZMod (n + 1))) ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0) := by
        intro c
        have hf := reconstructedEdgeSet_face_equation (n + 1) A hSector.1 i
          ((c : ZMod (n + 1)))
        push_cast
        linear_combination hf -
          ((if edgeOfRow (n + 1) true i ((c : ZMod (n + 1)) + 1) ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0 : ZMod 2) +
            (if edgeOfRow (n + 1) true i ((c : ZMod (n + 1))) ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0)) * htwo
      -- 横向きの有限和の差。格子面の等式の望遠鏡和で両端の縦辺二項だけが残る
      have hHsum : ((∑ c ∈ Finset.range j.val,
            (if edgeOfRow (n + 1) false (i + 1) ((c : ZMod (n + 1))) ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0)) +
          ∑ c ∈ Finset.range j.val,
            (if edgeOfRow (n + 1) false i ((c : ZMod (n + 1))) ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0) : ZMod 2) =
          (if edgeOfRow (n + 1) true i j ∈ reconstructedEdgeSet (n + 1) A then 1 else 0) +
            (if edgeOfRow (n + 1) true i 0 ∈ reconstructedEdgeSet (n + 1) A
              then 1 else 0) := by
        rw [← Finset.sum_add_distrib]
        calc
          (∑ c ∈ Finset.range j.val,
              ((if edgeOfRow (n + 1) false (i + 1) ((c : ZMod (n + 1))) ∈
                  reconstructedEdgeSet (n + 1) A then 1 else 0) +
                (if edgeOfRow (n + 1) false i ((c : ZMod (n + 1))) ∈
                  reconstructedEdgeSet (n + 1) A then 1 else 0)) : ZMod 2) =
            ∑ c ∈ Finset.range j.val,
              ((if edgeOfRow (n + 1) true i (((c + 1 : ℕ) : ZMod (n + 1))) ∈
                  reconstructedEdgeSet (n + 1) A then 1 else 0) +
                (if edgeOfRow (n + 1) true i ((c : ZMod (n + 1))) ∈
                  reconstructedEdgeSet (n + 1) A then 1 else 0)) :=
              Finset.sum_congr rfl (fun c _ => hface c)
          _ = (if edgeOfRow (n + 1) true i (((j.val : ℕ) : ZMod (n + 1))) ∈
                reconstructedEdgeSet (n + 1) A then 1 else 0) +
              (if edgeOfRow (n + 1) true i (((0 : ℕ) : ZMod (n + 1))) ∈
                reconstructedEdgeSet (n + 1) A then 1 else 0) :=
              sum_range_adjacent_pairs_char_two (fun c =>
                if edgeOfRow (n + 1) true i ((c : ZMod (n + 1))) ∈
                  reconstructedEdgeSet (n + 1) A then 1 else 0) j.val
          _ = _ := by rw [ZMod.natCast_zmod_val j, Nat.cast_zero]
      -- 縦向きの有限和の差。代表が末尾未満なら末尾の一項、末尾なら列全体の和の零性を使う
      have hvert : ((∑ r ∈ Finset.range (i + 1).val,
            (if edgeOfRow (n + 1) true ((r : ZMod (n + 1))) 0 ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0)) +
          ∑ r ∈ Finset.range i.val,
            (if edgeOfRow (n + 1) true ((r : ZMod (n + 1))) 0 ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0) : ZMod 2) =
          (if edgeOfRow (n + 1) true i 0 ∈ reconstructedEdgeSet (n + 1) A
            then 1 else 0) := by
        by_cases hi : i = -1
        · subst hi
          have hcol :=
            (reconstructedEdgeSet_all_row_column_sums_zero (n + 1) A hSector).2 0
          let residueEquiv : Fin (n + 1) ≃ ZMod (n + 1) :=
            { toFun := fun r => (r.val : ZMod (n + 1))
              invFun := fun z => ⟨z.val, z.val_lt⟩
              left_inv := fun r => Fin.ext (by
                simp only [ZMod.val_natCast, Nat.mod_eq_of_lt r.isLt])
              right_inv := fun z => ZMod.natCast_zmod_val z }
          have hcolFin : (∑ r : Fin (n + 1),
              (if edgeOfRow (n + 1) true ((r.val : ZMod (n + 1))) 0 ∈
                reconstructedEdgeSet (n + 1) A then 1 else 0) : ZMod 2) = 0 := by
            calc
              _ = ∑ r : ZMod (n + 1),
                  (if edgeOfRow (n + 1) true r 0 ∈ reconstructedEdgeSet (n + 1) A
                    then 1 else 0) := Fintype.sum_equiv residueEquiv _ _
                      (fun _ => rfl)
              _ = 0 := hcol
          have hcolRange : (∑ r ∈ Finset.range (n + 1),
              (if edgeOfRow (n + 1) true ((r : ZMod (n + 1))) 0 ∈
                reconstructedEdgeSet (n + 1) A then 1 else 0) : ZMod 2) = 0 := by
            rw [← Fin.sum_univ_eq_sum_range]
            exact hcolFin
          rw [Finset.sum_range_succ] at hcolRange
          have hcast : ((n : ℕ) : ZMod (n + 1)) = -1 := by
            apply ZMod.val_injective (n + 1)
            rw [ZMod.val_natCast, Nat.mod_eq_of_lt (Nat.lt_succ_self n), ZMod.val_neg_one]
          simp only [neg_add_cancel, ZMod.val_zero, Finset.range_zero, Finset.sum_empty,
            zero_add, ZMod.val_neg_one]
          rw [← hcast]
          linear_combination hcolRange -
            (if edgeOfRow (n + 1) true ((n : ZMod (n + 1))) 0 ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0 : ZMod 2) * htwo
        · have hilt : i.val + 1 < n + 1 := by
            have hibound := ZMod.val_lt i
            by_contra hnot
            have hval : i.val = n := by omega
            apply hi
            apply ZMod.val_injective (n + 1)
            rw [hval, ZMod.val_neg_one]
          have hival : (i + 1).val = i.val + 1 := by
            rw [show i + 1 = ((i.val + 1 : ℕ) : ZMod (n + 1)) by
              rw [Nat.cast_add, ZMod.natCast_zmod_val, Nat.cast_one]]
            rw [ZMod.val_natCast, Nat.mod_eq_of_lt hilt]
          rw [hival, Finset.sum_range_succ, ZMod.natCast_zmod_val i]
          linear_combination (∑ r ∈ Finset.range i.val,
            (if edgeOfRow (n + 1) true ((r : ZMod (n + 1))) 0 ∈
              reconstructedEdgeSet (n + 1) A then 1 else 0) : ZMod 2) * htwo
      rw [reconstructionPathParity, reconstructionPathParity]
      linear_combination hvert + hHsum +
        (if edgeOfRow (n + 1) true i 0 ∈ reconstructedEdgeSet (n + 1) A
          then 1 else 0 : ZMod 2) * htwo

/-- 本文の二場合。自然数代表は零か一なので、整数冪の値はスピン値に属する。 -/
lemma reconstructionParityPower_eq_one_or_neg_one (q : ZMod 2) :
    (-1 : ℤ) ^ q.val = 1 ∨ (-1 : ℤ) ^ q.val = -1 := by
  have hcases : q.val = 0 ∨ q.val = 1 := by
    have hlt := q.val_lt
    omega
  rcases hcases with hzero | hone
  · left
    calc
      (-1 : ℤ) ^ q.val = (-1 : ℤ) ^ 0 := congrArg ((-1 : ℤ) ^ ·) hzero
      _ = 1 := pow_zero _
  · right
    calc
      (-1 : ℤ) ^ q.val = (-1 : ℤ) ^ 1 := congrArg ((-1 : ℤ) ^ ·) hone
      _ = -1 := pow_one _

/-- 道和の偶奇を、自然数代表を指数とする整数冪でスピン値へ戻す。 -/
def reconstructionSpin (q : ZMod 2) : SpinValue :=
  ⟨(-1 : ℤ) ^ q.val, reconstructionParityPower_eq_one_or_neg_one q⟩

/-- 人手証明の自然数代表 `s₂(q)` は `q.val` であり、整数の冪を定める。 -/
lemma reconstructionSpin_val_eq_neg_one_pow_val (q : ZMod 2) :
    (reconstructionSpin q).val = (-1 : ℤ) ^ q.val := rfl

lemma reconstructionSpin_ne_iff_add_eq_one (a b : ZMod 2) :
    reconstructionSpin a ≠ reconstructionSpin b ↔ a + b = 1 := by
  fin_cases a <;> fin_cases b <;> decide

/-- 人手証明の `σ_A(i,j)=(-1)^{s₂(t(i,j))}`。 -/
noncomputable def reconstructedConfiguration (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) : Config L := fun v =>
  reconstructionSpin (reconstructionPathParity L A v.1 v.2)

/-- 道和から復元した配位の破れた辺集合は、双対辺写像で戻した辺集合に等しい。 -/
theorem reconstructedConfiguration_brokenEdgeSet (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hSector : IsInTorusHomologySector L A (0, 0)) :
    brokenEdgeSet L (reconstructedConfiguration L A) = reconstructedEdgeSet L A := by
  classical
  ext e
  rw [brokenEdgeSet, Finset.mem_filter]
  simp only [Finset.mem_univ, true_and]
  rw [show e = edgeEquiv L ((edgeEquiv L).symm e) by simp]
  rcases (edgeEquiv L).symm e with ⟨i, j⟩ | ⟨i, j⟩
  · simp only [edgeEquiv_inl_pair, edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal,
      reconstructedConfiguration, reconstructionSpin_ne_iff_add_eq_one]
    have h := reconstructionPathParity_horizontal_difference L A hSector i j
    rw [add_comm] at h
    by_cases he : edgeOfRow L false i j ∈ reconstructedEdgeSet L A
    · simpa [he] using h
    · simp only [he, iff_false]
      have hzero : reconstructionPathParity L A i j +
          reconstructionPathParity L A i (j + 1) = 0 := by simpa [he] using h
      intro hone
      rw [hone] at hzero
      norm_num at hzero
  · simp only [edgeEquiv_inr_pair, edgeOfRow_boundary0, edgeOfRow_boundary1_vertical,
      reconstructedConfiguration, reconstructionSpin_ne_iff_add_eq_one]
    have h := reconstructionPathParity_vertical_difference L A hSector i j
    rw [add_comm] at h
    by_cases he : edgeOfRow L true i j ∈ reconstructedEdgeSet L A
    · simpa [he] using h
    · simp only [he, iff_false]
      have hzero : reconstructionPathParity L A i j +
          reconstructionPathParity L A (i + 1) j = 0 := by simpa [he] using h
      intro hone
      rw [hone] at hzero
      norm_num at hzero

/-- 道和から復元した配位の双対破れ像は、もとの自明セクターの偶部分グラフに等しい。 -/
theorem reconstructedConfiguration_dualBrokenEdgeSet (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hSector : IsInTorusHomologySector L A (0, 0)) :
    dualBrokenEdgeSet L (reconstructedConfiguration L A) = A := by
  rw [dualBrokenEdgeSet, reconstructedConfiguration_brokenEdgeSet L A hSector,
    image_reconstructedEdgeSet]

theorem globalSpinReversal_dualBrokenEdgeSet (L : ℕ) [NeZero L] (σ : Config L) :
    dualBrokenEdgeSet L (globalSpinReversal L σ) = dualBrokenEdgeSet L σ := by
  simp only [dualBrokenEdgeSet]
  rw [globalSpinReversal_brokenEdgeSet]

theorem sameDualBrokenEdges_eq_or_globalSpinReversal (L : ℕ) [NeZero L]
    (σ τ : Config L) (hdual : dualBrokenEdgeSet L τ = dualBrokenEdgeSet L σ) :
    τ = σ ∨ τ = globalSpinReversal L σ := by
  apply sameBrokenEdges_eq_or_globalSpinReversal L σ τ
  intro e
  have himage := Finset.ext_iff.mp hdual (dualEdgeEquiv L e)
  simpa only [mem_dualBrokenEdgeSet_iff, (dualEdgeEquiv L).symm_apply_apply,
    brokenEdgeSet, mem_filter, mem_univ, true_and] using himage.symm

/-- 復元した配位が一つ存在すれば、双対破れ像の原像はその配位と全反転の二つだけである。 -/
theorem trivialSectorConfiguration_fiber_card_two_of_exists
    (L : ℕ) [NeZero L] (A : Finset (Edge L))
    (hexists : ∃ σ : Config L, dualBrokenEdgeSet L σ = A) :
    (univ.filter fun σ : Config L => dualBrokenEdgeSet L σ = A).card = 2 := by
  classical
  obtain ⟨σ, hσ⟩ := hexists
  -- 本文の「全スピン反転も原像に属し、もとの配位とは異なる」。
  have hReversal : dualBrokenEdgeSet L (globalSpinReversal L σ) = A :=
    (globalSpinReversal_dualBrokenEdgeSet L σ).trans hσ
  have hDistinct : σ ≠ globalSpinReversal L σ :=
    (globalSpinReversal_ne_self L σ).symm
  -- 本文の「任意の別の原像はもとの配位またはその全反転」。
  have hFiber :
      univ.filter (fun τ : Config L => dualBrokenEdgeSet L τ = A) =
        {σ, globalSpinReversal L σ} := by
    ext τ
    simp only [mem_filter, mem_univ, true_and, mem_insert, mem_singleton]
    constructor
    · intro hτ
      exact sameDualBrokenEdges_eq_or_globalSpinReversal L σ τ (hτ.trans hσ.symm)
    · intro hτ
      rcases hτ with rfl | rfl
      · exact hσ
      · exact hReversal
  -- 本文の原像の個数計算。異なる二配位なので二点集合の個数は二である。
  rw [hFiber, card_insert_of_notMem]
  · rw [card_singleton]
  · simpa only [mem_singleton] using hDistinct

/-- 自明セクターの偶部分グラフを双対破れ像として持つ配位はちょうど二つである。 -/
theorem trivialSectorConfiguration_fiber_card_two
    (L : ℕ) [NeZero L] (A : Finset (Edge L))
    (hSector : IsInTorusHomologySector L A (0, 0)) :
    (univ.filter fun σ : Config L => dualBrokenEdgeSet L σ = A).card = 2 := by
  apply trivialSectorConfiguration_fiber_card_two_of_exists L A
  exact ⟨reconstructedConfiguration L A,
    reconstructedConfiguration_dualBrokenEdgeSet L A hSector⟩

end Ising2DLambda.FisherZero
