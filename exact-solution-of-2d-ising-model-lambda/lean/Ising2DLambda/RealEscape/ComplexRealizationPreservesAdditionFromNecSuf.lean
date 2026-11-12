/-
`claim_complex_realization_preserves_addition` の具体版が、必要十分版
`complexRealization_preserves_addition_necSuf` の α := Q̄、β := 実閉部分体、coeff := 包含、
scale := b ↦ bω、decomposition := 一意表示の選択、realization := 下切断の上限による実現写像
への特殊化として得られること。coeffAdd は部分体の加法、scaleAdd は Q̄ の分配法則と部分体の加法、
unique は `def_real_closed_subfield` の一意性、realAdd は `claim_cut_realization_preserves_addition` から与える。
-/
import Ising2DLambda.RealEscape.ComplexRealizationPreservesAddition
import Ising2DLambda.NecSuf.RealEscape.ComplexRealizationPreservesAddition

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版の複素実現は、必要十分版の複素実現を一意表示の選択に特殊化したものに等しい。 -/
theorem complexAlgebraicRealization_eq_necSuf (data : RealClosedSubfieldData) :
    complexAlgebraicRealization data =
      Ising2DLambda.NecSuf.RealEscape.complexRealization
        (fun xi => Classical.choose (data.unique_decomposition xi))
        (realAlgebraicCutRealization data) := rfl

theorem complexAlgebraicRealization_preserves_addition_from_necSuf
    (data : RealClosedSubfieldData) (xi eta : Qbar) :
    complexAlgebraicRealization data (xi + eta) =
      complexAlgebraicRealization data xi + complexAlgebraicRealization data eta := by
  obtain ⟨⟨a, b⟩, hxi, -⟩ := data.unique_decomposition xi
  obtain ⟨⟨c, d⟩, heta, -⟩ := data.unique_decomposition eta
  rw [complexAlgebraicRealization_eq_necSuf]
  exact Ising2DLambda.NecSuf.RealEscape.complexRealization_preserves_addition_necSuf
    (α := Qbar) (β := data.carrier)
    (fun a : data.carrier => (a : Qbar))
    (fun b : data.carrier => (b : Qbar) * data.omega)
    (fun xi => Classical.choose (data.unique_decomposition xi))
    (realAlgebraicCutRealization data)
    (fun a c => Subfield.coe_add _ a c)
    (fun b d => by rw [Subfield.coe_add, add_mul])
    (fun xi a b h =>
      ((Classical.choose_spec (data.unique_decomposition xi)).2 (a, b) h).symm)
    (fun a c => cutRealization_preserves_addition data a c)
    hxi heta

end Ising2DLambda.RealEscape
