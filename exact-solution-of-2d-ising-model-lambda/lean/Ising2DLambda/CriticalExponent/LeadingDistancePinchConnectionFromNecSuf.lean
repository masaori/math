/- 具体版が必要十分版の特殊化として得られることは、具体版の合成の適用で明示している。 -/
import Ising2DLambda.CriticalExponent.LeadingDistancePinchConnection

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

theorem leadingDistance_pinching_implies_predicate_from_necSuf
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2)
    (hHyp : ∀ eta : ℚ, 0 < eta →
      ∃ (L : ℕ) (inst : NeZero L) (hL : 2 ≤ L),
        realAlgebraicLt data.toRealClosedSubfieldData
          (@leadingDistance L inst hL data.toRealClosedSubfieldData s hs)
          ⟨(eta : Qbar),
            rational_mem_realClosedCarrier data.toRealClosedSubfieldData eta⟩)
    (eps : PositiveRational) :
    zeroPinchingPredicate data.toRealClosedSubfieldData eps :=
  leadingDistance_pinching_implies_predicate data hs hHyp eps

end Ising2DLambda.CriticalExponent
