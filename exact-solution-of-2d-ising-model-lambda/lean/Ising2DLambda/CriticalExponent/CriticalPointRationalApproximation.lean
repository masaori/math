/- 人手証明 `claim_critical_point_rational_approximation` の具体版。 -/
import Ising2DLambda.CriticalExponent.PositiveRationalMeshWidth
import Ising2DLambda.CriticalExponent.CriticalPointRationalPartitionInterval
import Ising2DLambda.CriticalExponent.PositiveRationalPositiveInRealClosed
import Ising2DLambda.NecSuf.CriticalExponent.CriticalPointRationalApproximation

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- 任意の正の有理誤差に対し、臨界点の平方誤差がそれ未満となる正の有理点がある。 -/
theorem criticalPoint_exists_positiveRational_squareDiff_lt
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2)
    (delta : ℚ) (hDelta : 0 < delta) :
    ∃ q : ℚ, 0 < q ∧
      realAlgebraicLt data.toRealClosedSubfieldData
        ((criticalPointRealClosed data.toRealClosedSubfieldData s hs -
            ⟨(q : Qbar), rational_mem_realClosedCarrier data.toRealClosedSubfieldData q⟩) *
          (criticalPointRealClosed data.toRealClosedSubfieldData s hs -
            ⟨(q : Qbar), rational_mem_realClosedCarrier data.toRealClosedSubfieldData q⟩))
        ⟨(delta : Qbar), rational_mem_realClosedCarrier data.toRealClosedSubfieldData delta⟩ := by
  let base := data.toRealClosedSubfieldData
  let xc := criticalPointRealClosed base s hs
  obtain ⟨N, hN, hWidthPos, hWidthSq⟩ :=
    positiveRational_exists_meshWidth_square_lt delta hDelta
  obtain ⟨k, hkN, hLower, hUpper⟩ :=
    criticalPoint_rationalPartitionInterval data hs N hN
  let pRat : ℚ := (k : ℚ) / (N : ℚ)
  let qRat : ℚ := ((k + 1 : ℕ) : ℚ) / (N : ℚ)
  let hRat : ℚ := 1 / (N : ℚ)
  have hNQ : (0 : ℚ) < (N : ℚ) := by exact_mod_cast (Nat.lt_of_lt_of_le Nat.zero_lt_one hN)
  have hqRat : 0 < qRat := by
    exact div_pos (by exact_mod_cast Nat.succ_pos k) hNQ
  refine ⟨qRat, hqRat, ?_⟩
  let p : base.carrier := ⟨(pRat : Qbar), rational_mem_realClosedCarrier base pRat⟩
  let q : base.carrier := ⟨(qRat : Qbar), rational_mem_realClosedCarrier base qRat⟩
  let h : base.carrier := ⟨(hRat : Qbar), rational_mem_realClosedCarrier base hRat⟩
  let deltaR : base.carrier :=
    ⟨(delta : Qbar), rational_mem_realClosedCarrier base delta⟩
  have hp : p = rationalPartitionPoint base k N := by rfl
  have hq : q = rationalPartitionPoint base (k + 1) N := by rfl
  have hWidth : q - p = h := by
    apply Subtype.ext
    simp [p, q, h, pRat, qRat, hRat]
    field_simp
    ring
  have hLower' : (∃ d : base.carrier, xc - p = d * d) ∨ xc = p := by
    rcases hLower with hStrict | hEqual
    · rcases hStrict with ⟨d, hd0, hd⟩
      exact Or.inl ⟨d, by simpa [base, xc, hp] using hd⟩
    · exact Or.inr (by simpa [base, xc, hp] using hEqual.symm)
  have hUpper' : ∃ a : base.carrier, a ≠ 0 ∧ q - xc = a * a := by
    simpa [base, xc, hq, realAlgebraicLt] using hUpper
  have hPositive' : ∃ e : base.carrier, e ≠ 0 ∧ h = e * e := by
    have hLt := positiveRational_realAlgebraic_positive base hRat hWidthPos
    simpa [h, realAlgebraicLt] using hLt
  have hFineRat : 0 < delta - hRat * hRat := sub_pos.mpr hWidthSq
  have hFineLt := positiveRational_realAlgebraic_positive base
    (delta - hRat * hRat) hFineRat
  have hFine' : ∃ r : base.carrier, r ≠ 0 ∧ deltaR - h * h = r * r := by
    rcases hFineLt with ⟨r, hr0, hr⟩
    refine ⟨r, hr0, ?_⟩
    apply Subtype.ext
    have hrQ := congrArg (fun z : base.carrier => (z : Qbar)) hr
    push_cast at hrQ
    simpa [deltaR, h] using hrQ
  exact Ising2DLambda.NecSuf.CriticalExponent.rational_approximation_square_lt_necSuf
    (realClosed_sum_of_two_squares_is_square base)
    (fun a b hzero => by
      apply realClosed_sq_add_sq_eq_zero base a b
      exact_mod_cast hzero)
    xc p q h deltaR hWidth hLower' hUpper' hPositive' hFine'

end Ising2DLambda.CriticalExponent
