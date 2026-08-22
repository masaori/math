/-
「共終な添字での交差べき等式は箱サイズ極限の一致に十分である」の Lean 必要十分版。

具体版が正の実数を使う理由は二つに分かれる。各添字での乗根の一致を出すための
局所的なべき単射性と、二つの極限値を分離する Hausdorff 性である。前者は
仮定 `hinj` として各添字で受け取り、後者は `T2Space` として受け取る。
したがって台としてはモノイドと Hausdorff 位相だけを仮定する。手順は具体版と同じで、
共終性の一度の適用・各添字でのべき単射性・共終な一致からの極限一致の合成である。

削れなかった仮定：`Monoid` は `A L ^ M L` などのべきを書くために要る。
`T2Space` は `cofinalAgreement_limit_eq_abstract` が要求する（落とすと結論が偽になる）。
-/
import Ising3DCut.NecSuf.CrossPowerEqualityAbstract
import Ising3DCut.LimitQuantity.CofinalAgreementLimitAbstract

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 必要十分版：交差べき等式を満たす添字が共終な二つの根の列がそれぞれ収束するなら、
極限は等しい。 -/
theorem cofinal_cross_power_equality_is_sufficient_for_limit_quantity_abstract
    {G : Type*} [Monoid G] [TopologicalSpace G] [T2Space G]
    (x y A B : ℕ → G) (N M : ℕ → ℕ)
    (hxN : ∀ L, x L ^ N L = A L) (hyM : ∀ L, y L ^ M L = B L)
    (hcross : ∀ L1 : ℕ, ∃ L : ℕ, L1 ≤ L ∧ A L ^ M L = B L ^ N L)
    (hinj : ∀ L, x L ^ (N L * M L) = y L ^ (N L * M L) → x L = y L)
    (ℓ ℓ' : G) (hlimit : Tendsto x atTop (nhds ℓ))
    (hlimit' : Tendsto y atTop (nhds ℓ')) :
    ℓ = ℓ' := by
  -- 具体版の前半と同じ：共終な添字ごとにべき単射性で一致を出す。
  have hcofinal : ∀ L1 : ℕ, ∃ L : ℕ, L1 ≤ L ∧ x L = y L := by
    intro L1
    obtain ⟨L, hL, hEq⟩ := hcross L1
    exact ⟨L, hL, NecSuf.cross_power_equality_implies_root_equality_abstract
      (x L) (y L) (A L) (B L) (N L) (M L) (hxN L) (hyM L) hEq (hinj L)⟩
  -- 具体版の後半と同じ：共終な一致から極限一致を一度で得る。
  exact cofinalAgreement_limit_eq_abstract x y hcofinal ℓ ℓ' hlimit hlimit'

end Ising3DCut.LimitQuantity
