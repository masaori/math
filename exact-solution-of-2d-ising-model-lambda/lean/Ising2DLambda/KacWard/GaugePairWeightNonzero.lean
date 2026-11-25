import Ising2DLambda.KacWard.GaugedTerminalMatrix

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- Every gauge coefficient is nonzero for the eighth-root parameter. -/
theorem gaugePairWeight_ne_zero {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e f : OrientedEdge L) :
    gaugePairWeight z s e f ≠ 0 := by
  have hz0 : z ≠ 0 := diagonalGauge_root_ne_zero z hz
  have htwo : z ^ (2 : ℕ) ≠ 0 := pow_ne_zero 2 hz0
  have he : z ^ (-twistGaugeExponent s e) ≠ 0 := zpow_ne_zero _ hz0
  have he' : z ^ (-directionGaugeExponent e) ≠ 0 := zpow_ne_zero _ hz0
  have hf : z ^ directionGaugeExponent f ≠ 0 := zpow_ne_zero _ hz0
  have hf' : z ^ twistGaugeExponent s f ≠ 0 := zpow_ne_zero _ hz0
  change z ^ (2 : ℕ) *
    ((z ^ (-twistGaugeExponent s e) * z ^ (-directionGaugeExponent e)) *
      (z ^ directionGaugeExponent f * z ^ twistGaugeExponent s f)) ≠ 0
  exact mul_ne_zero htwo (mul_ne_zero (mul_ne_zero he he') (mul_ne_zero hf hf'))

end Ising2DLambda.KacWard
