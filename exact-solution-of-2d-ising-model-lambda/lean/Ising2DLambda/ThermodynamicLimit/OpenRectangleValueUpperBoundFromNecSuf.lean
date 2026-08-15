/-
「開境界長方形の値の配位数による上からの評価」の具体版が、既存の必要十分版
`sum_pow_le_uniform_bound_necSuf` の特殊化として得られることを明示する。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleValueUpperBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.PartitionValueUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open Finset

/-- `0<t≤1` の具体版を、各項を一様上界へ送る必要十分版から導く。 -/
theorem openPartitionValue_le_configurationCount_of_le_one_from_necSuf
    (a b : ℕ) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    openPartitionValue a b t ≤ ((2 ^ (a * b) : ℕ) : ℝ) := by
  rw [openPartitionValue_eq_sum]
  have h := NecSuf.ThermodynamicLimit.sum_pow_le_uniform_bound_necSuf
    (ι := OpenConfig a b) t (1 : ℝ) (openBrokenBondCount a b) 0
    (fun k => by simpa using pow_le_one₀ ht0.le ht1 (n := k))
    (fun _σ => by simp)
  calc
    ∑ σ : OpenConfig a b, t ^ openBrokenBondCount a b σ
        ≤ ∑ _σ : OpenConfig a b, (1 : ℝ) ^ 0 := h
    _ = ((2 ^ (a * b) : ℕ) : ℝ) := by
          rw [pow_zero, sum_const, card_univ, card_openConfig, nsmul_eq_mul]
          norm_num

/-- `1≤t` の具体版を、指数の一様上界を使う必要十分版から導く。 -/
theorem openPartitionValue_le_configurationCount_mul_power_of_one_le_from_necSuf
    (a b : ℕ) {t : ℝ} (ht : 1 ≤ t) :
    openPartitionValue a b t ≤ ((2 ^ (a * b) : ℕ) : ℝ) * t ^ (2 * a * b) := by
  have hedgeCap : a * (b - 1) + (a - 1) * b ≤ 2 * a * b := by
    have h₁ := Nat.mul_le_mul_left a (Nat.sub_le b 1)
    have h₂ := Nat.mul_le_mul_right b (Nat.sub_le a 1)
    calc
      a * (b - 1) + (a - 1) * b ≤ a * b + a * b := Nat.add_le_add h₁ h₂
      _ = 2 * a * b := by simp [two_mul, Nat.add_mul]
  rw [openPartitionValue_eq_sum]
  have h := NecSuf.ThermodynamicLimit.sum_pow_le_uniform_bound_necSuf
    (ι := OpenConfig a b) t t (openBrokenBondCount a b) (2 * a * b)
    (fun _k => le_rfl)
    (fun σ => pow_le_pow_of_one_le_of_exp_le_by_induction ht
      (le_trans (openBrokenBondCount_le a b σ) hedgeCap))
  calc
    ∑ σ : OpenConfig a b, t ^ openBrokenBondCount a b σ
        ≤ ∑ _σ : OpenConfig a b, t ^ (2 * a * b) := h
    _ = ((2 ^ (a * b) : ℕ) : ℝ) * t ^ (2 * a * b) := by
          rw [sum_const, card_univ, card_openConfig, nsmul_eq_mul]

end Ising2DLambda.ThermodynamicLimit
