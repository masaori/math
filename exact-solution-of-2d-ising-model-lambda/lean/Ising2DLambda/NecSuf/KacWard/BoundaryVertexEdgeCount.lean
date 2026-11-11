import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- The only ingredients needed for the boundary vertex-edge count are finite
endpoint sets of size two and degree two at every incident vertex. -/
theorem boundary_vertex_edge_count_necSuf
    {Edge Vertex : Type*} [DecidableEq Edge] [DecidableEq Vertex]
    (edges : Finset Edge) (vertices : Finset Vertex)
    (endpoints : Edge → Finset Vertex)
    (htwoEnds : ∀ e ∈ edges, (endpoints e).card = 2)
    (hendpoints : ∀ e ∈ edges, endpoints e ⊆ vertices)
    (htwoEdges : ∀ v ∈ vertices,
      (edges.filter fun e => v ∈ endpoints e).card = 2) :
    vertices.card = edges.card := by
  have hedgeSum :
      (∑ e ∈ edges, ∑ v ∈ vertices,
        if v ∈ endpoints e then (1 : ℕ) else 0) = 2 * edges.card := by
    calc
      _ = ∑ e ∈ edges, (vertices.filter fun v => v ∈ endpoints e).card := by
        simp only [Finset.sum_boole, Nat.cast_id]
      _ = ∑ e ∈ edges, (endpoints e).card := by
        apply Finset.sum_congr rfl
        intro e he
        congr 1
        ext v
        simp only [Finset.mem_filter]
        exact and_iff_right_of_imp (fun hv => hendpoints e he hv)
      _ = ∑ _e ∈ edges, (2 : ℕ) := Finset.sum_congr rfl htwoEnds
      _ = 2 * edges.card := by simp [mul_comm]
  have hvertexSum :
      (∑ v ∈ vertices, ∑ e ∈ edges,
        if v ∈ endpoints e then (1 : ℕ) else 0) = 2 * vertices.card := by
    calc
      _ = ∑ v ∈ vertices, (edges.filter fun e => v ∈ endpoints e).card := by
        simp only [Finset.sum_boole, Nat.cast_id]
      _ = ∑ _v ∈ vertices, (2 : ℕ) := Finset.sum_congr rfl htwoEdges
      _ = 2 * vertices.card := by simp [mul_comm]
  rw [Finset.sum_comm] at hedgeSum
  omega

end Ising2DLambda.NecSuf.KacWard
