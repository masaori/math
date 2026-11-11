import Ising2DLambda.KacWard.WalkInteriorSideConstant
import Ising2DLambda.NecSuf.KacWard.WalkInteriorSideConstant

namespace Ising2DLambda.KacWard

/-- The abstract finite-chain statement specializes to the actual walk. -/
theorem vertexSimpleWalk_interior_side_constant_from_necSuf
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    ∃ side : Bool, ∀ j : Fin (m + 1),
      Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt) = side := by
  classical
  let sideAt : Fin (m + 1) → Bool := fun j =>
    Classical.choose
      (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt)
  have hadjacent : ∀ j : Fin m,
      sideAt ⟨j.val, by omega⟩ = sideAt ⟨j.val + 1, by omega⟩ := by
    intro j
    exact vertexSimpleWalk_adjacent_interior_side_eq γ hγ hh hv hdistinct j
  exact Ising2DLambda.NecSuf.KacWard.finite_adjacent_side_constant sideAt hadjacent

end Ising2DLambda.KacWard
