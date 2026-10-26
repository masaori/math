import Mathlib.Data.Finset.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- The local source equality of a short pair makes a step after reversal.
    Only the endpoint interchange and involution laws are needed. -/
theorem shortPair_successor {J V : Type*}
    (reverse : J → J) (source target : J → V)
    (next : J → J → Prop)
    (hreverse : ∀ e, reverse (reverse e) = e)
    (htarget : ∀ e, target (reverse e) = source e)
    (hnext : ∀ e f, next e f ↔ target e = source f ∧ f ≠ reverse e)
    (g f : J) (hsource : source f = source g) (hne : f ≠ g) :
    next (reverse g) f := by
  apply (hnext (reverse g) f).2
  constructor
  · calc
      target (reverse g) = source g := htarget g
      _ = source f := hsource.symm
  · rw [hreverse]
    exact hne

end Ising2DLambda.NecSuf.KacWard
