import Ising2DLambda.KacWard.PlaneLiftCoordinates
import Ising2DLambda.NecSuf.KacWard.PlaneLiftCoordinates

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The abstract integer recurrence specializes to the actual row and column coordinates. -/
theorem planeLift_coordinates_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : nonbacktrackingEdgeSequence γ)
    (k : Fin (m + 2)) :
    planeLift γ k =
      (residueRepresentative L (planeLiftVertex γ k).1 + (L : ℤ) * verticalPrefix γ k,
       residueRepresentative L (planeLiftVertex γ k).2 + (L : ℤ) * horizontalPrefix γ k) := by
  have hrow := Ising2DLambda.NecSuf.KacWard.lift_coordinates_necSuf m (L : ℤ)
    (fun j => (planeLift γ j).1)
    (fun j => residueRepresentative L (planeLiftVertex γ j).1)
    (fun j => (orientedEdgeLatticeStep (γ j)).1)
    (fun j => (verticalSeamParity (γ j) : ℤ) * (1 - 2 * ((γ j).2.toNat : ℤ)))
    (by rfl)
    (by
      intro j
      exact congrArg Prod.fst (planeLift_succ γ j))
    (by
      intro j
      rw [planeLiftVertex_succ_source γ hγ j]
      change residueRepresentative L (orientedTarget (γ j)).1 -
          residueRepresentative L (orientedSource (γ j)).1 = _
      have hr := congrArg Prod.fst (edge_representative_displacement L (γ j))
      dsimp at hr
      nlinarith) k
  have hcol := Ising2DLambda.NecSuf.KacWard.lift_coordinates_necSuf m (L : ℤ)
    (fun j => (planeLift γ j).2)
    (fun j => residueRepresentative L (planeLiftVertex γ j).2)
    (fun j => (orientedEdgeLatticeStep (γ j)).2)
    (fun j => (horizontalSeamParity (γ j) : ℤ) * (1 - 2 * ((γ j).2.toNat : ℤ)))
    (by rfl)
    (by
      intro j
      exact congrArg Prod.snd (planeLift_succ γ j))
    (by
      intro j
      rw [planeLiftVertex_succ_source γ hγ j]
      change residueRepresentative L (orientedTarget (γ j)).2 -
          residueRepresentative L (orientedSource (γ j)).2 = _
      have hc := congrArg Prod.snd (edge_representative_displacement L (γ j))
      dsimp at hc
      nlinarith) k
  apply Prod.ext
  · simpa only [verticalPrefix] using hrow
  · simpa only [horizontalPrefix] using hcol

end Ising2DLambda.KacWard
