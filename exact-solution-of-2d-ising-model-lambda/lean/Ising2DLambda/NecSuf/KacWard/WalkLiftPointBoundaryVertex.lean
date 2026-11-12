import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- An odd finite count of selected positions has a selected position. -/
theorem exists_position_of_odd_count
    (n : ℕ) (selected : ℕ → Prop) [DecidablePred selected]
    (hodd : Odd (∑ k ∈ Finset.range n, if selected k then 1 else 0)) :
    ∃ k < n, selected k := by
  by_contra h
  have hzero : (∑ k ∈ Finset.range n, if selected k then 1 else 0) = 0 := by
    apply Finset.sum_eq_zero
    intro k hk
    simp [show ¬ selected k from by
      intro hs
      exact h ⟨k, Finset.mem_range.mp hk, hs⟩]
  rw [hzero] at hodd
  exact Nat.not_odd_zero hodd

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
