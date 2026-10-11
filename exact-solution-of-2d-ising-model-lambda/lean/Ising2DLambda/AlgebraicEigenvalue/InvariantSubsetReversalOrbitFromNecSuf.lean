import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalOrbit
import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InvariantPredicateReversalOrbit

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

/-- 有限集合上の軌道の定義へ特殊化する。 -/
theorem finitePermutationOrbit_inverse_from_necSuf (σ : Equiv.Perm J) (i : J) :
    finitePermutationOrbit σ.symm i = finitePermutationOrbit σ i := by
  exact NecSuf.AlgebraicEigenvalue.permutationOrbit_inverse σ i

variable [DecidableEq J]

/-- 逆置換の保存条件には既存の導出版を用いる。 -/
theorem invariantSubsetReversal_inverse_from_necSuf (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) :
    (invariantSubsetReversal C σ h).symm =
      invariantSubsetReversal C σ.symm
        (inverse_mem_invariantSubset_iff_from_necSuf C σ h) := by
  exact NecSuf.AlgebraicEigenvalue.invariantPredicateReversal_inverse
    (fun j : J => j ∈ C) σ h

/-- 述語へ有限部分集合の所属を供給し、二方向の台の保存を得る。 -/
theorem invariantSubsetReversal_orbit_from_necSuf (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    finitePermutationOrbit (invariantSubsetReversal C σ h) i =
      finitePermutationOrbit σ i := by
  exact NecSuf.AlgebraicEigenvalue.invariantPredicateReversal_orbit_necSuf
    (fun j : J => j ∈ C) σ h i

/-- 台へ `Set.ncard` を適用する必要十分版を、有限な台へ特殊化する。 -/
theorem invariantSubsetReversal_orbitLength_from_necSuf (C : Finset J) (σ : Equiv.Perm J)
    (h : ∀ i : J, σ i ∈ C ↔ i ∈ C) (i : J) :
    finitePermutationOrbitLength (invariantSubsetReversal C σ h) i =
      finitePermutationOrbitLength σ i := by
  exact NecSuf.AlgebraicEigenvalue.invariantPredicateReversal_orbit_ncard_necSuf
    (fun j : J => j ∈ C) σ h i

end Ising2DLambda.AlgebraicEigenvalue
