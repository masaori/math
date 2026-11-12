/-
`claim_cut_realization_agrees_on_rationals` の具体版が、必要十分版 `cutRealization_agrees_on_rationals_necSuf` の
α := 実閉部分体、rational := 有理数の所属、lt := 狭義順序 <_R への特殊化として得られること。
推移律は `claim_real_algebraic_order_transitive`、非反射性は三分法の排他性、
ratLt は正の有理数の正値性と狭義順序の定義から与える。
-/
import Ising2DLambda.RealEscape.CutRealizationAgreesOnRationals
import Ising2DLambda.NecSuf.RealEscape.CutRealizationAgreesOnRationals

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

theorem cutRealization_agrees_on_rationals_from_necSuf (data : RealClosedSubfieldData) (q : ℚ) :
    realAlgebraicCutRealization data (realClosedRat data q) = (q : ℝ) :=
  Ising2DLambda.NecSuf.RealEscape.cutRealization_agrees_on_rationals_necSuf
    (rational := realClosedRat data) (lt := realAlgebraicLt data)
    (realAlgebraicLt_trans data) (realAlgebraicLt_irrefl data)
    (fun _ _ h => realAlgebraic_rat_lt_of_lt data h) q

end Ising2DLambda.RealEscape
