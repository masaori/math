/-
`claim_real_algebraic_rational_pinching` の具体版が、必要十分版 `rational_pinching_necSuf` の
K := 実閉部分体、P := 「0 <_R ·」への特殊化として得られること。
四つの仮定は具体版の順序の事実（正の和、正の有理数）と三分法
（`claim_real_algebraic_order_trichotomy` の網羅性から trichotomy、排他性から notPosZero）から与え、
Archimedes 性は `claim_real_algebraic_archimedean` の具体版から与える。
-/
import Ising2DLambda.CriticalExponent.RealAlgebraicRationalPinching
import Ising2DLambda.NecSuf.CriticalExponent.RealAlgebraicRationalPinching

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

theorem realAlgebraic_rational_pinching_from_necSuf (data : RealClosedSubfieldData)
    (a : data.carrier) {ε : ℚ} (hε : 0 < ε) :
    ∃ r s : ℚ, realAlgebraicLt data (realClosedRat data r) a ∧
      realAlgebraicLt data a (realClosedRat data s) ∧ 0 < s - r ∧ s - r < ε := by
  obtain ⟨M, _, hlo, hhi⟩ := realAlgebraic_archimedean data a
  rw [realClosedRat_eq_cast, realAlgebraicLt_iff_pos_sub] at hlo
  rw [realClosedRat_eq_cast, realAlgebraicLt_iff_pos_sub] at hhi
  have notPosZero : ¬ realAlgebraicLt data 0 0 := fun h =>
    (realAlgebraicLt_trichotomy data 0 0).2.1 ⟨h, rfl⟩
  have trichotomy : ∀ u : data.carrier,
      realAlgebraicLt data 0 u ∨ u = 0 ∨ realAlgebraicLt data 0 (-u) := by
    intro u
    rcases (realAlgebraicLt_trichotomy data 0 u).1 with h | h | h
    · exact Or.inl h
    · exact Or.inr (Or.inl h.symm)
    · right; right
      rw [realAlgebraicLt_iff_pos_sub, zero_sub] at h
      exact h
  obtain ⟨r, s, hr, hs, hpos, hlt⟩ :=
    Ising2DLambda.NecSuf.CriticalExponent.rational_pinching_necSuf
      (K := data.carrier) (P := realAlgebraicLt data 0)
      (fun _ _ hu hv => realAlgebraic_pos_add data hu hv)
      (fun _ hq => realAlgebraic_rat_pos data hq)
      notPosZero trichotomy a hlo hhi hε
  refine ⟨r, s, ?_, ?_, hpos, hlt⟩
  · rw [realClosedRat_eq_cast, realAlgebraicLt_iff_pos_sub]
    exact hr
  · rw [realClosedRat_eq_cast, realAlgebraicLt_iff_pos_sub]
    exact hs

end Ising2DLambda.CriticalExponent
