import Mathlib.Data.ZMod.Basic

namespace Ising2DLambda.NecSuf.KacWard

theorem adjacentSteps_not_opposite
    (u : ZMod 4 → ℤ × ℤ)
    (hinj : Function.Injective u)
    (hneg : ∀ d, u (d + 2) = -u d)
    (a b : ZMod 4) (hnotreverse : b ≠ a + 2) :
    u b ≠ -u a := by
  intro hopposite
  have heq : u b = u (a + 2) := hopposite.trans (hneg a).symm
  exact hnotreverse (hinj heq)

end Ising2DLambda.NecSuf.KacWard
