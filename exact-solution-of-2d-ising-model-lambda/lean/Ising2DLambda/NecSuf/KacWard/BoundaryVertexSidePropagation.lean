import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

set_option maxHeartbeats 2000000

def incomingLeft (a b c d : Bool) (direction : Fin 4) : Bool :=
  if direction.val = 0 then a
  else if direction.val = 1 then b
  else if direction.val = 2 then c
  else d

def incomingRight (a b c d : Bool) (direction : Fin 4) : Bool :=
  if direction.val = 0 then d
  else if direction.val = 1 then a
  else if direction.val = 2 then b
  else c

def outgoingLeft (a b c d : Bool) (direction : Fin 4) : Bool :=
  if direction.val = 0 then b
  else if direction.val = 1 then c
  else if direction.val = 2 then d
  else a

def outgoingRight (a b c d : Bool) (direction : Fin 4) : Bool :=
  if direction.val = 0 then c
  else if direction.val = 1 then d
  else if direction.val = 2 then a
  else b

/-- Four cyclic cells, two distinct incident edges, and exclusion of diagonal
contact suffice for the interior side of successive steps to agree. -/
theorem boundary_vertex_side_propagation_necSuf
    (a b c d : Bool) (din dout : Fin 4) (sin sout : Bool)
    (hdiag₁ : ¬ (a = true ∧ b = false ∧ c = true ∧ d = false))
    (hdiag₂ : ¬ (a = false ∧ b = true ∧ c = false ∧ d = true))
    (hin : incomingLeft a b c d din = sin ∧
      incomingRight a b c d din = !sin)
    (hout : outgoingLeft a b c d dout = sout ∧
      outgoingRight a b c d dout = !sout)
    (hne : din.val ≠ (dout.val + 2) % 4) : sin = sout := by
  fin_cases din <;> fin_cases dout <;> cases sin <;> cases sout <;>
    cases a <;> cases b <;> cases c <;> cases d <;>
    simp_all [incomingLeft, incomingRight, outgoingLeft, outgoingRight]

end Ising2DLambda.NecSuf.KacWard
