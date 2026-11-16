import Ising2DLambda.RealEscape.DispersionRealizedPositive
import Ising2DLambda.RealEscape.DispersionProductSquareEvaluation

namespace Ising2DLambda.RealEscape

open Ising2DLambda.KacWard
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Polynomial

/-- 各モードの正の分散因子を `R` で選び、その有限積を平方の値へ戻す。 -/
theorem dispersion_product_realized_positive {L : ℕ} [NeZero L]
    (data : RealClosedSubfieldData) (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    ∃ D : FourierModePair L s → data.carrier,
      (∀ m, (D m : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar)) ∧
      (∀ m, 0 < realAlgebraicCutRealization data (D m)) ∧
      ((∏ m : FourierModePair L s, D m : data.carrier) : Qbar) =
        (((signedEvenSubgraphPolynomial L (spinComponentFin s.1)
          (spinComponentFin s.2)).map (Int.castRingHom Qbar)).eval (q : Qbar)) ^ 2 := by
  classical
  have hL : 1 ≤ L := Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)
  have hm (m : FourierModePair L s) :
      ∃ d : data.carrier,
        (d : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) ∧
        0 < realAlgebraicCutRealization data d :=
    dispersion_realized_positive data L hL s m.1.1 m.1.2 m.2.1 m.2.2 q hq0 hq1
  let D (m : FourierModePair L s) : data.carrier := (hm m).choose
  have hD (m : FourierModePair L s) :
      (D m : Qbar) = (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) :=
    (hm m).choose_spec.1
  have hpos (m : FourierModePair L s) : 0 < realAlgebraicCutRealization data (D m) :=
    (hm m).choose_spec.2
  refine ⟨D, hD, hpos, ?_⟩
  calc
    ((∏ m : FourierModePair L s, D m : data.carrier) : Qbar)
        = ∏ m : FourierModePair L s, (D m : Qbar) := by
          change (Subfield.subtype data.carrier) (∏ m : FourierModePair L s, D m) = _
          rw [map_prod]
          rfl
    _ = ∏ m : FourierModePair L s,
          (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) := by
          apply Finset.prod_congr rfl
          intro m _
          exact hD m
    _ = _ := (signedEvenSubgraph_square_eq_dispersion_product z hz s q).symm

end Ising2DLambda.RealEscape
