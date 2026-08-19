/-
「交差べき等式は箱サイズ極限の存在と一致に十分である」の Lean 具体版。

可算側の交差べき等式から乗根列の項別一致を得たあと、箱の大きさの極限を
一度だけ使って、一方の列の収束を他方へ移す。
-/
import Ising3DCut.LimitQuantity.PointwiseCrossPowerEqualityImpliesRootSequenceEquality
import Ising3DCut.LimitQuantity.RealLimitOfEqualSequences

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 各箱の交差べき等式は、一方の正の乗根列の極限を他方へ移す。 -/
theorem cross_power_equality_is_sufficient_for_limit_quantity
    (A B : ℕ → ℝ) (hA : ∀ L, 0 < A L) (hB : ∀ L, 0 < B L)
    (N M : ℕ → ℕ) (hN : ∀ L, N L ≠ 0) (hM : ∀ L, M L ≠ 0)
    (hcross : ∀ L, A L ^ M L = B L ^ N L) (ℓ : ℝ)
    (hlimit : Tendsto (fun L => posRoot (A L) (N L)) atTop (𝓝 ℓ)) :
    Tendsto (fun L => posRoot (B L) (M L)) atTop (𝓝 ℓ) := by
  have hpointwise : ∀ L, posRoot (A L) (N L) = posRoot (B L) (M L) :=
    pointwise_cross_power_equality_implies_root_sequence_equality
      A B hA hB N M hN hM hcross
  exact (tendsto_iff_of_pointwise_eq
    (fun L => posRoot (A L) (N L))
    (fun L => posRoot (B L) (M L)) hpointwise ℓ).1 hlimit

end Ising3DCut.LimitQuantity
