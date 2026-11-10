import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Restricting an endpoint pair to a vertex subset preserves incidence. -/
theorem endpoint_incidence_iff_of_subtype
    {V : Type*} [DecidableEq V] {vertices : Finset V}
    (edge : Sym2 vertices) (v : vertices) :
    v ∈ edge ↔ v.1 ∈ edge.toFinset.image Subtype.val := by
  constructor
  · intro hv
    exact Finset.mem_image.mpr ⟨v, by simpa using hv, rfl⟩
  · intro hv
    obtain ⟨w, hw, heq⟩ := Finset.mem_image.mp hv
    have h : w = v := Subtype.ext heq
    subst w
    simpa using hw

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

/-- An injective, loopless endpoint map identifies the edge indices with the graph edges. -/
noncomputable def finiteGraph_edgeEquiv_of_injective
    {V E : Type*} [Fintype V] [Fintype E] [DecidableEq V] [DecidableEq E]
    (endpoints : E → Sym2 V)
    (hloopless : ∀ e, ¬ (endpoints e).IsDiag)
    (hinj : Function.Injective endpoints) :
    E ≃ (SimpleGraph.fromEdgeSet
      (↑(Finset.univ.image endpoints) : Set (Sym2 V))).edgeFinset := by
  classical
  let G := SimpleGraph.fromEdgeSet
    (↑(Finset.univ.image endpoints) : Set (Sym2 V))
  have hedge : G.edgeFinset = Finset.univ.image endpoints := by
    ext edge
    rw [SimpleGraph.mem_edgeFinset]
    exact Set.ext_iff.mp (finiteGraph_edgeSet_of_endpoint_image endpoints hloopless) edge
  apply Equiv.ofBijective
    (fun e => (⟨endpoints e, hedge.symm ▸
      Finset.mem_image.mpr ⟨e, Finset.mem_univ _, rfl⟩⟩ : G.edgeFinset))
  constructor
  · intro e f h
    exact hinj (congrArg Subtype.val h)
  · intro edge
    obtain ⟨edge, hmem⟩ := edge
    rw [hedge] at hmem
    obtain ⟨e, _, he⟩ := Finset.mem_image.mp hmem
    exact ⟨e, Subtype.ext he⟩

/-- An edge equivalence preserving incidence preserves the number of selected
edges incident to each vertex. -/
theorem incident_edge_card_of_equiv
    {E F V : Type*} [DecidableEq E] [DecidableEq F]
    (edgeEquiv : E ≃ F) (A : Finset E) (v : V)
    (sourceIncident : V → E → Prop) (targetIncident : V → F → Prop)
    [DecidablePred (sourceIncident v)] [DecidablePred (targetIncident v)]
    (hinc : ∀ e, sourceIncident v e ↔ targetIncident v (edgeEquiv e)) :
    (A.filter (sourceIncident v)).card =
      ((A.image edgeEquiv).filter (targetIncident v)).card := by
  rw [Finset.filter_image]
  have hfilter :
      (A.filter fun e => targetIncident v (edgeEquiv e)) =
        A.filter (sourceIncident v) := by
    ext e
    simp [hinc e]
  rw [hfilter, Finset.card_image_of_injective _ edgeEquiv.injective]

end Ising2DLambda.NecSuf.KacWard
