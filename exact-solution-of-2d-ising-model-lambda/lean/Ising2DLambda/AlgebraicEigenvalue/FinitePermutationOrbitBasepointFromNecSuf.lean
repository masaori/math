import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitBasepoint
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitBasepoint

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

theorem finitePermutationOrbit_iterate_mem_iff_from_necSuf (σ : Equiv.Perm J) (i : J)
    (n : ℕ) (y : J) :
    finiteMapIterate σ n y ∈ finitePermutationOrbit σ i ↔
      y ∈ finitePermutationOrbit σ i :=
  NecSuf.AlgebraicEigenvalue.permutationOrbit_iterate_mem_iff_necSuf σ i n y

theorem finitePermutationOrbit_inverse_iterate_mem_iff_from_necSuf (σ : Equiv.Perm J)
    (i : J) (n : ℕ) (y : J) :
    finiteMapIterate σ.symm n y ∈ finitePermutationOrbit σ i ↔
      y ∈ finitePermutationOrbit σ i :=
  NecSuf.AlgebraicEigenvalue.permutationOrbit_inverse_iterate_mem_iff_necSuf σ i n y

theorem finitePermutationOrbit_self_mem_from_necSuf (σ : Equiv.Perm J) (i : J) :
    i ∈ finitePermutationOrbit σ i :=
  NecSuf.AlgebraicEigenvalue.permutationOrbit_self_mem_necSuf σ i

theorem finitePermutationOrbit_subset_of_mem_from_necSuf (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ finitePermutationOrbit σ i) :
    finitePermutationOrbit σ j ⊆ finitePermutationOrbit σ i :=
  NecSuf.AlgebraicEigenvalue.permutationOrbit_subset_of_mem_necSuf σ i j h

theorem finitePermutationOrbit_mem_symm_from_necSuf (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ finitePermutationOrbit σ i) :
    i ∈ finitePermutationOrbit σ j :=
  NecSuf.AlgebraicEigenvalue.permutationOrbit_mem_symm_necSuf σ i j h

theorem finitePermutationOrbit_basepoint_from_necSuf (σ : Equiv.Perm J) (i j : J)
    (h : j ∈ finitePermutationOrbit σ i) :
    finitePermutationOrbit σ j = finitePermutationOrbit σ i :=
  NecSuf.AlgebraicEigenvalue.permutationOrbit_basepoint_necSuf σ i j h

end Ising2DLambda.AlgebraicEigenvalue
