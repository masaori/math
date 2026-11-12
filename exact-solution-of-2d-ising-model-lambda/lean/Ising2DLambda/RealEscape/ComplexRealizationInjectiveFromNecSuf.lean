/-
`claim_complex_realization_injective` の具体版が、必要十分版
`complexRealization_injective_necSuf` の α := Q̄、β := 実閉部分体、coeff := 包含、
scale := b ↦ bω、decomposition := 一意表示の選択、realization := 下切断の上限による実現写像
への特殊化として得られること。represent と unique は `def_real_closed_subfield` の一意表示、
realInj は `claim_cut_realization_preserves_strict_order` の単射性から与える。
-/
import Ising2DLambda.RealEscape.ComplexRealizationInjective
import Ising2DLambda.RealEscape.ComplexRealizationPreservesAdditionFromNecSuf
import Ising2DLambda.NecSuf.RealEscape.ComplexRealizationInjective

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue

theorem complexAlgebraicRealization_injective_from_necSuf (data : RealClosedSubfieldData) :
    Function.Injective (complexAlgebraicRealization data) := by
  rw [complexAlgebraicRealization_eq_necSuf]
  exact Ising2DLambda.NecSuf.RealEscape.complexRealization_injective_necSuf
    (α := Qbar) (β := data.carrier)
    (fun a : data.carrier => (a : Qbar))
    (fun b : data.carrier => (b : Qbar) * data.omega)
    (fun xi => Classical.choose (data.unique_decomposition xi))
    (realAlgebraicCutRealization data)
    (fun xi => by
      obtain ⟨⟨a, b⟩, h, -⟩ := data.unique_decomposition xi
      exact ⟨a, b, h⟩)
    (fun xi a b h =>
      ((Classical.choose_spec (data.unique_decomposition xi)).2 (a, b) h).symm)
    (cutRealization_injective data)

end Ising2DLambda.RealEscape
