import Ising2DLambda.KacWard.CellGraphEvenEdgeBijection
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- A selected set of graph edges has the same incidence counts when its edges are
viewed as elements of the ambient edge type. -/
theorem cellGraphEdgeSubset_incidence_count (cells : Finset GridCell)
    (B : Finset (cellVertexGraph cells).edgeFinset)
    (v : cellVertices cells) :
    (B.filter (fun e => v ∈ e.1)).card =
      ((B.map ⟨Subtype.val, Subtype.val_injective⟩).filter (fun e => v ∈ e)).card := by
  have hmap :
      (B.filter (fun e => v ∈ e.1)).map ⟨Subtype.val, Subtype.val_injective⟩ =
        (B.map ⟨Subtype.val, Subtype.val_injective⟩).filter (fun e => v ∈ e) := by
    simp only [Finset.filter_map]
    rfl
  rw [← hmap]
  exact (Finset.card_map _).symm

/-- The subtype representation of graph edges and the ambient-edge representation
with an edge-set constraint have the same even subsets. -/
theorem cellGraphEdgeSubset_even_card (cells : Finset GridCell) :
    Nat.card {B : Finset (cellVertexGraph cells).edgeFinset //
      IsEvenCellGraphEdgeSet cells B} =
    Nat.card {A : Finset (Sym2 (cellVertices cells)) //
      A ⊆ (cellVertexGraph cells).edgeFinset ∧
        ∀ v : cellVertices cells,
          Even (A.filter (fun e => v ∈ e)).card} := by
  classical
  let e := Equiv.finsetSubtypeComm
    (fun a : Sym2 (cellVertices cells) => a ∈ (cellVertexGraph cells).edgeFinset)
  have hparity (B : Finset (cellVertexGraph cells).edgeFinset) :
      IsEvenCellGraphEdgeSet cells B ↔
        ∀ v : cellVertices cells,
          Even ((e B).1.filter (fun a => v ∈ a)).card := by
    constructor
    · intro h v
      simpa only [e, Equiv.finsetSubtypeComm] using
        (cellGraphEdgeSubset_incidence_count cells B v ▸ h v)
    · intro h v
      have hv := h v
      simpa only [e, Equiv.finsetSubtypeComm] using
        (cellGraphEdgeSubset_incidence_count cells B v ▸ hv)
  let f : {B : Finset (cellVertexGraph cells).edgeFinset //
      IsEvenCellGraphEdgeSet cells B} →
      {A : Finset (Sym2 (cellVertices cells)) //
        A ⊆ (cellVertexGraph cells).edgeFinset ∧
          ∀ v : cellVertices cells, Even (A.filter (fun a => v ∈ a)).card} :=
    fun B => ⟨(e B.1).1, (e B.1).2, (hparity B.1).mp B.2⟩
  have hf : Function.Bijective f := by
    constructor
    · intro A B h
      apply Subtype.ext
      apply e.injective
      apply Subtype.ext
      have hv := congrArg Subtype.val h
      change (e A.1).1 = (e B.1).1 at hv
      exact hv
    · intro A
      obtain ⟨B, hB⟩ := e.surjective ⟨A.1, A.2.1⟩
      have hEven : IsEvenCellGraphEdgeSet cells B := by
        apply (hparity B).mpr
        simpa [hB] using A.2.2
      refine ⟨⟨B, hEven⟩, ?_⟩
      apply Subtype.ext
      change (e B).1 = A.1
      exact congrArg Subtype.val hB
  exact Nat.card_congr (Equiv.ofBijective f hf)

end Ising2DLambda.KacWard
