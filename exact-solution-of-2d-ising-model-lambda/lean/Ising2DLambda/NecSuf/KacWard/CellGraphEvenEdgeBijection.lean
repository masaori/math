import Mathlib.Data.Finset.Image

namespace Ising2DLambda.NecSuf.KacWard

/-- A bijection of finite edge sets restricts to subsets satisfying equivalent properties. -/
theorem subsetProperty_bijective_of_edgeEquiv
    {E F : Type*} [DecidableEq E] [DecidableEq F]
    (edgeEquiv : E ≃ F) (P : Finset E → Prop) (Q : Finset F → Prop)
    (hproperty : ∀ A, P A ↔ Q (A.image edgeEquiv)) :
    Function.Bijective
      (fun A : {A : Finset E // P A} =>
        (⟨A.1.image edgeEquiv, (hproperty A.1).mp A.2⟩ :
          {B : Finset F // Q B})) := by
  constructor
  · intro A B h
    apply Subtype.ext
    have himage := congrArg (fun s => s.image edgeEquiv.symm)
      (congrArg Subtype.val h)
    simpa [Finset.image_image] using himage
  · intro B
    let A : Finset E := B.1.image edgeEquiv.symm
    have himage : A.image edgeEquiv = B.1 := by
      simp [A, Finset.image_image]
    have hP : P A := by
      apply (hproperty A).mpr
      simpa [himage] using B.2
    exact ⟨⟨A, hP⟩, Subtype.ext himage⟩

end Ising2DLambda.NecSuf.KacWard
