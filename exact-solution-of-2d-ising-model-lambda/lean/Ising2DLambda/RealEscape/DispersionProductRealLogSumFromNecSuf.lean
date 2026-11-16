import Ising2DLambda.RealEscape.DispersionProductRealLogSum
import Ising2DLambda.NecSuf.RealEscape.DispersionProductRealLogSum

namespace Ising2DLambda.RealEscape

open Ising2DLambda.KacWard
open Ising2DLambda.FisherZero
open Ising2DLambda.CriticalExponent
open Ising2DLambda.ThermodynamicLimit
open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

/-- 必要十分版を、実際のモード集合と分散多項式の値へ特殊化する。 -/
theorem dispersion_product_real_log_sum_from_necSuf {L : ℕ} [NeZero L]
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
  have hTprod : T ^ 2 = ∏ m : FourierModePair L s,
      realAlgebraicCutRealization data (D m) := by
    calc
      T ^ 2 = T * T := by ring
      _ = realAlgebraicCutRealization data (Q * Q) :=
        (cutRealization_preserves_multiplication data Q Q).symm
      _ = realAlgebraicCutRealization data (∏ m : FourierModePair L s, D m) := by
        rw [← pow_two, hprod]
      _ = ∏ m : FourierModePair L s, realAlgebraicCutRealization data (D m) :=
        cutRealization_finiteProduct data Finset.univ D
  have h := Ising2DLambda.NecSuf.RealEscape.squareProduct_realLog_sum
    (Finset.univ : Finset (FourierModePair L s)) T
    (fun m => realAlgebraicCutRealization data (D m)) hpos hTprod
    (1 / ((L : ℝ) ^ 2))
  change (1 / ((L : ℝ) ^ 2)) * Real.log |T| = _
  convert h using 1; ring

end Ising2DLambda.RealEscape
