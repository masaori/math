import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitInvariant
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitInvariant

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

theorem finiteMapIterate_commute_from_necSuf (f : J → J) (n : ℕ) (y : J) :
    f (finiteMapIterate f n y) = finiteMapIterate f n (f y) :=
  NecSuf.AlgebraicEigenvalue.iterate_commute_necSuf f n y

theorem finitePermutationOrbit_apply_mem_from_necSuf (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ finitePermutationOrbit σ i) :
    σ j ∈ finitePermutationOrbit σ i :=
  NecSuf.AlgebraicEigenvalue.permutationOrbit_apply_mem_necSuf σ i j h

theorem finitePermutationOrbit_invariant_from_necSuf (σ : Equiv.Perm J) (i j : J) :
    σ j ∈ finitePermutationOrbit σ i ↔ j ∈ finitePermutationOrbit σ i :=
  NecSuf.AlgebraicEigenvalue.permutationOrbit_invariant_necSuf σ i j

end Ising2DLambda.AlgebraicEigenvalue
