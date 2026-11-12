import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- If every selected edge has both endpoints among the visited points, its
entire vertex boundary is visited. -/
theorem boundary_vertices_covered
    {E V I : Type*} [DecidableEq E] [DecidableEq V]
    (edges : Finset E) (endpoints : E → Finset V) (point : I → V)
    (hcover : ∀ e ∈ edges, ∀ v ∈ endpoints e, ∃ i, point i = v)
    (v : V) (hv : v ∈ edges.biUnion endpoints) :
    ∃ i, point i = v := by
  obtain ⟨e, he, hve⟩ := Finset.mem_biUnion.mp hv
  exact hcover e he v hve

end Ising2DLambda.NecSuf.KacWard
