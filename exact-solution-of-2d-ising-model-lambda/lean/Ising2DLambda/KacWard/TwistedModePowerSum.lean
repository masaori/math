import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSumValue
import Ising2DLambda.KacWard.HorizontalTwistedModesCoset
import Ising2DLambda.KacWard.VerticalTwistedModesCoset
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

/-- 本文の冪和の証明の一方向分。境界符号が 1 なら冪根集合の上の乗法の全単射で、
-1 なら剰余類の表示 `hcoset` と乗法の単射で再添字付けする。 -/
theorem twistedModes_powerSum_of_coset {L : ℕ} (hL : 1 ≤ L)
    [Fintype (RootOfUnity L)] (U : Set Qbar) [Fintype U] (b : Bool) {ξ : Qbar}
    (hmem : ∀ z : Qbar, z ∈ U ↔ z ^ L = if b then -1 else 1)
    (hcoset : b = true → U = (fun y : Qbar => ξ * y) '' RootOfUnity L)
    (hξ : ξ ^ L = if b then -1 else 1) (k : ℕ) :
    (∑ z : U, z.1 ^ k) =
      ξ ^ k * (if L ∣ k then algebraMap ℚ Qbar (L : ℚ) else 0) := by
  classical
  cases b with
  | false =>
    have hξ1 : ξ ^ L = 1 := by simpa using hξ
    let e : U ≃ {z : Qbar // z ^ L = 1} :=
      Equiv.subtypeEquivRight (fun z => by simpa using hmem z)
    letI : Fintype {z : Qbar // z ^ L = 1} :=
      Fintype.ofEquiv (RootOfUnity L) (twistedModeRootEquiv hL one_ne_zero hξ1)
    calc
      (∑ z : U, z.1 ^ k) = ∑ z : {z : Qbar // z ^ L = 1}, z.1 ^ k :=
        Fintype.sum_equiv e _ _ (fun _ => rfl)
      _ = ξ ^ k * (if L ∣ k then algebraMap ℚ Qbar (L : ℚ) else 0) :=
        twistedMode_powerSum hL one_ne_zero hξ1 k
  | true =>
    have hξm : ξ ^ L = -1 := by simpa using hξ
    have hξne : ξ ≠ 0 := by
      intro hzero
      rw [hzero, zero_pow (Nat.ne_of_gt hL)] at hξm
      norm_num at hξm
    have hinj : Function.Injective (fun y : Qbar => ξ * y) :=
      fun y y' h => mul_left_cancel₀ hξne h
    let e : RootOfUnity L ≃ U :=
      (Equiv.Set.image (fun y : Qbar => ξ * y) (RootOfUnity L) hinj).trans
        (Equiv.setCongr (hcoset rfl).symm)
    calc
      (∑ z : U, z.1 ^ k) = ∑ y : RootOfUnity L, (ξ * y.1) ^ k :=
        (Fintype.sum_equiv e _ _ (fun _ => rfl)).symm
      _ = ∑ y : RootOfUnity L, ξ ^ k * y.1 ^ k := by
        apply Finset.sum_congr rfl
        intro y _
        rw [mul_pow]
      _ = ξ ^ k * (∑ y : RootOfUnity L, y.1 ^ k) := by rw [Finset.mul_sum]
      _ = ξ ^ k * (if L ∣ k then algebraMap ℚ Qbar (L : ℚ) else 0) := by
        change ξ ^ k * powerSum L k = _
        rw [powerSumValue hL k]
        rfl

/-- `claim_twisted_mode_power_sum` の横方向。`ξ` は本文の `ξ_a` である。 -/
theorem horizontalTwistedModes_powerSum {L : ℕ} (hL : 1 ≤ L)
    [Fintype (RootOfUnity L)] (s : SpinStructure)
    [Fintype (horizontalTwistedModes L s)] {ξ : Qbar}
    (hξ : ξ ^ L = if s.1 then -1 else 1) (k : ℕ) :
    (∑ z : horizontalTwistedModes L s, z.1 ^ k) =
      ξ ^ k * (if L ∣ k then algebraMap ℚ Qbar (L : ℚ) else 0) := by
  refine twistedModes_powerSum_of_coset hL (horizontalTwistedModes L s) s.1
    (fun z => Iff.rfl) (fun hs => ?_) hξ k
  have hset : horizontalTwistedModes L s = horizontalTwistedModes L (true, false) := by
    ext z
    simp [horizontalTwistedModes, hs]
  rw [hset]
  exact (horizontalTwistedModes_eq_coset L ξ (by simpa [hs] using hξ)).2

/-- `claim_twisted_mode_power_sum` の縦方向。`ξ` は本文の `η_b` である。 -/
theorem verticalTwistedModes_powerSum {L : ℕ} (hL : 1 ≤ L)
    [Fintype (RootOfUnity L)] (s : SpinStructure)
    [Fintype (verticalTwistedModes L s)] {ξ : Qbar}
    (hξ : ξ ^ L = if s.2 then -1 else 1) (k : ℕ) :
    (∑ z : verticalTwistedModes L s, z.1 ^ k) =
      ξ ^ k * (if L ∣ k then algebraMap ℚ Qbar (L : ℚ) else 0) := by
  refine twistedModes_powerSum_of_coset hL (verticalTwistedModes L s) s.2
    (fun z => Iff.rfl) (fun hs => ?_) hξ k
  have hset : verticalTwistedModes L s = verticalTwistedModes L (false, true) := by
    ext z
    simp [verticalTwistedModes, hs]
  rw [hset]
  exact (verticalTwistedModes_eq_coset L ξ (by simpa [hs] using hξ)).2

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
      -- 本文の横モード和の二行目: `claim_twisted_mode_power_sum`。
      congr 1
      convert twistedMode_powerSum hL hσ hξ k using 2
      congr 1
      exact Subsingleton.elim _ _
    _ = if i = j then (L : Qbar) else 0 := by
      simp only [hdiv]
      by_cases heq : i = j
      · subst j
        have hk_eq : k = L := by omega
        simp [hk_eq, hξ, hσ]
      · simp [heq]

end Ising2DLambda.KacWard
