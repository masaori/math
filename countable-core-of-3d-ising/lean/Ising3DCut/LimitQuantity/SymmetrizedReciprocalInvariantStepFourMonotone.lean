/-
「回文性で対称化した素指数データは逆数で不変である」
（`claim_symmetrized_prime_exponent_data_is_reciprocal_invariant`）の Lean 具体版・第四歩の後半。

人手証明の「Z_L の係数は非負、最高次係数は正、次数 ≥ 1 なので Z_L は正の有理数上で
狭義単調増加」に対応する。多項式は係数列 `c : ℕ → ℚ` と次数 `n` で
`∑_{i≤n} c i * a^i` として与える（`Polynomial.eval` との橋渡しは束ねの段で行う）。
各項は `0<a<b` で `c i * a^i ≤ c i * b^i`（`pow_le_pow_left`）、最高次の項だけ真の不等号
（`pow_lt_pow_left`）、それを `Finset.sum_lt_sum` で束ねるだけ。
前半（狭義単調なら `Z_L(q) ≠ Z_L(1/q)`）は `SymmetrizedReciprocalInvariantStepFour.lean`。
-/
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Algebra.Order.Field.Rat
import Mathlib.Algebra.Order.Ring.Basic

namespace Ising3DCut.LimitQuantity

open Finset

/-- 第四歩の後半。非負係数・正の最高次係数・次数 `n ≥ 1` の多項式値
`∑_{i≤n} c i * a^i` は `(0,∞)` 上で狭義単調増加。 -/
theorem strictMono_sum_of_nonneg_coeff {c : ℕ → ℚ} {n : ℕ}
    (hc : ∀ i, 0 ≤ c i) (hn : 1 ≤ n) (hlead : 0 < c n)
    {a b : ℚ} (ha : 0 < a) (hab : a < b) :
    ∑ i ∈ range (n + 1), c i * a ^ i < ∑ i ∈ range (n + 1), c i * b ^ i := by
  apply Finset.sum_lt_sum
  · intro i _
    exact mul_le_mul_of_nonneg_left (pow_le_pow_left₀ ha.le hab.le i) (hc i)
  · refine ⟨n, Finset.mem_range.mpr (Nat.lt_succ_self n), ?_⟩
    have hn0 : n ≠ 0 := by omega
    exact mul_lt_mul_of_pos_left (pow_lt_pow_left₀ hab ha.le hn0) hlead

end Ising3DCut.LimitQuantity
