/-
`claim_cut_realization_preserves_strict_order` の具体版が、必要十分版
`cutRealization_preserves_strict_order_necSuf`・`cutRealization_injective_necSuf` の α := 実閉部分体、
rational := 有理数の所属、lt := 狭義順序 <_R への特殊化として得られること。
仮定の与え方は乗法の保存の導出版と同じで、ratOne は部分体の 1 から与える。
-/
import Ising2DLambda.RealEscape.CutRealizationPreservesStrictOrder
import Ising2DLambda.NecSuf.RealEscape.CutRealizationPreservesStrictOrder

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

theorem cutRealization_preserves_strict_order_from_necSuf (data : RealClosedSubfieldData)
    {a b : data.carrier} (hab : realAlgebraicLt data a b) :
    realAlgebraicCutRealization data a < realAlgebraicCutRealization data b ∧
      Function.Injective (realAlgebraicCutRealization data) := by
  have hpinch : ∀ x : data.carrier, ∀ ε : ℚ, 0 < ε → ∃ r s : ℚ,
      realAlgebraicLt data (realClosedRat data r) x ∧
        realAlgebraicLt data x (realClosedRat data s) ∧ s - r < ε := by
    intro x ε hε
    obtain ⟨r, s, hr, hs, _, hw⟩ := realAlgebraic_rational_pinching data x hε
    exact ⟨r, s, hr, hs, hw⟩
  have hpos : ∀ q : ℚ, 0 < q → realAlgebraicLt data 0 (realClosedRat data q) := fun q hq => by
    rw [realClosedRat_eq_cast]; exact realAlgebraic_rat_pos data hq
  exact ⟨Ising2DLambda.NecSuf.RealEscape.cutRealization_preserves_strict_order_necSuf
      (rational := realClosedRat data) (lt := realAlgebraicLt data)
      (realAlgebraicLt_trans data) (realAlgebraicLt_irrefl data)
      (fun _ _ h => realAlgebraic_rat_lt_of_lt data h)
      (realAlgebraicLt_iff_pos_sub data)
      (fun _ _ hu hv => realAlgebraic_pos_mul data hu hv)
      (fun _ _ hu hv => realAlgebraic_pos_add_nonneg data hu (hv.imp id Eq.symm))
      hpos (realClosedRat_zero data) (realClosedRat_one data)
      (realClosedRat_add data) (realClosedRat_mul data)
      (fun x => (realAlgebraicLt_trichotomy data x 0).1) hpinch hab,
    Ising2DLambda.NecSuf.RealEscape.cutRealization_injective_necSuf
      (rational := realClosedRat data) (lt := realAlgebraicLt data)
      (realAlgebraicLt_trans data) (realAlgebraicLt_irrefl data)
      (fun _ _ h => realAlgebraic_rat_lt_of_lt data h)
      (realAlgebraicLt_iff_pos_sub data)
      (fun _ _ hu hv => realAlgebraic_pos_mul data hu hv)
      (fun _ _ hu hv => realAlgebraic_pos_add_nonneg data hu (hv.imp id Eq.symm))
      hpos (realClosedRat_zero data) (realClosedRat_one data)
      (realClosedRat_add data) (realClosedRat_mul data)
      (fun x => (realAlgebraicLt_trichotomy data x 0).1) hpinch⟩

end Ising2DLambda.RealEscape
