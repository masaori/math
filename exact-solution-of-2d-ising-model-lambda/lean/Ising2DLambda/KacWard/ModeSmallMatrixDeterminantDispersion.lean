import Ising2DLambda.KacWard.ModeSmallMatrixSignedSumAlgebra
import Ising2DLambda.KacWard.ModeSmallMatrixFourCycles
import Ising2DLambda.KacWard.ModeSmallMatrixForbiddenTerm

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

set_option maxRecDepth 4000

/-- The four-direction permutation expansion after terms containing an opposite
entry have vanished. The displayed nine products are the nine admissible
permutations in the human proof. -/
private theorem determinant_nine_direction_terms {R : Type*} [CommRing R]
    (A : Matrix (ZMod 4) (ZMod 4) R)
    (h02 : A 0 2 = 0) (h13 : A 1 3 = 0)
    (h20 : A 2 0 = 0) (h31 : A 3 1 = 0) :
    A.det =
      A 0 0 * A 1 1 * A 2 2 * A 3 3
      - A 0 0 * A 1 1 * A 2 3 * A 3 2
      - A 0 0 * A 1 2 * A 2 1 * A 3 3
      - A 0 1 * A 1 0 * A 2 2 * A 3 3
      + A 0 1 * A 1 0 * A 2 3 * A 3 2
      - A 0 1 * A 1 2 * A 2 3 * A 3 0
      - A 0 3 * A 1 0 * A 2 1 * A 3 2
      - A 0 3 * A 1 1 * A 2 2 * A 3 0
      + A 0 3 * A 1 2 * A 2 1 * A 3 0 := by
  let B : Matrix (Fin 4) (Fin 4) R :=
    A.submatrix (ZMod.finEquiv 4) (ZMod.finEquiv 4)
  have e0 : (ZMod.finEquiv 4) (0 : Fin 4) = (0 : ZMod 4) := by decide
  have e1 : (ZMod.finEquiv 4) (1 : Fin 4) = (1 : ZMod 4) := by decide
  have e2 : (ZMod.finEquiv 4) (2 : Fin 4) = (2 : ZMod 4) := by decide
  have e3 : (ZMod.finEquiv 4) (3 : Fin 4) = (3 : ZMod 4) := by decide
  have hB02 : B 0 2 = 0 := by simpa [B, e0, e2] using h02
  have hB13 : B 1 3 = 0 := by simpa [B, e1, e3] using h13
  have hB20 : B 2 0 = 0 := by simpa [B, e2, e0] using h20
  have hB31 : B 3 1 = 0 := by simpa [B, e3, e1] using h31
  have hB : B.det =
      B 0 0 * B 1 1 * B 2 2 * B 3 3
      - B 0 0 * B 1 1 * B 2 3 * B 3 2
      - B 0 0 * B 1 2 * B 2 1 * B 3 3
      - B 0 1 * B 1 0 * B 2 2 * B 3 3
      + B 0 1 * B 1 0 * B 2 3 * B 3 2
      - B 0 1 * B 1 2 * B 2 3 * B 3 0
      - B 0 3 * B 1 0 * B 2 1 * B 3 2
      - B 0 3 * B 1 1 * B 2 2 * B 3 0
      + B 0 3 * B 1 2 * B 2 1 * B 3 0 := by
    simp [Matrix.det_succ_row_zero, Fin.sum_univ_succ, Fin.succAbove,
      hB02, hB13, hB20, hB31]
    ring
  rw [show B.det = A.det from Matrix.det_submatrix_equiv_self
    (ZMod.finEquiv 4).toEquiv A] at hB
  simpa [B, Matrix.submatrix_apply, e0, e1, e2, e3] using hB

/-- Substitution of the nine signed products into the determinant expansion. -/
theorem modeSmallMatrix_determinant_dispersion
    (z varpi varsigma : Qbar) (hz4 : z ^ 4 = -1)
    (hp : varpi ≠ 0) (hs : varsigma ≠ 0) :
    (Matrix.det (1 - (X : QbarPoly) •
      (modeSmallMatrix z varpi varsigma).map C : Matrix (ZMod 4) (ZMod 4) QbarPoly)) =
      (1+X^2)^2-X*(1-X^2)*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) := by
  let A : Matrix (ZMod 4) (ZMod 4) QbarPoly :=
    1 - (X : QbarPoly) • (modeSmallMatrix z varpi varsigma).map C
  let d0 : QbarPoly := 1 - X * C varpi
  let d1 : QbarPoly := 1 - X * C varsigma
  let d2 : QbarPoly := 1 - X * C varpi⁻¹
  let d3 : QbarPoly := 1 - X * C varsigma⁻¹
  have hz : z ≠ 0 := by
    intro h
    simp [h] at hz4
  have h02 : A 0 2 = 0 := by
    simp (config := { decide := true }) [A, modeSmallMatrix_eq_entries, modeSmallMatrixEntries]
  have h13 : A 1 3 = 0 := by
    simp (config := { decide := true }) [A, modeSmallMatrix_eq_entries, modeSmallMatrixEntries]
  have h20 : A 2 0 = 0 := by
    simp (config := { decide := true }) [A, modeSmallMatrix_eq_entries, modeSmallMatrixEntries]
  have h31 : A 3 1 = 0 := by
    simp (config := { decide := true }) [A, modeSmallMatrix_eq_entries, modeSmallMatrixEntries]
  have hterms := modeSmallMatrix_remaining_terms z varpi varsigma hz hp hs
  have hcycles := modeSmallMatrix_four_cycle_terms z varpi varsigma hz4 hp hs
  dsimp only at hterms hcycles
  rcases hterms with ⟨ht0, ht1, ht2, ht3, ht4, ht5, ht6⟩
  rcases hcycles with ⟨hc0, hc1⟩
  change A.det = _
  calc
    A.det =
      A 0 0 * A 1 1 * A 2 2 * A 3 3
      - A 0 0 * A 1 1 * A 2 3 * A 3 2
      - A 0 0 * A 1 2 * A 2 1 * A 3 3
      - A 0 1 * A 1 0 * A 2 2 * A 3 3
      + A 0 1 * A 1 0 * A 2 3 * A 3 2
      - A 0 1 * A 1 2 * A 2 3 * A 3 0
      - A 0 3 * A 1 0 * A 2 1 * A 3 2
      - A 0 3 * A 1 1 * A 2 2 * A 3 0
      + A 0 3 * A 1 2 * A 2 1 * A 3 0 :=
        determinant_nine_direction_terms A h02 h13 h20 h31
    _ = d0*d1*d2*d3 - X^2 *
      (C varpi⁻¹*C varsigma⁻¹*d0*d1 + C varpi⁻¹*C varsigma*d0*d3 +
       C varpi*C varsigma*d2*d3 + C varpi*C varsigma⁻¹*d1*d2) + 4*X^4 := by
        rw [ht0, ht1, ht2, ht3, ht4, hc0, hc1, ht5, ht6]
        ring
    _ = (1+X^2)^2-X*(1-X^2)*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) :=
      modeSmallMatrix_signed_sum_algebra varpi varsigma hp hs

end Ising2DLambda.KacWard
