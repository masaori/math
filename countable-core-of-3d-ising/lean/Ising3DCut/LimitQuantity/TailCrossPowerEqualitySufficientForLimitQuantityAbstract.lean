/-
「有限個の例外を除いた交差べき等式は箱サイズ極限の存在と一致に十分である」の
Lean 必要十分版。

具体版で正の実数を使う理由は、各箱の二つの乗根について局所的な累乗の単射性を
供給するためだけである。ここではモノイド `G` と位相空間だけを仮定し、
交差べき等式をある添字 `L0` 以降だけへ弱めた仮定から、既存の
`tailAgreement_tendsto_abstract`（証拠 `L0`）を一度適用して収束を移送する。
-/
import Ising3DCut.NecSuf.CrossPowerEqualityAbstract
import Ising3DCut.LimitQuantity.TailAgreementSufficientAbstract

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- ある添字 `L0` 以降だけで交差べき等式を満たす二つの根の列は、
一方の極限を他方へ移す。証明には対象二元でのべき単射性と、
`L0` を証拠とする尾部一致による収束移送だけを使う。 -/
theorem tail_cross_power_equality_is_sufficient_for_limit_quantity_abstract
    {G : Type*} [Monoid G] [TopologicalSpace G]
    (x y A B : ℕ → G) (N M : ℕ → ℕ)
    (hxN : ∀ L, x L ^ N L = A L) (hyM : ∀ L, y L ^ M L = B L)
    (L0 : ℕ) (hcross : ∀ L, L0 ≤ L → A L ^ M L = B L ^ N L)
    (hinj : ∀ L, x L ^ (N L * M L) = y L ^ (N L * M L) → x L = y L)
    (ℓ : G) (hlimit : Tendsto x atTop (nhds ℓ)) :
    Tendsto y atTop (nhds ℓ) := by
  have hpointwise : ∀ L, L0 ≤ L → x L = y L := by
    intro L hL
    exact NecSuf.cross_power_equality_implies_root_equality_abstract
      (x L) (y L) (A L) (B L) (N L) (M L)
      (hxN L) (hyM L) (hcross L hL) (hinj L)
  exact tailAgreement_tendsto_abstract x y ⟨L0, hpointwise⟩ ℓ hlimit

end Ising3DCut.LimitQuantity
