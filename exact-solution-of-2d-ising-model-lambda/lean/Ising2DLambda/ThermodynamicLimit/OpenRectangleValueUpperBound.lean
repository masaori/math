/-
人手証明「開境界長方形の値の配位数による上からの評価」の具体版。
各項を一様に上から評価し、配位数 `2^(a*b)` 個の定数和へまとめる。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleValueAtLeastOne
import Ising2DLambda.ThermodynamicLimit.PartitionValueUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open Finset

/-- `claim_open_rectangle_value_upper_bound_le_one` の具体版。 -/
theorem openPartitionValue_le_configurationCount_of_le_one
    (a b : ℕ) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    openPartitionValue a b t ≤ ((2 ^ (a * b) : ℕ) : ℝ) := by
  rw [openPartitionValue_eq_sum]
  calc
    ∑ σ : OpenConfig a b, t ^ openBrokenBondCount a b σ
        ≤ ∑ _σ : OpenConfig a b, (1 : ℝ) := by
          exact sum_le_sum fun σ _ => pow_le_one₀ ht0.le ht1
    _ = ((2 ^ (a * b) : ℕ) : ℝ) := by
          rw [sum_const, card_univ, card_openConfig, nsmul_eq_mul]
          norm_num

/-- `claim_open_rectangle_value_upper_bound_one_le` の具体版。 -/
theorem openPartitionValue_le_configurationCount_mul_power_of_one_le
    (a b : ℕ) {t : ℝ} (ht : 1 ≤ t) :
    openPartitionValue a b t ≤ ((2 ^ (a * b) : ℕ) : ℝ) * t ^ (2 * a * b) := by
  have hedgeCap : a * (b - 1) + (a - 1) * b ≤ 2 * a * b := by
    have h₁ := Nat.mul_le_mul_left a (Nat.sub_le b 1)
    have h₂ := Nat.mul_le_mul_right b (Nat.sub_le a 1)
    calc
      a * (b - 1) + (a - 1) * b ≤ a * b + a * b := Nat.add_le_add h₁ h₂
      _ = 2 * a * b := by simp [two_mul, Nat.add_mul]
  rw [openPartitionValue_eq_sum]
  calc
    ∑ σ : OpenConfig a b, t ^ openBrokenBondCount a b σ
        ≤ ∑ _σ : OpenConfig a b, t ^ (2 * a * b) := by
          exact sum_le_sum fun σ _ =>
            pow_le_pow_of_one_le_of_exp_le_by_induction ht
              (le_trans (openBrokenBondCount_le a b σ) hedgeCap)
    _ = ((2 ^ (a * b) : ℕ) : ℝ) * t ^ (2 * a * b) := by
          rw [sum_const, card_univ, card_openConfig, nsmul_eq_mul]

end Ising2DLambda.ThermodynamicLimit
