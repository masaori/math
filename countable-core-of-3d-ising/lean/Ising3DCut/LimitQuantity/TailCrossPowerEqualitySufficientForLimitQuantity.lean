/-
「有限個の例外を除いた交差べき等式は箱サイズ極限の存在と一致に十分である」の
Lean 具体版。

交差べき等式をある添字 `L0` 以降だけへ弱めても、`L0` 以降の各添字で
`cross_power_equality_implies_posRoot_equality` を適用すれば `L0` を証拠とする
尾部一致が得られ、既存の `tailAgreement_tendsto` を一度適用するだけで
十分性が保たれる。
-/
import Ising3DCut.LimitQuantity.CrossPowerEqualityImpliesRootEquality
import Ising3DCut.LimitQuantity.TailAgreementLimit

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- ある添字 `L0` 以降だけで交差べき等式が成り立てば、
一方の乗根列の極限を他方へ移すのに十分である。 -/
theorem tail_cross_power_equality_is_sufficient_for_limit_quantity
    (A B : ℕ → ℝ) (hA : ∀ L, 0 < A L) (hB : ∀ L, 0 < B L)
    (N M : ℕ → ℕ) (hN : ∀ L, N L ≠ 0) (hM : ∀ L, M L ≠ 0)
    (L0 : ℕ) (hcross : ∀ L, L0 ≤ L → A L ^ M L = B L ^ N L) (ℓ : ℝ)
    (hlimit : Tendsto (fun L => posRoot (A L) (N L)) atTop (𝓝 ℓ)) :
    Tendsto (fun L => posRoot (B L) (M L)) atTop (𝓝 ℓ) := by
  have hpointwise : ∀ L, L0 ≤ L → posRoot (A L) (N L) = posRoot (B L) (M L) := by
    intro L hL
    exact cross_power_equality_implies_posRoot_equality
      (A L) (B L) (hA L) (hB L) (N L) (M L) (hN L) (hM L) (hcross L hL)
  exact tailAgreement_tendsto
    (fun L => posRoot (A L) (N L)) (fun L => posRoot (B L) (M L))
    ⟨L0, hpointwise⟩ ℓ hlimit

end Ising3DCut.LimitQuantity
