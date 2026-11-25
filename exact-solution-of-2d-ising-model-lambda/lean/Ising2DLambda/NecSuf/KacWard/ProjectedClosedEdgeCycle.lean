import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceAlternatingCycle
import Ising2DLambda.NecSuf.KacWard.ProjectedClosedEdgeCycleCore

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The first-colour vertices of an alternating cycle return after half its even period.
    The long mate of each intervening second-colour vertex is the next first-colour vertex. -/
theorem projectedClosedEdgeCycle (τ υ : FixedPointFreeInvolution J) (i : J)
    (hi : i ∈ matchingPairColor τ υ) :
    let σ := matchingPairPermutation τ υ
    ∃ k : ℕ, 0 < k ∧ finiteMapIterate σ (2 * k) i = i ∧
      ∀ r : ℕ, r < k →
        υ.val (finiteMapIterate σ (2 * r + 1) i) =
          finiteMapIterate σ (2 * (r + 1)) i := by
  dsimp
  let σ := matchingPairPermutation τ υ
  let C := matchingPairColor τ υ
  have hflip (j : J) : σ j ∈ C ↔ j ∉ C := matchingPairSuccessor_color τ υ j
  have hsecond (j : J) (hj : j ∉ C) : σ j = υ.val j := by
    change matchingPairSuccessor τ υ j = υ.val j
    rw [matchingPairSuccessor, if_neg hj]
  simpa only [finiteMapIterate] using
    projectedClosedEdgeCycleCore σ υ.val (fun j => j ∈ C) hflip hsecond i hi

end Ising2DLambda.NecSuf.KacWard
