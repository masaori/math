import Ising2DLambda.KacWard.FourierFiberDirectionBijection
import Ising2DLambda.KacWard.FourierBlockFiberDeterminantProduct

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem fourier_fiber_direction_determinant {L : ℕ} [NeZero L]
    (z : Qbar) (s : SpinStructure)
    (κ : OrientedEdge L ≃ {u // u ∈ fourierModeIndexSet L s})
    (m : FourierModePair L s) :
    Matrix.det (fun i j :
      {e : OrientedEdge L // fourierModeBlockIndex s κ e = m} =>
        (1 - (Polynomial.X : QbarPoly) •
          (modeBlockMatrix z s κ).map Polynomial.C) i.1 j.1) =
      Matrix.det (1 - (Polynomial.X : QbarPoly) •
        (modeSmallMatrix z m.1.1 m.1.2).map Polynomial.C) := by
  classical
  let e := fourierFiberDirectionEquiv s κ m
  let A : Matrix {u : OrientedEdge L // fourierModeBlockIndex s κ u = m}
      {u : OrientedEdge L // fourierModeBlockIndex s κ u = m} QbarPoly :=
    fun i j => (1 - (Polynomial.X : QbarPoly) •
      (modeBlockMatrix z s κ).map Polynomial.C) i.1 j.1
  have h : Matrix.reindex e e A =
      1 - (Polynomial.X : QbarPoly) •
        (modeSmallMatrix z m.1.1 m.1.2).map Polynomial.C := by
    apply Matrix.ext
    intro d d'
    change A (e.symm d) (e.symm d') = _
    change (1 - (Polynomial.X : QbarPoly) •
      (modeBlockMatrix z s κ).map Polynomial.C)
        (κ.symm ⟨(m.1.1, m.1.2, d), m.2⟩)
        (κ.symm ⟨(m.1.1, m.1.2, d'), m.2⟩) = _
    rw [fourier_mode_block_entries]
    simp
  rw [← Matrix.det_reindex_self e A, h]

end Ising2DLambda.KacWard
