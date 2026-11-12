/-
`claim_complex_realization_preserves_multiplication` の具体版が、必要十分版
`complexRealization_preserves_multiplication_necSuf`・`complexRealization_one_necSuf` の α := Q̄、
β := 実閉部分体、coeff := 部分体の包含（環準同型）、omega := 固定した虚数単位、
decomposition := 一意表示の選択、realization := 下切断の上限による実現写像への特殊化として得られること。
omegaSq は `def_real_closed_subfield` の条件、unique はその一意性、realAdd・realMul は
`claim_cut_realization_preserves_addition`・`claim_cut_realization_preserves_multiplication`、
realZero・realOne は `claim_cut_realization_agrees_on_rationals` から与える。
-/
import Ising2DLambda.RealEscape.ComplexRealizationPreservesMultiplication
import Ising2DLambda.RealEscape.ComplexRealizationPreservesAdditionFromNecSuf
import Ising2DLambda.NecSuf.RealEscape.ComplexRealizationPreservesMultiplication

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue

theorem complexAlgebraicRealization_preserves_multiplication_from_necSuf
    (data : RealClosedSubfieldData) (xi eta : Qbar) :
    complexAlgebraicRealization data (xi * eta) =
      complexAlgebraicRealization data xi * complexAlgebraicRealization data eta := by
  obtain ⟨⟨a, b⟩, hxi, -⟩ := data.unique_decomposition xi
  obtain ⟨⟨c, d⟩, heta, -⟩ := data.unique_decomposition eta
  rw [complexAlgebraicRealization_eq_necSuf]
  exact Ising2DLambda.NecSuf.RealEscape.complexRealization_preserves_multiplication_necSuf
    (α := Qbar) (β := data.carrier) data.carrier.subtype data.omega data.omega_sq
    (fun xi => Classical.choose (data.unique_decomposition xi))
    (realAlgebraicCutRealization data)
    (fun xi a b h =>
      ((Classical.choose_spec (data.unique_decomposition xi)).2 (a, b) h).symm)
    (fun a c => cutRealization_preserves_addition data a c)
    (fun a c => cutRealization_preserves_multiplication data a c)
    (cutRealization_zero data)
    hxi heta

theorem complexAlgebraicRealization_one_from_necSuf (data : RealClosedSubfieldData) :
    complexAlgebraicRealization data 1 = 1 := by
  rw [complexAlgebraicRealization_eq_necSuf]
  exact Ising2DLambda.NecSuf.RealEscape.complexRealization_one_necSuf
    (α := Qbar) (β := data.carrier) data.carrier.subtype data.omega
    (fun xi => Classical.choose (data.unique_decomposition xi))
    (realAlgebraicCutRealization data)
    (fun xi a b h =>
      ((Classical.choose_spec (data.unique_decomposition xi)).2 (a, b) h).symm)
    (cutRealization_zero data) (cutRealization_one data)

end Ising2DLambda.RealEscape
