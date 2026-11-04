import Ising2DLambda.KacWard.DualCellComponent
import Ising2DLambda.NecSuf.KacWard.DualCellComponent

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The finite relation theorem specializes to the dual steps of the actual walk. -/
theorem dualCellComponent_closed_from_necSuf (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (root p q : ZMod L × ZMod L)
    (hp : p ∈ dualCellComponent L m γ root)
    (hstep : dualCellStep L m γ p q) :
    q ∈ dualCellComponent L m γ root := by
  simpa only [dualCellComponent, Ising2DLambda.NecSuf.KacWard.reachableComponent]
    using Ising2DLambda.NecSuf.KacWard.reachableComponent_closed
      (dualCellStep L m γ) root p q hp hstep

theorem dualCellComponent_ne_univ_of_side_from_necSuf (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (root outside : ZMod L × ZMod L) (side : Finset (ZMod L × ZMod L))
    (hroot : root ∈ side) (houtside : outside ∉ side)
    (hclosed : ∀ p q, p ∈ side → dualCellStep L m γ p q → q ∈ side) :
    dualCellComponent L m γ root ≠ Finset.univ := by
  simpa only [dualCellComponent, Ising2DLambda.NecSuf.KacWard.reachableComponent]
    using Ising2DLambda.NecSuf.KacWard.reachableComponent_ne_univ_of_closed_side
      (dualCellStep L m γ) root outside side hroot houtside hclosed

end Ising2DLambda.KacWard
