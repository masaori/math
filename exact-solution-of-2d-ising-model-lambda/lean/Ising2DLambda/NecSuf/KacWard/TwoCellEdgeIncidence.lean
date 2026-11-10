import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- The two distinct cells incident to an edge are counted independently. -/
theorem twoCellEdge_incidence_count {Cell : Type*} [DecidableEq Cell]
    (cells : Finset Cell) (a b : Cell) (hne : a ≠ b) :
    (cells.filter (fun x => x = a ∨ x = b)).card =
      (if a ∈ cells then 1 else 0) + (if b ∈ cells then 1 else 0) := by
  classical
  have hfilter : cells.filter (fun x => x = a ∨ x = b) = ({a, b} : Finset Cell) ∩ cells := by
    ext x
    simp [eq_comm, and_comm]
  rw [hfilter]
  by_cases ha : a ∈ cells <;> by_cases hb : b ∈ cells <;>
    simp [ha, hb, hne]

theorem twoCellEdge_incidence_eq_one {Cell : Type*} [DecidableEq Cell]
    (cells : Finset Cell) (a b : Cell) (hne : a ≠ b) :
    (cells.filter (fun x => x = a ∨ x = b)).card = 1 ↔
      (a ∈ cells ∧ b ∉ cells) ∨ (a ∉ cells ∧ b ∈ cells) := by
  rw [twoCellEdge_incidence_count cells a b hne]
  by_cases ha : a ∈ cells <;> by_cases hb : b ∈ cells <;>
    simp [ha, hb]

theorem twoCellEdge_incidence_eq_two {Cell : Type*} [DecidableEq Cell]
    (cells : Finset Cell) (a b : Cell) (hne : a ≠ b) :
    (cells.filter (fun x => x = a ∨ x = b)).card = 2 ↔
      a ∈ cells ∧ b ∈ cells := by
  rw [twoCellEdge_incidence_count cells a b hne]
  by_cases ha : a ∈ cells <;> by_cases hb : b ∈ cells <;>
    simp [ha, hb]

end Ising2DLambda.NecSuf.KacWard
