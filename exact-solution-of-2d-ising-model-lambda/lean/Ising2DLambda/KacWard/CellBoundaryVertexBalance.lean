import Ising2DLambda.KacWard.CellBoundaryWinding

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The four labelled sides of one cell have zero boundary at every vertex. -/
theorem cellBoundary_vertex_balance (L : ℕ) [NeZero L]
    (i j : ZMod L) (v : Vertex L) :
    ((cellBoundaryEdges L i j).map fun e =>
      (if orientedSource e = v then (1 : ℤ) else 0) -
      (if orientedTarget e = v then (1 : ℤ) else 0)).sum = 0 := by
  obtain ⟨h₁, h₂, h₃, h₄⟩ := cellBoundaryEdges_connected L i j
  simp only [cellBoundaryEdges, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil]
  rw [h₁, h₂, h₃, h₄]
  ring

/-- A finite sum of cell boundaries has zero boundary at every vertex. -/
theorem cellSetBoundary_vertex_balance (L : ℕ) [NeZero L]
    (S : Finset (ZMod L × ZMod L)) (v : Vertex L) :
    (∑ p ∈ S, ((cellBoundaryEdges L p.1 p.2).map fun e =>
      (if orientedSource e = v then (1 : ℤ) else 0) -
      (if orientedTarget e = v then (1 : ℤ) else 0)).sum) = 0 := by
  classical
  simp [cellBoundary_vertex_balance]

end Ising2DLambda.KacWard
