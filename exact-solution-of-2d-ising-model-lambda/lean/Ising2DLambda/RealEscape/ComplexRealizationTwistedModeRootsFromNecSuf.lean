/-
`claim_complex_realization_twisted_modes_are_complex_roots` の具体版が、必要十分版
`complexRealization_root_necSuf` の α := Q̄、β := 実閉部分体、coeff := 包含、scale := b ↦ bω、
decomposition := 一意表示の選択、realization := 下切断の上限による実現写像、t := (-1)^c、
q := (-1)^c、z₀ := 0、r := (-1)^c への特殊化として得られること。mulPres・onePres は
`claim_complex_realization_preserves_multiplication`、unique は `def_real_closed_subfield` の一意性、
realQ・realZero は `claim_cut_realization_agrees_on_rationals` から与える。
-/
import Ising2DLambda.RealEscape.ComplexRealizationTwistedModeRoots
import Ising2DLambda.RealEscape.ComplexRealizationPreservesAdditionFromNecSuf
import Ising2DLambda.NecSuf.RealEscape.ComplexRealizationTwistedModeRoots

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent
open Ising2DLambda.KacWard

/-- (-1)^c の値が ℚ から ℝ を経て ℂ へ送った (-1)^c に等しいこと、と Q̄ での係数表示。 -/
theorem signRat_cast_complex (c : Bool) :
    ((((if c then -1 else 1 : ℚ)) : ℝ) : ℂ) = (if c then -1 else 1 : ℂ) := by
  cases c <;> simp

theorem signRat_decomposition (data : RealClosedSubfieldData) (c : Bool) :
    (if c then -1 else 1 : Qbar) =
      ((realClosedRat data (if c then -1 else 1) : data.carrier) : Qbar) +
        ((0 : data.carrier) : Qbar) * data.omega := by
  cases c <;> simp [realClosedRat]

theorem complexAlgebraicRealization_mode_pow_from_necSuf (data : RealClosedSubfieldData)
    (L : ℕ) (c : Bool) {w : Qbar} (hw : w ^ L = (if c then -1 else 1 : Qbar)) :
    complexAlgebraicRealization data w ^ L = (if c then -1 else 1 : ℂ) := by
  rw [← signRat_cast_complex c, complexAlgebraicRealization_eq_necSuf]
  exact Ising2DLambda.NecSuf.RealEscape.complexRealization_root_necSuf
    (α := Qbar) (β := data.carrier)
    (fun a : data.carrier => (a : Qbar))
    (fun b : data.carrier => (b : Qbar) * data.omega)
    (fun xi => Classical.choose (data.unique_decomposition xi))
    (realAlgebraicCutRealization data)
    (complexAlgebraicRealization_preserves_multiplication data)
    (complexAlgebraicRealization_one data)
    (fun xi a b h =>
      ((Classical.choose_spec (data.unique_decomposition xi)).2 (a, b) h).symm)
    (signRat_decomposition data c)
    (cutRealization_agrees_on_rationals data _)
    (cutRealization_zero data)
    L hw

theorem complexAlgebraicRealization_horizontalMode_pow_from_necSuf
    (data : RealClosedSubfieldData) (L : ℕ) (s : SpinStructure) {w : Qbar}
    (hw : w ∈ horizontalTwistedModes L s) :
    complexAlgebraicRealization data w ^ L = (if s.1 then -1 else 1 : ℂ) :=
  complexAlgebraicRealization_mode_pow_from_necSuf data L s.1 hw

theorem complexAlgebraicRealization_verticalMode_pow_from_necSuf
    (data : RealClosedSubfieldData) (L : ℕ) (s : SpinStructure) {w : Qbar}
    (hw : w ∈ verticalTwistedModes L s) :
    complexAlgebraicRealization data w ^ L = (if s.2 then -1 else 1 : ℂ) :=
  complexAlgebraicRealization_mode_pow_from_necSuf data L s.2 hw

end Ising2DLambda.RealEscape
