import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalIterate

namespace Ising2DLambda.AlgebraicEigenvalue

/-- `claim_finite_map_iterate_add` の六等号。第二の反復回数について帰納する。 -/
theorem finiteMapIterate_add {J : Type*} [Fintype J]
    (f : J → J) (m n : ℕ) (i : J) :
    finiteMapIterate f (m + n) i = finiteMapIterate f m (finiteMapIterate f n i) := by
  induction n generalizing i with
  | zero =>
    calc
      finiteMapIterate f (m + 0) i = finiteMapIterate f m i :=
        congrArg (fun k : ℕ => finiteMapIterate f k i) (Nat.add_zero m)
      _ = finiteMapIterate f m (finiteMapIterate f 0 i) := rfl
  | succ n ih =>
    calc
      finiteMapIterate f (m + (n + 1)) i = finiteMapIterate f ((m + n) + 1) i :=
        congrArg (fun k : ℕ => finiteMapIterate f k i) (Nat.add_assoc m n 1).symm
      _ = finiteMapIterate f (m + n) (f i) := rfl
      _ = finiteMapIterate f m (finiteMapIterate f n (f i)) := ih (f i)
      _ = finiteMapIterate f m (finiteMapIterate f (n + 1) i) := rfl

end Ising2DLambda.AlgebraicEigenvalue
