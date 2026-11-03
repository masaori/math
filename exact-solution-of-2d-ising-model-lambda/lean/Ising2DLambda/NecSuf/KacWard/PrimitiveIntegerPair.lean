import Mathlib.Data.Int.GCD

namespace Ising2DLambda.NecSuf.KacWard

/-- A nonzero pair is primitive when its two entries have unit gcd. -/
def primitivePair {A : Type*} [Zero A] (gcd : A → A → ℕ) (a b : A) : Prop :=
  (a, b) ≠ (0, 0) ∧ gcd a b = 1

end Ising2DLambda.NecSuf.KacWard
