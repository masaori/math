import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open Finset Polynomial

/-- A finite product with one polynomial variable in each factor is one monomial. -/
theorem shortProduct_monomial {ι R : Type*} [DecidableEq ι] [CommRing R]
    (t : Finset ι) (q : ι → R) :
    (∏ p ∈ t, (X : Polynomial R) * C (q p)) =
      X ^ t.card * C (∏ p ∈ t, q p) := by
  induction t using Finset.induction_on with
  | empty => simp
  | @insert p t hp ih =>
    rw [Finset.prod_insert hp, ih, Finset.card_insert_of_notMem hp,
      Finset.prod_insert hp, map_mul]
    ring

/-- A nonzero scalar multiple of the selected monomial has exactly that degree. -/
theorem monomial_term_natDegree {R : Type*} [CommRing R] [Nontrivial R]
    [NoZeroDivisors R] (n : ℕ) (c : R) (hc : c ≠ 0) :
    (X ^ n * C c : Polynomial R).natDegree = n := by
  rw [natDegree_mul_C hc, natDegree_X_pow]

end Ising2DLambda.NecSuf.KacWard
