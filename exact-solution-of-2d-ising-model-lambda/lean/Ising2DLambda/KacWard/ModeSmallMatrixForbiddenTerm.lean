import Ising2DLambda.KacWard.ModeSmallMatrixEntries
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- A permutation choosing an opposite direction has a zero factor in the
four-direction determinant product. -/
theorem modeSmallMatrix_forbidden_term_zero (z varpi varsigma : Qbar)
    (σ : Equiv.Perm (ZMod 4)) (i : ZMod 4) (hi : σ i = i + 2) :
    (∏ j : ZMod 4,
      ((1 -
        (Polynomial.X : QbarPoly) •
          (modeSmallMatrix z varpi varsigma).map Polynomial.C :
            Matrix (ZMod 4) (ZMod 4) QbarPoly) j (σ j))) = 0 := by
  have hzero :
      ((1 -
        (Polynomial.X : QbarPoly) •
          (modeSmallMatrix z varpi varsigma).map Polynomial.C :
            Matrix (ZMod 4) (ZMod 4) QbarPoly) i (i + 2)) = 0 := by
    -- 本文の根拠: `claim_mode_small_matrix_entries` の表で逆方向の成分は零。
    rw [modeSmallMatrix_eq_entries]
    have hne : ∀ j : ZMod 4, j ≠ j + 2 := by decide
    have e0 : modeSmallMatrixEntries z varpi varsigma 0 (0 + 2) = 0 := by
      simp (config := { decide := true }) [modeSmallMatrixEntries]
    have e1 : modeSmallMatrixEntries z varpi varsigma 1 (1 + 2) = 0 := by
      simp (config := { decide := true }) [modeSmallMatrixEntries]
    have e2 : modeSmallMatrixEntries z varpi varsigma 2 (2 + 2) = 0 := by
      simp (config := { decide := true }) [modeSmallMatrixEntries]
    have e3 : modeSmallMatrixEntries z varpi varsigma 3 (3 + 2) = 0 := by
      simp (config := { decide := true }) [modeSmallMatrixEntries]
    have hentry : modeSmallMatrixEntries z varpi varsigma i (i + 2) = 0 := by
      fin_cases i
      exacts [e0, e1, e2, e3]
    rw [Matrix.sub_apply, Matrix.one_apply_ne (hne i), Matrix.smul_apply,
      Matrix.map_apply, hentry]
    simp
  apply Finset.prod_eq_zero (Finset.mem_univ i)
  rw [hi]
  exact hzero

end Ising2DLambda.KacWard
