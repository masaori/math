import Ising2DLambda.KacWard.BoundaryVertexSidePropagation
import Ising2DLambda.NecSuf.KacWard.BoundaryVertexSidePropagation

namespace Ising2DLambda.KacWard

/-- The cell-set statement is the specialization of the four-Boolean statement. -/
theorem boundaryVertex_consecutive_sides_eq_from_necSuf
    (cells : Finset GridCell) (r c : ℤ) (din dout : Fin 4)
    (sin sout : Bool)
    (hdiag₁ : ¬ ((r - 1, c - 1) ∈ cells ∧ (r - 1, c) ∉ cells ∧
      (r, c) ∈ cells ∧ (r, c - 1) ∉ cells))
    (hdiag₂ : ¬ ((r - 1, c - 1) ∉ cells ∧ (r - 1, c) ∈ cells ∧
      (r, c) ∉ cells ∧ (r, c - 1) ∈ cells))
    (hin : (incomingLeftCell r c din ∈ cells ↔ sin = true) ∧
      (incomingRightCell r c din ∈ cells ↔ sin = false))
    (hout : (outgoingLeftCell r c dout ∈ cells ↔ sout = true) ∧
      (outgoingRightCell r c dout ∈ cells ↔ sout = false))
    (hne : cellBoundaryIncomingEdge r c (din.val : ZMod 4) ≠
      cellBoundaryOutgoingEdge r c (dout.val : ZMod 4)) :
    sin = sout := by
  let a := decide ((r - 1, c - 1) ∈ cells)
  let b := decide ((r - 1, c) ∈ cells)
  let c' := decide ((r, c) ∈ cells)
  let d := decide ((r, c - 1) ∈ cells)
  have hd₁ : ¬ (a = true ∧ b = false ∧ c' = true ∧ d = false) := by
    simpa [a, b, c', d] using hdiag₁
  have hd₂ : ¬ (a = false ∧ b = true ∧ c' = false ∧ d = true) := by
    simpa [a, b, c', d] using hdiag₂
  have hi : NecSuf.KacWard.incomingLeft a b c' d din = sin ∧
      NecSuf.KacWard.incomingRight a b c' d din = !sin := by
    fin_cases din <;> cases sin <;>
      simp_all [a, b, c', d, incomingLeftCell, incomingRightCell,
        NecSuf.KacWard.incomingLeft, NecSuf.KacWard.incomingRight]
  have ho : NecSuf.KacWard.outgoingLeft a b c' d dout = sout ∧
      NecSuf.KacWard.outgoingRight a b c' d dout = !sout := by
    fin_cases dout <;> cases sout <;>
      simp_all [a, b, c', d, outgoingLeftCell, outgoingRightCell,
        NecSuf.KacWard.outgoingLeft, NecSuf.KacWard.outgoingRight]
  have he : din.val ≠ (dout.val + 2) % 4 := by
    fin_cases din <;> fin_cases dout <;>
      simp_all [cellBoundaryIncomingEdge, cellBoundaryOutgoingEdge,
        ZMod.val_one_eq_one_mod, ZMod.val_ofNat]
  exact NecSuf.KacWard.boundary_vertex_side_propagation_necSuf
    a b c' d din dout sin sout hd₁ hd₂ hi ho he

end Ising2DLambda.KacWard
