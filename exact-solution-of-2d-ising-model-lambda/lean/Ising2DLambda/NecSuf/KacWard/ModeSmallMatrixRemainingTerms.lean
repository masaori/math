import Ising2DLambda.NecSuf.KacWard.ModeSmallMatrixEntries

namespace Ising2DLambda.NecSuf.KacWard

open Polynomial

/-- The seven admissible terms other than the two four cycles, computed from the entry table. -/
theorem modeSmallMatrix_remaining_terms
    {R : Type*} [Field R] (z varpi varsigma : R) (hz : z ≠ 0)
    (hvarpi : varpi ≠ 0) (hvarsigma : varsigma ≠ 0) :
    let A : Matrix (ZMod 4) (ZMod 4) (Polynomial R) :=
      1 - (X : Polynomial R) • (modeSmallMatrix z varpi varsigma).map C
    let d0 : Polynomial R := 1 - X * C varpi
    let d1 : Polynomial R := 1 - X * C varsigma
    let d2 : Polynomial R := 1 - X * C varpi⁻¹
    let d3 : Polynomial R := 1 - X * C varsigma⁻¹
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

end Ising2DLambda.NecSuf.KacWard
