import Ising2DLambda.KacWard.DispersionPolynomial
import Ising2DLambda.NecSuf.KacWard.DispersionPolynomial

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The concrete definition is the specialization of the field definition. -/
theorem dispersionPolynomial_from_necSuf (varpi varsigma : Qbar) :
    dispersionPolynomial varpi varsigma =
      Ising2DLambda.NecSuf.KacWard.dispersionPolynomial varpi varsigma := rfl

end Ising2DLambda.KacWard
