import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

def Compatible {I R : Type} (target : I → R) (positive : I → Prop) (r : R) : Prop :=
  ∀ i, positive i ↔ r = target i

def Forced {I R : Type} (target : I → R) (positive : I → Prop) (x : R) : Prop :=
  ∃ i, positive i ∧ x = target i

def Forbidden {I R : Type} (target : I → R) (positive : I → Prop) (x : R) : Prop :=
  ∃ i, ¬positive i ∧ x = target i

/-- 切断条件の本質は、正の条件が始点を強制し、負の条件が始点を除外することだけである。 -/
theorem compatible_iff_forced_forbidden
    {I R : Type} [DecidableEq R]
    (target : I → R) (positive : I → Prop) (r : R) :
    Compatible target positive r ↔
      (∀ x, Forced target positive x → r = x) ∧
      ¬Forbidden target positive r := by
  constructor
  · intro h
    constructor
    · intro x hx
      obtain ⟨i, hi, rfl⟩ := hx
      exact (h i).mp hi
    · intro hx
      obtain ⟨i, hi, hri⟩ := hx
      exact hi ((h i).mpr hri)
  · rintro ⟨hforced, hforbidden⟩ i
    constructor
    · intro hi
      exact hforced (target i) ⟨i, hi, rfl⟩
    · intro hri
      by_contra hi
      exact hforbidden ⟨i, hi, hri⟩

end Ising2DLambda.NecSuf.KacWard
