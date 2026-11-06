import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A zero oriented incidence sum remains zero after collecting occurrences by base edge. -/
theorem coefficient_vertex_balance {E V : Type*} [Fintype E] [DecidableEq E]
    [DecidableEq V] (edges : List (E × Bool)) (source target : E → V) (v : V)
    (hbalance : (edges.map fun e =>
      (if (if e.2 then target e.1 else source e.1) = v then (1 : ℤ) else 0) -
        (if (if e.2 then source e.1 else target e.1) = v then (1 : ℤ) else 0)).sum = 0) :
    (∑ edge : E, (edges.map fun e =>
      if e.1 = edge then 1 - 2 * (e.2.toNat : ℤ) else 0).sum *
      ((if source edge = v then (1 : ℤ) else 0) -
        (if target edge = v then (1 : ℤ) else 0))) = 0 := by
  classical
  have hsingle (e : E × Bool) :
      (if (if e.2 then target e.1 else source e.1) = v then (1 : ℤ) else 0) -
        (if (if e.2 then source e.1 else target e.1) = v then (1 : ℤ) else 0) =
      ∑ edge : E, (if e.1 = edge then 1 - 2 * (e.2.toNat : ℤ) else 0) *
        ((if source edge = v then (1 : ℤ) else 0) -
          (if target edge = v then (1 : ℤ) else 0)) := by
    cases e with
    | mk edge direction => cases direction <;> simp
  have hlist (es : List (E × Bool)) :
      (es.map fun e =>
        (if (if e.2 then target e.1 else source e.1) = v then (1 : ℤ) else 0) -
          (if (if e.2 then source e.1 else target e.1) = v then (1 : ℤ) else 0)).sum =
      ∑ edge : E, (es.map fun e =>
        if e.1 = edge then 1 - 2 * (e.2.toNat : ℤ) else 0).sum *
        ((if source edge = v then (1 : ℤ) else 0) -
          (if target edge = v then (1 : ℤ) else 0)) := by
    induction es with
    | nil => simp
    | cons e tail ih =>
        simp only [List.map_cons, List.sum_cons]
        rw [ih, hsingle e, ← Finset.sum_add_distrib]
        congr 1
        funext edge
        ring
  rw [← hlist]
  exact hbalance

end Ising2DLambda.NecSuf.KacWard
