import Ising2DLambda.KacWard.SuccessorDirectionSelection
import Ising2DLambda.NecSuf.KacWard.SuccessorDirectionSelection

namespace Ising2DLambda.KacWard

theorem successorDirection_selection_from_necSuf {L : ℕ} [NeZero L]
    (e : OrientedEdge L) (d : ZMod 4) :
    ∃! f : OrientedEdge L,
      orientedSource f = orientedTarget e ∧ directionNumber f = d ∧
        (f ∈ nonbacktrackingSuccessors e ↔ d ≠ directionNumber e + 2) := by
  have hsource : ∀ g : OrientedEdge L,
      orientedSource (reversal g) = orientedTarget g := by
    intro g
    rcases g with ⟨edge, false | true⟩ <;> rfl
  have habstract := Ising2DLambda.NecSuf.KacWard.successorDirection_selection_necSuf
    orientedSource orientedTarget directionNumber reversal
    sourceDirection_bijective hsource directionNumber_reversal e d
  obtain ⟨f, ⟨hs, hd, hmem⟩, huniq⟩ := habstract
  refine ⟨f, ⟨hs, hd, ?_⟩, ?_⟩
  · simpa [nonbacktrackingSuccessors, hs] using hmem
  · intro g hg
    apply sourceDirection_bijective.1
    exact Prod.ext (hg.1.trans hs.symm) (hg.2.1.trans hd.symm)

end Ising2DLambda.KacWard
