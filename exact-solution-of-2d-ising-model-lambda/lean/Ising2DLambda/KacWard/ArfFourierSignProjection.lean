/- 人手証明の `claim_arf_fourier_sign_projection` と一対一に対応する具体版。 -/
import Ising2DLambda.NecSuf.KacWard.ArfFourierSignProjection

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem arfFourierSignProjection (h v : Bool) :
    sign (arfParity false false) * sign (quadraticParity false false h v) +
    sign (arfParity false true) * sign (quadraticParity false true h v) +
    sign (arfParity true false) * sign (quadraticParity true false h v) +
    sign (arfParity true true) * sign (quadraticParity true true h v) = 2 := by
  cases h <;> cases v <;> decide

end Ising2DLambda.KacWard
