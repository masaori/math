import Ising2DLambda.KacWard.DirectedWindingNumbers
import Ising2DLambda.KacWard.WalkTwistSign

namespace Ising2DLambda.KacWard

/-- The directed horizontal winding number and the horizontal seam count have the same parity. -/
theorem horizontalDirectedWindingNumber_parity {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (_hγ : closedNonbacktrackingWalk γ) :
    (horizontalDirectedWindingNumber γ : ZMod 2) =
      ((edgeSequenceSeamParities (List.ofFn γ)).1 : ZMod 2) := by
  rw [horizontalDirectedWindingNumber, edgeSequenceSeamParities]
  simp only [List.map_ofFn, List.sum_ofFn]
  rw [ZMod.natCast_mod]
  push_cast
  apply Finset.sum_congr rfl
  intro k _
  cases (γ k).2 <;> norm_num

/-- The directed vertical winding number and the vertical seam count have the same parity. -/
theorem verticalDirectedWindingNumber_parity {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (_hγ : closedNonbacktrackingWalk γ) :
    (verticalDirectedWindingNumber γ : ZMod 2) =
      ((edgeSequenceSeamParities (List.ofFn γ)).2 : ZMod 2) := by
  rw [verticalDirectedWindingNumber, edgeSequenceSeamParities]
  simp only [List.map_ofFn, List.sum_ofFn]
  rw [ZMod.natCast_mod]
  push_cast
  apply Finset.sum_congr rfl
  intro k _
  cases (γ k).2 <;> norm_num

end Ising2DLambda.KacWard
