import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

theorem fiber_bijective {A B C : Type*} (f : A → B × C)
    (hf : Function.Bijective f) (b : B) :
    Function.Bijective
      (fun x : {a : A // (f a).1 = b} => (f x.1).2) := by
  constructor
  · intro x y h
    apply Subtype.ext
    apply hf.1
    apply Prod.ext
    · exact x.2.trans y.2.symm
    · exact h
  · intro c
    obtain ⟨a, ha⟩ := hf.2 (b, c)
    exact ⟨⟨a, congrArg Prod.fst ha⟩, congrArg Prod.snd ha⟩

theorem selected_fiber_bijective {A B C : Type*} (f : A → B × C)
    (hf : Function.Bijective f) (b : B) (P : A → Prop) :
    Set.BijOn (fun a => (f a).2)
      {a | (f a).1 = b ∧ P a}
      {c | ∃ a, (f a).1 = b ∧ P a ∧ (f a).2 = c} := by
  constructor
  · intro a ha
    exact ⟨a, ha.1, ha.2, rfl⟩
  constructor
  · intro a ha a' ha' h
    apply hf.1
    exact Prod.ext (ha.1.trans ha'.1.symm) h
  · intro c hc
    obtain ⟨a, hb, hp, hdir⟩ := hc
    exact ⟨a, ⟨hb, hp⟩, hdir⟩

end Ising2DLambda.NecSuf.KacWard
