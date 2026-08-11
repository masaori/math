/-
「1 の冪根は零でない」の必要十分版。具体版と同じ背理法・同じ鎖を、
代数構造を持たない型の上で書く。必要なのは次の 3 つだけである。

  - 冪の約束 pow z (k+1) = mul (pow z k) z（鎖の第 4 段が使う）
  - zero が積の右吸収元であること mul a zero = zero（鎖の第 5 段が使う）
  - one ≠ zero（矛盾の核）

積の結合則・可換性・単位元であること・zero の左吸収・体・代数閉性は使わない。
住処: ここに ℝ / ℂ は現れない。
-/
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 冪が one になる元は zero でない。 -/
theorem root_of_unity_element_ne_zero_necSuf {M : Type*}
    (mul : M → M → M) (pow : M → ℕ → M) (one zero : M)
    (hpow_succ : ∀ (z : M) (k : ℕ), pow z (k + 1) = mul (pow z k) z)
    (hmul_zero : ∀ a : M, mul a zero = zero)
    (hone : one ≠ zero)
    (n : ℕ) (hn : 1 ≤ n) (w : M) (hw : pow w n = one) : w ≠ zero := by
  -- 背理法。w = zero と仮定して one = zero を導く。
  intro h0
  apply hone
  calc
    one = pow w n := hw.symm
    _ = pow zero n := by rw [h0]
    _ = pow zero ((n - 1) + 1) := by rw [Nat.sub_add_cancel hn]
    _ = mul (pow zero (n - 1)) zero := hpow_succ zero (n - 1)
    _ = zero := hmul_zero _

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
