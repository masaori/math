/-
`claim_real_algebraic_lower_cut_has_supremum` の具体版が、必要十分版 `lower_cut_has_supremum_necSuf` の
α := 実閉部分体、rational := 有理数の所属、lt := 狭義順序 <_R への特殊化として得られること。
推移律は `claim_real_algebraic_order_transitive`、非反射性は三分法の排他性、
ratLt は正の有理数の正値性、挟み込みは `claim_real_algebraic_rational_pinching`（ε := 1）から与える。
-/
import Ising2DLambda.RealEscape.RealAlgebraicLowerCutSupremum
import Ising2DLambda.NecSuf.RealEscape.RealAlgebraicLowerCutSupremum

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

theorem realAlgebraic_lower_cut_has_supremum_from_necSuf (data : RealClosedSubfieldData)
    (a : data.carrier) :
    (realAlgebraicLowerCutImage data a).Nonempty ∧
      BddAbove (realAlgebraicLowerCutImage data a) ∧
      IsLUB (realAlgebraicLowerCutImage data a) (realAlgebraicCutRealization data a) := by
  obtain ⟨r, s, hr, hs, _, _⟩ := realAlgebraic_rational_pinching data a (ε := 1) one_pos
  exact Ising2DLambda.NecSuf.RealEscape.lower_cut_has_supremum_necSuf
    (rational := realClosedRat data) (lt := realAlgebraicLt data)
    (realAlgebraicLt_trans data) (realAlgebraicLt_irrefl data)
    (fun _ _ h => realAlgebraic_rat_lt_of_sub_pos data (realAlgebraic_rat_sub_pos data h))
    a ⟨r, s, hr, hs⟩

end Ising2DLambda.RealEscape
