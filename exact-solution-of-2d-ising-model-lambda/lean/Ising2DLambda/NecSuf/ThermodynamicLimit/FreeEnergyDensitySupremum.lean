/-
「自由エネルギー密度の値集合の上限の存在」の必要十分版。

格子・自由エネルギー密度・実数を外し、添字付き値集合の証人、一様上界、
および空でない上に有界な集合へ上限を与える性質だけを残す。
-/
import Mathlib.Order.Bounds.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 添字付きの値集合が上限を持つために、人手証明が実際に使う仮定だけを並べた形。 -/
theorem indexedValueSet_has_supremum_necSuf
    {I A : Type} [LE A]
    (value : I → A) (witness : I) (upper : A)
    (pointwiseUpper : ∀ i : I, value i ≤ upper)
    (hasSupremum : ∀ S : Set A, S.Nonempty → BddAbove S → ∃ s : A, IsLUB S s) :
    ∃ s : A, IsLUB (Set.range value) s := by
  have hnonempty : (Set.range value).Nonempty := by
    exact ⟨value witness, ⟨witness, rfl⟩⟩
  have hbounded : BddAbove (Set.range value) := by
    refine ⟨upper, ?_⟩
    intro y hy
    rcases hy with ⟨i, rfl⟩
    exact pointwiseUpper i
  exact hasSupremum (Set.range value) hnonempty hbounded

end Ising2DLambda.NecSuf.ThermodynamicLimit
