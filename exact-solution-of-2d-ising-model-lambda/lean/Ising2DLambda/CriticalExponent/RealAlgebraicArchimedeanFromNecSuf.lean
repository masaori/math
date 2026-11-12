/-
`claim_real_algebraic_archimedean` の具体版が、必要十分版 `archimedean_necSuf` の
K := 実閉部分体、P := 「0 <_R ·」への特殊化として得られること。
二つの仮定は具体版の順序の事実（正の和、正の有理数）から与え、有理上下界は
`claim_real_algebraic_rational_bounds` の具体版から与える。
-/
import Ising2DLambda.CriticalExponent.RealAlgebraicArchimedean
import Ising2DLambda.NecSuf.CriticalExponent.RealAlgebraicArchimedean

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

theorem realAlgebraic_archimedean_from_necSuf (data : RealClosedSubfieldData)
    (a : data.carrier) :
    ∃ N : ℕ, 0 < N ∧
      realAlgebraicLt data (realClosedRat data (-(N : ℚ))) a ∧
      realAlgebraicLt data a (realClosedRat data (N : ℚ)) := by
  obtain ⟨B, hB, hlower, hupper⟩ := realAlgebraic_rational_bounds data a
  rw [realClosedRat_eq_cast, realAlgebraicLt_iff_pos_sub] at hlower
  rw [realClosedRat_eq_cast, realAlgebraicLt_iff_pos_sub] at hupper
  obtain ⟨N, hN, hl, hu⟩ :=
    Ising2DLambda.NecSuf.CriticalExponent.archimedean_necSuf
      (K := data.carrier) (P := realAlgebraicLt data 0)
      (fun _ _ hu hv => realAlgebraic_pos_add data hu hv)
      (fun _ hq => realAlgebraic_rat_pos data hq)
      a hB hlower hupper
  refine ⟨N, hN, ?_, ?_⟩
  · rw [realClosedRat_eq_cast, realAlgebraicLt_iff_pos_sub]
    exact hl
  · rw [realClosedRat_eq_cast, realAlgebraicLt_iff_pos_sub]
    exact hu

end Ising2DLambda.CriticalExponent
