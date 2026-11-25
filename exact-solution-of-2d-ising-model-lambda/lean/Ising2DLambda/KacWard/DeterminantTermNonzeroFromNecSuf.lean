/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.DeterminantTermNonzero
import Ising2DLambda.NecSuf.KacWard.DeterminantTermNonzero

namespace Ising2DLambda.KacWard

open Matrix Polynomial Equiv Ising2DLambda.AlgebraicEigenvalue

theorem kacWardDeterminantEntryProduct_ne_zero_from_necSuf {ι : Type}
    [Fintype ι] [DecidableEq ι] (M : Matrix ι ι Qbar) (σ : Equiv.Perm ι) :
    kacWardDeterminantEntryProduct M σ ≠ 0 ↔
      ∀ i, σ i ≠ i → M i (σ i) ≠ 0 :=
  kacWardDeterminantEntryProduct_ne_zero_iff M σ

end Ising2DLambda.KacWard
