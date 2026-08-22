/-
「共終な添字での交差べき等式は箱サイズ極限の一致に十分である」の Lean 具体版。

交差べき等式を「ある添字以降のすべて」からさらに弱め、成り立つ添字が共終である
（どの添字より先にも成り立つ添字がある）ことだけを仮定する。人手証明と同じく、
任意の下界へ共終性を一度適用して成り立つ添字を一つ取り、そこで
`cross_power_equality_implies_posRoot_equality` を適用して乗根の一致を得て、
乗根列の一致する添字も共終であることを示し、`cofinalAgreement_limit_eq` を
一度適用する。尾部版と違い、他方の乗根列の収束は仮定に置く。
-/
import Ising3DCut.LimitQuantity.CrossPowerEqualityImpliesRootEquality
import Ising3DCut.LimitQuantity.CofinalAgreementLimit

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 交差べき等式が成り立つ添字が共終であれば、二つの乗根列の極限は一致する。 -/
theorem cofinal_cross_power_equality_is_sufficient_for_limit_quantity
    (A B : ℕ → ℝ) (hA : ∀ L, 0 < A L) (hB : ∀ L, 0 < B L)
    (N M : ℕ → ℕ) (hN : ∀ L, N L ≠ 0) (hM : ∀ L, M L ≠ 0)
    (hcross : ∀ L1 : ℕ, ∃ L : ℕ, L1 ≤ L ∧ A L ^ M L = B L ^ N L) (ℓ ℓ' : ℝ)
    (hlimit : Tendsto (fun L => posRoot (A L) (N L)) atTop (𝓝 ℓ))
    (hlimit' : Tendsto (fun L => posRoot (B L) (M L)) atTop (𝓝 ℓ')) :
    ℓ = ℓ' := by
  -- 人手証明の前半：一致する添字の共終性を、交差べき等式の共終性から作る。
  have hcofinal :
      ∀ L1 : ℕ, ∃ L : ℕ, L1 ≤ L ∧ posRoot (A L) (N L) = posRoot (B L) (M L) := by
    intro L1
    obtain ⟨L, hL, hEq⟩ := hcross L1
    exact ⟨L, hL, cross_power_equality_implies_posRoot_equality
      (A L) (B L) (hA L) (hB L) (N L) (M L) (hN L) (hM L) hEq⟩
  -- 人手証明の後半：共終な一致から極限値の一致を一度で得る。
  exact cofinalAgreement_limit_eq
    (fun L => posRoot (A L) (N L)) (fun L => posRoot (B L) (M L))
    hcofinal ℓ ℓ' hlimit hlimit'

end Ising3DCut.LimitQuantity
