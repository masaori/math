/-
三値の位相について、零積性ではなく三つの値を順に調べる部分を抽出する。
体の構造は逆元を扱うため、根の非零性は値 z の場合に必要である。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A three-valued phase is nonzero when its root is nonzero. -/
theorem three_value_phase_ne_zero {F : Type*} [Field F] (z r : F)
    (hz : z ≠ 0) (hr : r = 1 ∨ r = z ∨ r = z⁻¹) : r ≠ 0 := by
  rcases hr with h | h | h
  · rw [h]
    exact one_ne_zero
  · rw [h]
    exact hz
  · rw [h]
    exact inv_ne_zero hz

end Ising2DLambda.NecSuf.KacWard
