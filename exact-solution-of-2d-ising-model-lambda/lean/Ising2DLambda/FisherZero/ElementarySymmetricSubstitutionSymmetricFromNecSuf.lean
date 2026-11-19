/- 必要十分版を `Qbar` 係数の基本対称式への代入へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionSymmetric
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionSymmetric

namespace Ising2DLambda.FisherZero

/-- `claim_qbar_multivariate_substitution_composition` を必要十分版から得る。
`K = Qbar`、`σ = Fin n`、`τ = Fin m`、`υ = Fin p`。 -/
theorem qbarMvSubst_comp_from_necSuf {n m p : ℕ} (e : Fin n → QbarMvPoly m)
    (y : Fin m → QbarMvPoly p) (Q : QbarMvPoly n) :
    qbarMvSubst y (qbarMvSubst e Q) = qbarMvSubst (fun k => qbarMvSubst y (e k)) Q :=
  Ising2DLambda.NecSuf.FisherZero.mvSubst_comp_necSuf e y Q

/-- `claim_qbar_elementary_symmetric_is_symmetric` を必要十分版から得る。`K = Qbar`、`σ = Fin n`。 -/
theorem elementarySymmetric_isQbarSymmetric_from_necSuf (n j : ℕ) :
    IsQbarSymmetric (qbarElementarySymmetric n j) := fun ϱ =>
  Ising2DLambda.NecSuf.FisherZero.elementarySymmetric_equivInvariant_necSuf ϱ j

/-- `claim_elementary_symmetric_substitution_symmetric` を必要十分版から得る。
`y = xv_{n,ϱ}`、`e = ee_n`。各値の固定は基本対称式の対称性（必要十分版からの導出）。 -/
theorem elementarySymmetricSubst_isQbarSymmetric_from_necSuf {n : ℕ} (Q : QbarMvPoly n) :
    IsQbarSymmetric (elementarySymmetricSubst n Q) := fun ϱ =>
  Ising2DLambda.NecSuf.FisherZero.mvSubst_fixed_of_values_fixed_necSuf
    (elementarySymmetricValues n) (variablePermutationValues n ϱ)
    (fun j => elementarySymmetric_isQbarSymmetric_from_necSuf n (j.val + 1) ϱ) Q

end Ising2DLambda.FisherZero
