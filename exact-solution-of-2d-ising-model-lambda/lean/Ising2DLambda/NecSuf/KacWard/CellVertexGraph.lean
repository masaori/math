import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A loopless endpoint map on a finite edge index set yields exactly its image as graph edges. -/
theorem finiteGraph_edgeSet_of_endpoint_image
    {V E : Type*} [Fintype V] [Fintype E] [DecidableEq V] [DecidableEq E]
    (endpoints : E → Sym2 V)
    (hloopless : ∀ e, ¬ (endpoints e).IsDiag) :
    (SimpleGraph.fromEdgeSet (↑(Finset.univ.image endpoints) : Set (Sym2 V))).edgeSet =
      ↑(Finset.univ.image endpoints) := by
  ext edge
  simp only [SimpleGraph.edgeSet_fromEdgeSet,
    Set.mem_sdiff, Finset.mem_coe, Sym2.mem_diagSet]
  constructor
  · exact And.left
  · intro h
    obtain ⟨e, _, rfl⟩ := Finset.mem_image.mp h
    exact ⟨Finset.mem_image.mpr ⟨e, Finset.mem_univ _, rfl⟩, hloopless e⟩

end Ising2DLambda.NecSuf.KacWard
