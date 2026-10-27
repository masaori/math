import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- Only source-direction uniqueness and the source and direction of reversal are needed. -/
theorem successorDirection_selection_necSuf {E V : Type*}
    (source target : E → V) (direction : E → ZMod 4) (reverse : E → E)
    (hbij : Function.Bijective (fun f : E => (source f, direction f)))
    (hsource : ∀ e, source (reverse e) = target e)
    (hdirection : ∀ e, direction (reverse e) = direction e + 2)
    (e : E) (d : ZMod 4) :
    ∃! f : E, source f = target e ∧ direction f = d ∧
      ((source f = target e ∧ f ≠ reverse e) ↔ d ≠ direction e + 2) := by
  obtain ⟨f, hf⟩ := hbij.2 (target e, d)
  have hs : source f = target e := congrArg Prod.fst hf
  have hd : direction f = d := congrArg Prod.snd hf
  have hreverse : f = reverse e ↔ d = direction e + 2 := by
    constructor
    · intro h
      rw [h] at hd
      exact hd.symm.trans (hdirection e)
    · intro h
      apply hbij.1
      apply Prod.ext
      · exact hs.trans (hsource e).symm
      · calc
          direction f = d := hd
          _ = direction e + 2 := h
          _ = direction (reverse e) := (hdirection e).symm
  have hmem : (source f = target e ∧ f ≠ reverse e) ↔ d ≠ direction e + 2 := by
    constructor
    · intro h hd'
      exact h.2 (hreverse.mpr hd')
    · intro hd'
      exact ⟨hs, fun heq => hd' (hreverse.mp heq)⟩
  refine ⟨f, ⟨hs, hd, hmem⟩, ?_⟩
  intro g hg
  apply hbij.1
  exact Prod.ext (hg.1.trans hs.symm) (hg.2.1.trans hd.symm)

end Ising2DLambda.NecSuf.KacWard
