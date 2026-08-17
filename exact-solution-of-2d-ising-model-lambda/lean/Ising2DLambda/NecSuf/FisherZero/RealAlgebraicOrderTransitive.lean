/-
「実代数的数の狭義順序は推移的である」の必要十分版。

部分体も虚数単位も本質でない。効いているのは
「差が平方で書ける関係は、平方の和が平方でありかつ和が零なら各項が零である環では推移的である」
ことだけで、必要なのは可換環とその 2 つの性質である。
-/
import Mathlib.Algebra.Ring.Basic
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

theorem lt_of_difference_trans_necSuf {R : Type*} [CommRing R]
    (sum_is_square : ∀ u v : R, ∃ w : R, u * u + v * v = w * w)
    (sum_zero : ∀ u v : R, u * u + v * v = 0 → u = 0 ∧ v = 0)
    (a b c : R)
    (hab : ∃ u : R, u ≠ 0 ∧ b - a = u * u)
    (hbc : ∃ v : R, v ≠ 0 ∧ c - b = v * v) :
    ∃ w : R, w ≠ 0 ∧ c - a = w * w := by
  obtain ⟨u, hu0, hu⟩ := hab
  obtain ⟨v, hv0, hv⟩ := hbc
  obtain ⟨w, hw⟩ := sum_is_square u v
  refine ⟨w, ?_, ?_⟩
  · intro hw0
    rw [hw0] at hw
    have : u * u + v * v = 0 := by rw [hw]; ring
    exact hu0 (sum_zero u v this).1
  · calc c - a = (c - b) + (b - a) := by ring
      _ = v * v + u * u := by rw [hu, hv]
      _ = u * u + v * v := by ring
      _ = w * w := hw

end Ising2DLambda.NecSuf.FisherZero
