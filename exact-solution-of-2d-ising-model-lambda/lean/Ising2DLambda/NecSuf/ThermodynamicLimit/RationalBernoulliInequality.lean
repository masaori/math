/-
「有理数の Bernoulli 不等式」の必要十分版。ℚ を外し、証明手順（n についての帰納法、
0 ≤ n h² の挿入、分配則、帰納法の仮定に 0 ≤ 1+h を掛ける、冪の定義）はそのまま、
必要なのは可換半環と順序（加法単調性・非負元の乗法単調性・平方の非負性）だけである。
体（除法）は使わない。乗法の可換性は分配則の並べ替え（`ring`）に使う。
-/
import Mathlib.Algebra.Order.Ring.Defs
import Mathlib.Data.Nat.Cast.Order.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 順序可換半環上の Bernoulli 不等式。 -/
theorem one_add_nsmul_le_one_add_pow_necSuf
    {K : Type*} [CommSemiring K] [PartialOrder K] [IsOrderedRing K]
    (h : K) (hh : 0 ≤ h) (n : ℕ) :
    1 + (n : K) * h ≤ (1 + h) ^ n := by
  induction n with
  | zero => simp
  | succ n ih =>
    have h1 : (0 : K) ≤ 1 + h := add_nonneg zero_le_one hh
    have hsq : (0 : K) ≤ (n : K) * (h * h) := mul_nonneg (Nat.cast_nonneg n) (mul_nonneg hh hh)
    calc
      1 + ((n + 1 : ℕ) : K) * h
          ≤ 1 + ((n + 1 : ℕ) : K) * h + (n : K) * (h * h) := le_add_of_nonneg_right hsq
      _ = (1 + (n : K) * h) * (1 + h) := by push_cast; ring
      _ ≤ (1 + h) ^ n * (1 + h) := mul_le_mul_of_nonneg_right ih h1
      _ = (1 + h) ^ (n + 1) := (pow_succ (1 + h) n).symm

end Ising2DLambda.NecSuf.ThermodynamicLimit
