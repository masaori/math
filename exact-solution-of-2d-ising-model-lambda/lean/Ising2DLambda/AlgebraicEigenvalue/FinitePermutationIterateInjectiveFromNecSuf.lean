import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalIterate
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.IterationInjective

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を有限集合上の置換へ特殊化する。 -/
theorem finitePermutationIterate_injective_from_necSuf {J : Type*} [Fintype J]
    (σ : Equiv.Perm J) (n : ℕ) :
    Function.Injective (finiteMapIterate σ n) := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterate_injective_necSuf
    σ σ.injective n

end Ising2DLambda.AlgebraicEigenvalue
