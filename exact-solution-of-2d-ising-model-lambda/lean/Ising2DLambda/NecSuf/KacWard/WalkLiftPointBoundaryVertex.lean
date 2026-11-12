import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A finite list of steps whose departure point is an endpoint of each selected
edge maps into the vertex boundary of the selected edges. -/
theorem departure_mem_edgeBoundaryVertices
    {ι E V : Type*} [DecidableEq E] [DecidableEq V]
    (edges : Finset E) (endpoints : E → Finset V)
    (departure : ι → V) (stepEdge : ι → E)
    (hstep : ∀ i, stepEdge i ∈ edges)
    (hendpoint : ∀ i, departure i ∈ endpoints (stepEdge i))
    (i : ι) :
    departure i ∈ edges.biUnion endpoints := by
  exact Finset.mem_biUnion.mpr ⟨stepEdge i, hstep i, hendpoint i⟩

end Ising2DLambda.NecSuf.KacWard
