/-
「交差べき等式は極限量に対して十分である」の Lean 必要十分版。

具体版の証明が使うのは、各添字で対象二元のべきが一致すれば元が一致することと、
項別一致した列へ収束を移すことだけである。正値性・実数・正の乗根は前者を
供給する具体構造なので落とし、モノイドと位相空間だけを残す。
-/
import Ising3DCut.NecSuf.CrossPowerEqualityAbstract
import Ising3DCut.LimitQuantity.TailAgreementSufficientAbstract

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 各添字で交差べき等式を満たす二つの根の列は、一方の極限を他方へ移す。
証明には対象二元でのべき単射性と、項別一致による収束移送だけを使う。 -/
theorem cross_power_equality_is_sufficient_for_limit_quantity_abstract
    {G : Type*} [Monoid G] [TopologicalSpace G]
    (x y A B : ℕ → G) (N M : ℕ → ℕ)
    (hxN : ∀ L, x L ^ N L = A L) (hyM : ∀ L, y L ^ M L = B L)
    (hcross : ∀ L, A L ^ M L = B L ^ N L)
    (hinj : ∀ L, x L ^ (N L * M L) = y L ^ (N L * M L) → x L = y L)
    (ℓ : G) (hlimit : Tendsto x atTop (nhds ℓ)) :
    Tendsto y atTop (nhds ℓ) := by
  have hpointwise : ∀ L, x L = y L := by
    intro L
    exact NecSuf.cross_power_equality_implies_root_equality_abstract
      (x L) (y L) (A L) (B L) (N L) (M L)
      (hxN L) (hyM L) (hcross L) (hinj L)
  exact tailAgreement_tendsto_abstract x y
    ⟨0, fun n _ => hpointwise n⟩ ℓ hlimit

end Ising3DCut.LimitQuantity
