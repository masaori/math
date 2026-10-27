import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockDiagonalTermFactorization
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftCharOrbitProduct

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- Termwise factorization, followed by finite distributivity. No matrix structure
    is used after the permutation families have been constructed. -/
theorem weightedFiberFamily_sum_eq_prod_sums
    {K R : Type*} [Fintype K] [DecidableEq K] [CommSemiring R]
    {P : K → Type*} [∀ k, Fintype (P k)]
    (term : (k : K) → P k → R)
    (wholeTerm : (∀ k, P k) → R)
    (hterm : ∀ parts, wholeTerm parts = ∏ k : K, term k (parts k)) :
    (∑ parts : (∀ k, P k), wholeTerm parts) =
      ∏ k : K, ∑ p : P k, term k p := by
  classical
  calc
    (∑ parts : (∀ k, P k), wholeTerm parts) =
        ∑ parts : (∀ k, P k), ∏ k : K, term k (parts k) := by
      refine Finset.sum_congr rfl ?_
      intro parts _
      exact hterm parts
    _ = ∏ k : K, ∑ p : P k, term k p :=
      (prod_sum_eq_sum_prod_pi term).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
