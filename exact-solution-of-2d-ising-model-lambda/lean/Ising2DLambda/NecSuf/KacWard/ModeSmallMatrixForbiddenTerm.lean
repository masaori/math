import Ising2DLambda.NecSuf.KacWard.ModeSmallMatrixEntries
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization

namespace Ising2DLambda.NecSuf.KacWard

/-- Only the four direction positions and a polynomial coefficient field are
used to remove a determinant term selecting an opposite direction. -/
theorem modeSmallMatrix_forbidden_term_zero {R : Type*} [Field R]
    (z varpi varsigma : R) (σ : Equiv.Perm (ZMod 4))
    (i : ZMod 4) (hi : σ i = i + 2) :
    (∏ j : ZMod 4,
      ((1 - (Polynomial.X : Polynomial R) •
          (modeSmallMatrix z varpi varsigma).map Polynomial.C :
            Matrix (ZMod 4) (ZMod 4) (Polynomial R)) j (σ j))) = 0 := by
  classical
  have h0 : i + 2 ≠ i := by fin_cases i <;> decide
  have h1 : i + 2 ≠ i + 1 := by fin_cases i <;> decide
  have h2 : i + 2 ≠ i - 1 := by fin_cases i <;> decide
  have hzero :
      ((1 - (Polynomial.X : Polynomial R) •
          (modeSmallMatrix z varpi varsigma).map Polynomial.C :
            Matrix (ZMod 4) (ZMod 4) (Polynomial R)) i (i + 2)) = 0 := by
    simp [Matrix.sub_apply, Matrix.one_apply, Matrix.smul_apply,
      Matrix.map_apply, modeSmallMatrix, h0, h1, h2] <;> decide
  apply Finset.prod_eq_zero (Finset.mem_univ i)
  rw [hi]
  exact hzero

end Ising2DLambda.NecSuf.KacWard
