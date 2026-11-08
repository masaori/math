import Ising2DLambda.KacWard.PlaneDualRayHeight
import Ising2DLambda.NecSuf.KacWard.PlaneHeightOneVerticalEdge

namespace Ising2DLambda.KacWard

/-- The concrete grid statement follows by specializing the binary-height argument. -/
theorem planeHeightOne_vertical_edge_from_necSuf (edges : Finset GridEdge) (r c : ℤ) :
    ((planeDualRayHeight edges r (c - 1) = 1 ∧
        planeDualRayHeight edges r c ≠ 1) ∨
      (planeDualRayHeight edges r (c - 1) ≠ 1 ∧
        planeDualRayHeight edges r c = 1)) ↔
      (true, (r, c)) ∈ edges := by
  have h := Ising2DLambda.NecSuf.KacWard.binaryHeight_vertical_edge
    (planeDualRayHeight edges r (c - 1)) (planeDualRayHeight edges r c)
    (if (true, (r, c)) ∈ edges then 1 else 0)
    (planeDualRayHeight_horizontal edges r c)
  simpa using h

end Ising2DLambda.KacWard
