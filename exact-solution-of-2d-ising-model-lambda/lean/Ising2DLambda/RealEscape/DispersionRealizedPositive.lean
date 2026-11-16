/-
`claim_dispersion_product_real_log_sum` のうち、各分散因子の実現値の正値性。
可算側の正値分解を実現写像の狭義順序保存で実数へ移す。
残りの有限積と実対数の等式は別の段で扱う。
-/
import Ising2DLambda.KacWard.DispersionPositiveAtRationalPoint
import Ising2DLambda.RealEscape.CutRealizationPreservesStrictOrder

namespace Ising2DLambda.RealEscape

open Ising2DLambda.KacWard
open Ising2DLambda.FisherZero
open Ising2DLambda.CriticalExponent
open Ising2DLambda.AlgebraicEigenvalue

/-- 各モードの分散因子には、正の実現値を持つ `R` の元がある。 -/
theorem dispersion_realized_positive (data : RealClosedSubfieldData) (L : ℕ)
    (hL : 1 ≤ L) (spin : SpinStructure) (varpi varsigma : Qbar)
    (hvarpi : varpi ∈ horizontalTwistedModes L spin)
    (hvarsigma : varsigma ∈ verticalTwistedModes L spin)
    (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    ∃ D : data.carrier,
      (D : Qbar) = (dispersionPolynomial varpi varsigma).eval (q : Qbar) ∧
      0 < realAlgebraicCutRealization data D := by
  obtain ⟨D, hD, hp, hle⟩ :=
    dispersion_positive_at_rationalPoint data L hL spin varpi varsigma
      hvarpi hvarsigma q hq0 hq1
  have hpos : realAlgebraicLt data 0 D := by
    rcases hle with hlt | heq
    · exact realAlgebraicLt_trans data _ _ _ hp hlt
    · rw [← heq]
      exact hp
  refine ⟨D, hD, ?_⟩
  have hreal := cutRealization_preserves_strict_order data hpos
  simpa [cutRealization_zero] using hreal

end Ising2DLambda.RealEscape
