import Ising2DLambda.NecSuf.KacWard.DispersionCriticalProductNonzero
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphDualityFixedPointSign

namespace Ising2DLambda.NecSuf.KacWard

/-- Nonzero mode factors select the positive polynomial branch at a fixed point. -/
theorem duality_nontrivial_positive_sign {F I : Type*}
    [CommRing F] [NoZeroDivisors F] [CharZero F] [Fintype I]
    (f q : Polynomial F) (c d x : F) (factor : I → F)
    (hc : c ≠ 0)
    (hsign : f = Polynomial.C c * q ∨ f = -(Polynomial.C c * q))
    (heval : f.eval x = (Polynomial.C c * q).eval x)
    (hsquare : d = (q.eval x) ^ 2)
    (hproduct : d = ∏ i, factor i)
    (hfactor : ∀ i, factor i ≠ 0) : f = Polynomial.C c * q := by
  have hq : q.eval x ≠ 0 :=
    signed_value_nonzero_of_mode_product (q.eval x) d factor hsquare hproduct hfactor
  have hscaled : (Polynomial.C c * q).eval x ≠ 0 := by
    simp only [Polynomial.eval_mul, Polynomial.eval_C]
    exact mul_ne_zero hc hq
  exact duality_fixed_point_positive_sign f (Polynomial.C c * q) x
    hsign heval hscaled

end Ising2DLambda.NecSuf.KacWard
