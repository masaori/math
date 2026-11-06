import Ising2DLambda.KacWard.WalkEqualsCellBoundary

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

/-- An oriented occurrence contributes its signed base-edge coefficient to vertex divergence. -/
private theorem oriented_incidence_as_coefficient (L : ℕ) (e : OrientedEdge L)
    (v : Vertex L) :
    (if orientedSource e = v then (1 : ℤ) else 0) -
      (if orientedTarget e = v then (1 : ℤ) else 0) =
    ∑ edge : Edge L, orientedEdgeCoefficient edge e *
      ((if orientedSource (edge, false) = v then (1 : ℤ) else 0) -
        (if orientedTarget (edge, false) = v then (1 : ℤ) else 0)) := by
  classical
  cases e with
  | mk edge direction =>
    cases direction <;> simp [orientedEdgeCoefficient, orientedSource, orientedTarget]

private theorem boundaryList_incidence_as_coefficients (L : ℕ)
    (edges : List (OrientedEdge L)) (v : Vertex L) :
    (edges.map fun e =>
      (if orientedSource e = v then (1 : ℤ) else 0) -
        (if orientedTarget e = v then (1 : ℤ) else 0)).sum =
    ∑ edge : Edge L, (edges.map (orientedEdgeCoefficient edge)).sum *
      ((if orientedSource (edge, false) = v then (1 : ℤ) else 0) -
        (if orientedTarget (edge, false) = v then (1 : ℤ) else 0)) := by
  classical
  induction edges with
  | nil => simp
  | cons e tail ih =>
      simp only [List.map_cons, List.sum_cons]
      rw [ih, oriented_incidence_as_coefficient L e v, ← Finset.sum_add_distrib]
      congr 1
      funext edge
      ring

/-- The concrete proof of `claim_cell_boundary_coefficient_vertex_balance`:
the orientation identity is collected first, then the cell-boundary balance is applied. -/
theorem cellSetBoundary_coefficient_vertex_balance (L : ℕ) [NeZero L]
    (S : Finset (ZMod L × ZMod L)) (v : Vertex L) :
    (∑ edge : Edge L, cellSetEdgeCoefficient L S edge *
      ((if orientedSource (edge, false) = v then (1 : ℤ) else 0) -
        (if orientedTarget (edge, false) = v then (1 : ℤ) else 0))) = 0 := by
  classical
  calc
    _ = ∑ p ∈ S, ∑ edge : Edge L,
        ((cellBoundaryEdges L p.1 p.2).map
          (orientedEdgeCoefficient edge)).sum *
          ((if orientedSource (edge, false) = v then (1 : ℤ) else 0) -
            (if orientedTarget (edge, false) = v then (1 : ℤ) else 0)) := by
          simp only [cellSetEdgeCoefficient, Finset.sum_mul]
          exact Finset.sum_comm
    _ = ∑ p ∈ S, ((cellBoundaryEdges L p.1 p.2).map fun e =>
        (if orientedSource e = v then (1 : ℤ) else 0) -
          (if orientedTarget e = v then (1 : ℤ) else 0)).sum := by
          apply Finset.sum_congr rfl
          intro p _
          exact (boundaryList_incidence_as_coefficients L _ v).symm
    _ = 0 := cellSetBoundary_vertex_balance L S v

end Ising2DLambda.KacWard
