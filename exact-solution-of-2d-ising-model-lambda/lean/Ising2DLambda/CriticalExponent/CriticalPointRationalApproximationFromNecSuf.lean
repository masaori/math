/- 具体版が必要十分版の特殊化として得られることは、具体版の最後の適用で明示している。 -/
import Ising2DLambda.CriticalExponent.CriticalPointRationalApproximation

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

theorem criticalPoint_exists_positiveRational_squareDiff_lt_from_necSuf
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2)
    (delta : ℚ) (hDelta : 0 < delta) :
    ∃ q : ℚ, 0 < q ∧
      realAlgebraicLt data.toRealClosedSubfieldData
        ((criticalPointRealClosed data.toRealClosedSubfieldData s hs -
            ⟨(q : Qbar), rational_mem_realClosedCarrier data.toRealClosedSubfieldData q⟩) *
          (criticalPointRealClosed data.toRealClosedSubfieldData s hs -
            ⟨(q : Qbar), rational_mem_realClosedCarrier data.toRealClosedSubfieldData q⟩))
        ⟨(delta : Qbar), rational_mem_realClosedCarrier data.toRealClosedSubfieldData delta⟩ :=
  criticalPoint_exists_positiveRational_squareDiff_lt data hs delta hDelta

end Ising2DLambda.CriticalExponent
