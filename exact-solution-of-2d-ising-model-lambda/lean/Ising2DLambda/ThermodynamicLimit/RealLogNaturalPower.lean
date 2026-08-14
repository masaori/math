/-
人手証明「実対数の自然数冪」の具体版。

冪の正値性を定義域の証拠として保持し、指数についての帰納法を本文の
基底四段・歩み七段と同じ順で辿る。狭義単調性・完備性・極限は使わない。
-/
import Ising2DLambda.ThermodynamicLimit.FiniteRealFreeEntropy

namespace Ising2DLambda.ThermodynamicLimit

/-- `claim_real_log_natural_power`。人手証明の帰納法と一対一に対応する。 -/
theorem realLogarithm_naturalPower (u : StrictlyPositiveReal) :
    ∀ n : ℕ,
      realLogarithm ⟨u.1 ^ n, pow_pos u.2 n⟩ = (n : ℝ) * realLogarithm u
  | 0 => by
      calc
        realLogarithm ⟨u.1 ^ 0, pow_pos u.2 0⟩ = realLogarithm ⟨1, zero_lt_one⟩ := by
          congr 1
        _ = 0 := realLogarithm_one
        _ = 0 * realLogarithm u := (zero_mul _).symm
        _ = ((0 : ℕ) : ℝ) * realLogarithm u := by rw [Nat.cast_zero]
  | k + 1 => by
      calc
        realLogarithm ⟨u.1 ^ (k + 1), pow_pos u.2 (k + 1)⟩ =
            realLogarithm ⟨(u.1 ^ k) * u.1, mul_pos (pow_pos u.2 k) u.2⟩ := by
              congr 1
        _ = realLogarithm ⟨u.1 ^ k, pow_pos u.2 k⟩ + realLogarithm u :=
          realLogarithm_mul ⟨u.1 ^ k, pow_pos u.2 k⟩ u
        _ = (k : ℝ) * realLogarithm u + realLogarithm u := by
          rw [realLogarithm_naturalPower u k]
        _ = (k : ℝ) * realLogarithm u + 1 * realLogarithm u := by rw [one_mul]
        _ = ((k : ℝ) + 1) * realLogarithm u := (add_mul _ _ _).symm
        _ = ((k : ℝ) + ((1 : ℕ) : ℝ)) * realLogarithm u := by rw [Nat.cast_one]
        _ = ((k + 1 : ℕ) : ℝ) * realLogarithm u := by rw [Nat.cast_add]

end Ising2DLambda.ThermodynamicLimit
