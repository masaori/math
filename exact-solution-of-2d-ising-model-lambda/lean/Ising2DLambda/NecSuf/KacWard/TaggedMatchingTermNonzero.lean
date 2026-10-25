import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A labelled matching term is nonzero when its sign and every labelled factor are nonzero. -/
theorem labelled_term_ne_zero {R : Type*} [CommRing R] [Nontrivial R] [NoZeroDivisors R]
    {α : Type*} [DecidableEq α] (pairs short : Finset α)
    (sign : R) (longWeight shortWeight : α → R)
    (hsign : sign ≠ 0)
    (hlong : ∀ p ∈ pairs \ short, longWeight p ≠ 0)
    (hshortWeight : ∀ p ∈ short, shortWeight p ≠ 0) :
    sign * (-1 : R) ^ short.card *
      (∏ p ∈ pairs \ short, longWeight p) *
      (∏ p ∈ short, shortWeight p) ≠ 0 := by
  have hminus : (-1 : R) ^ short.card ≠ 0 :=
    pow_ne_zero _ (neg_ne_zero.mpr one_ne_zero)
  have hlongProd : (∏ p ∈ pairs \ short, longWeight p) ≠ 0 := by
    apply Finset.prod_ne_zero_iff.mpr
    intro p hp
    exact hlong p hp
  have hshortProd : (∏ p ∈ short, shortWeight p) ≠ 0 := by
    apply Finset.prod_ne_zero_iff.mpr
    intro p hp
    exact hshortWeight p hp
  exact mul_ne_zero (mul_ne_zero (mul_ne_zero hsign hminus) hlongProd) hshortProd

end Ising2DLambda.NecSuf.KacWard
