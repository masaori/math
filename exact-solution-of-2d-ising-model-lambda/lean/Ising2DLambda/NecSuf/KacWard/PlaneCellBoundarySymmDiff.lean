import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- The edge boundary records exclusive membership of its two incident cells. -/
def boundaryParity (a b : Prop) : Prop := (a ∧ ¬b) ∨ (¬a ∧ b)

/-- The only input needed for compatibility with symmetric difference is XOR parity. -/
theorem boundaryParity_symmDiff (a b c d : Prop) :
    boundaryParity (boundaryParity a b) (boundaryParity c d) ↔
      boundaryParity (boundaryParity a c) (boundaryParity b d) := by
  unfold boundaryParity
  tauto

end Ising2DLambda.NecSuf.KacWard
