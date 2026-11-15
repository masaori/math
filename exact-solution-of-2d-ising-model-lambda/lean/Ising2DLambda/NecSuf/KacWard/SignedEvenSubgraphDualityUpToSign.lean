import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolynomialZeroProduct

namespace Ising2DLambda.NecSuf.KacWard

/-- Equal squares in a polynomial ring over a domain differ by a sign. -/
theorem duality_up_to_sign {R : Type*} [CommRing R] [NoZeroDivisors R]
    (f q : Polynomial R) (hsq : f ^ 2 = q ^ 2) :
    f = q ∨ f = -q := by
  have hprod : (f - q) * (f + q) = 0 := by
    calc
      (f - q) * (f + q) = f ^ 2 - q ^ 2 := by ring
      _ = q ^ 2 - q ^ 2 := by rw [hsq]
      _ = 0 := sub_self _
  rcases Ising2DLambda.NecSuf.AlgebraicEigenvalue.polynomial_zero_product_necSuf
      (f - q) (f + q) hprod with hdiff | hsum
  · exact Or.inl (sub_eq_zero.mp hdiff)
  · exact Or.inr (add_eq_zero_iff_eq_neg.mp hsum)

end Ising2DLambda.NecSuf.KacWard
