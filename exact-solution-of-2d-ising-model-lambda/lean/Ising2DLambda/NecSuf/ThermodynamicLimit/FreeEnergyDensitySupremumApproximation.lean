/-
「上限への任意近接」の必要十分版。

自由エネルギー密度・実数・減法を外し、線形順序、値の列、上限、
上限より小さい元だけを残す。証明手順は具体版と同じである。
-/
import Mathlib.Order.Bounds.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 値集合の上限より小さい任意の元を、値の一つが上回る。 -/
theorem rangeValue_supremum_approximation_necSuf
    {I A : Type} [LinearOrder A]
    (value : I → A) (upper lower : A)
    (hupper : IsLUB (Set.range value) upper)
    (hlower_lt_upper : lower < upper) :
    ∃ i : I, lower < value i := by
  have hlower_not_upper : lower ∉ upperBounds (Set.range value) := by
    intro hlower_upper
    have hupper_le_lower : upper ≤ lower := hupper.2 hlower_upper
    exact (not_le_of_gt hlower_lt_upper) hupper_le_lower
  have hexample : ∃ y : A, y ∈ Set.range value ∧ ¬y ≤ lower := by
    by_contra hno_example
    push_neg at hno_example
    apply hlower_not_upper
    intro y hy
    exact hno_example y hy
  obtain ⟨y, hy, hy_not_le⟩ := hexample
  have hlower_lt_y : lower < y := lt_of_not_ge hy_not_le
  rcases hy with ⟨i, rfl⟩
  exact ⟨i, hlower_lt_y⟩

end Ising2DLambda.NecSuf.ThermodynamicLimit
