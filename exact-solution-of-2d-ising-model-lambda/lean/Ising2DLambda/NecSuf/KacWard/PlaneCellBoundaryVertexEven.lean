import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Four edge indicators formed by differences of four binary cell values have even sum. -/
theorem boundaryVertex_even_of_binary_cells (a b d f : Bool) :
    ((if a != b then 1 else 0) + (if d != f then 1 else 0) +
      (if a != d then 1 else 0) + (if b != f then 1 else 0)) % 2 = 0 := by
  cases a <;> cases b <;> cases d <;> cases f <;> decide

end Ising2DLambda.NecSuf.KacWard
