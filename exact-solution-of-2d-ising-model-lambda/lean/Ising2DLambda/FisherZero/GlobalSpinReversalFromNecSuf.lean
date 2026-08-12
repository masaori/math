/- 具体版が必要十分版の特殊化であることの導出。住処: Z。 -/
import Ising2DLambda.FisherZero.GlobalSpinReversal
import Ising2DLambda.NecSuf.FisherZero.GlobalSpinReversal

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial

theorem globalSpinReversal_brokenEdge_iff_from_necSuf (L : ℕ) (σ : Config L) (e : Edge L) :
    globalSpinReversal L σ (boundary0 L e) ≠ globalSpinReversal L σ (boundary1 L e) ↔
      σ (boundary0 L e) ≠ σ (boundary1 L e) := by
  exact Ising2DLambda.NecSuf.FisherZero.injective_map_ne_iff
    spinReversal spinReversal_injective
      (σ (boundary0 L e)) (σ (boundary1 L e))

end Ising2DLambda.FisherZero
