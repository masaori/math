/- `claim_positive_rational_positive_in_real_closed` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.CriticalExponent.PositiveRationalPositiveInRealClosed
import Ising2DLambda.NecSuf.CriticalExponent.PositiveRationalPositiveInRealClosed

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

theorem positiveRational_realAlgebraic_positive_from_necSuf
    (data : RealClosedSubfieldData) (q : ℚ) (hq : 0 < q) :
    realAlgebraicLt data 0
      ⟨(q : Qbar), rational_mem_realClosedCarrier data q⟩ := by
  have hnumPos : 0 < q.num := Rat.num_pos.mpr hq
  have haInt : ((q.num.toNat : ℕ) : ℤ) = q.num := Int.toNat_of_nonneg hnumPos.le
  have haPos : 1 ≤ q.num.toNat := by omega
  have hbPos : 1 ≤ q.den := q.den_pos
  obtain ⟨z, hz0, hz⟩ :=
    Ising2DLambda.NecSuf.CriticalExponent.positiveRational_positive_necSuf
      (K := data.carrier)
      (realClosed_sum_of_two_squares_is_square data)
      (fun a b h => by
        apply realClosed_sq_add_sq_eq_zero data a b
        exact_mod_cast h)
      (q.num.toNat - 1) (q.den - 1)
  have hsuccNum : q.num.toNat - 1 + 1 = q.num.toNat := by omega
  have hsuccDen : q.den - 1 + 1 = q.den := by omega
  rw [hsuccNum, hsuccDen] at hz
  refine ⟨z, hz0, ?_⟩
  have hqR : (⟨(q : Qbar), rational_mem_realClosedCarrier data q⟩ : data.carrier)
      = ((q.num.toNat : ℕ) : data.carrier) / ((q.den : ℕ) : data.carrier) := by
    apply Subtype.ext
    push_cast
    rw [Rat.cast_def]
    congr 1
    exact_mod_cast haInt.symm
  rw [hqR]
  exact hz

end Ising2DLambda.CriticalExponent
