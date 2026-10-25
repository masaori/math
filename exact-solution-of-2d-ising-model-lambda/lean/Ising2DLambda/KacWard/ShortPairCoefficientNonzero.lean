import Ising2DLambda.KacWard.TaggedMatchingExpansion
import Ising2DLambda.KacWard.GaugePairWeightNonzero
import Ising2DLambda.KacWard.TwistSignNonzero
import Ising2DLambda.KacWard.ShortPairRotationPhaseNonzero
import Ising2DLambda.NecSuf.KacWard.ShortPairCoefficientNonzero

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The scalar coefficient of an admissible short pair is nonzero. -/
theorem shortPairCoefficient_ne_zero {L : ℕ} [NeZero L]
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (e f : OrientedEdge L) (hsource : orientedSource e = orientedSource f)
    (hne : e ≠ f) :
    (gaugePairWeight z s e f * (twistSign s f : Qbar)) *
      rotationPhase z (reversal e) f ≠ 0 := by
  have hw : gaugePairWeight z s e f ≠ 0 :=
    gaugePairWeight_ne_zero z hz s e f
  have hε : (twistSign s f : Qbar) ≠ 0 :=
    twistSign_qbar_ne_zero s f
  have hρ : rotationPhase z (reversal e) f ≠ 0 :=
    shortPairRotationPhase_ne_zero z hz e f hsource hne
  have hpair : gaugePairWeight z s e f * (twistSign s f : Qbar) ≠ 0 :=
    mul_ne_zero hw hε
  exact mul_ne_zero hpair hρ

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
