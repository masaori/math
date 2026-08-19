/-
「各箱の交差べき等式は乗根列の項別一致を決める」の Lean 具体版。

各添字で既存の一箱の補題を一度適用する。ここでは極限を取らない。
-/
import Ising3DCut.LimitQuantity.CrossPowerEqualityImpliesRootEquality

namespace Ising3DCut.LimitQuantity

/-- 各添字の交差べき等式は、対応する正の乗根列の項別一致を与える。 -/
theorem pointwise_cross_power_equality_implies_root_sequence_equality
    (A B : ℕ → ℝ) (hA : ∀ L, 0 < A L) (hB : ∀ L, 0 < B L)
    (N M : ℕ → ℕ) (hN : ∀ L, N L ≠ 0) (hM : ∀ L, M L ≠ 0)
    (hcross : ∀ L, A L ^ M L = B L ^ N L) :
    ∀ L, posRoot (A L) (N L) = posRoot (B L) (M L) := by
  intro L
  exact cross_power_equality_implies_posRoot_equality
    (A L) (B L) (hA L) (hB L) (N L) (M L) (hN L) (hM L) (hcross L)

end Ising3DCut.LimitQuantity
