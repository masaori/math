import Ising2DLambda.KacWard.CellBoundaryVertexBalance

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- At a vertex with only one incoming and one outgoing supported base edge,
the boundary coefficients agree after orientation is taken into account. -/
theorem cellSetBoundary_two_edge_propagation (L : ℕ) [NeZero L]
    (S : Finset (ZMod L × ZMod L)) (v : Vertex L)
    (incoming outgoing : OrientedEdge L)
    (hdistinct : incoming.1 ≠ outgoing.1)
    (hin : orientedTarget incoming = v)
    (hnotin : orientedSource incoming ≠ v)
    (hout : orientedSource outgoing = v)
    (hnotout : orientedTarget outgoing ≠ v)
    (hsupport : ∀ edge : Edge L, edge ≠ incoming.1 → edge ≠ outgoing.1 →
      cellSetEdgeCoefficient L S edge *
        ((if orientedSource (edge, false) = v then (1 : ℤ) else 0) -
          (if orientedTarget (edge, false) = v then (1 : ℤ) else 0)) = 0) :
    cellSetEdgeCoefficient L S incoming.1 *
        (1 - 2 * (incoming.2.toNat : ℤ)) =
      cellSetEdgeCoefficient L S outgoing.1 *
        (1 - 2 * (outgoing.2.toNat : ℤ)) := by
  classical
  let D : Edge L → ℤ := fun edge =>
    (if orientedSource (edge, false) = v then 1 else 0) -
      (if orientedTarget (edge, false) = v then 1 else 0)
  let f : Edge L → ℤ := fun edge => cellSetEdgeCoefficient L S edge * D edge
  -- The terms outside the two supported base edges vanish in the vertex sum.
  have htwo : (∑ edge : Edge L, f edge) = f incoming.1 + f outgoing.1 := by
    have hsub : ({incoming.1, outgoing.1} : Finset (Edge L)) ⊆ Finset.univ := by simp
    have hsum : (∑ edge ∈ ({incoming.1, outgoing.1} : Finset (Edge L)), f edge) =
        ∑ edge : Edge L, f edge := by
      apply Finset.sum_subset hsub
      intro edge _ hnot
      have hnein : edge ≠ incoming.1 := by
        intro heq
        exact hnot (by simp [heq])
      have hneout : edge ≠ outgoing.1 := by
        intro heq
        exact hnot (by simp [heq])
      exact hsupport edge hnein hneout
    rw [← hsum]
    simp [hdistinct, f]
  -- The finite-cell boundary has zero vertex divergence.
  have hbalance : f incoming.1 + f outgoing.1 = 0 := by
    rw [← htwo]
    exact cellSetBoundary_coefficient_vertex_balance L S v
  -- Reversing an incoming edge reverses its base-edge incidence.
  have hinc : D incoming.1 = -(1 - 2 * (incoming.2.toNat : ℤ)) := by
    cases incoming with
    | mk edge direction =>
      cases direction <;> simp [D, orientedSource, orientedTarget] at hin hnotin ⊢
      all_goals simp_all [orientedSource, orientedTarget]
  -- An outgoing edge has the same sign as its base-edge incidence.
  have houtc : D outgoing.1 = 1 - 2 * (outgoing.2.toNat : ℤ) := by
    cases outgoing with
    | mk edge direction =>
      cases direction <;> simp [D, orientedSource, orientedTarget] at hout hnotout ⊢
      all_goals simp_all [D, orientedSource, orientedTarget]
  simp only [f, hinc, houtc] at hbalance
  linear_combination -hbalance

end Ising2DLambda.KacWard
