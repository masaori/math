import Mathlib.Logic.Function.Iterate

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 本文と同じ六等号。写像と自然数回の反復だけを使い、有限性・単射性・順序は不要。 -/
theorem iterate_add_necSuf {J : Type*} (f : J → J) (m n : ℕ) (i : J) :
    f^[m + n] i = f^[m] (f^[n] i) := by
  induction n generalizing i with
  | zero =>
    calc
      f^[m + 0] i = f^[m] i :=
        congrArg (fun k : ℕ => f^[k] i) (Nat.add_zero m)
      _ = f^[m] (f^[0] i) := rfl
  | succ n ih =>
    calc
      f^[m + (n + 1)] i = f^[(m + n) + 1] i :=
        congrArg (fun k : ℕ => f^[k] i) (Nat.add_assoc m n 1).symm
      _ = f^[m + n] (f i) := rfl
      _ = f^[m] (f^[n] (f i)) := ih (f i)
      _ = f^[m] (f^[n + 1] i) := rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
