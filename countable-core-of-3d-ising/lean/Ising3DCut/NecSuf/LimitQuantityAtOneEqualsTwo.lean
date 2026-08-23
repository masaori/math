/-
「有理点 1 では極限量が存在して 2 に等しい」の Lean 必要十分版。

具体版の極限へ渡す段が使うのは、列が最終的に一定であることと、その一定値の
近傍へ定数列が収束することだけである。Ising 分配多項式・正の実数乗根・自然数の
冪は、有限箱の列が最終的に一定であることを示す具体版の段にだけ属するので落とす。
-/
import Mathlib.Topology.Order
import Mathlib.Order.Filter.AtTopBot.Basic

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 最終的に値 `c` に一致する列は `c` へ収束する。 -/
theorem eventually_constant_sequence_tendsto
    {X : Type*} [TopologicalSpace X] (a : ℕ → X) (c : X)
    (hconstant : ∀ᶠ L in atTop, a L = c) :
    Tendsto a atTop (𝓝 c) := by
  apply Tendsto.congr' _ tendsto_const_nhds
  filter_upwards [hconstant] with L hL
  exact hL.symm

end Ising3DCut.NecSuf
