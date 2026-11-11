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

/-- At a non-diagonal boundary vertex, an entering direction with a selected
cell on its left is the direction selected by the four-cell rule. -/
theorem local_incoming_unique (a b c d : Bool) (direction : Fin 4)
    (hdiag₁ : ¬ (a = true ∧ b = false ∧ c = true ∧ d = false))
    (hdiag₂ : ¬ (a = false ∧ b = true ∧ c = false ∧ d = true))
    (hboundary : localCellCount a b c d = 1 ∨
      localCellCount a b c d = 2 ∨ localCellCount a b c d = 3)
    (hleft : if direction.val = 0 then a = true ∧ d = false
      else if direction.val = 1 then b = true ∧ a = false
      else if direction.val = 2 then c = true ∧ b = false
      else d = true ∧ c = false) :
    (direction.val : ZMod 4) = localIncoming a b c d := by
  fin_cases direction <;> cases a <;> cases b <;> cases c <;> cases d <;>
    simp_all [localCellCount, localIncoming]

/-- The same uniqueness holds for a leaving direction. -/
theorem local_outgoing_unique (a b c d : Bool) (direction : Fin 4)
    (hdiag₁ : ¬ (a = true ∧ b = false ∧ c = true ∧ d = false))
    (hdiag₂ : ¬ (a = false ∧ b = true ∧ c = false ∧ d = true))
    (hboundary : localCellCount a b c d = 1 ∨
      localCellCount a b c d = 2 ∨ localCellCount a b c d = 3)
    (hleft : if direction.val = 0 then b = true ∧ c = false
      else if direction.val = 1 then c = true ∧ d = false
      else if direction.val = 2 then d = true ∧ a = false
      else a = true ∧ b = false) :
    (direction.val : ZMod 4) = localOutgoing a b c d := by
  fin_cases direction <;> cases a <;> cases b <;> cases c <;> cases d <;>
    simp_all [localCellCount, localOutgoing]

/-- Across an eastward boundary edge, the outgoing direction at its west end
is the incoming direction at its east end. -/
theorem local_east_outgoing_matches_next_incoming
    (a b c d e f : Bool)
    (hsource : localCellCount a b c d = 1 ∨
      localCellCount a b c d = 2 ∨ localCellCount a b c d = 3)
    (htarget : localCellCount b e f c = 1 ∨
      localCellCount b e f c = 2 ∨ localCellCount b e f c = 3)
    (hdiag₁ : ¬ (b = true ∧ e = false ∧ f = true ∧ c = false))
    (hdiag₂ : ¬ (b = false ∧ e = true ∧ f = false ∧ c = true))
    (hout : localOutgoing a b c d = 0) :
    localIncoming b e f c = 0 := by
  have hleft := (local_directions_selected_left a b c d hsource).2
  rw [hout] at hleft
  have hside : b = true ∧ c = false := by simpa using hleft
  have hunique := local_incoming_unique b e f c (0 : Fin 4)
    hdiag₁ hdiag₂ htarget (by simpa using hside)
  simpa using hunique.symm

/-- Across a westward boundary edge, the outgoing direction at its east end
is the incoming direction at its west end. -/
theorem local_west_outgoing_matches_next_incoming
    (a b c d e f : Bool)
    (hsource : localCellCount a b c d = 1 ∨
      localCellCount a b c d = 2 ∨ localCellCount a b c d = 3)
    (htarget : localCellCount e a d f = 1 ∨
      localCellCount e a d f = 2 ∨ localCellCount e a d f = 3)
    (hdiag₁ : ¬ (e = true ∧ a = false ∧ d = true ∧ f = false))
    (hdiag₂ : ¬ (e = false ∧ a = true ∧ d = false ∧ f = true))
    (hout : localOutgoing a b c d = 2) :
    localIncoming e a d f = 2 := by
  have hleft := (local_directions_selected_left a b c d hsource).2
  rw [hout] at hleft
  have hside : d = true ∧ a = false := by
    simpa [show (2 : ZMod 4) ≠ 0 by decide,
      show (2 : ZMod 4) ≠ 1 by decide] using hleft
  have hunique := local_incoming_unique e a d f (2 : Fin 4)
    hdiag₁ hdiag₂ htarget (by simpa using hside)
  simpa using hunique.symm

/-- Across a southward boundary edge, the outgoing direction at its north end
is the incoming direction at its south end. -/
theorem local_south_outgoing_matches_next_incoming
    (a b c d e f : Bool)
    (hsource : localCellCount a b c d = 1 ∨
      localCellCount a b c d = 2 ∨ localCellCount a b c d = 3)
    (htarget : localCellCount d c e f = 1 ∨
      localCellCount d c e f = 2 ∨ localCellCount d c e f = 3)
    (hdiag₁ : ¬ (d = true ∧ c = false ∧ e = true ∧ f = false))
    (hdiag₂ : ¬ (d = false ∧ c = true ∧ e = false ∧ f = true))
    (hout : localOutgoing a b c d = 1) :
    localIncoming d c e f = 1 := by
  have hleft := (local_directions_selected_left a b c d hsource).2
  rw [hout] at hleft
  have hside : c = true ∧ d = false := by
    simpa [show (1 : ZMod 4) ≠ 0 by decide] using hleft
  have hunique := local_incoming_unique d c e f (1 : Fin 4)
    hdiag₁ hdiag₂ htarget (by simpa using hside)
  simpa using hunique.symm

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
