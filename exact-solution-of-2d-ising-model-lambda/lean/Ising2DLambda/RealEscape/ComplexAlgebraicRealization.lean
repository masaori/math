import Ising2DLambda.RealEscape.RealAlgebraicCutRealization
import Mathlib.Data.Complex.Basic

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue

/-- `def_complex_algebraic_realization`。一意な二係数表示を実数の実部と虚部へ送る。 -/
noncomputable def complexAlgebraicRealization (data : RealClosedSubfieldData)
    (xi : Qbar) : ℂ :=
  let ab := Classical.choose (data.unique_decomposition xi)
  (realAlgebraicCutRealization data ab.1 : ℂ) +
    Complex.I * (realAlgebraicCutRealization data ab.2 : ℂ)

theorem complexAlgebraicRealization_eq (data : RealClosedSubfieldData)
    (xi : Qbar) (a b : data.carrier)
    (h : xi = (a : Qbar) + (b : Qbar) * data.omega) :
    complexAlgebraicRealization data xi =
      (realAlgebraicCutRealization data a : ℂ) +
        Complex.I * (realAlgebraicCutRealization data b : ℂ) := by
  have hab := (Classical.choose_spec (data.unique_decomposition xi)).2 (a, b) h
  simp only [complexAlgebraicRealization, ← hab]

end Ising2DLambda.RealEscape
