/-
四セクターへの一意な所属の必要十分版。
具体的な偶奇や格子を外すと、要るのは対象からセクターへの写像一つだけである。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 適格な対象は、写像の値を唯一のラベルとして持つ。 -/
theorem admissible_fiber_label_unique_necSuf {α β : Type*} (admissible : α → Prop)
    (label : α → β) (x : α) (hx : admissible x) :
    ∃! y : β, admissible x ∧ label x = y := by
  refine ⟨label x, ⟨hx, rfl⟩, ?_⟩
  intro y hy
  exact hy.2.symm

end Ising2DLambda.NecSuf.FisherZero
