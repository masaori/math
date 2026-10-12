import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalIterate

namespace Ising2DLambda.AlgebraicEigenvalue

/-- claim_finite_permutation_iterate_injective の八等号。二点を全称化して帰納する。 -/
theorem finitePermutationIterate_injective {J : Type*} [Fintype J]
    (σ : Equiv.Perm J) (n : ℕ) :
    Function.Injective (finiteMapIterate σ n) := by
  induction n with
  | zero =>
    intro i j hij
    calc
      i = finiteMapIterate σ 0 i := rfl
      _ = finiteMapIterate σ 0 j := hij
      _ = j := rfl
  | succ n ih =>
    intro i j hij
    have hiter : finiteMapIterate σ n (σ i) = finiteMapIterate σ n (σ j) := by
      calc
        finiteMapIterate σ n (σ i) = finiteMapIterate σ (n + 1) i := rfl
        _ = finiteMapIterate σ (n + 1) j := hij
        _ = finiteMapIterate σ n (σ j) := rfl
    have himage : σ i = σ j := ih hiter
    calc
      i = j := σ.injective himage

end Ising2DLambda.AlgebraicEigenvalue
