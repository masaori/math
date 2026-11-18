/- 必要十分版を `Qbar` 係数の多変数多項式環の変数の置換へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.VariablePermutationCoefficient
import Ising2DLambda.NecSuf.FisherZero.VariablePermutationCoefficient

namespace Ising2DLambda.FisherZero

open MvPolynomial

/-- `claim_qbar_variable_permutation_coefficient` を必要十分版から得る。
`K = Qbar`、`σ = τ = Fin n`、`e = ϱ`。指数の合成はどちらも `Finsupp.equivMapDomain ϱ.symm a` で同じ元である。 -/
theorem variablePermutation_coeff_from_necSuf {n : ℕ} (ϱ : Equiv.Perm (Fin n)) (P : QbarMvPoly n)
    (a : Fin n →₀ ℕ) :
    coeff a (variablePermutation n ϱ P) = coeff (exponentComp a ϱ) P :=
  Ising2DLambda.NecSuf.FisherZero.equivVariable_coeff_necSuf ϱ P a

end Ising2DLambda.FisherZero
