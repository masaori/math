/- `claim_critical_point_lt_one` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.CriticalExponent.CriticalPointLtOne
import Ising2DLambda.NecSuf.CriticalExponent.CriticalPointLtOne

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

theorem criticalPoint_lt_one_from_necSuf
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2) :
    realAlgebraicLt data.toRealClosedSubfieldData
      (criticalPointRealClosed data.toRealClosedSubfieldData s hs) 1 := by
  let base := data.toRealClosedSubfieldData
  obtain ⟨w, hw0, hsw⟩ := data.sqrtTwo_square
  have hsCarrier : (w * w) * (w * w) = (1 + 1 : base.carrier) := by
    apply Subtype.ext
    push_cast
    rw [← hsw]
    norm_num
    exact hs
  obtain ⟨z, hz0, hz⟩ :=
    Ising2DLambda.NecSuf.CriticalExponent.criticalPoint_lt_one_necSuf
      (K := base.carrier) (w * w) w hw0 rfl hsCarrier
      (realClosed_sum_of_two_squares_is_square base)
      (fun a b h => by
        apply realClosed_sq_add_sq_eq_zero base a b
        exact_mod_cast h)
  refine ⟨z, hz0, ?_⟩
  have hxc : criticalPointRealClosed base s hs = -1 + w * w := by
    apply Subtype.ext
    rw [criticalPointRealClosed_val]
    push_cast
    rw [← hsw]
  rw [hxc]
  simpa using hz

end Ising2DLambda.CriticalExponent
