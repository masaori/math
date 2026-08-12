/- 全単射として与えた写像の全単射性に必要な構造だけを残す。 -/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 逆写像と二つの往復律があれば、もとの写像は全単射である。 -/
theorem map_bijective_of_two_sided_inverse_necSuf {α β : Type*} (f : α → β) (g : β → α)
    (leftInverse : ∀ x, g (f x) = x) (rightInverse : ∀ y, f (g y) = y) :
    Function.Bijective f := by
  constructor
  · intro x x' h
    calc
      x = g (f x) := (leftInverse x).symm
      _ = g (f x') := congrArg g h
      _ = x' := leftInverse x'
  · intro y
    exact ⟨g y, rightInverse y⟩

end Ising2DLambda.NecSuf.FisherZero
