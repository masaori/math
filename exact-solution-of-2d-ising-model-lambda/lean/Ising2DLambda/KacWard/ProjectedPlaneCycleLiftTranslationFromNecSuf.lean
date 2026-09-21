/- 具体版が必要十分版の整数格子点列への特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ProjectedPlaneCycleLiftTranslation

namespace Ising2DLambda.KacWard

/-- `claim_projected_plane_cycle_lift_translation` を必要十分版から導いたもの。 -/
theorem projectedPlaneCycleLift_translation_and_winding_zero_from_necSuf
    (L : ℕ) [NeZero L] (lift original : ℕ → ℤ × ℤ) (n : ℕ) (wv wh : ℤ)
    (hstep : ∀ k, lift (k + 1) = lift k + (original (k + 1) - original k))
    (hclosed : original n = original 0)
    (hendpoint : lift n - lift 0 = integerWindingPair L wv wh) :
    (∀ k, lift k = lift 0 + original k - original 0) ∧
      lift n = lift 0 ∧ wv = 0 ∧ wh = 0 :=
  projectedPlaneCycleLift_translation_and_winding_zero
    L lift original n wv wh hstep hclosed hendpoint

end Ising2DLambda.KacWard
