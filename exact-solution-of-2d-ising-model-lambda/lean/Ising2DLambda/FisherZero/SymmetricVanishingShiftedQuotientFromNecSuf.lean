/- 必要十分版を `Qbar` 係数の対称多項式へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.SymmetricVanishingShiftedQuotient
import Ising2DLambda.NecSuf.FisherZero.SymmetricVanishingShiftedQuotient

namespace Ising2DLambda.FisherZero

open MvPolynomial

/-- `claim_qbar_full_elementary_symmetric_is_all_ones_monomial` を必要十分版から得る。
`K = Qbar`、`σ = Fin n`。基本対称式・単項式・指数 `1_n` は具体版と同じ式で定めてある。 -/
theorem qbarElementarySymmetric_self_eq_monomial_allOnes_from_necSuf (n : ℕ) :
    qbarElementarySymmetric n n = qbarMonomial n (allOnesExponent n) := by
  have h := Ising2DLambda.NecSuf.FisherZero.elementarySymmetricCard_eq_monomialProd_allOnes_necSuf
    (K := Ising2DLambda.AlgebraicEigenvalue.Qbar) (σ := Fin n)
  rw [Fintype.card_fin] at h
  exact h

/-- `claim_symmetric_vanishing_last_variable_shifted_quotient_product` を必要十分版から得る。
`K = Qbar`。対称性から各互換 `(k n)` についての不変性を取り出して渡す。 -/
theorem symmetricVanishing_eq_elementarySymmetric_mul_allOnesShift_from_necSuf {n : ℕ}
    (P : QbarMvPoly (n + 1)) (hsym : IsQbarSymmetric P) (hlz : lastVariableZero n P = 0) :
    P = qbarElementarySymmetric (n + 1) (n + 1) * allOnesShift P :=
  Ising2DLambda.NecSuf.FisherZero.swapInvariantVanishing_eq_monomialProd_mul_allOnesShift_necSuf P
    (fun k => hsym (Equiv.swap k (Fin.last n))) hlz

end Ising2DLambda.FisherZero
