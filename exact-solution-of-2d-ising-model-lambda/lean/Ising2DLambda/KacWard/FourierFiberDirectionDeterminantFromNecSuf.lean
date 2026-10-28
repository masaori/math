import Ising2DLambda.KacWard.FourierFiberDirectionDeterminant
import Ising2DLambda.NecSuf.KacWard.FiberDirectionDeterminant

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem fourier_fiber_direction_determinant_from_necSuf {L : ℕ} [NeZero L]
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
  change A.det = _
  apply Ising2DLambda.NecSuf.KacWard.fiberDirectionDeterminant e A _
  intro d d'
  change (1 - (Polynomial.X : QbarPoly) •
    (modeBlockMatrix z s κ).map Polynomial.C)
      (κ.symm ⟨(m.1.1, m.1.2, d), m.2⟩)
      (κ.symm ⟨(m.1.1, m.1.2, d'), m.2⟩) = _
  rw [fourier_mode_block_entries]
  simp

end Ising2DLambda.KacWard
