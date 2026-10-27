import Ising2DLambda.KacWard.TwistedModeWrapPhase
import Ising2DLambda.NecSuf.KacWard.TwistedModeWrapPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem twistedMode_wrapPhase_from_necSuf (L : ℕ) (hL : 1 ≤ L) (σ z : Qbar)
    (hσ : σ = 1 ∨ σ = -1) (hz : z ^ L = σ) :
    σ * z ^ 0 = z ^ L ∧ σ * z ^ (L - 1) = z⁻¹ := by
  have hσsq : σ * σ = 1 := by
    rcases hσ with h | h <;> rw [h] <;> ring
  exact Ising2DLambda.NecSuf.KacWard.twistedMode_wrapPhase_necSuf L hL σ z hσsq hz

end Ising2DLambda.KacWard
