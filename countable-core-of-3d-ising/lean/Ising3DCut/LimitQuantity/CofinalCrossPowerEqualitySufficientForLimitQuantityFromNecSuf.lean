/-
「共終な添字での交差べき等式は箱サイズ極限の一致に十分である」の
Lean 必要十分版からの導出。

具体版で正の実数を使う理由は、各箱の二つの正の乗根について正の自然数乗が
単射になることと、実数が Hausdorff であることの二つだけである。前者を各添字で
抽象版へ渡し、後者は実数の位相から供給される。共終性の適用と極限一致の合成は
抽象版に一度だけ担わせる。
-/
import Ising3DCut.LimitQuantity.CofinalCrossPowerEqualitySufficientForLimitQuantityAbstract
import Ising3DCut.LimitQuantity.PositiveRealRootUnique

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 具体版は、各箱の二つの正の実数における累乗の単射性を
必要十分版へ渡す特殊化として導出できる。 -/
theorem cofinal_cross_power_equality_is_sufficient_for_limit_quantity_fromNecSuf
    (A B : ℕ → ℝ) (hA : ∀ L, 0 < A L) (hB : ∀ L, 0 < B L)
    (N M : ℕ → ℕ) (hN : ∀ L, N L ≠ 0) (hM : ∀ L, M L ≠ 0)
    (hcross : ∀ L1 : ℕ, ∃ L : ℕ, L1 ≤ L ∧ A L ^ M L = B L ^ N L) (ℓ ℓ' : ℝ)
    (hlimit : Tendsto (fun L => posRoot (A L) (N L)) atTop (𝓝 ℓ))
    (hlimit' : Tendsto (fun L => posRoot (B L) (M L)) atTop (𝓝 ℓ')) :
    ℓ = ℓ' :=
  cofinal_cross_power_equality_is_sufficient_for_limit_quantity_abstract
    (fun L => posRoot (A L) (N L)) (fun L => posRoot (B L) (M L)) A B N M
    (fun L => posRoot_pow (A L) (hA L) (N L) (hN L))
    (fun L => posRoot_pow (B L) (hB L) (M L) (hM L))
    hcross
    (fun L hpowers => (pow_left_inj₀
      (posRoot_pos (A L) (hA L) (N L)).le
      (posRoot_pos (B L) (hB L) (M L)).le
      (Nat.mul_ne_zero (hN L) (hM L))).1 hpowers)
    ℓ ℓ' hlimit hlimit'

end Ising3DCut.LimitQuantity
