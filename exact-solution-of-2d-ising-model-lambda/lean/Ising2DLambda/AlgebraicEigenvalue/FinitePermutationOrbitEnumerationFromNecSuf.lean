import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitEnumeration
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationMinimalPeriodFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PeriodicTwoWayOrbit

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

/-- 正の帰還を既証の導出版から供給し、二方向の到達の定義を対応させる。 -/
theorem finitePermutationOrbit_mem_iff_lt_period_from_necSuf (σ : Equiv.Perm J) (i j : J) :
    j ∈ finitePermutationOrbit σ i ↔
      ∃ r : ℕ, r < finitePermutationMinimalPeriod σ i ∧ finiteMapIterate σ r i = j := by
  have hs := finitePermutationMinimalPeriod_spec_from_necSuf σ i
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.twoWayOrbit_mem_iff_lt_period_necSuf
    σ σ.symm σ.symm_apply_apply i (finitePermutationMinimalPeriod σ i) hs.1 hs.2.1 j

/-- 添字と軌道の点への写像は定義から一致する。 -/
theorem finitePermutationOrbitEnumeration_bijective_from_necSuf (σ : Equiv.Perm J) (i : J) :
    Function.Bijective (finitePermutationOrbitEnumeration σ i) := by
  have hs := finitePermutationMinimalPeriod_spec_from_necSuf σ i
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.twoWayOrbitEnumeration_bijective_necSuf
    σ σ.symm σ.symm_apply_apply i (finitePermutationMinimalPeriod σ i) hs.1 hs.2.1 hs.2.2

/-- 軌道の台と個数の定義の対応により具体版の結論を得る。 -/
theorem finitePermutationMinimalPeriod_eq_orbitLength_from_necSuf (σ : Equiv.Perm J) (i : J) :
    finitePermutationMinimalPeriod σ i = finitePermutationOrbitLength σ i := by
  have hs := finitePermutationMinimalPeriod_spec_from_necSuf σ i
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.period_eq_twoWayOrbit_ncard_necSuf
    σ σ.symm σ.symm_apply_apply i (finitePermutationMinimalPeriod σ i) hs.1 hs.2.1 hs.2.2

end Ising2DLambda.AlgebraicEigenvalue
