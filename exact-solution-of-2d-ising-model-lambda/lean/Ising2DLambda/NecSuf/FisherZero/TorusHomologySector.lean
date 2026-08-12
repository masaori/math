/-
四セクターへの一意な所属の必要十分版。
具体的な偶奇や格子を外すと、要るのは対象からセクターへの写像一つだけである。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 対象のラベルは、その写像の値を唯一のラベルとして持つ。 -/
theorem fiber_label_unique_necSuf {α β : Type*} (label : α → β) (x : α) :
    ∃! y : β, label x = y := by
  refine ⟨label x, rfl, ?_⟩
  intro y hy
  exact hy.symm

end Ising2DLambda.NecSuf.FisherZero
