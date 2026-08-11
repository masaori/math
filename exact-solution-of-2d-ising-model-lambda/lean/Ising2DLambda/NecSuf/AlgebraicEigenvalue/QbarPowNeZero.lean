/-
「零でない代数的数の冪は零でない」の必要十分版。具体版と同じ帰納法で示す。

必要なのは、冪の零乗が zero でないこと、冪の再帰式、および零でない左因子を
消去できることだけである。積の結合則・可換性・単位元・分配則・体・代数閉性は使わない。
住処: ここに ℝ / ℂ は現れない。
-/
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 零でない元の反復積は零でないための必要十分な手順。 -/
theorem pow_ne_zero_necSuf {M : Type*}
    (mul : M → M → M) (pow : M → ℕ → M) (zero : M)
    (hpow_zero : ∀ z : M, pow z 0 ≠ zero)
    (hpow_succ : ∀ (z : M) (k : ℕ), pow z (k + 1) = mul (pow z k) z)
    (hcancel : ∀ a b : M, a ≠ zero → mul a b = zero → b = zero)
    (w : M) (hw : w ≠ zero) : ∀ n : ℕ, pow w n ≠ zero := by
  intro n
  induction n with
  | zero => exact hpow_zero w
  | succ k ih =>
      intro hzero
      apply hw
      apply hcancel (pow w k) w ih
      calc
        mul (pow w k) w = pow w (k + 1) := (hpow_succ w k).symm
        _ = zero := hzero

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
