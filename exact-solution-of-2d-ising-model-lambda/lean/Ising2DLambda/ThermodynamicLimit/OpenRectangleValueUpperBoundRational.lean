/-
章「熱力学極限」の「開境界長方形の正の有理点での値の上からの評価」
（`claim_open_rectangle_value_upper_bound_at_positive_rational`）の具体版（人手証明と 1 対 1 に対応させる）。

`a, b ≥ 1`、`q ∈ ℚ_{>0}` について `Z^op_{a,b}(q) ≤ 2^{ab}·(1+q)^{2ab}`。
準備の第一〜第四は周期境界の `PartitionValueUpperBoundRational.lean` と同じ
（冪の正値性 `pow_pos_by_induction`、底の単調性 `pow_le_pow_of_pos_of_le_by_induction_rat`、
指数の単調性 `pow_le_pow_of_one_le_of_exp_le_by_induction_rat`、定数の有限和 `Finset.sum_const`）。
準備の第五: `b^op_{a,b}(σ) ≤ |E^op_{a,b}| = a(b-1)+(a-1)b ≤ 2ab`（`openBrokenBondCount_le` と ℕ の計算）。
式変形は人手証明と同じ五段:
  Z^op_{a,b}(q) = Σ_σ q^{b^op(σ)}              （代入は環準同型。`openPartitionValueRat_eq_sum`）
              ≤ Σ_σ (1+q)^{b^op(σ)}            （底を 1+q へ上げる。準備の第二）
              ≤ Σ_σ (1+q)^{2ab}                （指数を 2ab へ上げる。準備の第五と第三）
              = |Σ^op_{a,b}|·(1+q)^{2ab}        （定数の有限和。準備の第四）
              = 2^{ab}·(1+q)^{2ab}              （`card_openConfig`）
住処は ℕ・ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectanglePartitionValueRational
import Ising2DLambda.ThermodynamicLimit.PartitionValueUpperBoundRational

namespace Ising2DLambda.ThermodynamicLimit

open Finset

variable (a b : ℕ)

/-- 準備の第五: 開境界長方形の破れボンド数は辺数 `a(b-1)+(a-1)b` 以下で、辺数は `2ab` 以下。 -/
lemma openBrokenBondCount_le_two_mul (σ : OpenConfig a b) :
    openBrokenBondCount a b σ ≤ 2 * (a * b) := by
  have hedgeCap : a * (b - 1) + (a - 1) * b ≤ 2 * (a * b) := by
    have h₁ := Nat.mul_le_mul_left a (Nat.sub_le b 1)             -- a(b-1) ≤ ab
    have h₂ := Nat.mul_le_mul_right b (Nat.sub_le a 1)            -- (a-1)b ≤ ab
    calc
      a * (b - 1) + (a - 1) * b ≤ a * b + a * b := Nat.add_le_add h₁ h₂
      _ = 2 * (a * b) := (two_mul (a * b)).symm
  exact le_trans (openBrokenBondCount_le a b σ) hedgeCap

/-- `claim_open_rectangle_value_upper_bound_at_positive_rational`。人手証明の五段の鎖を同じ順序で辿る。 -/
theorem openPartitionValueRat_le_upperBound {q : ℚ} (hq : 0 < q) :
    openPartitionValueRat a b q ≤ ((2 ^ (a * b) : ℕ) : ℚ) * (1 + q) ^ (2 * (a * b)) := by
  have hqBase : q ≤ 1 + q := by linarith                          -- 0 < 1 を q へ足す
  have hOneBase : 1 ≤ 1 + q := by linarith                        -- 0 < q を 1 へ足す
  rw [openPartitionValueRat_eq_sum]                               -- 代入は環準同型
  calc
    ∑ σ : OpenConfig a b, q ^ openBrokenBondCount a b σ
        ≤ ∑ σ : OpenConfig a b, (1 + q) ^ openBrokenBondCount a b σ := by
          exact sum_le_sum fun σ _ =>
            pow_le_pow_of_pos_of_le_by_induction_rat hq hqBase _  -- 底を 1+q へ上げる
    _ ≤ ∑ _σ : OpenConfig a b, (1 + q) ^ (2 * (a * b)) := by
          exact sum_le_sum fun σ _ =>
            pow_le_pow_of_one_le_of_exp_le_by_induction_rat hOneBase
              (openBrokenBondCount_le_two_mul a b σ)              -- 指数を 2ab へ上げる
    _ = ((2 ^ (a * b) : ℕ) : ℚ) * (1 + q) ^ (2 * (a * b)) := by
          rw [sum_const, card_univ, card_openConfig, nsmul_eq_mul]  -- 定数の有限和・|Σ^op| = 2^{ab}

end Ising2DLambda.ThermodynamicLimit
