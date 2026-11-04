import Ising2DLambda.KacWard.PlaneLiftCoordinates
import Ising2DLambda.KacWard.ContactPairCount

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The representative of each lift point projects to its passage vertex. -/
theorem planeLift_projection {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (i : Fin (m + 1)) :
    (residueProjection L (planeLift γ i.castSucc).1,
      residueProjection L (planeLift γ i.castSucc).2) =
        planeLiftVertex γ i.castSucc := by
  have h := planeLift_coordinates γ hγ.1 i.castSucc
  apply Prod.ext
  · have hr := congrArg (fun p : ℤ × ℤ => residueProjection L p.1) h
    simpa [residueProjection, residueRepresentative] using hr
  · have hc := congrArg (fun p : ℤ × ℤ => residueProjection L p.2) h
    simpa [residueProjection, residueRepresentative] using hc

/-- The initial source and later targets list the passage vertices exactly once. -/
theorem planeLiftVertex_injective_of_no_contacts {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0) :
    Function.Injective (fun i : Fin (m + 1) => planeLiftVertex γ i.castSucc) := by
  have hinj := (contactPairCount_eq_zero_iff_pass_vertices_injective γ hγ).mp hcontact
  have hclose : orientedSource (γ 0) = orientedTarget (γ (Fin.last m)) :=
    (Finset.mem_filter.mp hγ.2).2.1.symm
  intro i j hij
  induction i using Fin.cases with
  | zero =>
    induction j using Fin.cases with
    | zero => rfl
    | succ j =>
      have heq : (orientedTarget (γ (Fin.last m)) : ZMod L × ZMod L) =
          orientedTarget (γ j.castSucc) := by
        simpa [planeLiftVertex, hclose, Vertex] using hij
      have hindex := hinj heq
      exact False.elim (Fin.castSucc_ne_last j hindex.symm)
  | succ i =>
    induction j using Fin.cases with
    | zero =>
      have heq : (orientedTarget (γ i.castSucc) : ZMod L × ZMod L) =
          orientedTarget (γ (Fin.last m)) := by
        simpa [planeLiftVertex, hclose, Vertex] using hij
      have hindex := hinj heq
      exact False.elim (Fin.castSucc_ne_last i hindex)
    | succ j =>
      have heq : (orientedTarget (γ i.castSucc) : ZMod L × ZMod L) =
          orientedTarget (γ j.castSucc) := by
        simpa [planeLiftVertex, Vertex] using hij
      exact congrArg Fin.succ (Fin.castSucc_inj.mp (hinj heq))

/-- `claim_vertex_simple_plane_lift_points_distinct` for the actual closed walk. -/
theorem vertexSimplePlaneLift_points_distinct {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0) :
    Function.Injective (fun i : Fin (m + 1) => planeLift γ i.castSucc) := by
  intro i j hij
  change planeLift γ i.castSucc = planeLift γ j.castSucc at hij
  apply planeLiftVertex_injective_of_no_contacts γ hγ hcontact
  calc
    planeLiftVertex γ i.castSucc =
        (residueProjection L (planeLift γ i.castSucc).1,
          residueProjection L (planeLift γ i.castSucc).2) :=
            (planeLift_projection γ hγ i).symm
    _ = (residueProjection L (planeLift γ j.castSucc).1,
          residueProjection L (planeLift γ j.castSucc).2) := by rw [hij]
    _ = planeLiftVertex γ j.castSucc := planeLift_projection γ hγ j

end Ising2DLambda.KacWard
