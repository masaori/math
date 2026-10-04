import Ising2DLambda.KacWard.PlaneProjectionCyclicTurning
import Ising2DLambda.NecSuf.KacWard.PlaneProjectionCyclicTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem planeProjection_cyclicTurning_from_necSuf (L : ℕ) [NeZero L]
    (n : ℕ) (hn : 0 < n) (W : ℕ → ℤ × ℤ)
    (hunit : ∀ j < n, let u := W (j + 1) - W j
      u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0)) :
    cyclicAdjacentSum (fun e f => directionPairTurning (directionNumber e) (directionNumber f))
      n (fun j => projectedUnitStep L (W j) (W (j + 1) - W j)) =
    cyclicAdjacentSum latticeStepTurning n (fun j => W (j + 1) - W j) := by
  apply cyclicAdjacentSum_transport_necSuf _ _ _ _ n
  · intro j hj
    exact projectedUnitStep_turning L _ _ _ _ (hunit j (by omega))
      (hunit (j + 1) (by omega))
  · exact projectedUnitStep_turning L _ _ _ _ (hunit (n - 1) (by omega)) (hunit 0 hn)

end Ising2DLambda.KacWard
