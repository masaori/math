import Ising2DLambda.KacWard.BoundaryVertexLocalTurn

namespace Ising2DLambda.KacWard

set_option maxHeartbeats 2000000

/-- The cell to the left of a step entering a planar grid vertex. -/
def incomingLeftCell (r c : ℤ) (d : Fin 4) : GridCell :=
  if d.val = 0 then (r - 1, c - 1)
  else if d.val = 1 then (r - 1, c)
  else if d.val = 2 then (r, c)
  else (r, c - 1)

def incomingRightCell (r c : ℤ) (d : Fin 4) : GridCell :=
  if d.val = 0 then (r, c - 1)
  else if d.val = 1 then (r - 1, c - 1)
  else if d.val = 2 then (r - 1, c)
  else (r, c)

def outgoingLeftCell (r c : ℤ) (d : Fin 4) : GridCell :=
  if d.val = 0 then (r - 1, c)
  else if d.val = 1 then (r, c)
  else if d.val = 2 then (r, c - 1)
  else (r - 1, c - 1)

def outgoingRightCell (r c : ℤ) (d : Fin 4) : GridCell :=
  if d.val = 0 then (r, c)
  else if d.val = 1 then (r, c - 1)
  else if d.val = 2 then (r - 1, c - 1)
  else (r - 1, c)

/-- Two different boundary edges at a vertex cannot switch which side contains
the selected cell unless the two diagonal cells alone are selected. -/
theorem boundaryVertex_consecutive_sides_eq
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
  fin_cases din <;> fin_cases dout <;> cases sin <;> cases sout <;>
    simp_all [incomingLeftCell, incomingRightCell, outgoingLeftCell,
      outgoingRightCell, cellBoundaryIncomingEdge, cellBoundaryOutgoingEdge,
      ZMod.val_one_eq_one_mod, ZMod.val_ofNat]

end Ising2DLambda.KacWard
