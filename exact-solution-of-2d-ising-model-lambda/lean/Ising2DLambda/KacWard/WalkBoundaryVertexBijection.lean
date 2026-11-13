import Ising2DLambda.KacWard.WalkLiftPointBoundaryVertex
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Departure positions of the lifted simple closed walk correspond exactly
to the boundary vertices of its interior cells. -/
noncomputable def vertexSimpleWalk_departure_equiv_boundaryVertices
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    Fin (m + 1) ≃
      {v // v ∈ cellBoundaryVertices
        (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset} := by
  classical
  let f : Fin (m + 1) →
      {v // v ∈ cellBoundaryVertices
        (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset} :=
    fun j => ⟨planeLift γ j.castSucc,
      vertexSimpleWalk_liftPoint_mem_boundaryVertices γ hγ hh hv hdistinct j⟩
  apply Equiv.ofBijective f
  constructor
  · intro i j hij
    apply hdistinct
    exact congrArg Subtype.val hij
  · intro v
    obtain ⟨j, hj⟩ := interiorCellsOfWalk_boundaryVertex_has_departure
      γ hγ hh hv v.val v.property
    refine ⟨j, ?_⟩
    apply Subtype.ext
    exact hj

end Ising2DLambda.KacWard
