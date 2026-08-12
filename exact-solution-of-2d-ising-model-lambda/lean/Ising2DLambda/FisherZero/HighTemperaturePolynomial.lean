/-
「高温展開の多項式恒等式」の具体版。
人手証明と同じく、一辺の二項表示を全辺へ掛けた有限和を二通りに計算する。
住処は有限集合、ℤ、ℤ[x] であり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.FisherZero.EvenSubgraphSpinSum
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

/-- 偶部分グラフだけにわたる高温展開の整数多項式 `H_L`。 -/
noncomputable def highTemperaturePolynomial (L : ℕ) [NeZero L] : Polynomial ℤ := by
  classical
  exact ∑ A ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
    ((1 : Polynomial ℤ) + Polynomial.X) ^ (2 * L ^ 2 - A.card) *
      ((1 : Polynomial ℤ) - Polynomial.X) ^ A.card

/-- 人手証明の一辺の二項表示。 -/
noncomputable def highTemperatureEdgeWeight (L : ℕ) (σ : Config L) (e : Edge L) : Polynomial ℤ :=
  ((1 : Polynomial ℤ) + Polynomial.X) +
    ((1 : Polynomial ℤ) - Polynomial.X) *
      Polynomial.C ((σ (boundary0 L e)).1 * (σ (boundary1 L e)).1)

lemma highTemperatureEdgeWeight_eq (L : ℕ) (σ : Config L) (e : Edge L) :
    highTemperatureEdgeWeight L σ e =
      if σ (boundary0 L e) = σ (boundary1 L e) then 2 else 2 * Polynomial.X := by
  by_cases heq : σ (boundary0 L e) = σ (boundary1 L e)
  · rw [if_pos heq]
    unfold highTemperatureEdgeWeight
    rw [heq]
    rcases (σ (boundary1 L e)).property with h | h <;>
      simp [h] <;> ring
  · rw [if_neg heq]
    rcases (σ (boundary0 L e)).property with h0 | h0 <;>
      rcases (σ (boundary1 L e)).property with h1 | h1
    · exfalso
      apply heq
      apply Subtype.ext
      omega
    · simp [highTemperatureEdgeWeight, h0, h1]
      ring
    · simp [highTemperatureEdgeWeight, h0, h1]
      ring
    · exfalso
      apply heq
      apply Subtype.ext
      omega

/-- 一辺表示を全辺へ掛けると `2^(2L²) x^b(σ)` になる。 -/
lemma highTemperatureEdgeWeight_prod (L : ℕ) [NeZero L] (σ : Config L) :
    ∏ e : Edge L, highTemperatureEdgeWeight L σ e =
      2 ^ (2 * L ^ 2) * Polynomial.X ^ brokenBondCount L σ := by
  classical
  simp_rw [highTemperatureEdgeWeight_eq]
  rw [Finset.prod_ite]
  simp only [Finset.prod_const]
  rw [mul_pow, ← mul_assoc, ← pow_add]
  have hcard := Finset.card_filter_add_card_filter_not
    (s := (univ : Finset (Edge L)))
    (fun e => σ (boundary0 L e) = σ (boundary1 L e))
  rw [hcard, Finset.card_univ, card_edge]
  rfl

/-- 全辺の二項展開。 -/
lemma highTemperatureEdgeWeight_expand (L : ℕ) [NeZero L] (σ : Config L) :
    ∏ e : Edge L, highTemperatureEdgeWeight L σ e =
      ∑ A : Finset (Edge L),
        ((1 : Polynomial ℤ) + Polynomial.X) ^ (2 * L ^ 2 - A.card) *
          ((1 : Polynomial ℤ) - Polynomial.X) ^ A.card *
            ∏ e ∈ A, Polynomial.C
              ((σ (boundary0 L e)).1 * (σ (boundary1 L e)).1) := by
  classical
  simp only [highTemperatureEdgeWeight]
  simp_rw [add_comm ((1 : Polynomial ℤ) + Polynomial.X)]
  rw [Fintype.prod_add]
  apply Finset.sum_congr rfl
  intro A _
  rw [Finset.prod_mul_distrib]
  simp only [Finset.prod_const, Finset.card_compl, card_edge]
  ring

lemma edgeSubsetSpinSum_C (L : ℕ) [NeZero L] (A : Finset (Edge L)) :
    (∑ σ : Config L,
      ∏ e ∈ A, Polynomial.C
        ((σ (boundary0 L e)).1 * (σ (boundary1 L e)).1)) =
      Polynomial.C (edgeSubsetSpinSum L A) := by
  rw [edgeSubsetSpinSum, map_sum]
  apply Finset.sum_congr rfl
  intro σ _
  rw [map_prod]

/-- 人手証明が二通りに計算する共通の有限和。 -/
noncomputable def highTemperatureCommonSum (L : ℕ) [NeZero L] : Polynomial ℤ :=
  ∑ σ : Config L, ∏ e : Edge L, highTemperatureEdgeWeight L σ e

lemma highTemperatureCommonSum_eq_partition (L : ℕ) [NeZero L] :
    highTemperatureCommonSum L = 2 ^ (2 * L ^ 2) * partitionPolynomial L := by
  rw [highTemperatureCommonSum, partitionPolynomial]
  simp_rw [highTemperatureEdgeWeight_prod]
  rw [← Finset.mul_sum]

lemma highTemperatureCommonSum_eq_highTemperature (L : ℕ) [NeZero L] :
    highTemperatureCommonSum L = 2 ^ (L ^ 2) * highTemperaturePolynomial L := by
  classical
  rw [highTemperatureCommonSum]
  simp_rw [highTemperatureEdgeWeight_expand]
  rw [Finset.sum_comm]
  simp_rw [← Finset.mul_sum]
  simp_rw [edgeSubsetSpinSum_C, evenSubgraph_spinSum]
  rw [highTemperaturePolynomial]
  simp_rw [apply_ite Polynomial.C, map_pow, map_ofNat, map_zero]
  simp only [mul_ite, mul_zero]
  rw [← Finset.sum_filter]
  rw [← Finset.sum_mul]
  rw [mul_comm]

/-- `claim_high_temperature_polynomial_identity` の具体版。 -/
theorem highTemperaturePolynomial_identity (L : ℕ) [NeZero L] :
    2 ^ (L ^ 2) * partitionPolynomial L = highTemperaturePolynomial L := by
  have hcommon :
      2 ^ (2 * L ^ 2) * partitionPolynomial L =
        2 ^ (L ^ 2) * highTemperaturePolynomial L :=
    (highTemperatureCommonSum_eq_partition L).symm.trans
      (highTemperatureCommonSum_eq_highTemperature L)
  have hpow : (2 : Polynomial ℤ) ^ (2 * L ^ 2) =
      2 ^ (L ^ 2) * 2 ^ (L ^ 2) := by
    rw [← pow_add]
    congr
    omega
  rw [hpow] at hcommon
  rw [mul_assoc] at hcommon
  exact mul_left_cancel₀
    (pow_ne_zero _ (Polynomial.C_ne_zero.mpr (by norm_num : (2 : ℤ) ≠ 0))) hcommon

end Ising2DLambda.FisherZero
