/- 必要十分版を `Qbar` 係数の多変数多項式環へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.MonomialAndLastVariableZeroCoefficient
import Ising2DLambda.NecSuf.FisherZero.MonomialAndLastVariableZeroCoefficient

namespace Ising2DLambda.FisherZero

open MvPolynomial

/-- `claim_qbar_monomial_multiplication_coefficient` を必要十分版から得る。
`K = Qbar`、`σ = Fin n`。単項式はどちらも `∏ k, X k ^ a k` で同じ元である。 -/
theorem qbarMonomial_mul_coeff_from_necSuf {n : ℕ} (a c : Fin n →₀ ℕ) (Q : QbarMvPoly n) :
    coeff c (qbarMonomial n a * Q) = if a ≤ c then coeff (c - a) Q else 0 :=
  Ising2DLambda.NecSuf.FisherZero.monomialProd_mul_coeff_necSuf a c Q

/-- `claim_last_variable_zero_coefficient` を必要十分版から得る。
`K = Qbar`。末尾の変数への零代入と、末尾に零を足した指数は、どちらも具体版と同じ式で定めてある。 -/
theorem lastVariableZero_coeff_from_necSuf {n : ℕ} (P : QbarMvPoly (n + 1)) (b : Fin n →₀ ℕ) :
    coeff b (lastVariableZero n P) = coeff (exponentZeroExtension b) P :=
  Ising2DLambda.NecSuf.FisherZero.lastVariableZero_coeff_necSuf P b

end Ising2DLambda.FisherZero
