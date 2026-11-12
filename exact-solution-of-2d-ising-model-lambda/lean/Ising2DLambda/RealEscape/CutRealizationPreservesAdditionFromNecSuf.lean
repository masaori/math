/-
`claim_cut_realization_preserves_addition` の具体版が、必要十分版 `cutRealization_preserves_addition_necSuf` の
α := 実閉部分体、rational := 有理数の所属、lt := 狭義順序 <_R への特殊化として得られること。
推移律は `claim_real_algebraic_order_transitive`、非反射性は三分法の排他性、
ratLt は正の有理数の正値性と狭義順序の定義、addRight・addLeft は狭義順序の定義（差が変わらない）、
ratAdd は部分体の加法、hpa・hpb は `claim_real_algebraic_rational_pinching` から与える。
-/
import Ising2DLambda.RealEscape.CutRealizationPreservesAddition
import Ising2DLambda.NecSuf.RealEscape.CutRealizationPreservesAddition

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

theorem cutRealization_preserves_addition_from_necSuf (data : RealClosedSubfieldData)
    (a b : data.carrier) :
    realAlgebraicCutRealization data (a + b) =
      realAlgebraicCutRealization data a + realAlgebraicCutRealization data b := by
  have hpinch : ∀ x : data.carrier, ∀ ε : ℚ, 0 < ε → ∃ r s : ℚ,
      realAlgebraicLt data (realClosedRat data r) x ∧
        realAlgebraicLt data x (realClosedRat data s) ∧ s - r < ε := by
    intro x ε hε
    obtain ⟨r, s, hr, hs, _, hw⟩ := realAlgebraic_rational_pinching data x hε
    exact ⟨r, s, hr, hs, hw⟩
  exact Ising2DLambda.NecSuf.RealEscape.cutRealization_preserves_addition_necSuf
    (rational := realClosedRat data) (lt := realAlgebraicLt data)
    (realAlgebraicLt_trans data) (realAlgebraicLt_irrefl data)
    (fun _ _ h => realAlgebraic_rat_lt_of_lt data h)
    (fun _ _ w h => realAlgebraicLt_add_right data w h)
    (fun _ _ w h => realAlgebraicLt_add_left data w h)
    (realClosedRat_add data) a b (hpinch a) (hpinch b)

end Ising2DLambda.RealEscape
