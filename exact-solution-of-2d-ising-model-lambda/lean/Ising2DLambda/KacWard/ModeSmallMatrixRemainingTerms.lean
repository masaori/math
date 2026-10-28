import Ising2DLambda.KacWard.ModeSmallMatrixEntries
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

/-- The seven admissible terms other than the two four cycles, computed from the entry table. -/
theorem modeSmallMatrix_remaining_terms
    (z varpi varsigma : Qbar) (hz : z ≠ 0)
    (hvarpi : varpi ≠ 0) (hvarsigma : varsigma ≠ 0) :
    let A : Matrix (ZMod 4) (ZMod 4) QbarPoly :=
      1 - (X : QbarPoly) • (modeSmallMatrix z varpi varsigma).map C
    let d0 : QbarPoly := 1 - X * C varpi
    let d1 : QbarPoly := 1 - X * C varsigma
    let d2 : QbarPoly := 1 - X * C varpi⁻¹
    let d3 : QbarPoly := 1 - X * C varsigma⁻¹
    (A 0 0 * A 1 1 * A 2 2 * A 3 3 = d0 * d1 * d2 * d3) ∧
    (A 0 0 * A 1 1 * A 2 3 * A 3 2 = X ^ 2 * C varpi⁻¹ * C varsigma⁻¹ * d0 * d1) ∧
    (A 0 0 * A 1 2 * A 2 1 * A 3 3 = X ^ 2 * C varpi⁻¹ * C varsigma * d0 * d3) ∧
    (A 0 1 * A 1 0 * A 2 2 * A 3 3 = X ^ 2 * C varpi * C varsigma * d2 * d3) ∧
    (A 0 1 * A 1 0 * A 2 3 * A 3 2 = X ^ 4) ∧
    (A 0 3 * A 1 1 * A 2 2 * A 3 0 = X ^ 2 * C varpi * C varsigma⁻¹ * d1 * d2) ∧
    (A 0 3 * A 1 2 * A 2 1 * A 3 0 = X ^ 4) := by
  dsimp
  rw [modeSmallMatrix_eq_entries]
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  all_goals try simp (config := { decide := true }) [modeSmallMatrixEntries]
  all_goals try field_simp
  all_goals try ring_nf
  all_goals try simp [← map_pow, ← map_mul, hz, hvarpi, hvarsigma]
  all_goals try field_simp
  all_goals try simp

theorem modeSmallMatrix_remaining_terms_of_modes (L : ℕ) (hL : 0 < L)
    (s : SpinStructure) (z varpi varsigma : Qbar) (hz : z ≠ 0)
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s) :
    let A : Matrix (ZMod 4) (ZMod 4) QbarPoly :=
      1 - (X : QbarPoly) • (modeSmallMatrix z varpi varsigma).map C
    let d0 : QbarPoly := 1 - X * C varpi
    let d1 : QbarPoly := 1 - X * C varsigma
    let d2 : QbarPoly := 1 - X * C varpi⁻¹
    let d3 : QbarPoly := 1 - X * C varsigma⁻¹
    (A 0 0 * A 1 1 * A 2 2 * A 3 3 = d0 * d1 * d2 * d3) ∧
    (A 0 0 * A 1 1 * A 2 3 * A 3 2 = X ^ 2 * C varpi⁻¹ * C varsigma⁻¹ * d0 * d1) ∧
    (A 0 0 * A 1 2 * A 2 1 * A 3 3 = X ^ 2 * C varpi⁻¹ * C varsigma * d0 * d3) ∧
    (A 0 1 * A 1 0 * A 2 2 * A 3 3 = X ^ 2 * C varpi * C varsigma * d2 * d3) ∧
    (A 0 1 * A 1 0 * A 2 3 * A 3 2 = X ^ 4) ∧
    (A 0 3 * A 1 1 * A 2 2 * A 3 0 = X ^ 2 * C varpi * C varsigma⁻¹ * d1 * d2) ∧
    (A 0 3 * A 1 2 * A 2 1 * A 3 0 = X ^ 4) := by
  have hp : varpi ≠ 0 := by
    intro h
    have hpow := hvarpi
    change varpi ^ L = (if s.1 then -1 else 1) at hpow
    cases hs : s.1 <;> simp [h, hs, Nat.ne_of_gt hL] at hpow
  have hs : varsigma ≠ 0 := by
    intro h
    have hpow := hvarsigma
    change varsigma ^ L = (if s.2 then -1 else 1) at hpow
    cases hs : s.2 <;> simp [h, hs, Nat.ne_of_gt hL] at hpow
  exact modeSmallMatrix_remaining_terms z varpi varsigma hz hp hs

end Ising2DLambda.KacWard
