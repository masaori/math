import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSumValue
import Mathlib

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open BigOperators

/-- ねじれたモード集合を、一の冪根への非零スカラーの乗法で添字付けする。 -/
noncomputable def twistedModeRootEquiv {L : ℕ} {σ ξ : Qbar}
    (hL : 1 ≤ L) (hσ : σ ≠ 0) (hξ : ξ ^ L = σ) :
    RootOfUnity L ≃ {z : Qbar // z ^ L = σ} := by
  have hξne : ξ ≠ 0 := by
    intro hzero
    apply hσ
    rw [← hξ, hzero]
    simp [Nat.ne_of_gt hL]
  exact {
    toFun := fun y => ⟨ξ * y.1, by
      rw [mul_pow, hξ, y.property, mul_one]⟩
    invFun := fun z => ⟨ξ⁻¹ * z.1, by
      change (ξ⁻¹ * z.1) ^ L = 1
      rw [mul_pow, inv_pow, hξ, z.property]
      simp [hσ]⟩
    left_inv := by
      intro y
      apply Subtype.ext
      change ξ⁻¹ * (ξ * y.1) = y.1
      simp [hξne]
    right_inv := by
      intro z
      apply Subtype.ext
      change ξ * (ξ⁻¹ * z.1) = z.1
      simp [hξne]
  }

/-- 横・縦のねじれたモードに共通する冪和。σ は各方向の境界符号である。 -/
theorem twistedMode_powerSum {L : ℕ} (hL : 1 ≤ L)
    [Fintype (RootOfUnity L)] {σ ξ : Qbar} (hσ : σ ≠ 0)
    (hξ : ξ ^ L = σ) (k : ℕ) :
    (letI : Fintype {z : Qbar // z ^ L = σ} :=
      Fintype.ofEquiv (RootOfUnity L) (twistedModeRootEquiv hL hσ hξ)
     ∑ z : {z : Qbar // z ^ L = σ}, z.1 ^ k) =
      ξ ^ k * (if L ∣ k then algebraMap ℚ Qbar (L : ℚ) else 0) := by
  classical
  let e := twistedModeRootEquiv hL hσ hξ
  letI : Fintype {z : Qbar // z ^ L = σ} := Fintype.ofEquiv (RootOfUnity L) e
  change (∑ z : {z : Qbar // z ^ L = σ}, z.1 ^ k) = _
  calc
    (∑ z : {z : Qbar // z ^ L = σ}, z.1 ^ k)
        = ∑ y : RootOfUnity L, (ξ * y.1) ^ k := by
          exact (Fintype.sum_equiv e _ _ (fun _ => rfl)).symm
    _ = ∑ y : RootOfUnity L, ξ ^ k * y.1 ^ k := by
      apply Finset.sum_congr rfl
      intro y _
      rw [mul_pow]
    _ = ξ ^ k * (∑ y : RootOfUnity L, y.1 ^ k) := by rw [Finset.mul_sum]
    _ = ξ ^ k * (if L ∣ k then algebraMap ℚ Qbar (L : ℚ) else 0) := by
      change ξ ^ k * powerSum L k = _
      rw [powerSumValue hL k]
      rfl

/-- The twisted power sum evaluates a pair of target-coordinate monomials. -/
theorem twistedMode_coordinateKernel {L : ℕ} (hL : 1 ≤ L)
    [Fintype (RootOfUnity L)] {σ ξ : Qbar}
    [Fintype {z : Qbar // z ^ L = σ}] (hσ : σ ≠ 0)
    (hξ : ξ ^ L = σ) (i j : ℕ) (hi : i < L) (hj : j < L) :
    (∑ z : {z : Qbar // z ^ L = σ}, z.1 ^ i * (z.1⁻¹) ^ j) =
      if i = j then (L : Qbar) else 0 := by
  classical
  let k := i + L - j
  have hjle : j ≤ i + L := by omega
  have hkadd : k + j = i + L := Nat.sub_add_cancel hjle
  have hterm (z : {z : Qbar // z ^ L = σ}) :
      z.1 ^ i * (z.1⁻¹) ^ j = σ⁻¹ * z.1 ^ k := by
    have hz0 : z.1 ≠ 0 := by
      intro hzero
      apply hσ
      rw [← z.property, hzero]
      simp [Nat.ne_of_gt hL]
    apply (mul_right_cancel₀ (pow_ne_zero j hz0))
    have hright : (σ⁻¹ * z.1 ^ k) * z.1 ^ j = z.1 ^ i := by
      calc
        (σ⁻¹ * z.1 ^ k) * z.1 ^ j = σ⁻¹ * z.1 ^ (k + j) := by
          rw [mul_assoc, pow_add]
        _ = σ⁻¹ * z.1 ^ (i + L) := by rw [hkadd]
        _ = σ⁻¹ * (z.1 ^ i * σ) := by rw [pow_add, z.property]
        _ = z.1 ^ i := by field_simp
    calc
      (z.1 ^ i * (z.1⁻¹) ^ j) * z.1 ^ j = z.1 ^ i := by
        rw [inv_pow]
        simp [hz0]
      _ = (σ⁻¹ * z.1 ^ k) * z.1 ^ j := hright.symm
  have hdiv : L ∣ k ↔ i = j := by
    constructor
    · intro hd
      have hkpos : 0 < k := by dsimp [k]; omega
      have hklt : k < 2 * L := by dsimp [k]; omega
      have hk_eq : k = L := by
        by_contra hne
        rcases lt_or_gt_of_ne hne with hsmall | hlarge
        · exact (Nat.not_dvd_of_pos_of_lt hkpos hsmall) hd
        · have hdsub : L ∣ k - L := (Nat.dvd_sub_self_right).2 (Or.inl hd)
          exact (Nat.not_dvd_of_pos_of_lt (by omega) (by omega)) hdsub
      omega
    · intro heq
      subst j
      have hk_eq : k = L := by omega
      rw [hk_eq]
  calc
    (∑ z : {z : Qbar // z ^ L = σ}, z.1 ^ i * (z.1⁻¹) ^ j)
        = ∑ z : {z : Qbar // z ^ L = σ}, σ⁻¹ * z.1 ^ k := by
          apply Finset.sum_congr rfl
          intro z _
          exact hterm z
    _ = σ⁻¹ * (∑ z : {z : Qbar // z ^ L = σ}, z.1 ^ k) := by
      rw [Finset.mul_sum]
    _ = σ⁻¹ * (ξ ^ k * (if L ∣ k then algebraMap ℚ Qbar (L : ℚ) else 0)) := by
      rw [← Fintype.sum_equiv (twistedModeRootEquiv hL hσ hξ)
        (fun z : RootOfUnity L => (ξ * z.1) ^ k)
        (fun z : {z : Qbar // z ^ L = σ} => z.1 ^ k) (fun _ => rfl)]
      simp_rw [mul_pow]
      rw [← Finset.mul_sum]
      change σ⁻¹ * (ξ ^ k * powerSum L k) = _
      rw [powerSumValue hL k]
      rfl
    _ = if i = j then (L : Qbar) else 0 := by
      simp only [hdiv]
      by_cases heq : i = j
      · subst j
        have hk_eq : k = L := by omega
        simp [hk_eq, hξ, hσ]
      · simp [heq]

end Ising2DLambda.KacWard
