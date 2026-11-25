/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.CellGridIncidentParity
import Ising2DLambda.KacWard.CellBoundaryEvenEdgeBijectionFromNecSuf
import Ising2DLambda.KacWard.CellVertexGraphFromNecSuf
import Ising2DLambda.NecSuf.KacWard.FourEdgeMembershipParity

namespace Ising2DLambda.KacWard

theorem gridIncidentEven_iff_from_necSuf (A : Finset GridEdge) (r c : ℤ) :
    (((if (false, (r, c)) ∈ A then (1 : ZMod 2) else 0) +
      (if (false, (r, c - 1)) ∈ A then 1 else 0) +
      (if (true, (r, c)) ∈ A then 1 else 0) +
      (if (true, (r - 1, c)) ∈ A then 1 else 0)) = 0) ↔
      Even (A.filter (fun e => (r, c) ∈ gridEdgeEndpoints e)).card := by
  rw [incident_edges_eq_four]
  have hfilter :
      A.filter (fun e => e ∈ ({(false, (r, c)), (false, (r, c - 1)),
        (true, (r, c)), (true, (r - 1, c))} : Finset GridEdge)) =
      ({(false, (r, c)), (false, (r, c - 1)),
        (true, (r, c)), (true, (r - 1, c))} : Finset GridEdge).filter
        (fun e => e ∈ A) := by
    ext e
    simp [and_comm]
  rw [hfilter]
  apply Ising2DLambda.NecSuf.KacWard.fourEdgeMembershipParity
  all_goals simp [Prod.mk.injEq] <;> omega

end Ising2DLambda.KacWard
