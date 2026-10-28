import Ising2DLambda.NecSuf.KacWard.ModeSmallMatrixEntries

namespace Ising2DLambda.NecSuf.KacWard

open Polynomial

/- claim_mode_small_matrix_four_cycle_terms: the same entrywise calculation
   needs a field for the mode inverses and a four element direction set. -/
theorem modeSmallMatrix_four_cycle_terms {R : Type*} [Field R]
    (z varpi varsigma : R) (hz4 : z ^ 4 = -1)
    (hvarpi : varpi ≠ 0) (hvarsigma : varsigma ≠ 0) :
    let A : Matrix (ZMod 4) (ZMod 4) (Polynomial R) :=
      1 - (X : Polynomial R) • (modeSmallMatrix z varpi varsigma).map C
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

end Ising2DLambda.NecSuf.KacWard
