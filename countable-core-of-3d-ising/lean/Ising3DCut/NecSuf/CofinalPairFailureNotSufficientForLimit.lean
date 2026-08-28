/-
「どの閾値の先にも二項関係の破れがあることは、列の極限の存在を保証しない」の Lean 必要十分版。

具体版（`Ising3DCut.LimitQuantity.tail_cross_power_failure_not_sufficient_for_limit_quantity`）の
証明が実際に使うのは次だけである。
添字の二つの列が `atTop` へ飛ぶこと、その二つの列の各段で二項関係が破れること、
値の列をその二つの添字列で引き戻すとそれぞれ定数で、二つの定数値が相異なること。

交差冪等式であること、有限箱量が自然数であること、乗根であること、
箱幅の偶奇、素数 2、指数の三乗はいずれも使わない。二項関係は添字の上の任意の述語でよく、
値の型は Hausdorff 位相空間でよい。

削れなかった仮定：`T2Space` は極限の一意性に必要である（これを落とすと相異なる二点へ
同じ列が収束しうる）。
-/
import Ising3DCut.NecSuf.ResidueClassValuesDifferNoLimitQuantity

namespace Ising3DCut.NecSuf

open Filter Topology

/-- `atTop` へ飛ぶ二つの添字列の各段で述語が破れるなら、どの閾値の先にも破れる対がある。 -/
theorem cofinalPairFailure_of_divergentIndices
    (rel : ℕ → ℕ → Prop) (index₁ index₂ : ℕ → ℕ)
    (hindex₁ : Tendsto index₁ atTop atTop)
    (hindex₂ : Tendsto index₂ atTop atTop)
    (hfail : ∀ k : ℕ, ¬ rel (index₁ k) (index₂ k)) :
    ∀ K : ℕ, ∃ L M : ℕ, K ≤ L ∧ K ≤ M ∧ ¬ rel L M := by
  intro K
  obtain ⟨k₁, hk₁⟩ := (tendsto_atTop_atTop.1 hindex₁) K
  obtain ⟨k₂, hk₂⟩ := (tendsto_atTop_atTop.1 hindex₂) K
  refine ⟨index₁ (max k₁ k₂), index₂ (max k₁ k₂), hk₁ _ (le_max_left _ _),
    hk₂ _ (le_max_right _ _), hfail _⟩

/-- どの閾値の先にも述語の破れがあり、かつ値の列に極限が無い、という二つが両立する。 -/
theorem cofinalPairFailure_and_noLimit
    {X : Type*} [TopologicalSpace X] [T2Space X]
    (rel : ℕ → ℕ → Prop) (a : ℕ → X) (index₁ index₂ : ℕ → ℕ)
    (hindex₁ : Tendsto index₁ atTop atTop)
    (hindex₂ : Tendsto index₂ atTop atTop)
    (hfail : ∀ k : ℕ, ¬ rel (index₁ k) (index₂ k))
    {c₁ c₂ : X}
    (hconst₁ : ∀ k : ℕ, a (index₁ k) = c₁)
    (hconst₂ : ∀ k : ℕ, a (index₂ k) = c₂)
    (hdiffer : c₁ ≠ c₂) :
    (∀ K : ℕ, ∃ L M : ℕ, K ≤ L ∧ K ≤ M ∧ ¬ rel L M) ∧
      ¬ ∃ α : X, Tendsto a atTop (nhds α) :=
  ⟨cofinalPairFailure_of_divergentIndices rel index₁ index₂ hindex₁ hindex₂ hfail,
    differingConstantCofinalSubsequences_noLimit a index₁ index₂ hindex₁ hindex₂
      hconst₁ hconst₂ hdiffer⟩

end Ising3DCut.NecSuf
