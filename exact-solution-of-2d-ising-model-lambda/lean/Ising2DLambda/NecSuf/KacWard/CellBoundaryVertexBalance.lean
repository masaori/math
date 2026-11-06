import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Only cyclic endpoint matching is needed for the local cancellation. -/
theorem closedFourEdgeBoundary_vertex_balance {E V : Type*} [DecidableEq V]
    (a b c d : E) (source target : E → V)
    (h₁ : target a = source b) (h₂ : target b = source c)
    (h₃ : target c = source d) (h₄ : target d = source a) (v : V) :
    (([a, b, c, d].map fun e =>
      (if source e = v then (1 : ℤ) else 0) -
      (if target e = v then (1 : ℤ) else 0)).sum) = 0 := by
  simp only [List.map_cons, List.map_nil, List.sum_cons, List.sum_nil]
  rw [h₁, h₂, h₃, h₄]
  ring

end Ising2DLambda.NecSuf.KacWard
