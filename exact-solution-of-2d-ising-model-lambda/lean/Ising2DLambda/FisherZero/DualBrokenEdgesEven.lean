/-
「破れた辺の双対像は偶部分グラフである」の具体版。
人手証明と同じく、一つの格子面の四辺に沿うスピン積で局所破れ数の偶数性を示す。
-/
import Mathlib
import Ising2DLambda.FisherZero.DualEdgeMap
import Ising2DLambda.FisherZero.EvenSubgraphSpinSum

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 配位の破れた辺集合を双対辺写像で送った像。 -/
noncomputable def dualBrokenEdgeSet (L : ℕ) [NeZero L] (σ : Config L) : Finset (Edge L) :=
  (brokenEdgeSet L σ).image (dualEdgeEquiv L)

@[simp] lemma dualEdgeEquiv_horizontal (L : ℕ) [NeZero L] (i j : ZMod L) :
    dualEdgeEquiv L (edgeOfRow L false i j) = edgeOfRow L true i (j + 1) := by
  rw [show edgeOfRow L false i j = edgeEquiv L (Sum.inl (i, j)) from rfl]
  change edgeEquiv L (dualEdgeCoordinatesEquiv L ((edgeEquiv L).symm
    (edgeEquiv L (Sum.inl (i, j))))) = _
  rw [(edgeEquiv L).symm_apply_apply]
  rfl

@[simp] lemma dualEdgeEquiv_vertical (L : ℕ) [NeZero L] (i j : ZMod L) :
    dualEdgeEquiv L (edgeOfRow L true i j) = edgeOfRow L false (i + 1) j := by
  rw [show edgeOfRow L true i j = edgeEquiv L (Sum.inr (i, j)) from rfl]
  change edgeEquiv L (dualEdgeCoordinatesEquiv L ((edgeEquiv L).symm
    (edgeEquiv L (Sum.inr (i, j))))) = _
  rw [(edgeEquiv L).symm_apply_apply]
  rfl

@[simp] lemma dualEdgeEquiv_symm_horizontal (L : ℕ) [NeZero L] (i j : ZMod L) :
    (dualEdgeEquiv L).symm (edgeOfRow L false i j) = edgeOfRow L true (i - 1) j := by
  rw [show edgeOfRow L false i j = edgeEquiv L (Sum.inl (i, j)) from rfl]
  change edgeEquiv L ((dualEdgeCoordinatesEquiv L).symm ((edgeEquiv L).symm
    (edgeEquiv L (Sum.inl (i, j))))) = _
  rw [(edgeEquiv L).symm_apply_apply]
  rfl

@[simp] lemma dualEdgeEquiv_symm_vertical (L : ℕ) [NeZero L] (i j : ZMod L) :
    (dualEdgeEquiv L).symm (edgeOfRow L true i j) = edgeOfRow L false i (j - 1) := by
  rw [show edgeOfRow L true i j = edgeEquiv L (Sum.inr (i, j)) from rfl]
  change edgeEquiv L ((dualEdgeCoordinatesEquiv L).symm ((edgeEquiv L).symm
    (edgeEquiv L (Sum.inr (i, j))))) = _
  rw [(edgeEquiv L).symm_apply_apply]
  rfl

@[simp] lemma edgeEquiv_inl_pair (L : ℕ) [NeZero L] (p : ZMod L × ZMod L) :
    edgeEquiv L (Sum.inl p) = edgeOfRow L false p.1 p.2 := by rcases p; rfl

@[simp] lemma edgeEquiv_inr_pair (L : ℕ) [NeZero L] (p : ZMod L × ZMod L) :
    edgeEquiv L (Sum.inr p) = edgeOfRow L true p.1 p.2 := by rcases p; rfl

@[simp] lemma mem_dualBrokenEdgeSet_iff (L : ℕ) [NeZero L] (sigma : Config L)
    (e : Edge L) :
    e ∈ dualBrokenEdgeSet L sigma ↔
      (dualEdgeEquiv L).symm e ∈ brokenEdgeSet L sigma := by
  classical
  rw [dualBrokenEdgeSet, Finset.mem_image]
  constructor
  · rintro ⟨a, ha, rfl⟩
    simpa using ha
  · intro he
    exact ⟨(dualEdgeEquiv L).symm e, he, (dualEdgeEquiv L).apply_symm_apply e⟩

lemma dualBrokenEdgeSet_incidenceCount (L : ℕ) [NeZero L] (sigma : Config L)
    (i j : ZMod L) :
    edgeSubsetIncidenceCount L (dualBrokenEdgeSet L sigma) (i, j) =
      (if edgeOfRow L true (i - 1) j ∈ brokenEdgeSet L sigma then 1 else 0) +
      (if edgeOfRow L false i (j - 1) ∈ brokenEdgeSet L sigma then 1 else 0) +
      (if edgeOfRow L true (i - 1) (j - 1) ∈ brokenEdgeSet L sigma then 1 else 0) +
      (if edgeOfRow L false (i - 1) (j - 1) ∈ brokenEdgeSet L sigma then 1 else 0) := by
  classical
  rw [edgeSubsetIncidenceCount]
  rw [show dualBrokenEdgeSet L sigma =
      (Finset.univ.filter fun e : Edge L => e ∈ dualBrokenEdgeSet L sigma) by ext; simp]
  rw [Finset.sum_filter]
  change (∑ e : Edge L, if e ∈ dualBrokenEdgeSet L sigma then
    ((if boundary0 L e = (i, j) then 1 else 0) +
      (if boundary1 L e = (i, j) then 1 else 0)) else 0) = _
  rw [← Fintype.sum_equiv (edgeEquiv L)
    (fun w => if edgeEquiv L w ∈ dualBrokenEdgeSet L sigma then
      ((if boundary0 L (edgeEquiv L w) = (i, j) then 1 else 0) +
        (if boundary1 L (edgeEquiv L w) = (i, j) then 1 else 0)) else 0)
    (fun e => if e ∈ dualBrokenEdgeSet L sigma then
      ((if boundary0 L e = (i, j) then 1 else 0) +
        (if boundary1 L e = (i, j) then 1 else 0)) else 0) (fun _ => rfl)]
  simp only [Fintype.sum_sum_type, edgeEquiv_inl_pair, edgeEquiv_inr_pair,
    edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal,
    edgeOfRow_boundary1_vertical, mem_dualBrokenEdgeSet_iff,
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

lemma spinValue_square (s : SpinValue) : s.1 * s.1 = 1 := by
  rcases s with ⟨s, rfl | rfl⟩ <;> norm_num

lemma spinValue_mul_of_ne (s t : SpinValue) (h : s ≠ t) : s.1 * t.1 = -1 := by
  rcases s with ⟨s, rfl | rfl⟩ <;> rcases t with ⟨t, rfl | rfl⟩
  · exact (h rfl).elim
  · norm_num
  · norm_num
  · exact (h rfl).elim

lemma brokenEdge_sign (L : ℕ) [NeZero L] (sigma : Config L) (e : Edge L) :
    (if e ∈ brokenEdgeSet L sigma then (-1 : ℤ) else 1) =
      (sigma (boundary0 L e)).1 * (sigma (boundary1 L e)).1 := by
  simp only [brokenEdgeSet, Finset.mem_filter, Finset.mem_univ, true_and]
  by_cases h : sigma (boundary0 L e) = sigma (boundary1 L e)
  · rw [if_neg (not_not.mpr h), h]
    exact (spinValue_square _).symm
  · rw [if_pos h]
    exact (spinValue_mul_of_ne _ _ h).symm

/-- 本文の準備式：破れ指示子を指数とする符号は辺の両端のスピン積。 -/
lemma brokenEdge_pow_sign (L : ℕ) [NeZero L] (sigma : Config L) (e : Edge L) :
    (-1 : ℤ) ^ (if e ∈ brokenEdgeSet L sigma then 1 else 0 : ℕ) =
      (sigma (boundary0 L e)).1 * (sigma (boundary1 L e)).1 := by
  classical
  calc
    _ = (if e ∈ brokenEdgeSet L sigma then (-1 : ℤ) else 1) := by
      split_ifs <;> norm_num
    _ = _ := brokenEdge_sign L sigma e

/-- 本文の指数代入から四つの平方の積までを、整数上で順に計算する。 -/
lemma dualBrokenEdgeSet_incidence_pow (L : ℕ) [NeZero L] (sigma : Config L)
    (i j : ZMod L) :
    (-1 : ℤ) ^ edgeSubsetIncidenceCount L (dualBrokenEdgeSet L sigma) (i, j) = 1 := by
  classical
  let e₁ := edgeOfRow L true (i - 1) j
  let e₂ := edgeOfRow L false i (j - 1)
  let e₃ := edgeOfRow L true (i - 1) (j - 1)
  let e₄ := edgeOfRow L false (i - 1) (j - 1)
  let q (e : Edge L) : ℕ := if e ∈ brokenEdgeSet L sigma then 1 else 0
  let s₀ := (sigma (i - 1, j - 1)).1
  let s₁ := (sigma (i - 1, j)).1
  let s₂ := (sigma (i, j)).1
  let s₃ := (sigma (i, j - 1)).1
  calc
    _ = (-1 : ℤ) ^ (q e₁ + q e₂ + q e₃ + q e₄) := by
      rw [dualBrokenEdgeSet_incidenceCount]
    _ = (-1 : ℤ) ^ q e₁ * (-1 : ℤ) ^ q e₂ *
        (-1 : ℤ) ^ q e₃ * (-1 : ℤ) ^ q e₄ := by
      rw [pow_add, pow_add, pow_add]
    _ = ((sigma (boundary0 L e₁)).1 * (sigma (boundary1 L e₁)).1) *
        ((sigma (boundary0 L e₂)).1 * (sigma (boundary1 L e₂)).1) *
        ((sigma (boundary0 L e₃)).1 * (sigma (boundary1 L e₃)).1) *
        ((sigma (boundary0 L e₄)).1 * (sigma (boundary1 L e₄)).1) := by
      rw [brokenEdge_pow_sign, brokenEdge_pow_sign, brokenEdge_pow_sign,
        brokenEdge_pow_sign]
    _ = (s₁ * s₂) * (s₃ * s₂) * (s₀ * s₃) * (s₀ * s₁) := by
      simp only [e₁, e₂, e₃, e₄, s₀, s₁, s₂, s₃, edgeOfRow_boundary0,
        edgeOfRow_boundary1_horizontal, edgeOfRow_boundary1_vertical, sub_add_cancel]
    _ = (s₀ * s₀) * (s₁ * s₁) * (s₂ * s₂) * (s₃ * s₃) := by ac_rfl
    _ = 1 * 1 * 1 * 1 := by
      rw [spinValue_square, spinValue_square, spinValue_square, spinValue_square]
    _ = 1 := by norm_num

/-- `claim_dual_broken_edges_even` の具体版。必要十分版を呼ばず本文を検証する。 -/
theorem dualBrokenEdgeSet_isEven (L : ℕ) [NeZero L] (sigma : Config L) :
    IsEvenEdgeSubset L (dualBrokenEdgeSet L sigma) := by
  rintro ⟨i, j⟩
  -- 本文末尾の自然数の偶奇：(-1)^d = 1 と d の偶数性は同値。
  exact (neg_one_pow_eq_one_iff_even (by norm_num : (-1 : ℤ) ≠ 1)).mp
    (dualBrokenEdgeSet_incidence_pow L sigma i j)

end Ising2DLambda.FisherZero
