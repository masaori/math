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

end Ising2DLambda.KacWard
