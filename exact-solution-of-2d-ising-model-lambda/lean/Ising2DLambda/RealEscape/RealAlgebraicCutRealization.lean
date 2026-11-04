/-
有理下切断の上限による実閉部分体の実現写像の具体版。
実数の完備性で下切断の実数像の上限を取る段が ℝ への脱出である。
-/
import Ising2DLambda.FisherZero.RealAlgebraicOrder
import Mathlib.Algebra.Order.Archimedean.Real.Hom

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue

/-- `def_real_algebraic_cut_realization`。有理下切断の実数像の上限。 -/
noncomputable def realAlgebraicCutRealization (data : RealClosedSubfieldData)
    (a : data.carrier) : ℝ :=
  sSup {x : ℝ | ∃ q : ℚ,
    realAlgebraicLt data ⟨(q : Qbar), rational_mem_realClosedCarrier data q⟩ a ∧
      x = (q : ℝ)}

end Ising2DLambda.RealEscape
