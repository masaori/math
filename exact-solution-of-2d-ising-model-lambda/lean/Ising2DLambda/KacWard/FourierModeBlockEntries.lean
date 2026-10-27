import Ising2DLambda.KacWard.FourierSimilarityPreservesDeterminant

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem fourier_mode_block_entries {L : ℕ} [DecidableEq Qbar] (z : Qbar) (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s})
    (g h : OrientedEdge L) :
    (1 - (Polynomial.X : QbarPoly) • (modeBlockMatrix z s κ).map Polynomial.C) g h =
      if ((κ g).val.1, (κ g).val.2.1) = ((κ h).val.1, (κ h).val.2.1) then
        (1 - (Polynomial.X : QbarPoly) •
          (modeSmallMatrix z (κ g).val.1 (κ g).val.2.1).map Polynomial.C)
          (κ g).val.2.2 (κ h).val.2.2
      else 0 := by
  classical
  by_cases hm : ((κ g).val.1, (κ g).val.2.1) =
      ((κ h).val.1, (κ h).val.2.1)
  · obtain ⟨hv, hw⟩ := Prod.mk.inj hm
    have hEq : g = h ↔ (κ g).val.2.2 = (κ h).val.2.2 := by
      constructor
      · intro hgh
        rw [hgh]
      · intro hd
        apply κ.injective
        apply Subtype.ext
        exact Prod.ext hv (Prod.ext hw hd)
    simp only [if_pos hm, Matrix.sub_apply, Matrix.smul_apply, Matrix.map_apply]
    simp [modeBlockMatrix, hv, hw, Matrix.one_apply, hEq]
  · have hne : g ≠ h := by
      intro hgh
      exact hm (by rw [hgh])
    have hblock : modeBlockMatrix z s κ g h = 0 := by
      unfold modeBlockMatrix
      split_ifs with hp
      · exact False.elim (hm (Prod.ext hp.1 hp.2))
      · rfl
    simp [hm, hne, hblock, Matrix.sub_apply, Matrix.smul_apply,
      Matrix.map_apply]

end Ising2DLambda.KacWard
