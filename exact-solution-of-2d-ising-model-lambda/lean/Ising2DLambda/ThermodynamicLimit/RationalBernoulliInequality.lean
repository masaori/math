/-
章「熱力学極限」の「有理数の Bernoulli 不等式」（`claim_rational_bernoulli_inequality`）の
具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                                    このファイル
  h ∈ ℚ, 0 ≤ h, n ∈ ℕ について 1 + n h ≤ (1+h)^n               `one_add_nsmul_le_one_add_pow_rat`
  n についての帰納法。
    n = 0: 1 + 0·h = 1 = (1+h)^0                              `Nat.zero` の場
    n → n+1:
      1+(n+1)h ≤ 1+(n+1)h + n h²   (0 ≤ n h²)                  第 1 段
               = (1+nh)(1+h)       (ℚ の分配則)                第 2 段
               ≤ (1+h)^n (1+h)     (帰納法の仮定・0 ≤ 1+h)      第 3 段
               = (1+h)^{n+1}       (ℚ の冪の定義)              第 4 段

住処は ℕ・ℚ のみで、ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

namespace Ising2DLambda.ThermodynamicLimit

/-- `claim_rational_bernoulli_inequality`。`0 ≤ h` なる有理数 `h` と自然数 `n` について
`1 + n·h ≤ (1+h)^n`。 -/
theorem one_add_nsmul_le_one_add_pow_rat (h : ℚ) (hh : 0 ≤ h) (n : ℕ) :
    1 + (n : ℚ) * h ≤ (1 + h) ^ n := by
  induction n with
  | zero =>
    -- n = 0: 1 + 0·h = 1 = (1+h)^0
    simp
  | succ n ih =>
    have h1 : (0 : ℚ) ≤ 1 + h := by linarith
    have hsq : (0 : ℚ) ≤ (n : ℚ) * (h * h) := by positivity
    calc
      1 + ((n + 1 : ℕ) : ℚ) * h
          ≤ 1 + ((n + 1 : ℕ) : ℚ) * h + (n : ℚ) * (h * h) := by linarith   -- 0 ≤ n h²
      _ = (1 + (n : ℚ) * h) * (1 + h) := by push_cast; ring                -- ℚ の分配則
      _ ≤ (1 + h) ^ n * (1 + h) := mul_le_mul_of_nonneg_right ih h1         -- 帰納法の仮定
      _ = (1 + h) ^ (n + 1) := (pow_succ (1 + h) n).symm                     -- ℚ の冪の定義

end Ising2DLambda.ThermodynamicLimit
