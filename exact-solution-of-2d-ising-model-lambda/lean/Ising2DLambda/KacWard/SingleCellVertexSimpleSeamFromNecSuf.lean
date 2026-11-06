import Ising2DLambda.KacWard.SingleCellVertexSimpleSeam
import Ising2DLambda.NecSuf.KacWard.SingleCellVertexSimpleSeam

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The binary classifier in the necessary and sufficient proof is the actual
horizontal or vertical base-edge type at side length one. -/
theorem single_cell_vertex_simple_zero_seam_impossible_from_necSuf {m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge 1)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0) :
    False := by
  have hvertex : Fintype.card (Vertex 1) = 1 := by
    rw [card_vertex]
    norm_num
  have hinj := (contactPairCount_eq_zero_iff_pass_vertices_injective γ hγ).mp hcontact
  have hhorizontal (e : OrientedEdge 1) :
      (if decide (e.1.val < 1) then 1 else 0) = horizontalSeamParity e := by
    rcases e with ⟨edge, direction⟩
    fin_cases edge <;> cases direction <;> decide
  have hvertical (e : OrientedEdge 1) :
      (if decide (e.1.val < 1) then 0 else 1) = verticalSeamParity e := by
    rcases e with ⟨edge, direction⟩
    fin_cases edge <;> cases direction <;> decide
  have hh' : (∑ k : Fin (m + 1),
      if decide ((γ k).1.val < 1) then 1 else 0) % 2 = 0 := by
    simpa only [hhorizontal] using hh
  have hv' : (∑ k : Fin (m + 1),
      if decide ((γ k).1.val < 1) then 0 else 1) % 2 = 0 := by
    simpa only [hvertical] using hv
  exact Ising2DLambda.NecSuf.KacWard.single_cell_vertex_simple_seam
    hvertex γ orientedTarget (fun e => decide (e.1.val < 1)) hinj hh' hv'

end Ising2DLambda.KacWard
