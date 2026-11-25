/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.TermOrbitWeightFactorization
import Ising2DLambda.NecSuf.KacWard.TermOrbitWeightFactorization

namespace Ising2DLambda.KacWard

open Finset Polynomial

open Ising2DLambda.AlgebraicEigenvalue

variable {ι : Type} [Fintype ι] [DecidableEq ι]

/-- 導出版: 同じ分解を必要十分版から得たことの明示。 -/
theorem kacWardEntryProduct_orbit_factorization_from_necSuf
    (M : Matrix ι ι Qbar) (σ : Equiv.Perm ι) :
    kacWardDeterminantEntryProduct M σ =
      (∏ e ∈ univ.filter fun e => σ e = e, kacWardPolynomialMatrix M e (σ e)) *
        ∏ O ∈ movedEdgeOrbitSet σ,
          ((-Polynomial.X : QbarPoly) ^ O.card *
            ∏ e ∈ O, Polynomial.C (M e (σ e))) :=
  kacWardEntryProduct_orbit_factorization M σ

end Ising2DLambda.KacWard
