/-
「自由エネルギー密度の極限の言明」と「完備性への脱出の宣言」の必要十分版。

実数・自由エネルギー・格子を外し、二つの不等式による極限述語と、空でなく上に有界な
集合が上限を持つという性質だけを残す。
-/
import Mathlib.Order.Bounds.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 順序と負号・減法だけで書いた二側極限述語。 -/
def twoSidedLimitOn {I A : Type*} [LT A] [Neg A] [Sub A]
    (rank : I → ℕ) (sequence : I → A) (positive : A → Prop) (f : A) : Prop :=
  ∀ eps : A, positive eps → ∃ N : ℕ, 1 ≤ N ∧
    ∀ i : I, N ≤ rank i → -eps < sequence i - f ∧ sequence i - f < eps

/-- 上限の存在として切り出した、後続の存在証明が使う完備性。 -/
def UpperBoundComplete (A : Type*) [LE A] : Prop :=
  ∀ S : Set A, S.Nonempty → BddAbove S → ∃ s : A, IsLUB S s

end Ising2DLambda.NecSuf.ThermodynamicLimit
