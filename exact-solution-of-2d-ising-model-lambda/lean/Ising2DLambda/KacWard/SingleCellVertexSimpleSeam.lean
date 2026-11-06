import Ising2DLambda.KacWard.VertexSimpleBoundaryNonloopPropagation

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- A vertex-simple closed walk at side length one has one edge, which crosses
exactly one of the two seams. -/
theorem single_cell_vertex_simple_zero_seam_impossible {m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge 1)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0) :
    False := by
  have hinj := (contactPairCount_eq_zero_iff_pass_vertices_injective γ hγ).mp hcontact
  -- The unique torus vertex leaves only one passage position.
  have hcard : Fintype.card (Fin (m + 1)) ≤ Fintype.card (Vertex 1) :=
    Fintype.card_le_of_injective _ hinj
  rw [Fintype.card_fin, card_vertex] at hcard
  have hm : m = 0 := by omega
  subst m
  have hsum : horizontalSeamParity (γ 0) + verticalSeamParity (γ 0) = 1 := by
    -- Either base edge crosses its own seam; orientation does not change this.
    rcases γ 0 with ⟨edge, direction⟩
    fin_cases edge <;> cases direction <;>
      decide
  have hhor : horizontalSeamParity (γ 0) % 2 = 0 := by
    simpa using hh
  have hver : verticalSeamParity (γ 0) % 2 = 0 := by
    simpa using hv
  omega

end Ising2DLambda.KacWard
