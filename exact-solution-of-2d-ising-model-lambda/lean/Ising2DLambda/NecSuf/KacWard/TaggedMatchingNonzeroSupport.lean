import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- Only the nonzero factors of each labelled product can occur in a nonzero term. -/
theorem taggedProduct_nonzero_support {ι R : Type*} [DecidableEq ι] [CommRing R]
    [IsDomain R] (s t : Finset ι) (long short : ι → R)
    (longAllowed shortAllowed : ι → Prop)
    (hL : ∀ p, long p ≠ 0 → longAllowed p)
    (hS : ∀ p, short p ≠ 0 → shortAllowed p)
    (hterm : (∏ p ∈ s \ t, long p) * (∏ p ∈ t, short p) ≠ 0) :
    (∀ p ∈ s \ t, longAllowed p) ∧ (∀ p ∈ t, shortAllowed p) := by
  rcases mul_ne_zero_iff.mp hterm with ⟨hlong, hshort⟩
  constructor
  · intro p hp
    exact hL p ((Finset.prod_ne_zero_iff.mp hlong) p hp)
  · intro p hp
    exact hS p ((Finset.prod_ne_zero_iff.mp hshort) p hp)

end Ising2DLambda.NecSuf.KacWard
