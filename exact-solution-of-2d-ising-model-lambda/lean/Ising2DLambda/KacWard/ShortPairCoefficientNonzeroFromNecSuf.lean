/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ShortPairCoefficientNonzero
import Ising2DLambda.NecSuf.KacWard.ShortPairCoefficientNonzero

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The concrete triple product is an instance of the domain argument. -/
theorem shortPairCoefficient_ne_zero_from_necSuf {L : ℕ} [NeZero L]
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (e f : OrientedEdge L) (hsource : orientedSource e = orientedSource f)
    (hne : e ≠ f) :
    (gaugePairWeight z s e f * (twistSign s f : Qbar)) *
      rotationPhase z (reversal e) f ≠ 0 := by
  exact Ising2DLambda.NecSuf.KacWard.three_factor_coefficient_ne_zero
    (gaugePairWeight z s e f) (twistSign s f : Qbar)
    (rotationPhase z (reversal e) f)
    (gaugePairWeight_ne_zero z hz s e f)
    (twistSign_qbar_ne_zero s f)
    (shortPairRotationPhase_ne_zero z hz e f hsource hne)

end Ising2DLambda.KacWard
