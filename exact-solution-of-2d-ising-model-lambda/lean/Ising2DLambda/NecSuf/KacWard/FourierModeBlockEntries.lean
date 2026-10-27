import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

namespace Ising2DLambda.NecSuf.KacWard

theorem fourier_mode_block_entries_necSuf
    {E D M R : Type*} [Fintype E] [DecidableEq E] [Fintype D] [DecidableEq D]
    [DecidableEq M] [CommRing R]
    (κ : E ≃ D × M) (small : M → Matrix D D R) (B : Matrix E E R)
    (hB : ∀ g h, B g h = if (κ g).2 = (κ h).2 then small (κ g).2 (κ g).1 (κ h).1 else 0)
    (c : R) (g h : E) :
    (1 - c • B) g h =
      if (κ g).2 = (κ h).2 then (1 - c • small (κ g).2) (κ g).1 (κ h).1 else 0 := by
  classical
  by_cases hm : (κ g).2 = (κ h).2
  · have hEq : g = h ↔ (κ g).1 = (κ h).1 := by
      constructor
      · intro hgh
        rw [hgh]
      · intro hd
        apply κ.injective
        exact Prod.ext hd hm
    simp [hm, hEq, hB, Matrix.sub_apply, Matrix.smul_apply, Matrix.one_apply]
  · have hne : g ≠ h := by
      intro hgh
      exact hm (by rw [hgh])
    simp [hm, hne, hB, Matrix.sub_apply, Matrix.smul_apply]

end Ising2DLambda.NecSuf.KacWard
