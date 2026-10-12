import Ising2DLambda.AlgebraicEigenvalue.InvariantSubsetReversalIterate
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.IterationAdd

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を有限集合上の反復の定義へ特殊化する。 -/
theorem finiteMapIterate_add_from_necSuf {J : Type*} [Fintype J]
    (f : J → J) (m n : ℕ) (i : J) :
    finiteMapIterate f (m + n) i = finiteMapIterate f m (finiteMapIterate f n i) := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterate_add_necSuf f m n i

end Ising2DLambda.AlgebraicEigenvalue
