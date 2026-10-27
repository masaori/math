import Ising2DLambda.NecSuf.KacWard.DualTwistedFourierMatrix
import Ising2DLambda.NecSuf.KacWard.TwistedFourierMatrix
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open BigOperators

theorem fourier_leftInverse_necSuf {E M F : Type*}
    [Fintype E] [DecidableEq E] [DecidableEq M] [Field F]
    (κ : E ≃ M) (ψ ψbar : M → E → F) (scale : F) (hscale : scale ≠ 0)
    (hinner : ∀ m n : M,
      (∑ e : E, ψbar m e * ψ n e) = if m = n then scale else 0) :
    fourierInverseCandidate scale⁻¹ κ ψbar * fourierMatrix κ ψ = 1 := by
  classical
  apply Matrix.ext
  intro g h
  rw [Matrix.one_apply]
  simp only [Matrix.mul_apply, fourierInverseCandidate,
    dualFourierMatrix, fourierMatrix, Matrix.smul_apply, smul_eq_mul]
  simp_rw [mul_assoc]
  rw [← Finset.mul_sum, hinner]
  by_cases hgh : g = h
  · subst hgh
    simp [hscale]
  · have hmn : κ g ≠ κ h := fun heq => hgh (κ.injective heq)
    simp [hmn, hgh]

end Ising2DLambda.NecSuf.KacWard
