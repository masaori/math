/-
「末尾を一つずらした有限箱量の列は同じ極限量を持つ」の Lean 必要十分版。

分配多項式・有理点・自然数乗根・実数は本質ではない。証明が使うのは、添字の写像
`shift` が極限フィルタを保つこと、二つの列が項ごとに一致すること、極限の一意性だけである。
-/
import Mathlib.Topology.Basic
import Mathlib.Topology.Separation.Hausdorff

namespace Ising3DCut.LimitQuantity

open Filter Topology

variable {ι X : Type*}

/-- 添字の写像がフィルタを保つなら、列をその写像でずらしても同じ値へ収束する。 -/
theorem tendsto_shift [TopologicalSpace X] (F : Filter ι) (shift : ι → ι)
    (hshift : Tendsto shift F F) (a : ι → X) (x : X)
    (ha : Tendsto a F (𝓝 x)) : Tendsto (fun i => a (shift i)) F (𝓝 x) := by
  exact ha.comp hshift

/-- ずらした列が元の列の `shift` による合成と項ごとに一致すれば、同じ値へ収束する。 -/
theorem shiftedSequence_tendsto [TopologicalSpace X] (F : Filter ι) (shift : ι → ι)
    (hshift : Tendsto shift F F) (a a' : ι → X) (hpoint : ∀ i, a' i = a (shift i))
    (x : X) (ha : Tendsto a F (𝓝 x)) : Tendsto a' F (𝓝 x) := by
  refine (tendsto_shift F shift hshift a x ha).congr ?_
  intro i
  exact (hpoint i).symm

/-- Hausdorff 空間で非自明なフィルタに沿う極限が存在すれば、ずらした列の極限値は元と等しい。 -/
theorem shiftedSequence_limit_eq [TopologicalSpace X] [T2Space X] (F : Filter ι) [F.NeBot]
    (shift : ι → ι) (hshift : Tendsto shift F F) (a a' : ι → X)
    (hpoint : ∀ i, a' i = a (shift i)) (x x' : X)
    (ha : Tendsto a F (𝓝 x)) (ha' : Tendsto a' F (𝓝 x')) : x' = x := by
  exact tendsto_nhds_unique ha' (shiftedSequence_tendsto F shift hshift a a' hpoint x ha)

end Ising3DCut.LimitQuantity
