import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationPeriodInjective
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationMinimalPeriodFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.IterateNoShortReturn

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 短い正の帰還が無いという条件を、既証の最小周期の性質から供給する。 -/
theorem finitePermutationIterate_injOn_period_from_necSuf {J : Type*} [Fintype J]
    (σ : Equiv.Perm J) (i : J) :
    Set.InjOn (fun n : ℕ => finiteMapIterate σ n i)
      (Set.Iio (finitePermutationMinimalPeriod σ i)) := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterate_injOn_of_no_short_return_necSuf
    σ σ.injective i (finitePermutationMinimalPeriod σ i)
    (finitePermutationMinimalPeriod_spec_from_necSuf σ i).2.2

end Ising2DLambda.AlgebraicEigenvalue
