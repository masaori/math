import Ising2DLambda.KacWard.PlaneDualRayHeightVertical
import Ising2DLambda.NecSuf.KacWard.PlaneHeightOneHorizontalEdge

namespace Ising2DLambda.KacWard

theorem planeHeightOne_horizontal_edge_from_necSuf (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0)
    (r c : ℤ) :
    ((planeDualRayHeight edges r c = 1 ∧
        planeDualRayHeight edges (r - 1) c ≠ 1) ∨
      (planeDualRayHeight edges r c ≠ 1 ∧
        planeDualRayHeight edges (r - 1) c = 1)) ↔
      (false, (r, c)) ∈ edges := by
  have h := Ising2DLambda.NecSuf.KacWard.binaryHeight_horizontal_edge
    (planeDualRayHeight edges r c) (planeDualRayHeight edges (r - 1) c)
    (if (false, (r, c)) ∈ edges then 1 else 0)
    (planeDualRayHeight_vertical edges heven r c)
  simpa using h

end Ising2DLambda.KacWard
