import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising3DCut.Prediction

open scoped BigOperators

/-- Pfaffian の有限展開で全完全マッチングの符号が同じなら、
符号付き有限和からその一定符号を括り出せる。 -/
theorem constantSign_finiteExpansion
    {ι R : Type*} [CommRing R]
    (matchings : Finset ι) (sign weight : ι → R) (ε : R)
    (hSign : ∀ matching ∈ matchings, sign matching = ε) :
    ∑ matching ∈ matchings, sign matching * weight matching =
      ε * ∑ matching ∈ matchings, weight matching := by
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro matching hMatching
  rw [hSign matching hMatching]

end Ising3DCut.Prediction
