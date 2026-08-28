/-
「有限個の値しかとらず極限量を持つ正の有理点は 1 に限られる」の Lean 必要十分版。

具体版の証明が実際に使うのは、Hausdorff 位相空間に値を持つ自然数列、その値域が有限であること、
列が極限を持つこと、および末尾定数性から対象を一つに定める分類だけである。
Ising 模型・有理数・正の実数乗根・箱の点数・格子の形は使わない。

削れなかった仮定：`T2Space` は、無限回とる値が極限に一致することに必要である
（これが無ければ有限値域でも末尾定数性は従わない）。
-/
import Ising3DCut.NecSuf.FiniteRangeConvergentEventuallyConstant

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 有限個の値しかとらない列が極限を持ち、末尾定数性が対象を一意に定めるなら、その対象である。 -/
theorem finiteRangeLimit_onlyTarget
    {X Q : Type*} [TopologicalSpace X] [T2Space X]
    (a : ℕ → X) (q target : Q)
    (hfin : (Set.range a).Finite)
    (hlimit : ∃ α : X, Tendsto a atTop (nhds α))
    (heventuallyConstantOnlyTarget :
      (∃ L0 : ℕ, ∃ c : X, ∀ L, L0 ≤ L → a L = c) → q = target) :
    q = target := by
  obtain ⟨α, hα⟩ := hlimit
  obtain ⟨L0, hconstant⟩ := finiteRangeConvergent_eventuallyConstant hα hfin
  exact heventuallyConstantOnlyTarget ⟨L0, α, hconstant⟩

end Ising3DCut.NecSuf
