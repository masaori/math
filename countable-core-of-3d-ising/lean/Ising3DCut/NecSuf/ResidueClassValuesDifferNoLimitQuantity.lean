/-
「剰余類ごとの定数値が二つ相異なるなら極限量は存在しない」の Lean 必要十分版。

具体版の証明が実際に使うのは、Hausdorff 位相空間に値を持つ一つの列、
`atTop` へ飛ぶ二つの添字列、その二つの部分列がそれぞれ定数であること、
および二つの定数値が相異なることだけである。
Ising 模型・有理数・正の実数乗根・周期性・剰余類は使わない。

削れなかった仮定：`T2Space` は極限の一意性に必要である。これを落とすと、
相異なる二点へ同じ列が収束しうるので結論は成り立たない。
-/
import Mathlib.Topology.Instances.Real.Lemmas

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 共終な二つの定数部分列が相異なる値を持つなら、元の列は極限を持たない。 -/
theorem differingConstantCofinalSubsequences_noLimit
    {X : Type*} [TopologicalSpace X] [T2Space X]
    (a : ℕ → X) (index₁ index₂ : ℕ → ℕ)
    (hindex₁ : Tendsto index₁ atTop atTop)
    (hindex₂ : Tendsto index₂ atTop atTop)
    {c₁ c₂ : X}
    (hconst₁ : ∀ k : ℕ, a (index₁ k) = c₁)
    (hconst₂ : ∀ k : ℕ, a (index₂ k) = c₂)
    (hdiffer : c₁ ≠ c₂) :
    ¬ ∃ α : X, Tendsto a atTop (nhds α) := by
  rintro ⟨α, hlimit⟩
  have hsub₁ : Tendsto (a ∘ index₁) atTop (nhds α) := hlimit.comp hindex₁
  have hsub₂ : Tendsto (a ∘ index₂) atTop (nhds α) := hlimit.comp hindex₂
  have hfun₁ : a ∘ index₁ = fun _ : ℕ => c₁ := funext hconst₁
  have hfun₂ : a ∘ index₂ = fun _ : ℕ => c₂ := funext hconst₂
  rw [hfun₁] at hsub₁
  rw [hfun₂] at hsub₂
  have hc₁ : c₁ = α := tendsto_nhds_unique tendsto_const_nhds hsub₁
  have hc₂ : c₂ = α := tendsto_nhds_unique tendsto_const_nhds hsub₂
  exact hdiffer (hc₁.trans hc₂.symm)

end Ising3DCut.NecSuf
