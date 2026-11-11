import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Four cells in cyclic order: northwest, northeast, southeast, southwest. -/
def localCellCount (a b c d : Bool) : ℕ :=
  (if a then 1 else 0) + (if b then 1 else 0) +
    (if c then 1 else 0) + (if d then 1 else 0)

/-- The incoming direction when selected cells lie to the left of the boundary. -/
def localIncoming (a b c d : Bool) : ZMod 4 :=
  if c && !b then 2 else if d && !c then 3 else if a && !d then 0 else 1

/-- The outgoing direction under the same orientation. -/
def localOutgoing (a b c d : Bool) : ZMod 4 :=
  if b && !c then 0 else if c && !d then 1 else if d && !a then 2 else 3

def localTurn (a b c d : Bool) : ℤ :=
  if localOutgoing a b c d - localIncoming a b c d = (1 : ZMod 4) then 1
  else if localOutgoing a b c d - localIncoming a b c d = (-1 : ZMod 4) then -1
  else 0

/-- At a non-diagonal boundary vertex the turn is determined by the number of cells. -/
theorem local_turn_by_cell_count (a b c d : Bool)
    (hdiag₁ : ¬ (a = true ∧ b = false ∧ c = true ∧ d = false))
    (hdiag₂ : ¬ (a = false ∧ b = true ∧ c = false ∧ d = true))
    (hboundary : localCellCount a b c d = 1 ∨
      localCellCount a b c d = 2 ∨ localCellCount a b c d = 3) :
    localTurn a b c d =
      if localCellCount a b c d = 1 then -1
      else if localCellCount a b c d = 3 then 1 else 0 := by
  cases a <;> cases b <;> cases c <;> cases d <;>
    simp_all [localCellCount, localTurn, localIncoming, localOutgoing] <;> decide

end Ising2DLambda.NecSuf.KacWard
