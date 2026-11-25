/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.DirectedWindingParity
import Ising2DLambda.NecSuf.KacWard.DirectedWindingParity

namespace Ising2DLambda.KacWard

/-- The concrete claims specialize the sign independence of finite sums. -/
theorem directedWindingNumber_parity_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (_hγ : closedNonbacktrackingWalk γ) :
    (horizontalDirectedWindingNumber γ : ZMod 2) =
      ((edgeSequenceSeamParities (List.ofFn γ)).1 : ZMod 2) ∧
    (verticalDirectedWindingNumber γ : ZMod 2) =
      ((edgeSequenceSeamParities (List.ofFn γ)).2 : ZMod 2) :=
    by
      constructor
      · rw [horizontalDirectedWindingNumber, edgeSequenceSeamParities]
        simp only [List.map_ofFn, List.sum_ofFn]
        rw [ZMod.natCast_mod]
        exact Ising2DLambda.NecSuf.KacWard.directedWindingParity_necSuf
          (fun k => horizontalSeamParity (γ k)) (fun k => (γ k).2)
      · rw [verticalDirectedWindingNumber, edgeSequenceSeamParities]
        simp only [List.map_ofFn, List.sum_ofFn]
        rw [ZMod.natCast_mod]
        exact Ising2DLambda.NecSuf.KacWard.directedWindingParity_necSuf
          (fun k => verticalSeamParity (γ k)) (fun k => (γ k).2)

end Ising2DLambda.KacWard
