/-
「零でない代数的数の冪は零でない」の具体版。人手証明と 1 対 1 に対応させる。

  人手証明                                      このファイル
  出発点 w^0 = 1 ≠ 0                           `pow_zero` と `one_ne_zero`
  帰納法の一歩で w^k * w = w^(k+1) = 0         `pow_succ` と仮定
  w^k ≠ 0 から w = 0                           `qbarNoZeroDivisors`
  w ≠ 0 との矛盾                                `hw`

mathlib の `pow_ne_zero` へは委ねない。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 零でない代数的数の自然数冪は零でない（`claim_qbar_pow_ne_zero`）。 -/
theorem qbarPowNeZero (w : Qbar) (hw : w ≠ 0) : ∀ n : ℕ, w ^ n ≠ 0 := by
  intro n
  induction n with
  | zero =>
      calc
        w ^ 0 = 1 := pow_zero w
        _ ≠ 0 := one_ne_zero
  | succ k ih =>
      intro hzero
      apply hw
      apply qbarNoZeroDivisors ih
      calc
        w ^ k * w = w ^ (k + 1) := (pow_succ w k).symm
        _ = 0 := hzero

end Ising2DLambda.AlgebraicEigenvalue
