import Ising2DLambda.KacWard.ShortPairRotationPhaseNonzero
import Ising2DLambda.KacWard.TerminalMatrix

namespace Ising2DLambda.KacWard

/-- Each direction at the target selects one edge; precisely the reverse direction is excluded. -/
theorem successorDirection_selection {L : ℕ} [NeZero L]
    (e : OrientedEdge L) (d : ZMod 4) :
    ∃! f : OrientedEdge L,
      orientedSource f = orientedTarget e ∧ directionNumber f = d ∧
        (f ∈ nonbacktrackingSuccessors e ↔ d ≠ directionNumber e + 2) := by
  obtain ⟨f, hf⟩ := sourceDirection_bijective.2 (orientedTarget e, d)
  have hs : orientedSource f = orientedTarget e := congrArg Prod.fst hf
  have hd : directionNumber f = d := congrArg Prod.snd hf
  have hrevsrc : orientedSource (reversal e) = orientedTarget e := by
    rcases e with ⟨edge, false | true⟩ <;> rfl
  have hreverse : f = reversal e ↔ d = directionNumber e + 2 := by
    constructor
    · intro h
      rw [h] at hd
      exact hd.symm.trans (directionNumber_reversal e)
    · intro h
      apply sourceDirection_bijective.1
      apply Prod.ext
      · exact hs.trans hrevsrc.symm
      · calc
          directionNumber f = d := hd
          _ = directionNumber e + 2 := h
          _ = directionNumber (reversal e) := (directionNumber_reversal e).symm
  have hmem : f ∈ nonbacktrackingSuccessors e ↔ d ≠ directionNumber e + 2 := by
    constructor
    · intro h
      have hne : f ≠ reversal e :=
        (Finset.mem_filter.mp h).2.2
      exact fun hd' => hne (hreverse.mpr hd')
    · intro hd'
      apply Finset.mem_filter.mpr
      exact ⟨Finset.mem_univ _, hs.symm, fun heq => hd' (hreverse.mp heq)⟩
  refine ⟨f, ⟨hs, hd, hmem⟩, ?_⟩
  intro g hg
  apply sourceDirection_bijective.1
  exact Prod.ext (hg.1.trans hs.symm) (hg.2.1.trans hd.symm)

end Ising2DLambda.KacWard
