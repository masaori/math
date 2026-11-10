import Ising2DLambda.KacWard.CellGridIncidentParity
import Ising2DLambda.KacWard.CellGraphEvenEdgeBijection
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Passing from grid edges to the edge subtype preserves the even-incidence
condition at every integer lattice vertex. -/
theorem cellGridEvenEdge_iff_encoded (cells : Finset GridCell)
    (A : Finset GridEdge) (hA : A ⊆ cellEdges cells) :
    IsEvenCellEdgeSubset cells A ↔
      IsEvenEncodedCellEdgeSet cells
        (A.subtype (fun e => e ∈ cellEdges cells)) := by
  classical
  have hcard (r c : ℤ) :
      ((A.subtype (fun e => e ∈ cellEdges cells)).filter
        (fun e => (r, c) ∈ gridEdgeEndpoints e.1)).card =
      (A.filter (fun e => (r, c) ∈ gridEdgeEndpoints e)).card := by
    apply Finset.card_bij (fun e _ => e.1)
    · intro e he
      exact Finset.mem_filter.mpr ⟨Finset.mem_subtype.mp
        (Finset.mem_filter.mp he).1, (Finset.mem_filter.mp he).2⟩
    · intro e₁ he₁ e₂ he₂ heq
      exact Subtype.ext heq
    · intro e he
      refine ⟨⟨e, hA (Finset.mem_filter.mp he).1⟩, ?_, rfl⟩
      exact Finset.mem_filter.mpr ⟨Finset.mem_subtype.mpr
        (Finset.mem_filter.mp he).1, (Finset.mem_filter.mp he).2⟩
  constructor
  · intro h r c
    rw [hcard r c]
    exact (gridIncidentEven_iff A r c).mp (h.2 r c)
  · intro h
    refine ⟨hA, ?_⟩
    intro r c
    apply (gridIncidentEven_iff A r c).mpr
    rw [← hcard r c]
    exact h r c

/-- Even grid-edge sets and even subsets of the cell-edge subtype have the same cardinality. -/
theorem cellGridEvenEdge_card_encoded (cells : Finset GridCell) :
    Nat.card {A : Finset GridEdge // IsEvenCellEdgeSubset cells A} =
      Nat.card {B : Finset (cellEdges cells) // IsEvenEncodedCellEdgeSet cells B} := by
  classical
  let e := (Equiv.finsetSubtypeComm
    (fun edge : GridEdge => edge ∈ cellEdges cells)).symm
  have he_apply (A : Finset GridEdge) (hA : A ⊆ cellEdges cells) :
      e ⟨A, hA⟩ = A.subtype (fun edge => edge ∈ cellEdges cells) := by
    ext edge
    change edge ∈ A.attach.map (Subtype.impEmbedding _ _ hA) ↔ _
    constructor
    · intro he
      obtain ⟨a, _, ha⟩ := Finset.mem_map.mp he
      exact Finset.mem_subtype.mpr ((congrArg Subtype.val ha).symm ▸ a.2)
    · intro he
      let a : {x : GridEdge // x ∈ A} := ⟨edge.1, Finset.mem_subtype.mp he⟩
      exact Finset.mem_map.mpr ⟨a, Finset.mem_attach _ _, Subtype.ext rfl⟩
  let f : {A : Finset GridEdge // IsEvenCellEdgeSubset cells A} →
      {B : Finset (cellEdges cells) // IsEvenEncodedCellEdgeSet cells B} :=
    fun A => ⟨e ⟨A.1, A.2.1⟩,
      (by
        simpa [he_apply] using
          (cellGridEvenEdge_iff_encoded cells A.1 A.2.1).mp A.2)⟩
  have hf : Function.Bijective f := by
    constructor
    · intro A B h
      apply Subtype.ext
      have he : e ⟨A.1, A.2.1⟩ = e ⟨B.1, B.2.1⟩ :=
        congrArg Subtype.val h
      exact congrArg
        (fun x : {s : Finset GridEdge // s ⊆ cellEdges cells} => x.1)
        (e.injective he)
    · intro B
      obtain ⟨A, hA⟩ := e.surjective B.1
      have hEven : IsEvenCellEdgeSubset cells A.1 := by
        apply (cellGridEvenEdge_iff_encoded cells A.1 A.2).mpr
        rw [← he_apply A.1 A.2, hA]
        exact B.2
      refine ⟨⟨A.1, hEven⟩, ?_⟩
      apply Subtype.ext
      exact hA
  exact Nat.card_congr (Equiv.ofBijective f hf)

end Ising2DLambda.KacWard
