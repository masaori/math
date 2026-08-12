/-
「自明セクターの偶部分グラフから配位を復元できる」の具体版のうち、復元した配位が
一つ得られたあとの個数計算。人手証明の末尾と同じく、全スピン反転による二つの原像を
作り、同じ破れた辺集合の一意性で他の原像を排除する。

基点からの道和によって原像を構成する部分は、続く tick でこのファイルへ加える。
-/
import Ising2DLambda.FisherZero.DualBrokenEdgesWinding
import Ising2DLambda.FisherZero.LowTemperaturePolynomial
import Ising2DLambda.NecSuf.FisherZero.TrivialSectorConfigurationReconstruction

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

/-- 双対像の各双対頂点での局所端点数を、元の辺集合の四つの所属指示子で書く
（`dualBrokenEdgeSet_incidenceCount` を任意の辺集合へ一般化したもの）。 -/
lemma dualImage_incidenceCount (L : ℕ) [NeZero L] (S : Finset (Edge L))
    (i j : ZMod L) :
    edgeSubsetIncidenceCount L (S.image (dualEdgeEquiv L)) (i, j) =
      (if edgeOfRow L true (i - 1) j ∈ S then 1 else 0) +
      (if edgeOfRow L false i (j - 1) ∈ S then 1 else 0) +
      (if edgeOfRow L true (i - 1) (j - 1) ∈ S then 1 else 0) +
      (if edgeOfRow L false (i - 1) (j - 1) ∈ S then 1 else 0) := by
  classical
  rw [edgeSubsetIncidenceCount]
  rw [show S.image (dualEdgeEquiv L) =
      (Finset.univ.filter fun e : Edge L => e ∈ S.image (dualEdgeEquiv L)) by ext; simp]
  rw [Finset.sum_filter]
  change (∑ e : Edge L, if e ∈ S.image (dualEdgeEquiv L) then
    ((if boundary0 L e = (i, j) then 1 else 0) +
      (if boundary1 L e = (i, j) then 1 else 0)) else 0) = _
  rw [← Fintype.sum_equiv (edgeEquiv L)
    (fun w => if edgeEquiv L w ∈ S.image (dualEdgeEquiv L) then
      ((if boundary0 L (edgeEquiv L w) = (i, j) then 1 else 0) +
        (if boundary1 L (edgeEquiv L w) = (i, j) then 1 else 0)) else 0)
    (fun e => if e ∈ S.image (dualEdgeEquiv L) then
      ((if boundary0 L e = (i, j) then 1 else 0) +
        (if boundary1 L e = (i, j) then 1 else 0)) else 0) (fun _ => rfl)]
  simp only [Fintype.sum_sum_type, edgeEquiv_inl_pair, edgeEquiv_inr_pair,
    edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal,
    edgeOfRow_boundary1_vertical, mem_image_dualEdgeEquiv_iff,
    dualEdgeEquiv_symm_horizontal, dualEdgeEquiv_symm_vertical]
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
  have hcount := hEven (i + 1, j + 1)
  rw [show A = (reconstructedEdgeSet L A).image (dualEdgeEquiv L) from
    (image_reconstructedEdgeSet L A).symm, dualImage_incidenceCount] at hcount
  simp only [add_sub_cancel_right] at hcount
  obtain ⟨k, hk⟩ := hcount
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
  rw [hcast, hk]
  push_cast
  rw [← two_mul, show (2 : ZMod 2) = 0 from rfl, zero_mul]

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
  obtain ⟨σ, hσ⟩ := hexists
  have h := Ising2DLambda.NecSuf.FisherZero.paired_fiber_card_two_necSuf
    (dualBrokenEdgeSet L) (globalSpinReversal L) σ
    (globalSpinReversal_ne_self L σ)
    (globalSpinReversal_dualBrokenEdgeSet L σ)
    (sameDualBrokenEdges_eq_or_globalSpinReversal L σ)
  simpa [hσ] using h

end Ising2DLambda.FisherZero
