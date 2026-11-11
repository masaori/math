import Ising2DLambda.KacWard.WalkConsecutiveInteriorSides

namespace Ising2DLambda.KacWard

/-- The actual simple closed walk has one interior side throughout its period. -/
theorem vertexSimpleWalk_interior_side_constant
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
  let side := Classical.choose
    (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct 0 (by omega))
  refine ⟨side, ?_⟩
  intro j
  have hchain (k : ℕ) (hk : k < m + 1) :
      Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct k hk) = side := by
    induction k with
    | zero => rfl
    | succ k ih =>
        have hprev : k < m := by omega
        have hstep := vertexSimpleWalk_adjacent_interior_side_eq
          γ hγ hh hv hdistinct ⟨k, hprev⟩
        exact hstep.symm.trans (ih (by omega))
  exact hchain j.val j.isLt

end Ising2DLambda.KacWard
