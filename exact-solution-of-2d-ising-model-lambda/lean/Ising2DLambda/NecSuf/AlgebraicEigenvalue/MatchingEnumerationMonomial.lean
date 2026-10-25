import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open scoped Classical

/-- A duplicate-free enumeration has the same product as its underlying finite set. -/
theorem matchingEnumerationMonomial_necSuf {J R : Type*} [DecidableEq J]
    [CommMonoid R] (E : Finset J) (l : List J)
    (hl : l.Nodup) (hE : ∀ j, j ∈ l ↔ j ∈ E) (f : J → R) :
    (l.map f).prod = ∏ j ∈ E, f j := by
  classical
  have hset : l.toFinset = E := Finset.ext fun j => by
    simpa only [List.mem_toFinset] using hE j
  rw [← List.prod_toFinset f hl, hset]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
