import Ising2DLambda.KacWard.DispersionInversionInvariant
import Ising2DLambda.KacWard.DispersionPolynomialFromNecSuf
import Ising2DLambda.NecSuf.KacWard.DispersionInversionInvariant

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版の主張は、必要十分版を `R := Qbar`、`t := (−1)^a`、`t' := (−1)^b` に特殊化して得られる。 -/
theorem dispersion_inversion_invariant_from_necSuf {L : ℕ} (hL : 1 ≤ L) (s : SpinStructure)
    {varpi varsigma : Qbar} (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s) :
    varpi⁻¹ ∈ horizontalTwistedModes L s ∧ varsigma⁻¹ ∈ verticalTwistedModes L s ∧
      dispersionPolynomial varpi⁻¹ varsigma = dispersionPolynomial varpi varsigma ∧
      dispersionPolynomial varpi varsigma⁻¹ = dispersionPolynomial varpi varsigma := by
  simp only [dispersionPolynomial_from_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.dispersion_inversion_invariant_necSuf hL _ _
    (twistSign_ne_zero s.1) (twistSign_mul_self s.1)
    (twistSign_ne_zero s.2) (twistSign_mul_self s.2) varpi varsigma hvarpi hvarsigma

end Ising2DLambda.KacWard
