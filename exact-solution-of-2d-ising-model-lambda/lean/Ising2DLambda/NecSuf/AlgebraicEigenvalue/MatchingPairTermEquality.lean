import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- The two orientation signs cancel after the sign identity and the entry
product identity are substituted into the same permutation summand. -/
theorem matchingPairTermEquality_necSuf {R : Type*} [CommRing R]
    (s p α β c d b e : R)
    (hs : s = α * β * c * d)
    (hp : p = (α * β) * (b * e))
    (hα : α * α = 1) (hβ : β * β = 1) :
    s * p = (c * d) * (b * e) := by
  calc
    s * p = (α * β * c * d) * ((α * β) * (b * e)) := by rw [hs, hp]
    _ = (α * α) * (β * β) * ((c * d) * (b * e)) := by ring
    _ = (c * d) * (b * e) := by rw [hα, hβ]; ring

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
