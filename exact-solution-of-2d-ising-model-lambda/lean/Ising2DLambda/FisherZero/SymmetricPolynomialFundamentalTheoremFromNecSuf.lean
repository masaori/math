/- 必要十分版を `K = Qbar`、`S = F`（部分体なので `0`・`1`・`−1` を含み和と積で閉じる）へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.SymmetricPolynomialFundamentalTheorem
import Ising2DLambda.NecSuf.FisherZero.SymmetricPolynomialFundamentalTheorem

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- 具体版の `se_n` と必要十分版の基本対称式への代入は同じ式（`aeval` に同じ値の写像）で定めてある。 -/
theorem elementarySymmetricSubst_eq_necSuf (n : ℕ) (Q : QbarMvPoly n) :
    elementarySymmetricSubst n Q = Ising2DLambda.NecSuf.FisherZero.seNecSuf n Q :=
  rfl

/-- 具体版の対称性と必要十分版の対称性は同じ条件である。 -/
theorem isQbarSymmetric_iff_necSuf {n : ℕ} (P : QbarMvPoly n) :
    IsQbarSymmetric P ↔ Ising2DLambda.NecSuf.FisherZero.IsSymNecSuf P :=
  Iff.rfl

/-- `claim_symmetric_polynomial_fundamental_theorem` を必要十分版から得る。 -/
theorem symmetricPolynomialFundamental_from_necSuf (F : Subfield Qbar) (n : ℕ) (P : QbarMvPoly n)
    (hF : P ∈ subfieldCoefficientMvPolys F n) (hsym : IsQbarSymmetric P) :
    ∃ Q ∈ subfieldCoefficientMvPolys F n,
      P = elementarySymmetricSubst n Q ∧ qbarWeightedDegree Q ≤ qbarTotalDegree P :=
  Ising2DLambda.NecSuf.FisherZero.symmetricPolynomialFundamental_necSuf (S := (F : Set Qbar))
    F.zero_mem F.one_mem (F.neg_mem F.one_mem) (fun _ _ hx hy => F.add_mem hx hy)
    (fun _ _ hx hy => F.mul_mem hx hy) n P hF hsym

end Ising2DLambda.FisherZero
