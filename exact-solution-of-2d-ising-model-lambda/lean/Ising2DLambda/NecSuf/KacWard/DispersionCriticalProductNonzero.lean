import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A nonzero finite mode product and a square identity force the signed value to be nonzero. -/
theorem signed_value_nonzero_of_mode_product {F I : Type*}
    [CommMonoidWithZero F] [NoZeroDivisors F] [Nontrivial F] [Fintype I]
    (Q D : F) (factor : I → F)
    (hsquare : D = Q ^ 2) (hproduct : D = ∏ i, factor i)
    (hfactor : ∀ i, factor i ≠ 0) : Q ≠ 0 := by
  intro hQ
  have hprod : (∏ i, factor i) ≠ 0 := Finset.prod_ne_zero_iff.mpr (by
    intro i _
    exact hfactor i)
  apply hprod
  rw [← hproduct, hsquare, hQ]
  simp

end Ising2DLambda.NecSuf.KacWard
