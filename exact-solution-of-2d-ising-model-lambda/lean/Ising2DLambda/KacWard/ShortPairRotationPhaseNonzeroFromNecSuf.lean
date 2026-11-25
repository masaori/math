/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ShortPairRotationPhaseNonzero
import Ising2DLambda.NecSuf.KacWard.ShortPairRotationPhaseNonzero

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- Specialization of the abstract three-value argument. -/
theorem shortPairRotationPhase_ne_zero_from_necSuf {L : ℕ} [NeZero L] (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (e f : OrientedEdge L)
    (hsource : orientedSource e = orientedSource f) (hne : e ≠ f) :
    rotationPhase z (reversal e) f ≠ 0 := by
  have hz0 : z ≠ 0 := by
    intro h
    simp [h] at hz
  have hdir : directionNumber f ≠ directionNumber e :=
    (shortPair_direction_ne e f hsource hne).symm
  exact Ising2DLambda.NecSuf.KacWard.three_value_phase_ne_zero z
    (rotationPhase z (reversal e) f) hz0
    (shortPairRotationPhase_three_values z e f hdir)

end Ising2DLambda.KacWard
