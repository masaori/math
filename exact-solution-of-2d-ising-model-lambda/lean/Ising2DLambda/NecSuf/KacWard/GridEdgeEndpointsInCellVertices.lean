import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A local endpoint inclusion extends through the union over all cells. -/
theorem endpoints_subset_vertices_of_local_inclusion
    {C V E : Type*} [DecidableEq C] [DecidableEq V] [DecidableEq E]
    (cells : Finset C) (vertices : C → Finset V) (edges : C → Finset E)
    (endpoints : E → Finset V)
    (hlocal : ∀ c e, e ∈ edges c → endpoints e ⊆ vertices c)
    (e : E) (he : e ∈ cells.biUnion edges) :
    endpoints e ⊆ cells.biUnion vertices := by
  obtain ⟨c, hc, hce⟩ := Finset.mem_biUnion.mp he
  exact (hlocal c e hce).trans (Finset.subset_biUnion_of_mem vertices hc)

end Ising2DLambda.NecSuf.KacWard
