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

/-- Whether the edge entering from a direction separates selected and
unselected cells. -/
def incomingExposed (a b c d : Bool) (direction : ZMod 4) : Prop :=
  if direction = 0 then a ≠ d
  else if direction = 1 then a ≠ b
  else if direction = 2 then b ≠ c
  else c ≠ d

/-- Whether the edge leaving in a direction separates selected and
unselected cells. -/
def outgoingExposed (a b c d : Bool) (direction : ZMod 4) : Prop :=
  if direction = 0 then b ≠ c
  else if direction = 1 then c ≠ d
  else if direction = 2 then a ≠ d
  else a ≠ b

theorem local_directions_exposed (a b c d : Bool)
    (hboundary : localCellCount a b c d = 1 ∨
      localCellCount a b c d = 2 ∨ localCellCount a b c d = 3) :
    incomingExposed a b c d (localIncoming a b c d) ∧
      outgoingExposed a b c d (localOutgoing a b c d) := by
  cases a <;> cases b <;> cases c <;> cases d <;>
    simp_all [localCellCount, incomingExposed, outgoingExposed,
      localIncoming, localOutgoing] <;> decide

/-- Each selected direction has a selected cell on its left and an unselected
cell on its right. The boundary condition excludes the empty and full patterns. -/
theorem local_directions_selected_left (a b c d : Bool)
    (hboundary : localCellCount a b c d = 1 ∨
      localCellCount a b c d = 2 ∨ localCellCount a b c d = 3) :
    (if localIncoming a b c d = 0 then a = true ∧ d = false
      else if localIncoming a b c d = 1 then b = true ∧ a = false
      else if localIncoming a b c d = 2 then c = true ∧ b = false
      else d = true ∧ c = false) ∧
    (if localOutgoing a b c d = 0 then b = true ∧ c = false
      else if localOutgoing a b c d = 1 then c = true ∧ d = false
      else if localOutgoing a b c d = 2 then d = true ∧ a = false
      else a = true ∧ b = false) := by
  cases a <;> cases b <;> cases c <;> cases d <;>
    simp_all [localCellCount, localIncoming, localOutgoing] <;> decide

/-- The incoming edge touches the west, north, east, or south side. -/
def incomingSide (direction : ZMod 4) : Fin 4 :=
  if direction = 0 then 3 else if direction = 1 then 0
  else if direction = 2 then 1 else 2

/-- The outgoing edge touches the east, south, west, or north side. -/
def outgoingSide (direction : ZMod 4) : Fin 4 :=
  if direction = 0 then 1 else if direction = 1 then 2
  else if direction = 2 then 3 else 0

theorem local_incoming_outgoing_sides_ne (a b c d : Bool)
    (hdiag₁ : ¬ (a = true ∧ b = false ∧ c = true ∧ d = false))
    (hdiag₂ : ¬ (a = false ∧ b = true ∧ c = false ∧ d = true))
    (hboundary : localCellCount a b c d = 1 ∨
      localCellCount a b c d = 2 ∨ localCellCount a b c d = 3) :
    incomingSide (localIncoming a b c d) ≠
      outgoingSide (localOutgoing a b c d) := by
  cases a <;> cases b <;> cases c <;> cases d <;>
    simp_all [localCellCount, incomingSide, outgoingSide,
      localIncoming, localOutgoing] <;> decide

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
