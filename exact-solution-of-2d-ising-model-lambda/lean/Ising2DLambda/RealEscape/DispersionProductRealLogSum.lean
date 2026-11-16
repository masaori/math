import Ising2DLambda.RealEscape.DispersionProductRealizedPositive
import Ising2DLambda.RealEscape.CutRealizationFiniteProductRealLog
import Ising2DLambda.RealEscape.RealLogAbsoluteSquare
import Ising2DLambda.KacWard.HighTemperaturePartitionBounds

namespace Ising2DLambda.RealEscape

open Ising2DLambda.KacWard
open Ising2DLambda.FisherZero
open Ising2DLambda.CriticalExponent
open Ising2DLambda.ThermodynamicLimit
open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

/-- `Q_L^{a,b}(q)` の実対数を、実際のねじれたモードの分散因子の和へ移す。 -/
theorem dispersion_product_real_log_sum {L : ℕ} [NeZero L]
    (data : RealClosedSubfieldData) (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    ∃ D : FourierModePair L s → data.carrier,
      (∀ m, (D m : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar)) ∧
      (∀ m, 0 < realAlgebraicCutRealization data (D m)) ∧
      (1 / ((L : ℝ) ^ 2)) *
        Real.log |realAlgebraicCutRealization data
          (realClosedRat data (signedEvenSubgraphValue L q s))| =
        (1 / (2 * ((L : ℝ) ^ 2))) *
          ∑ m : FourierModePair L s,
            Real.log (realAlgebraicCutRealization data (D m)) := by
  classical
  obtain ⟨D, hD, hpos, hsq⟩ :=
    dispersion_product_realized_positive (L := L) data z hz s q hq0 hq1
  refine ⟨D, hD, hpos, ?_⟩
  let Q : data.carrier := realClosedRat data (signedEvenSubgraphValue L q s)
  let T : ℝ := realAlgebraicCutRealization data Q
  have hprod : Q ^ 2 = ∏ m : FourierModePair L s, D m := by
    apply Subtype.ext
    have hqbar := signedEvenSubgraphPolynomial_qbar_eval_rat L s q
    change ((Q : Qbar) ^ 2) = ((∏ m : FourierModePair L s, D m : data.carrier) : Qbar)
    rw [hsq, hqbar]
    rfl
  have hprodpos : 0 < realAlgebraicCutRealization data
      (∏ m : FourierModePair L s, D m) := by
    rw [cutRealization_finiteProduct]
    exact Finset.prod_pos (fun m _ => hpos m)
  have hTprod : T ^ 2 = realAlgebraicCutRealization data
      (∏ m : FourierModePair L s, D m) := by
    calc
      T ^ 2 = T * T := by ring
      _ = realAlgebraicCutRealization data (Q * Q) :=
        (cutRealization_preserves_multiplication data Q Q).symm
      _ = realAlgebraicCutRealization data (∏ m : FourierModePair L s, D m) := by
        rw [← pow_two, hprod]
  have hT : T ≠ 0 := by
    intro hzero
    have hsqpos : 0 < T ^ 2 := hTprod ▸ hprodpos
    simpa [hzero] using hsqpos
  have hlogabs := realLog_abs_eq_half_realLog_sq T hT
  have hlogprod := cutRealization_realLog_finiteProduct data
    (Finset.univ : Finset (FourierModePair L s)) D hpos
  change Real.log |T| = (1 / 2 : ℝ) * Real.log (T ^ 2) at hlogabs
  have hlogsum : Real.log (T ^ 2) =
      ∑ m : FourierModePair L s, Real.log (realAlgebraicCutRealization data (D m)) := by
    calc
      Real.log (T ^ 2) = Real.log (realAlgebraicCutRealization data
          (∏ m : FourierModePair L s, D m)) := congrArg Real.log hTprod
      _ = ∑ m : FourierModePair L s,
          Real.log (realAlgebraicCutRealization data (D m)) := hlogprod
  change (1 / ((L : ℝ) ^ 2)) * Real.log |T| = _
  rw [hlogabs, hlogsum]
  ring

end Ising2DLambda.RealEscape
