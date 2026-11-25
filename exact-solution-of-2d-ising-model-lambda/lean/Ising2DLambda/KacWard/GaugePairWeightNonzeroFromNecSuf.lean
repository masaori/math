/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.GaugePairWeightNonzero
import Ising2DLambda.NecSuf.KacWard.GaugePairWeightNonzero

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The concrete coefficient specializes the field calculation after reassociation. -/
theorem gaugePairWeight_ne_zero_from_necSuf {L : ℕ} (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) (e f : OrientedEdge L) :
    gaugePairWeight z s e f ≠ 0 := by
  have hz0 : z ≠ 0 := diagonalGauge_root_ne_zero z hz
  change z ^ (2 : ℕ) *
    ((z ^ (-twistGaugeExponent s e) * z ^ (-directionGaugeExponent e)) *
      (z ^ directionGaugeExponent f * z ^ twistGaugeExponent s f)) ≠ 0
  exact Ising2DLambda.NecSuf.KacWard.gauge_pair_weight_ne_zero_necSuf z hz0
    (-twistGaugeExponent s e) (-directionGaugeExponent e)
    (directionGaugeExponent f) (twistGaugeExponent s f)

end Ising2DLambda.KacWard
