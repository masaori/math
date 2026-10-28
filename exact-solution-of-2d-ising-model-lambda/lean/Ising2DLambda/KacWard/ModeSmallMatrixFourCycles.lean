import Ising2DLambda.KacWard.ModeSmallMatrixEntries
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

/- claim_mode_small_matrix_four_cycle_terms: substitute four entries, group the
   factors, cancel the mode inverses, and use the fourth power of the phase. -/
theorem modeSmallMatrix_four_cycle_terms
    (z varpi varsigma : Qbar) (hz4 : z ^ 4 = -1)
    (hvarpi : varpi ≠ 0) (hvarsigma : varsigma ≠ 0) :
    let A : Matrix (ZMod 4) (ZMod 4) (QbarPoly) :=
      1 - (X : QbarPoly) • (modeSmallMatrix z varpi varsigma).map C
    A 0 1 * A 1 2 * A 2 3 * A 3 0 = -(X ^ 4) ∧
    A 0 3 * A 1 0 * A 2 1 * A 3 2 = -(X ^ 4) := by
  dsimp
  rw [modeSmallMatrix_eq_entries]
  constructor
  · simp (config := { decide := true }) [modeSmallMatrixEntries]
    have hz : z ≠ 0 := by
      intro h
      simp [h] at hz4
    field_simp
    ring_nf
    simp [← map_pow, ← map_mul, hz4]
    field_simp
    simp
  · simp (config := { decide := true }) [modeSmallMatrixEntries]
    have hz : z ≠ 0 := by
      intro h
      simp [h] at hz4
    field_simp
    ring_nf
    simp [← map_pow, ← map_mul, hz4]
    field_simp
    simp

theorem modeSmallMatrix_four_cycle_terms_of_modes (L : ℕ) (hL : 0 < L)
    (s : SpinStructure) (z varpi varsigma : Qbar) (hz4 : z ^ 4 = -1)
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s) :
    let A : Matrix (ZMod 4) (ZMod 4) QbarPoly :=
      1 - (X : QbarPoly) • (modeSmallMatrix z varpi varsigma).map C
    A 0 1 * A 1 2 * A 2 3 * A 3 0 = -(X ^ 4) ∧
    A 0 3 * A 1 0 * A 2 1 * A 3 2 = -(X ^ 4) := by
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
  exact modeSmallMatrix_four_cycle_terms z varpi varsigma hz4 hp hs

end Ising2DLambda.KacWard
