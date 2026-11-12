/-
`claim_real_algebraic_rational_bounds` の具体版が、必要十分版 `rational_bounds_necSuf` の
K := 実閉部分体、P := 「0 <_R ·」への特殊化として得られること。
五つの仮定は具体版の順序の事実 (ii)〜(v) と三分法から与え、根の有理係数の和は代数性から与える。
-/
import Ising2DLambda.CriticalExponent.RealAlgebraicRationalBounds
import Ising2DLambda.NecSuf.CriticalExponent.RealAlgebraicRationalBounds

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Finset

theorem realAlgebraic_rational_bounds_from_necSuf (data : RealClosedSubfieldData)
    (a : data.carrier) :
    ∃ B : ℚ, 0 < B ∧
      realAlgebraicLt data (realClosedRat data (-B)) a ∧
      realAlgebraicLt data a (realClosedRat data B) := by
  obtain ⟨p, hp0, hpa⟩ : ∃ p : Polynomial ℚ, p ≠ 0 ∧ Polynomial.aeval (a : Qbar) p = 0 :=
    Algebra.IsAlgebraic.isAlgebraic (R := ℚ) (a : Qbar)
  have hc : p.coeff p.natDegree ≠ 0 := Polynomial.leadingCoeff_ne_zero.mpr hp0
  have hroot : ∑ i ∈ range (p.natDegree + 1), (p.coeff i : data.carrier) * a ^ i = 0 := by
    apply Subtype.ext
    rw [realAlgebraic_polynomial_value data p a, hpa]
    rfl
  have htotal : ∀ z : data.carrier,
      realAlgebraicLt data 0 z ∨ z = 0 ∨ realAlgebraicLt data 0 (-z) := by
    intro z
    rcases (realAlgebraicLt_trichotomy data 0 z).1 with h | h | h
    · exact Or.inl h
    · exact Or.inr (Or.inl h.symm)
    · right
      right
      rw [realAlgebraicLt_iff_pos_sub] at h
      simpa using h
  obtain ⟨B, hB, hlower, hupper⟩ :=
    Ising2DLambda.NecSuf.CriticalExponent.rational_bounds_necSuf
      (K := data.carrier) (P := realAlgebraicLt data 0)
      (fun _ _ hu hv => realAlgebraic_pos_add data hu hv)
      (fun _ _ hu hv => realAlgebraic_pos_mul data hu hv)
      (fun _ hq => realAlgebraic_rat_pos data hq)
      (fun _ hu => realAlgebraic_pos_ne_zero data hu)
      htotal p.natDegree (fun i => p.coeff i) hc a hroot
  refine ⟨B, hB, ?_, ?_⟩
  · rw [realClosedRat_eq_cast, realAlgebraicLt_iff_pos_sub]
    exact hlower
  · rw [realClosedRat_eq_cast, realAlgebraicLt_iff_pos_sub]
    exact hupper

end Ising2DLambda.CriticalExponent
