import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A finite set of oriented edges is determined by its source and direction
once all source-direction pairs occur and the two finite sets have equal size. -/
theorem sourceDirection_bijective_necSuf {E V : Type*}
    [Fintype E] [Fintype V] (source : E → V) (direction : E → ZMod 4)
    (hcover : ∀ v d, ∃ e, source e = v ∧ direction e = d)
    (hcard : Fintype.card E = Fintype.card (V × ZMod 4)) :
    Function.Bijective (fun e => (source e, direction e)) := by
  have hsurj : Function.Surjective (fun e => (source e, direction e)) := by
    rintro ⟨v, d⟩
    obtain ⟨e, hs, hd⟩ := hcover v d
    exact ⟨e, Prod.ext hs hd⟩
  exact (Fintype.bijective_iff_surjective_and_card _).mpr ⟨hsurj, hcard⟩

end Ising2DLambda.NecSuf.KacWard
