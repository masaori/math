import Ising2DLambda.KacWard.CellBoundaryEvenEdgeBijection
import Ising2DLambda.KacWard.CellVertexGraph
import Ising2DLambda.NecSuf.KacWard.FourEdgeMembershipParity
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- At a grid vertex exactly four encoded edge positions can be incident. -/
private theorem incident_edges_eq_four (A : Finset GridEdge) (r c : ℤ) :
    A.filter (fun e => (r, c) ∈ gridEdgeEndpoints e) =
      A.filter (fun e => e ∈ ({(false, (r, c)), (false, (r, c - 1)),
        (true, (r, c)), (true, (r - 1, c))} : Finset GridEdge)) := by
  ext ⟨b, s, t⟩
  cases b <;> simp [gridEdgeEndpoints, Prod.mk.injEq] <;> omega

/-- The local four-edge parity formula is the parity of incident-edge count. -/
theorem gridIncidentEven_iff (A : Finset GridEdge) (r c : ℤ) :
    (((if (false, (r, c)) ∈ A then (1 : ZMod 2) else 0) +
      (if (false, (r, c - 1)) ∈ A then 1 else 0) +
      (if (true, (r, c)) ∈ A then 1 else 0) +
      (if (true, (r - 1, c)) ∈ A then 1 else 0)) = 0) ↔
      Even (A.filter (fun e => (r, c) ∈ gridEdgeEndpoints e)).card := by
  rw [incident_edges_eq_four]
  have hfilter :
      A.filter (fun e => e ∈ ({(false, (r, c)), (false, (r, c - 1)),
        (true, (r, c)), (true, (r - 1, c))} : Finset GridEdge)) =
      ({(false, (r, c)), (false, (r, c - 1)),
        (true, (r, c)), (true, (r - 1, c))} : Finset GridEdge).filter
        (fun e => e ∈ A) := by
    ext e
    simp [and_comm]
  rw [hfilter]
  simp only [Finset.filter_insert, Finset.filter_singleton]
  have hr : r ≠ r - 1 := by omega
  have hc : c ≠ c - 1 := by omega
  by_cases h₁ : (false, (r, c)) ∈ A <;>
    by_cases h₂ : (false, (r, c - 1)) ∈ A <;>
    by_cases h₃ : (true, (r, c)) ∈ A <;>
    by_cases h₄ : (true, (r - 1, c)) ∈ A <;>
    simp [h₁, h₂, h₃, h₄, Prod.mk.injEq, hr, hc, Nat.even_iff] <;>
      norm_num <;> decide

theorem gridIncidentEven_iff_from_necSuf (A : Finset GridEdge) (r c : ℤ) :
    (((if (false, (r, c)) ∈ A then (1 : ZMod 2) else 0) +
      (if (false, (r, c - 1)) ∈ A then 1 else 0) +
      (if (true, (r, c)) ∈ A then 1 else 0) +
      (if (true, (r - 1, c)) ∈ A then 1 else 0)) = 0) ↔
      Even (A.filter (fun e => (r, c) ∈ gridEdgeEndpoints e)).card := by
  rw [incident_edges_eq_four]
  have hfilter :
      A.filter (fun e => e ∈ ({(false, (r, c)), (false, (r, c - 1)),
        (true, (r, c)), (true, (r - 1, c))} : Finset GridEdge)) =
      ({(false, (r, c)), (false, (r, c - 1)),
        (true, (r, c)), (true, (r - 1, c))} : Finset GridEdge).filter
        (fun e => e ∈ A) := by
    ext e
    simp [and_comm]
  rw [hfilter]
  apply Ising2DLambda.NecSuf.KacWard.fourEdgeMembershipParity
  all_goals simp [Prod.mk.injEq] <;> omega

end Ising2DLambda.KacWard
