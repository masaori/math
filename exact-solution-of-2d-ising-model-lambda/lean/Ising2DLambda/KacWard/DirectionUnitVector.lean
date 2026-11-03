import Ising2DLambda.NecSuf.KacWard.DirectionUnitVector

namespace Ising2DLambda.KacWard

/-- `def_direction_unit_vector`: the row and column increments for each direction. -/
def directionUnitVector (d : ZMod 4) : ℤ × ℤ :=
  if d = 0 then (0, 1) else if d = 1 then (1, 0)
  else if d = 2 then (0, -1) else (-1, 0)

theorem directionUnitVector_values :
    directionUnitVector 0 = (0, 1) ∧
    directionUnitVector 1 = (1, 0) ∧
    directionUnitVector 2 = (0, -1) ∧
    directionUnitVector 3 = (-1, 0) := by
  decide

theorem directionUnitVector_from_necSuf (d : ZMod 4) :
    directionUnitVector d =
      Ising2DLambda.NecSuf.KacWard.directionUnitVector
        (0, 1) (1, 0) (0, -1) (-1, 0) d := rfl

end Ising2DLambda.KacWard
