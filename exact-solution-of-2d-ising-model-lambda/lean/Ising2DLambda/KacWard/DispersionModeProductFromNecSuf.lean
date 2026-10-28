import Ising2DLambda.KacWard.DispersionModeProduct
import Ising2DLambda.NecSuf.KacWard.DispersionModeProduct

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem dispersion_mode_product_from_necSuf {L : ℕ} [NeZero L]
    (z : Qbar) (hz4 : z ^ 4 = -1) (s : SpinStructure) :
    kacWardDeterminant (kacWardTransitionMatrix L z s) =
      ∏ m : FourierModePair L s, dispersionPolynomial m.1.1 m.1.2 := by
  classical
  obtain ⟨κ⟩ := edgeModeIndex_equiv_exists (L := L) s
  let fiber (m : FourierModePair L s) : QbarPoly :=
    Matrix.det (fun i j :
      {e : OrientedEdge L // fourierModeBlockIndex s κ e = m} =>
        (1 - (Polynomial.X : QbarPoly) •
          (modeBlockMatrix z s κ).map Polynomial.C) i.1 j.1)
  let direction (m : FourierModePair L s) : QbarPoly :=
    Matrix.det (1 - (Polynomial.X : QbarPoly) •
      (modeSmallMatrix z m.1.1 m.1.2).map Polynomial.C)
  apply Ising2DLambda.NecSuf.KacWard.dispersion_mode_product_necSuf
    (kacWardDeterminant (kacWardTransitionMatrix L z s)) fiber direction
    (fun m => dispersionPolynomial m.1.1 m.1.2)
  · exact fourier_block_fiber_determinant_product z s κ
  · intro m
    exact fourier_fiber_direction_determinant z s κ m
  · intro m
    have hp : m.1.1 ≠ 0 := by
      intro h
      have hm := m.2.1
      simp [horizontalTwistedModes, h] at hm
      have hnon : (if s.1 then (-1 : Qbar) else 1) ≠ 0 := by
        split <;> norm_num
      exact hnon (by simpa [NeZero.ne L] using hm.symm)
    have hs : m.1.2 ≠ 0 := by
      intro h
      have hm := m.2.2
      simp [verticalTwistedModes, h] at hm
      have hnon : (if s.2 then (-1 : Qbar) else 1) ≠ 0 := by
        split <;> norm_num
      exact hnon (by simpa [NeZero.ne L] using hm.symm)
    exact modeSmallMatrix_determinant_dispersion z m.1.1 m.1.2 hz4 hp hs

end Ising2DLambda.KacWard
