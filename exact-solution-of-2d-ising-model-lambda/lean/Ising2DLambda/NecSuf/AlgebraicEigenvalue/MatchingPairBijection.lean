import Mathlib.Logic.Equiv.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 復元写像が左右両方の逆であることだけから全単射を得る。 -/
def equivalenceOfTwoSidedInverse {A B : Type*} (f : A → B) (g : B → A)
    (hleft : ∀ a, g (f a) = a) (hright : ∀ b, f (g b) = b) : A ≃ B where
  toFun := f
  invFun := g
  left_inv := hleft
  right_inv := hright

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
