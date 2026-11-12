/-
`claim_cut_realization_preserves_multiplication` の具体版が、必要十分版
`cutRealization_preserves_multiplication_necSuf` の α := 実閉部分体、rational := 有理数の所属、
lt := 狭義順序 <_R への特殊化として得られること。
推移律は `claim_real_algebraic_order_transitive`、非反射性と網羅性は三分法、
ratLt・ratPos は正の有理数の正値性と狭義順序の定義、subPos は狭義順序の定義、
posMul・posAddNonneg は正錐の閉性、ratZero・ratAdd・ratMul は部分体の演算、
pinch は `claim_real_algebraic_rational_pinching` から与える。
-/
import Ising2DLambda.RealEscape.CutRealizationPreservesMultiplication
import Ising2DLambda.NecSuf.RealEscape.CutRealizationPreservesMultiplication

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

theorem cutRealization_preserves_multiplication_from_necSuf (data : RealClosedSubfieldData)
    (a b : data.carrier) :
    realAlgebraicCutRealization data (a * b) =
      realAlgebraicCutRealization data a * realAlgebraicCutRealization data b := by
  exact Ising2DLambda.NecSuf.RealEscape.cutRealization_preserves_multiplication_necSuf
    (rational := realClosedRat data) (lt := realAlgebraicLt data)
    (realAlgebraicLt_trans data) (realAlgebraicLt_irrefl data)
    (fun _ _ h => realAlgebraic_rat_lt_of_lt data h)
    (realAlgebraicLt_iff_pos_sub data)
    (fun _ _ hu hv => realAlgebraic_pos_mul data hu hv)
    (fun _ _ hu hv => realAlgebraic_pos_add_nonneg data hu (hv.imp id Eq.symm))
    (fun q hq => by rw [realClosedRat_eq_cast]; exact realAlgebraic_rat_pos data hq)
    (realClosedRat_zero data) (realClosedRat_add data) (realClosedRat_mul data)
    (fun x => (realAlgebraicLt_trichotomy data x 0).1)
    (fun x ε hε => by
      obtain ⟨r, s, hr, hs, _, hw⟩ := realAlgebraic_rational_pinching data x hε
      exact ⟨r, s, hr, hs, hw⟩)
    a b

end Ising2DLambda.RealEscape
