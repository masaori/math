/-
「第二の極限量候補は無限個の有限箱量を持つ」の Lean 必要十分版。

具体版の証明が実際に使うのは、Hausdorff 位相空間に値を持つ自然数列、列が極限を持つこと、
末尾定数性から対象を一つに定める分類、および対象と異なることだけである。
Ising 模型・有理数・正の実数乗根・箱の点数・格子の形は使わない。

削れなかった仮定：`T2Space` は、直前の必要十分版
`finiteRangeLimit_onlyTarget` が値域の有限性から末尾定数性を得るために必要である
（これが無ければ有限値域でも末尾定数性は従わない）。
-/
import Ising3DCut.NecSuf.FiniteRangeLimitOnlyTarget

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 極限を持ち、末尾定数性が対象を一意に定める列について、対象と異なるなら値域は無限である。 -/
theorem infiniteRange_of_ne_target
    {X Q : Type*} [TopologicalSpace X] [T2Space X]
    (a : ℕ → X) (q target : Q)
    (hne : q ≠ target)
    (hlimit : ∃ α : X, Tendsto a atTop (nhds α))
    (heventuallyConstantOnlyTarget :
      (∃ L0 : ℕ, ∃ c : X, ∀ L, L0 ≤ L → a L = c) → q = target) :
    (Set.range a).Infinite := by
  intro hfinite
  exact hne
    (finiteRangeLimit_onlyTarget a q target hfinite hlimit heventuallyConstantOnlyTarget)

end Ising3DCut.NecSuf
