/-
有理下切断の上限による実現写像の必要十分版。
下切断を作るための有理数の写像と狭義順序だけを受け取り、
実数の完備性による上限を取る段だけを記述する。
-/
import Mathlib.Algebra.Order.Archimedean.Real.Hom

namespace Ising2DLambda.NecSuf.RealEscape

/-- 有理数の下切断の実数像の上限。 -/
noncomputable def cutRealization {α : Type*} (rational : ℚ → α)
    (lt : α → α → Prop) (a : α) : ℝ :=
  sSup {x : ℝ | ∃ q : ℚ, lt (rational q) a ∧ x = (q : ℝ)}

end Ising2DLambda.NecSuf.RealEscape
