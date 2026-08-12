/-
格子面境界の四つの破れ指示子から偶数性を得る段の必要十分版。
具体的な格子・辺・配位を外し、四つの真偽値と符号積だけを残す。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 四つの符号の積が 1 なら、負号を選んだ個数は偶数である。 -/
theorem four_signs_even_necSuf (q₁ q₂ q₃ q₄ : Bool)
    (hproduct :
      (if q₁ then (-1 : ℤ) else 1) *
      (if q₂ then (-1 : ℤ) else 1) *
      (if q₃ then (-1 : ℤ) else 1) *
      (if q₄ then (-1 : ℤ) else 1) = 1) :
    Even (
      (if q₁ then 1 else 0) +
      (if q₂ then 1 else 0) +
      (if q₃ then 1 else 0) +
      (if q₄ then 1 else 0)) := by
  have hzero : Even 0 := ⟨0, rfl⟩
  have htwo : Even 2 := ⟨1, rfl⟩
  have hfour : Even 4 := ⟨2, rfl⟩
  cases q₁ <;> cases q₂ <;> cases q₃ <;> cases q₄
  all_goals norm_num at hproduct
  all_goals first | exact hzero | exact htwo | exact hfour

end Ising2DLambda.NecSuf.FisherZero
